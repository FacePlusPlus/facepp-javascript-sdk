Face++ SDK for JavaScript
=====================

Example:

    var api = new FacePP('YOUR_API_KEY', 'YOUR_API_SECRET');

    api.request(method, data, callback)
    api.requestAsync(method, data, callback)

    method: API method (e.g. 'detection/detect')
    data: API arguments
    callback: function(error, result) {}

Optional API URL configution: 

    var api = new FacePP('YOUR_API_KEY',
                         'YOUR_API_SECRET',
                         { apiURL: 'YOUR_API_URL' });
                         //CN API Url: http://apicn.faceplusplus.com/v2
                         //US API Url: http://apius.faceplusplus.com/v2 

Check your FacePlusPlus DevCenter for your API Key, Secret, and URL.

You will need to use XMLHttpRequest 2 (HTML 5 File, Blob object.). Adding jQuery is required if you want to support older browsers.
