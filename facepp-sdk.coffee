class @FacePP

  @RE_TRIM: /^\/+|\/+$/g

  constructor: (@apiKey, @apiSecret, options={}) ->
    defaults =
      apiURL: 'https://apicn.faceplusplus.com/v2'
      sessionInterval: 500
      requestTimeout: 10 * 1000
      ajaxAdapter: if ('FormData' of window) then 'XMLHttpRequest' else 'jQuery'
      concurrency: 2

    for k of defaults
      if not options[k]?
        options[k] = defaults[k]

    @apiURL = options.apiURL.replace FacePP.RE_TRIM, ''
    {@sessionInterval, @requestTimeout} = options
    @requestAdapter = FacePP.adapter[options.ajaxAdapter]

    if (requestCapacity = options.concurrency) > 0
      # wrapper for limiting concurrency
      queue = []

      scheduleRequest = =>
        if requestCapacity > 0 and queue.length > 0
          --requestCapacity

          [apiMethod, data, callback] = queue.shift()
          FacePP::request.call this, apiMethod, data, (err, resp) ->
            ++requestCapacity
            setTimeout scheduleRequest, 0
            callback err, resp
            return
        return

      @request = (apiMethod, data, callback) ->
        queue.push [apiMethod, data, callback]
        scheduleRequest()
        return

  request: (apiMethod, data, callback) ->
    data['api_key'] = @apiKey
    data['api_secret'] = @apiSecret
    url = @apiURL + '/' + (apiMethod.replace FacePP.RE_TRIM, '')
    @requestAdapter url, data, timeout: @requestTimeout, callback
    return

  sessionCheck: (session_id, callback) =>
    @request 'info/get_session', session_id: session_id, (err, result) =>
      if err
        callback err, result
      else if result.status == 'FAILED'
        callback (result.result.error_code or -1), result.result
      else if result.status == 'INQUEUE'
        setTimeout @sessionCheck, @sessionInterval, session_id, callback
      else
        callback null, result.result
      return
    return

  requestAsync: (apiMethod, data, callback) ->
    data['async'] = 'true'
    @request apiMethod, data, (err, result) =>
      if err
        callback err, result
      else
        setTimeout @sessionCheck, @sessionInterval, result.session_id, callback
      return
    return

  # Adapters for ajax library
  @adapter:

    jQuery: (url, data, options, callback) ->
      valueLengthEst = 0
      for k of data
        valueLengthEst += data[k].length or 0

      jQuery.ajax
        url: url
        dataType: 'jsonp'
        crossDomain: true
        data: data
        method: if valueLengthEst < 1024 then 'GET' else 'POST'
        timeout: options.timeout
        error: (xhr) ->
          if (response = xhr.responseText)
            try
              response = JSON.parse response
          callback (response?.error_code or -1), response
          return
        success: (data) ->
          callback null, data
          return
      return

    XMLHttpRequest: (url, data, options, callback) ->
      hasBlob = false
      for k of data
        if data[k] instanceof Blob
          hasBlob = true
          break

      xhr = new XMLHttpRequest
      xhr.onreadystatechange = ->
        if @readyState == 4
          @onreadystatechange = null

          if (response = @responseText)
            try
              response = JSON.parse response

          if @status == 200
            callback null, response
          else
            callback (response.error_code or -1), response
        return

      if 'timeout' of xhr
        xhr.timeout = options.timeout
      xhr.open 'POST', url, true

      if hasBlob
        form = new FormData
        form.append k, data[k] for k of data
        xhr.send form

      else
        xhr.setRequestHeader 'Content-type', 'application/x-www-form-urlencoded'
        encode = encodeURIComponent
        tmp = []
        tmp.push "#{encode k}=#{encode data[k]}" for k of data
        xhr.send (tmp.join '&')

      return

