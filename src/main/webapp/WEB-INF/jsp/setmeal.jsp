<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
  <title>套餐订购</title>
  <link rel="stylesheet" type="text/css" href="./css/hui.css" />
  <link rel="stylesheet" href="/vendors/css/vendor.bundle.base.css">
  <link rel="stylesheet" href="/vendors/iconfonts/mdi/css/materialdesignicons.min.css">
</head>
<body>
<header class="hui-header">
  <div id="hui-back"></div>
  <h1>套餐订购</h1>
  <div id="hui-header-menu"></div>
</header>
<div class="hui-wrap">
  <div style="height: 10px;"></div>
  <form style="padding:28px 10px;" class="hui-form" id="form1" method="post" action="/setmeal">

    <div class="hui-form-radios" style="line-height:38px;">
      <input type="hidden" value="now" name="status" id="status">
      <c:forEach var="st" items="${setmealList}" varStatus="status">
        <input type="radio" value="${st.id}" name="setmeal" ${status.index == 0? 'checked="checked" ' :''} id="radio${st.id}" /><label for="radio${st.id}" >${st.name}</label><br />
      </c:forEach>
      <c:if test="${setmealList == null}">
        <h3>暂无套餐</h3>
      </c:if>
    </div>

  </form>
  <div style="display: flex;" id="btnList1">
    <p style="text-align: center;color: red;"></p><br>
    <button onclick="dinggou('now')" style="width: 100%" type="button" class="btn btn-gradient-secondary btn-rounded btn-fw">订购</button>
  </div>

</div>
</div>
<script src="./js/hui.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
  function dinggou(status) {
    document.getElementById('status').value = status;
    var form = document.getElementById('form1');
    form.submit();
  }
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