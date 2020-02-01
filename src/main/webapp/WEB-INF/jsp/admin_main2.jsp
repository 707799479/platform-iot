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

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
      <script src="../../assets/js/html5shiv.js"></script>
      <script src="../../assets/js/respond.min.js"></script>
    <![endif]-->

</head>
<body>
<div class="container">
  <div class="top-navbar header b-b"> <a data-original-title="Toggle navigation" class="toggle-side-nav pull-left" href="#"><i style="position: relative;top: 7px;" class="icon-reorder"></i> </a>
    <div class="brand pull-left"> <a href="/"> </a></div>
    
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
      <li class="current"> <a href="/admin/main"> <i class="icon-list"></i> 首页 </a> </li>
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
      <li> <a href="/admin/websiteConfig"> <i class="icon-cogs"></i>网站配置</a> </li>
      <li> <a href="/admin/dataCenter"> <i class="icon-bar-chart"></i>数据中心</a> </li>
      <li> <a href="/admin/express"> <i class="icon-flag"></i>单号管理</a> </li>
      <li> <a href="/admin/feedback"> <i class="icon-tags"></i>反馈管理</a> </li>
      <li> <a href="/admin/updatePassword"> <i class="icon-cogs"></i>修改密码</a> </li>
        <li> <a href="/admin/orderList"> <i class="icon-tags"></i>订单管理</a> </li>  <li> <a href="http://${user_agent.domain}.${web_config.domain}"> <i class="icon-tags"></i>跳转我的网站</a> </li>
        <c:if test="${user_agent.parentId == 0}">
          <li> <a href="/admin/cardList"> <i class="icon-tags"></i>卡片列表</a> </li>
          <li> <a href="/admin/costList"> <i class="icon-tags"></i>实时资费</a> </li>
          <li> <a href="/admin/outfreecard"> <i class="icon-tags"></i>导出补卡单号</a> </li>
          <li> <a href="/admin/express"> <i class="icon-flag"></i>卡片管理</a> </li>
        </c:if>
        </ul>
    </div>
  </div>
  <div class="page-content">
    <div class="content container">
      <div class="row">
        <div class="col-lg-12">
          <h2 class="page-title">物联网卡后台 <small>快捷、便捷</small></h2>
        </div>
      </div>
      <div class="row">
        <div class="col-lg-6">
          <div class="widget widget-nopad">
            <div class="widget-header"> <i class="icon-list-alt"></i>
              <h3>Data</h3>
            </div>
            <!-- /widget-header -->
            <div class="widget-content">
              <div class="widget big-stats-container">
                <h6 class="bigstats">Big </h6>
                <div class="cf" id="big_stats">
                  <div class="stat">今日利润<i class="icon-money"></i> <span class="value">${todayMoney}</span> </div>
                  <div class="stat">账户余额<i class="icon-anchor"></i> <span class="value">${money}</span> </div>
                  <!-- .stat -->
                  
                  <div class="stat">代理总数<i class="icon-retweet"></i> <span class="value">${agentCount}</span> </div>
                  <!-- .stat -->
                  
                  <div class="stat">总订单数<i class="icon-user-md"></i> <span class="value">${orderCount}</span> </div>
                  <!-- .stat -->

                </div>
                <!-- /widget-content --> 
                
              </div>
            </div>
          </div>
        </div>
        <%--<div class="col-lg-6">
          <div class="widget">
            <div class="widget-header"> <i class="icon-bookmark"></i>
              <h3>控制中心</h3>
            </div>
            <!-- /widget-header -->
            <div class="widget-content">
              <div class="shortcuts"> <a class="shortcut" href="javascript:;"><i class="shortcut-icon icon-list-alt"></i><span class="shortcut-label">XXX</span> </a><a class="shortcut" href="javascript:;"><i class="shortcut-icon icon-bookmark"></i><span class="shortcut-label">XXX</span> </a><a class="shortcut" href="javascript:;"><i class="shortcut-icon icon-signal"></i> <span class="shortcut-label">XXX</span> </a><a class="shortcut" href="javascript:;"> <i class="shortcut-icon icon-comment"></i><span class="shortcut-label">XXX</span> </a><a class="shortcut" href="javascript:;"><i class="shortcut-icon icon-user"></i><span class="shortcut-label">XXX</span> </a><a class="shortcut" href="javascript:;"><i class="shortcut-icon icon-file"></i><span class="shortcut-label">XXX</span> </a><a class="shortcut" href="javascript:;"><i class="shortcut-icon icon-picture"></i> <span class="shortcut-label">XXX</span> </a><a class="shortcut" href="javascript:;"> <i class="shortcut-icon icon-tag"></i><span class="shortcut-label">待开发</span> </a> </div>
              <!-- /shortcuts --> 
            </div>
            <!-- /widget-content --> 
          </div>
        </div>--%>
      </div>

    </div>
  </div>
</div>
<div class="bottom-nav footer"> 科朗通信物联自管理门户 2019 &copy; </div>

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) --> 
<script src="/js/jquery.js"></script>
<script src="/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/js/smooth-sliding-menu.js"></script>

</body>
</html>