<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>后台管理中心</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- Bootstrap -->
<link href="/css/bootstrap.css" rel="stylesheet" media="screen">
<link href="/css/thin-admin.css" rel="stylesheet" media="screen">
<link href="/css/font-awesome.css" rel="stylesheet" media="screen">
<link href="/style/style.css" rel="stylesheet">
<link href="/style/dashboard.css" rel="stylesheet">
<link href="http://zm921.com:8080/grant/statics/layui/css/layui.css" rel="stylesheet">

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
      <script src="../../assets/js/html5shiv.js"></script>
      <script src="../../assets/js/respond.min.js"></script>
    <![endif]-->

</head>
<body>
<div class="container">
  <div class="top-navbar header b-b"> <a data-original-title="Toggle navigation" class="toggle-side-nav pull-left" href="#"><i style="position: relative;top: 7px;" class="icon-reorder"></i> </a>
    <div class="brand pull-left"> <a href="index.html"> </a></div>

    <ul class="nav navbar-nav navbar-right  hidden-xs">
      <li class="dropdown user  hidden-xs"> <a data-toggle="dropdown" class="dropdown-toggle" href="#"> <i class="icon-male"></i> <span class="username">我的</span> <i class="icon-caret-down small"></i> </a>
        <ul class="dropdown-menu">
          <li class="divider"></li>
           <li><a href="/admin/out"><i class="icon-key"></i>退出</a></li>
        </ul>
      </li>
    </ul>
    <form class="pull-right" >

    </form>
  </div>
