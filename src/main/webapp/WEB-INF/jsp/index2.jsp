<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
  <title>充值平台</title>
  <link rel="stylesheet" type="text/css" href="/css/hui.css" />
</head>
<body>
<header class="hui-header">
  <h1>充值平台</h1>
</header>
<div class="hui-wrap">
  <div style="height: 10px;"></div>
  <form style="padding:28px 10px;" method="post" action="/start" class="hui-form" id="form1">
    <div class="hui-form-items">
      <div class="hui-form-items-title">输入卡号:</div>
      <c:if test="${diy != null}">
        <input type="hidden" value="t" name="d">
      </c:if>
      <input type="text" class="hui-input hui-input-clear" name="iccid" placeholder="如：199554654654XXX" />
    </div>
  </form>
  <div style="padding:28px 20px 10px 20px;" id="btnList1">
    <p style="text-align: center;color: red;">${start_note}</p><br>
    <button onclick="start()" type="button" class="hui-button hui-button-large hui-primary" >进入</button>
  </div>

</div>
</div>
<script src="/js/hui.js" type="text/javascript" charset="utf-8"></script>

<script type="text/javascript">
  function start() {

    var form = document.getElementById('form1');

    if(true){
      form.submit();
    }else{

    }

  }

    <c:if test="${openid == null && diy != null}">
     // window.location.href = 'https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx09593ca188ca98a0&redirect_uri=http://www.${config.domain}/wxpublic/result/ok&response_type=code&scope=snsapi_base&state=www#wechat_redirect';
    </c:if>
    <c:if test="${openid == null && diy == null}">
      //window.location.href = 'https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx09593ca188ca98a0&redirect_uri=http://www.${config.domain}/wxpublic/result/no&response_type=code&scope=snsapi_base&state=www#wechat_redirect';
    </c:if>
</script>
</body>
</html>