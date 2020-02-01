<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
  <title>paying</title>
</head>
<body>

</body>
</html>

<script type="text/javascript">
    if (typeof WeixinJSBridge == "undefined"){
      if( document.addEventListener ){
        document.addEventListener('WeixinJSBridgeReady', onBridgeReady, false);
      }else if (document.attachEvent){
        document.attachEvent('WeixinJSBridgeReady', onBridgeReady);
        document.attachEvent('onWeixinJSBridgeReady', onBridgeReady);
      }
    }else{
      onBridgeReady();
    }


  function onBridgeReady(){
    WeixinJSBridge.invoke(
            'getBrandWCPayRequest', {
              "appId":"${payinfo["appId"]}",     //公众号名称，由商户传入
              "timeStamp":"${payinfo["timeStamp"]}",         //时间戳，自1970年以来的秒数
              "nonceStr":"${payinfo["nonceStr"]}", //随机串
              "package":"${payinfo["package"]}",
              "signType":"${payinfo["signType"]}",         //微信签名方式：
              "paySign":"${payinfo["paySign"]}" //微信签名
            },
            function(res){
              if(res.err_msg == "get_brand_wcpay_request:ok" ){
                window.location.href = 'http://${payinfo["domain"]}.${payinfo["domain2"]}./success.html';
              }
            });
  }
</script>