<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0, user-scalable=0">
    <title>实名认证</title>
    <link rel="stylesheet" type="text/css" href="/css/hui.css"/>
    <link rel="stylesheet" href="/vendors/css/vendor.bundle.base.css">
    <link rel="stylesheet" href="/vendors/iconfonts/mdi/css/materialdesignicons.min.css">
    <link rel="stylesheet" href="/css/style.css">
    <style>
        * {
            padding: 0;
            margin: 0;
            color: #5d5d5d;
        }

        h1, h2, h3, h4, h5, h6, .h1, .h2, .h3, .h4, .h5, .h6 {
            margin: 0;
        }

        .hui-header {
            background: #f1c205!important;
        }

        .hui-header h1 {
            padding-left: 0;
        }

        .hui-form-items {
            padding: 0.8rem 1rem;
            font-size: 0.94rem;
        }

        .hui-form-items-title {
            width: 26%;
            font-size: 0.94rem;
        }

        .info_c {
            padding: 1rem;
            font-size: 0.8rem;
            color: #FFF;
            background: #fe7e56;
        }

        .bc1 {
            background: #F4F4F4;
        }

        .bc2 {
            background: #f1c205;
        }

        .mr-b-1 {
            margin-bottom: 1rem;
        }

        .pd1 {
            padding: 1rem;
        }

        .mr-t-10 {
          margin-top: 10rem;
         }

        .pd-b-0 {
            padding-bottom: 0 !important;
        }

        .c2 {
          color: #fe7e56 !important;
        }

        .c3 {
          color: #64a0ef !important;
        }

        .c4 {
          color: #f0ad4e !important;
        }
    </style>
</head>
<body class="bc1">
<header class="hui-header">
    <div id="hui-back"></div>
    <h1>实名认证</h1>
</header>
<div class="hui-wrap mr-b-1">
    <div class="info_c  mr-b-1">尊敬的用户为了贯彻工信部《电话用户真实身份信息登记规定》，请对您购买的流量卡进行十几名认证。</div>
    <form class="hui-form" id="form1">
        <div class="hui-form-items">
            <div class="hui-form-items-title">真实姓名:</div>
          <input type="text" class="hui-input hui-input-clear" name="nickname" placeholder="您的真实姓名" checktype="string" checkdata="2,10" checkmsg="姓名应为2-20个字符">
        </div>
        <div class="hui-form-items">
            <div class="hui-form-items-title">SIM卡号:</div>
            <input id="SIM" type="text" class="hui-input hui-input-clear" name="nickname" placeholder="SIM卡号"/>
        </div>
        <div class="hui-form-items">
            <div class="hui-form-items-title">手机号码:</div>
            <input id="phone" type="text" class="hui-input hui-input-clear" name="nickname" placeholder="11位手机号码"/>
        </div>
        <div class="hui-form-items">
            <div class="hui-form-items-title">身份证号:</div>
            <input id="sfid" type="text" class="hui-input hui-input-clear" name="nickname" placeholder="18位身份证号码"/>
        </div>
    </form>
</div>


<div class="pd1 mr-t-10">
    <button id="submitBtn"  type="button" class="hui-button bc2 text-white hui-button-large">立即认证
    </button>
</div>
</div>
<script src="/js/hui.js" type="text/javascript"></script>
<script src="/js/hui-form.js" type="text/javascript"></script>
<script>
  //表单验证
  var loves;
  hui('#submitBtn').click(function(){
    var res = huiFormCheck('#form1');
    //提交
    if(res){
      hui.iconToast('验证通过！');
      var data = hui.getFormData('#form1');
      data.loves = loves;
      console.log(JSON.stringify(data));
    }
  });
</script>
</body>
</html>