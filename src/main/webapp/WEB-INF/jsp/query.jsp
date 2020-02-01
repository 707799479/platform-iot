<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
  <title>查询</title>
  <link rel="stylesheet" type="text/css" href="./css/hui.css" />
</head>
<body>
<header class="hui-header">
  <div id="hui-back"></div>
  <h1>查询</h1>
  <div id="hui-header-menu"></div>
</header>
<div class="hui-wrap">
  <div style="height: 10px;"></div>
  <form style="padding:28px 10px;" class="hui-form" id="form1">

    <c:if test="${setmeal==null}">
      <c:if test="${upsetmeal != null}">
        <p style="color: red;">您订购的套餐【${upsetmeal.name}】已用尽或已到期。</p>
      </c:if>
      <c:if test="${upsetmeal == null}">
        <p style="color: red;">您还未订购套餐或您的套餐已到期。</p>
      </c:if>

    </c:if>
    <c:if test="${setmeal != null && setmeal!='noInfo'}">
      <p>套餐名称：${setmeal.name}</p>
      <p>已用流量：${setmeal.imgUrl}</p>
      <c:if test="${setmeal.note != null}">
        <p>总共流量：${setmeal.note}M</p>
      </c:if>
      <p>生效时间：${startenddata["go_time"]}</p>
      <p>结束时间：${startenddata["end_time"]}</p>
    </c:if>

  </form>
  <div style="padding:0px 20px 0px 20px;" id="btnList1">
    <p style="text-align: center;color: red;"></p><br>
  </div>

</div>
</div>
<script src="./js/hui.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">

</script>
</body>
</html>
<style type="text/css">
  .hui-form-radios input[type="radio"]:checked + label:before{
    color: #F69F2E !important;
  }

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