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
  <h1>反馈列表</h1>
  <div id="hui-header-menu"></div>


</header>

<div class="hui-wrap">
  <div onclick="fankui()" style="box-shadow: darkgrey 10px 3px 10px 3px ;margin: 5px; right:0px;bottom:0px;margin: 10px; background-color: #3388FF; color: #fff; width: 60px;height: 60px;border-radius: 50%;line-height: 60px;text-align: center; position:fixed;">反馈</div>
  <br>
  <c:forEach var="feedback" items="${feedbackList}">

    <div style="margin: 5px 5px 13px 5px; background-color: #fff;border-radius: 5px;box-shadow: darkgrey 10px 3px 10px 3px ;">
      <p style="float: left; line-height: 40px;text-overflow: ellipsis;overflow: hidden;white-space: nowrap; width: 65%;">&nbsp;${feedback.note}</p>

      <button onclick="javascript:window.location.href='/feedbackView?id='+'${feedback.id}'" style="width: 20%; float: right;" class="hui-button">查看</button>
      <c:if test="${feedback.note2 == null}">
        <p style="width: 15%;float: right;line-height: 40px; color: red;">未解决</p>
      </c:if>
      <c:if test="${feedback.note2 != null}">
        <div style="position: relative;top: 9px;right: 66px;"><c:if test="${feedback.status!=0}"><span style="position: fixed; " class="hui-badge hui-danger">有回复</span></c:if></div>
        <p style="width: 15%;float: right;line-height: 40px; color: green;">已解决</p>
      </c:if>
    </div>

  </c:forEach>
  <c:if test="${feedbackList == null}">
    <h1 style="text-align: center;">您还没有反馈记录，赶快去反馈吧</h1>
  </c:if>

</div>
</div>
<script src="./js/hui.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
    function fankui() {
      var okfankui = ${okfankui};
      if(okfankui){
        alert("充值之后才可以反馈！");
      }else{
        window.location.href='/feedback';
      }

    }
</script>
</body>
</html>