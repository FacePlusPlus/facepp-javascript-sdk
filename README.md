Face++ SDK for JavaScript
=====================

Example:

    var api = new FacePP('YOUR_API_KEY', 'YOUR_API_SECRET');

    api.request(method, data, callback)
    api.requestAsync(method, data, callback)

    method: API method (e.g. 'detection/detect')
    data: API arguments
    callback: function(error, result) {}

默认需要使用XMLHttpRequest 2，需要加入 jQuery 库支持老版浏览器。在支持XMLHttpRequest 2的浏览器中可以上传HTML 5中的File、Blob对象。

Translation (with Google's help)
You will need to use XMLHttpRequest 2 (HTML 5 File, Blob object.). Adding jQuery to support old versions of the browser, as required. 
