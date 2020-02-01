<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
  <title>续费查询</title>
  <!-- plugins:css -->
  <link rel="stylesheet" href="/vendors/iconfonts/mdi/css/materialdesignicons.min.css">
  <link rel="stylesheet" href="/vendors/css/vendor.bundle.base.css">
  <!-- endinject -->
  <!-- inject:css -->
  <link rel="stylesheet" href="/css/style.css">
  <link rel="stylesheet" type="text/css" href="/css/hui.css" />
  <!-- endinject -->
  <link rel="shortcut icon" href="/images/favicon.png" />
</head>

<body style="background-color: #F4F4F4;">
<div class="hui-swipe" id="swipe2" style="touch-action: pan-y; user-select: none; -webkit-user-drag: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0);">
  <img src="/img/main.jpg" width="100%">
</div>
<div style="margin: 10px;margin-top: 25px;">

  <form style="padding:28px 10px; background-color: #F4F4F4;text-align: center" method="post" action="/start" id="form1">
    <input name="iccid" style="border-radius: 50px;" type="text" class="form-control" id="exampleInputUsername1" placeholder="">
    <br>
    <button onclick="start()" style="width: 100%; position: relative;right:10px;" type="button" class="btn btn-gradient-secondary btn-rounded btn-fw">续费查询</button>
    <p style="text-align: center;color: red;">${start_note}</p>
  </form>
</div>
</body>
<!-- plugins:js -->
<script src="/vendors/js/vendor.bundle.base.js"></script>
<script src="/vendors/js/vendor.bundle.addons.js"></script>
<script src="/js/off-canvas.js"></script>
<script src="/js/misc.js"></script>

<script src="/js/dashboard.js"></script>

</html>
<script src="/js/jquery.js"></script>
<script src="/js/bootstrap-table.js"></script>
<script src="/js/locale/bootstrap-table-zh-CN.js"></script>
<script type="text/javascript">
  function start() {

    var form = document.getElementById('form1');

    if(true){
      form.submit();
    }else{

    }

  }
  <c:if test="${openid == null}">
   window.location.href = 'https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxe4d148622d2837f6&redirect_uri=http://${config.domain}/wxpublic/result/no&response_type=code&scope=snsapi_base&state=yt#wechat_redirect';
  </c:if>
</script>
<style type="text/css">
  .hui-speed-dial-text{

    font-size: 14px;
  }
  .hui-icons{
    font-size: 30px !important;
    color: #F69F2E !important;
  }
</style>