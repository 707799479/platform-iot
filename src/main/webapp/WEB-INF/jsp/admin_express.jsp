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
      <input type="search" placeholder="Search..." class="search" id="search-input">
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
            <li> <a href="/admin/addAgent"> <i class="icon-angle-right"></i>添加代理</a> </li>
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
        <li class="current"> <a href="/admin/express"> <i class="icon-flag"></i>单号管理</a> </li>
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
          <h2 class="page-title">单号录入<small> 系统已录入：${expressCount}个单号</small></h2>
        </div>
      </div>
      <div class="row">
        <div class="widget">
          <div class="widget-header"> <i class="icon-arrow-down"></i>
            <h3>单号录入(建议每次录入的数据量保持在1000以内 速度最佳)</h3>
          </div>
          <div class="widget-content">
            <div class="body">
              <div>
                <div class="form-group col-md-4">
                  <label for="search-input">下单姓名：</label>
                  <div class="input-group" style="width:100%;">
                    <textarea id="names" class="form-control" rows="10" name="note"></textarea>
                    <span class="input-group-btn">
                        </span> </div>
                </div>

                <div class="form-group col-md-4">
                  <label for="search-input">下单手机号：</label>
                  <div class="input-group" style="width:100%;">
                    <textarea id="phones" class="form-control" rows="10" name="note"></textarea>
                    <span class="input-group-btn">
                        </span> </div>
                </div>
                <div class="form-group col-md-4">
                  <label for="search-input">快递单号：</label>
                  <div class="input-group" style="width:100%;">
                    <textarea id="express" class="form-control" rows="10" name="note"></textarea>
                    <span class="input-group-btn">
                        </span> </div>
                </div>


                <a class="btn btn-s-md btn-default" style="width:100%;" href="javascript:checkText();">保存</a>
              </div>
            </div>

          </div>
        </div>
      </div>

    </div>
  </div>
</div>


<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="/vendor/jquery/jquery.min.js"></script>
<script src="/js/bootstrap.min.js"></script>
<script src="/js/smooth-sliding-menu.js"></script>


</body>
</html>
<script src="/vendor/jquery/jquery.min.js"></script>
<script type="text/javascript">

function checkText(){
    var names =$("#names").val();
    var phones =$("#phones").val();
    var express =$("#express").val();
    names = names.split("\n");
    phones = phones.split("\n");
    express = express.split("\n");
    for(var i = 0;i<names.length;i++){
        if(names[i].length == 0){
            names.splice(i,1);
            i = i-1;
        }
    }
    for(var i = 0;i<phones.length;i++){
        if(phones[i].length == 0){
            phones.splice(i,1);
            i = i-1;
        }
    }
    for(var i = 0;i<express.length;i++){
        if(express[i].length == 0){
            express.splice(i,1);
            i = i-1;
        }
    }
    if(names.length == 0){
        alert("数据不能为空");
        return;
    }
    if(!(names.length == phones.length)){
        alert("下单姓名和下单手机号不匹配，下单姓名共有："+names.length+"个，下单手机号共有："+phones.length+"个，请检查数据中是否有空的换行。");
    }else if(!(phones.length == express.length)){
        alert("下单手机号和快递单号不匹配，下单手机号共有："+phones.length+"个，快递单号共有："+express.length+"个，请检查数据中是否有空的换行。");
    }else{
        names = names.join("#");
        phones = phones.join("#");
        express = express.join("#");

        $.post("/admin/addExpress",{names:names,phones:phones,express:express},function(result){
            if(result == 1){
                $("#names").val("");
                $("#phones").val("");
                $("#express").val("");
                alert("保存成功");
            }else{
                alert("保存失败");
            }
        });

    }
}
</script>