</div>
<div class="wrapper">
  <div class="left-nav">
    <div id="side-nav">
      <ul id="nav">
        <li > <a href="/admin/main"> <i class="icon-list"></i> 首页 </a> </li>
        <li> <a href="#"> <i class="icon-edit"></i>套餐管理<i class="arrow icon-angle-left"></i></a>
          <ul class="sub-menu">
            <li> <a href="/admin/commodityClass"> <i class="icon-angle-right"></i>卡分类</a> </li>
            <li> <a href="/admin/addClass"> <i class="icon-angle-right"></i>添加分类</a> </li>
            <li> <a href="/admin/commodityList"> <i class="icon-angle-right"></i>套餐列表</a> </li>
            <li> <a href="/admin/addCommodity"> <i class="icon-angle-right"></i>添加套餐</a> </li>
          </ul>
        </li>
        <li> <a href="#"> <i class="icon-user"></i>代理管理<i class="arrow icon-angle-left"></i></a>
          <ul class="sub-menu">
            <li> <a href="/admin/agentList"> <i class="icon-angle-right"></i>代理列表</a> </li>
            <li class="current"> <a href="/admin/addAgent"> <i class="icon-angle-right"></i>添加代理</a> </li>
          </ul>
        </li>
        <li> <a href="#"> <i class="icon-money"></i>提现<i class="arrow icon-angle-left"></i></a>
          <ul class="sub-menu">
            <li> <a href="/admin/extract"> <i class="icon-angle-right"></i>申请提现</a> </li>
            <li> <a href="/admin/extractLog"> <i class="icon-angle-right"></i>提现记录</a> </li>
          </ul>
        </li>
        <li > <a href="/admin/websiteConfig"> <i class="icon-cogs"></i>网站配置</a> </li>
        <li> <a href="/admin/dataCenter"> <i class="icon-bar-chart"></i>数据中心</a> </li>
        <li> <a href="/admin/express"> <i class="icon-flag"></i>单号管理</a> </li>
        <li> <a href="/admin/feedback"> <i class="icon-tags"></i>反馈管理</a> </li>
        <li  > <a href="/admin/updatePassword"> <i class="icon-cogs"></i>修改密码</a> </li>
        <li> <a href="/admin/orderList"> <i class="icon-tags"></i>订单管理</a> </li>  <li> <a href="http://${user_agent.domain}.${web_config.domain}"> <i class="icon-tags"></i>跳转我的网站</a> </li>

      </ul>
    </div>
  </div>
  <div class="page-content">
    <div class="content container">
      <div class="row">
        <div class="col-lg-12">
          <h2 class="page-title">添加代理<small>您可以在这里添加代理</small></h2>
        </div>
      </div>
      <div class="row">
        <div class="widget">
            <div class="widget-header"> <i class="icon-arrow-down"></i>
              <h3>代理信息</h3>
            </div>
            <div class="widget-content">
              <div class="body">
                <form id="regForm" action="/admin/addAgent" method="post">
                  <div>
                    <div class="form-group">
                      <label for="search-input">账号：</label>
                      <div class="input-group" style="width:100%;">
                        <input onKeyUp="value=value.replace(/[^\w|chun]/g,'')" type="text" id="account" name="account" class="form-control">
                        <span class="input-group-btn">
                        </span> </div>
                    </div>
                    <div class="form-group">
                      <label for="search-input">密码：</label>
                      <div class="input-group" style="width:100%;">
                        <input type="password" id="passowrd" name="password" class="form-control">
                        <span class="input-group-btn">
                        </span> </div>
                    </div>
                    <div class="form-group">
                      <label for="search-input">联系电话：</label>
                      <div class="input-group" style="width:100%;">
                        <input type="number" maxlength="11" id="qq" name="qq" class="form-control">
                        <span class="input-group-btn">
                        </span> </div>
                    </div>
                    <div class="form-group">
                      <label for="search-input">二级域名(只能英文或者数字不能有任何标点符号)：</label>
                      <div class="input-group" style="width:100%;">
                        <input onKeyUp="value=value.replace(/[^\w|chun]/g,'')" type="text" id="domain" name="domain" class="form-control">
                        <span class="input-group-btn">
					</span> </div>
                    </div>
                    <div class="form-group">
                      <label for="search-input">网站名称：</label>
                      <div class="input-group" style="width:100%;">
                        <input type="text" id="websiteName" name="websiteName" class="form-control">
                        <span class="input-group-btn">
                        </span> </div>
                    </div>
                    <div class="form-group">
                      <label for="search-input">提现账号：</label>
                      <div class="input-group" style="width:100%;">
                        <input type="text" id="tAccount" name="tAccount" class="form-control">
                        <span class="input-group-btn">
                        </span> </div>
                    </div>
                    <div class="form-group">
                      <label for="search-input">提现姓名(真实姓名用于提现)：</label>
                      <div class="input-group" style="width:100%;">
                        <input type="text" id="tName" name="tName" class="form-control">
                        <span class="input-group-btn">
                        </span> </div>
                    </div>

                    <a class="btn btn-s-md btn-default" href="javascript:addAgent()">开通代理</a>
                  </div>
                </form>

              </div>

            </div>
          </div>
      </div>


    </div>
  </div>
</div>


<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="/js/jquery.js"></script>
<script src="/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/js/smooth-sliding-menu.js"></script>
<script type="text/javascript" src="http://zm921.com:8080/grant/statics/layui/layui.js"></script>

</body>
</html>
<script src="/js/jquery.js"></script>
<script type="text/javascript">

  var ok = '${alert}';
  if(ok.length > 1){
      alert("添加成功");
      window.location.href = "/admin/addAgent";
  }
  function addAgent() {
      var num = $(":input").length;
      for(var i = 0;i < num;i++){
          var t = $(":input").eq(i).val().length;
          if(t < 1){
              alert("不能有空项");
              return;
          }
      }
      $.get("/checkAccount",{a:$("#account").val()},function (result) {
          if(result == 0){

              $.get("/checkDomain",{d:$("#domain").val()},function (res) {
                  if(res == 0){
                      $("#regForm").submit();
                  }else{
                      alert("域名已被使用，请换一个吧。");
                  }
              });
          }else{
              alert("用户名已存在");
              return;
          }
      });
  }
</script>