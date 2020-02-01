<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
  <h1>反馈问题</h1>
  <div id="hui-header-menu"></div>
</header>
<div class="hui-wrap">
  <form method="post" action="/feedback" class="hui-form">
    <div class="hui-form-items">
      <div class="hui-form-items-title">问题:</div>
      <div class="hui-form-textarea">
        <input type="hidden" name="iccid" value="ok">
        <textarea placeholder="故障描述..." name="note"></textarea>
      </div>
    </div>
    <button type="submit" class="hui-button hui-button-large hui-primary" style="margin-top:15px;">发送反馈</button>
  </form>
</div>
</div>
<script src="./js/hui.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">

</script>
</body>
</html>