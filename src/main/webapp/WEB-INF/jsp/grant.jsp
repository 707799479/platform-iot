<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
  <title>实名认证</title>
  <link rel="stylesheet" type="text/css" href="./css/hui.css" />
</head>
<body>
<header class="hui-header">
  <div id="hui-back"></div>
  <h1>实名认证</h1>
  <div id="hui-header-menu"></div>
</header>
<div class="hui-wrap">
  <div style="display: none;" id="hui-black-mask">
    <!-- 演示消息内容 -->
    <div  id="hui-black-mask-content">
      <div id="hui-black-action">
        <div id="hui-black-close"></div>
      </div>
      <h1 style="color: #fff;text-align: center;">为了您操作安全</h1>
      <h1 style="color: #fff;text-align: center;">请完成图形认证</h1>
      <div style="text-align:center;"><a href="javascript:imgChange()"><img id="img" style="width:100%;" src="http://www.localhost.com:81/getCode" /></a></div>
      <input id="codeT" style="height: 35px;margin-top:5px;" type="text" class="hui-input hui-input-clear" name="nickname" placeholder="图形验证码" />
      <div style="text-align:center; color:#FFFFFF; margin-top: 10px;">

        <button onclick="getCode()" type="button" style="width: 100%;height: 30px; line-height: 30px;" class="hui-button hui-primary" >发送验证码到手机</button>
      </div>

    </div>

  </div>

  <form style="padding:28px 10px;" class="hui-form" id="form1">
    <div class="hui-form-items">
      <div class="hui-form-items-title">真实姓名:</div>
      <input id="name" type="text" class="hui-input hui-input-clear" name="nickname" placeholder="您的真实姓名" />
    </div>
    <div class="hui-form-items">
      <div class="hui-form-items-title">身份证号:</div>
      <input id="sfid" type="text" class="hui-input hui-input-clear" name="nickname" placeholder="18位身份证号码" />
    </div>
    <div class="hui-form-items">
      <div class="hui-form-items-title">手机号码:</div>
      <input id="phone" type="text" class="hui-input hui-input-clear" name="nickname" placeholder="11位手机号码" />
    </div>
    <div class="hui-form-items">
      <div class="hui-form-items-title">短信验证:</div>
      <input id="code" type="text" class="hui-input hui-input-clear" name="nickname" placeholder="短信验证码" />
      <button id="get" type="button" style="width: 80%; border-radius: 5px;" class="hui-button-sm hui-primary" >获取</button>
    </div>
  </form>

  <div style="display: flex;" id="btnList1" >
    <button  onclick="sub()" type="button" style="width: 100%; margin: 10px;" class="hui-button hui-primary" >立即认证</button>
  </div>
</div>
</div>
<script src="./js/hui.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">

  hui.blackMask();
  hui("#get").click(function(){
    if(hui("#get").html() == '获取') {
      var phone = hui('#phone').val();
      var codeT = hui('#codeT').val();
      if (phone.length == 11) {
        hui.get("/sendCode?phone=" + phone + "&code=" + codeT, function (res) {
          if (res == 'success') {
            alert("验证码已发送到您手机");
            hui('#hui-black-close').click();
          } else {
            alert("获取失败");
          }
        });
        localStorage.setItem("code", 60);
        hui("#get").html("60");
      } else {
        alert("数据填写不完整");
      }
    }
  });

  function getCode(){



  }

  setInterval(function(){
    var code = localStorage.getItem('code');

    if(code != 'ok'){
      code--;
      localStorage.setItem("code",code);
      hui("#get").html(code);
      if(code < 1){
        localStorage.setItem('code','ok');
        hui("#get").html("获取");
      }
    }else{
      console.log("空的");
    }
  },1000);

  function imgChange(){
    hui("#img").attr('src', '/getCode?'+new Date().getTime());
  }

  function sub(){
    var name = hui('#name').val();
    var phone = hui('#phone').val();
    var sfid = hui('#sfid').val();
    var code = hui('#code').val();
    if(name.length > 1 && phone.length == 11 && sfid.length == 18){
      hui.get('/grantSubmit?name='+name+'&phone='+phone+'&sfid='+sfid+'&code='+code,function (res) {
        if(res > 0){
          alert("认证成功");

          <c:if test="${diy != null}">
          window.location.href = '/start?d=t';
          </c:if>
          <c:if test="${diy == null}">
          window.location.href = '/start';
          </c:if>
        }else if(res == -4){
          alert("验证码错误");
        }else if(res == -10){
          alert("手机号已经认证过其他号码了！");
        }else{
          alert("认证失败");
        }
      });
    }else{
      alert("请确保数据填写正确");
    }
  }

</script>
</body>
</html>