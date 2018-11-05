Face++ SDK for JavaScript
=====================

* 这个Demo里面的SDK是对官网在线Api接口的封装,需要联网使用.官网接口文档地址: <https://console.faceplusplus.com.cn/documents/4888373>
* 如何运行Demo:
    * 在官网注册账号: <https://www.faceplusplus.com.cn/>
    * 创建APIKey来使用: <https://console.faceplusplus.com.cn/app/apikey/create> (试用的APIKey可以免费使用,可能有并发数错误.正式APIKey需要充值后使用)
    * 配置`common.js`文件,将生成的`APIKey`和`APISecret`写入(在第4行和第5行)
    * 运行index.html

* 如何集成到自己的项目
  
  * 把`facepp_sdk`这个文件夹拖入到自己的项目
  * 在项目中引用

  ```
    <script type="text/javascript" src="facepp_sdk/jquery.min.js"></script>
    <script type="text/javascript" src="facepp_sdk/exif.js"></script>
    <script type="text/javascript" src="facepp_sdk/facepp_sdk.js"></script>

  ``` 
参考示例代码调用
  
* 如果集成中有问题,请[联系我们](https://www.faceplusplus.com.cn/contact-us/)

