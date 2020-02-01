<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
  <title>问题反馈</title>
  <link rel="stylesheet" type="text/css" href="./css/hui.css" />
</head>
<body>
<header class="hui-header">
  <div id="hui-back"></div>
  <h1>反馈详情</h1>
  <div id="hui-header-menu"></div>
</header>
<div class="hui-wrap">
  <form class="hui-form">
    <div class="hui-form-items">
      <div class="hui-form-items-title">您的问题:</div>
      <div class="hui-form-textarea">
        <p>${feedback.note}</p>
      </div>
    </div>
    <div class="hui-form-items">
      <div class="hui-form-items-title">客服答复:</div>
      <div class="hui-form-textarea">
        <p style="color: green;">${feedback.note2}</p>
      </div>
    </div>
    <div>
      <p style="float: right;margin-right: 10px;">反馈时间：<fmt:formatDate value="${feedback.create_time}" type="date" pattern="yyyy-MM-dd HH:mm"/></p>
    </div>
  </form>
</div>
</div>
<script src="./js/hui.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">

</script>
</body>
</html>