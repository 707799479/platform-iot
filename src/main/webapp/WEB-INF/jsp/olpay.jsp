<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
  <title>支付</title>
  <link rel="stylesheet" type="text/css" href="./css/hui.css" />
</head>
<body>
<header class="hui-header">
  <h1>支付</h1>
</header>
<div class="hui-wrap">
  <div style="height: 10px;"></div>
  <form style="padding:28px 10px;" class="hui-form" id="form1">

    <c:if test="${payinfo == 'error'}">
      <h2>发起支付错误</h2>
    </c:if>
    <c:if test="${payinfo != 'error'}">
    <div style="text-align: center;">
      <p>订单已创建请在5分钟内完成付款</p>
      <div id="countdown"></div>
    </div>


    <br>

    <div class="hui-form-items-title" style="width: 100%;">套餐：<strong>${tname}</strong></div><br>
    <div class="hui-form-items-title" style="width: 100%;">价格：<strong>${price}元</strong></div>
    <div class="hui-form-items-title" style="width: 100%;">时态：<strong>${type}</strong></div><br>



  </form>
  <div style="padding:0px 20px 0px 20px;" id="btnList1">
    <p style="text-align: center;color: red;"></p><br>
    <button onclick="check()" style="width: 100%" type="button" class="btn btn-gradient-secondary btn-rounded btn-fw">续费查询</button>
  </div>
  </c:if>


</div>
</div>
<script src="./js/hui.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">

  function getNowFormatDate() {
    var date = new Date();
    var seperator1 = "-";
    var seperator2 = ":";
    var month = date.getMonth() + 1;
    var strDate = date.getDate();
    if (month >= 1 && month <= 9) {
      month = "0" + month;
    }
    if (strDate >= 0 && strDate <= 9) {
      strDate = "0" + strDate;
    }
    var fen =  parseInt(date.getMinutes());
    fen = fen +5;
    if(fen < 10){
      fen = "0"+fen;
    }
    var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate
            + " " + date.getHours() + seperator2 + fen
            + seperator2 + date.getSeconds();
    return currentdate;
  }

  var dater = new Date();

  var timer = (dater.getFullYear()) + '-03-31 19:00:00';
  hui.countdown(getNowFormatDate(),'#countdown', 4);

  function check() {

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
  }

  <c:if test="${payinfo != 'error'}">
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
                window.location.href = "/success.html";
              }
            });
  }
  </c:if>




</script>
</body>
</html>
<style type="text/css">
  .btn-gradient-secondary {
    background: linear-gradient(to right, #e7ebf0, #868e96);
    border: 0;
    -webkit-transition: opacity 0.3s ease;
    -moz-transition: opacity 0.3s ease;
    -ms-transition: opacity 0.3s ease;
    -o-transition: opacity 0.3s ease;
    transition: opacity 0.3s ease;
    color: #fff;
    height: 40px;
    margin: 10px;
  }
  .btn.btn-rounded {
    border-radius: 50px;
  }
  .hui-header{
    background: linear-gradient(to right, #e7ebf0, #868e96);
    border: 0;
    -webkit-transition: opacity 0.3s ease;
    -moz-transition: opacity 0.3s ease;
    -ms-transition: opacity 0.3s ease;
    -o-transition: opacity 0.3s ease;
    transition: opacity 0.3s ease;
  }
</style>