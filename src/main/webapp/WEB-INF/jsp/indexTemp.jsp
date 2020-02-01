<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>${agent.websiteName}平台</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="robots" content="all,follow">
    <!-- Bootstrap CSS-->
    <link rel="stylesheet" href="vendor/bootstrap/css/bootstrap.min.css">
    <!-- Font Awesome CSS-->
    <link rel="stylesheet" href="vendor/font-awesome/css/font-awesome.min.css">
    <!-- Fontastic Custom icon font-->
    <link rel="stylesheet" href="css/fontastic.css">
    <!-- Google fonts - Poppins -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Poppins:300,400,700">
    <!-- theme stylesheet-->
    <link rel="stylesheet" href="css/style.default.css" id="theme-stylesheet">
    <!-- Custom stylesheet - for your changes-->
    <link rel="stylesheet" href="css/custom.css">
    <!-- Favicon-->
    <link rel="shortcut icon" href="img/favicon.ico">
    <!-- Tweaks for older IEs--><!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script><![endif]-->
  </head>
  <body>
    <div class="page">
      <!-- Main Navbar-->
      <header class="header">
        <nav class="navbar">
          <!-- Search Box-->
          <div class="search-box">
            <button class="dismiss"><i class="icon-close"></i></button>
            <form id="searchForm" action="#" role="search">
              <input type="search" placeholder="What are you looking for..." class="form-control">
            </form>
          </div>
          <div class="container-fluid">
            <div class="navbar-holder d-flex align-items-center justify-content-between">
              <!-- Navbar Header-->
              <div class="navbar-header">
                <!-- Navbar Brand --><a href="index.html" class="navbar-brand d-none d-sm-inline-block">
                  <div class="brand-text d-none d-lg-inline-block"><span>${agent.websiteName}</span><strong>平台</strong></div>
                  <div class="brand-text d-none d-sm-inline-block d-lg-none"><strong>BD</strong></div></a>
                <!-- Toggle Button--><a id="toggle-btn" href="#" class="menu-btn active"><span></span><span></span><span></span></a>
              </div>
              <!-- Navbar Menu -->
             
            </div>
          </div>
        </nav>
      </header>
      <div class="page-content d-flex align-items-stretch"> 
        <!-- Side Navbar -->
        <nav class="side-navbar">
          <!-- Sidebar Header-->
          <div class="sidebar-header d-flex align-items-center">
            <div class="avatar"><img src="img/avatar-1.jpg" alt="..." class="img-fluid rounded-circle"></div>
            <div class="title">
              <h1 class="h4">  </h1>
              <p></p>
            </div>
          </div>
          <!-- Sidebar Navidation Menus--><span class="heading">导航</span>
          <ul class="list-unstyled">
            <li class="active"><a href="/index"> <i class="icon-home"></i>首页 </a></li>
            <li><a href="/admin"> <i class="icon-interface-windows"></i>后台登录</a></li>
            <li><a href="/express"> <i class="icon-grid"></i>单号查询 </a></li>
            <li><a href="/feedback"> <i class="fa fa-bar-chart"></i>人工客服 </a></li>
          </ul>
        </nav>
        <div class="content-inner">
          <!-- Page Header-->
          <header class="page-header">
            <div class="container-fluid">
              <h2 class="no-margin-bottom">${agent.websiteName}平台</h2>
            </div>
          </header>
          <!-- Dashboard Counts Section-->
		  
          
          <!-- Dashboard Header Section    -->
          <section style="padding:20px; margin-bottom:35px; text-align:center;" class="dashboard-header">
            <button onclick="javascript:window.location.href= '/reg';" style='width:100%; background-color:#2F333E; 'type="button" data-toggle="modal" data-target="#myModal" class="btn btn-primary">申请成为通信服务商</button>
          </section>
          <!-- Projects Section-->
          
          <!-- Client Section-->
          
          <!-- Feeds Section-->
		  
          <section id='accordion' class="feeds no-padding-top">
           <div style="margin:15px;" class="card">
			<div class="card-body">公告：${agent.notice}</div>
		  </div>
                <!-- Trending Articles-->
				
                <div class="col-lg-12">
                  <div class="articles card">
                    
                    <div class="card-header d-flex align-items-center">
                      <h2 class="h3">资费分类</h2>
                     <!-- <div class="badge badge-rounded bg-green">共50个商品</div>-->
					 <div class="badge badge-rounded bg-green" ></div>
                    </div>
                    <div class="card-body no-padding">
                      <c:forEach var="cl" items="${pclass}">
                      <div onclick="dianji(${cl.id})" class="item d-flex align-items-center">
                        <div class="image"><img src="https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1551682400986&di=194d0ce66e13c3fd68b1a963162781ab&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F01d233583bd7b7a8012060c820fc5e.png%401280w_1l_2o_100sh.png" alt="..." class="img-fluid rounded-circle"></div>
                        <div class="text"><a href="list?aid=${agent.id}&pcid=${cl.id}">
                          <h3 class="h5">${cl.name}</h3></a><small>${cl.note}</small></div>
                      </div>
                    </c:forEach>
                  </div>
                  </div>
                </div>
                <!-- Check List -->
               
              
			<div class="col-lg-12">
                  <div  class="articles card">
                    
                    <div class="card-header d-flex align-items-center">
                      <h2 class="h3">实时资费更新 </h2>
                      
					 
					<div class="badge badge-rounded bg-green" ><a style="color:#fff" data-toggle="collapse" data-parent="#accordion" 
				   href="#sszf">
					展开
				</a></div>
					
				
                    </div>
                    <div id="sszf" class="card-body no-padding collapse">
                      <c:forEach var="map" items="${costs}">
                        <div class="item d-flex">
                          <input type="checkbox" id="input-1" name="input-1" class="checkbox-template">
                          <label for="input-1">${map.note}</label>
                        </div>
                      </c:forEach>
                    </div>
                  </div>
                </div>
			<div class="col-lg-12">
                  <div  class="articles card">
                    
                    <div class="card-header d-flex align-items-center">
                      <h2 class="h3">网站信息 </h2>
                      
					 
					<div class="badge badge-rounded bg-green" ><a style="color:#fff" data-toggle="collapse" data-parent="#accordion" 
				   href="#collapseOne">
					展开
				</a></div>
                    </div>
                    <div id='collapseOne' class="card-body no-padding collapse">
                      
				<div class="container-fluid " style="padding:10px;">
					  
				<div class="statistic d-flex align-items-center bg-white has-shadow">
                    <div class="icon bg-red"><i class="fa fa-tasks"></i></div>
                    <div class="text"><span>网站访问</span><br><strong>${config.web_fangwen}</strong></div>
                  </div>
				  <div class="statistic d-flex align-items-center bg-white has-shadow">
                    <div class="icon bg-green"><i class="fa fa-calendar-o"></i></div>
                    <div class="text"><span>订单总数</span><br><strong>${config.order_number}</strong></div>
                  </div>
				  <div class="statistic d-flex align-items-center bg-white has-shadow">
                    <div class="icon bg-orange"><i class="fa fa-paper-plane-o"></i></div>
                    <div class="text"><span>成交金额</span><br><strong>${config.success_money}</strong></div>
                  </div>
				  <div class="statistic d-flex align-items-center bg-white has-shadow">
                    <div class="icon bg-violet"><i class="icon-user"></i></div>
                    <div class="text"><span>旗下代理</span><br><strong>${config.down_agent}</strong></div>
                  </div>
				</div>
                      
                    </div>
                  </div>
                </div>
          </section>
          <!-- Updates Section                                                -->
          <section class="updates no-padding-top">
            <div class="container-fluid">
              <div class="row">
                <!-- Recent Updates-->
                
                <!-- Daily Feeds -->
               
                <!-- Recent Activities -->
               
              </div>
            </div>
          </section>
          <!-- Page Footer-->
          <footer class="main-footer">
            <div class="container-fluid">
              <div class="row">
                <div class="col-sm-6">
                  <p>科朗通信物联自管理门户&copy; 2017-2019</p>
                </div>
                <div class="col-sm-6 text-right">
                  
                  <!-- Please do not remove the backlink to us unless you support further theme's development at https://bootstrapious.com/donate. It is part of the license conditions. Thank you for understanding :)-->
                </div>
              </div>
            </div>
          </footer>
        </div>
      </div>
    </div>
    <!-- JavaScript files-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/popper.js/umd/popper.min.js"> </script>
    <script src="vendor/bootstrap/js/bootstrap.min.js"></script>
    <script src="vendor/jquery.cookie/jquery.cookie.js"> </script>
    <script src="vendor/chart.js/Chart.min.js"></script>
    <script src="vendor/jquery-validation/jquery.validate.min.js"></script>
    <script src="js/charts-home.js"></script>
    <!-- Main File-->
    <script src="js/front.js"></script>
  </body>
</html>