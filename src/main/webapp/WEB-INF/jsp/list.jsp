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
          
          <!-- Sidebar Navidation Menus-->
          <ul class="list-unstyled">
              <li><a href="index"> <i class="icon-home"></i>首页 </a></li>
              <c:forEach var="cl" items="${pclass}">
                  <li <c:if test="${tempClassId == cl.id}">
                      class="active"
                      <c:set var="headName" value="${cl.name}" />
                  </c:if>><a href="list?aid=${agent.id}&pcid=${cl.id}"> <i class="icon-padnote"></i>${cl.name}</a></li>
              </c:forEach>
          </ul>
          
        </nav>
        <div class="content-inner">
          <!-- Page Header-->
          <header class="page-header">
            <div class="container-fluid">
              <h2 class="no-margin-bottom">${headName}</h2>
            </div>
          </header>
          <!-- Dashboard Counts Section-->
		  
       
          <!-- Feeds Section-->
		  
          <section style="margin-top:20px;" class="feeds no-padding-top">
		  
		 
		  
            <div class="container-fluid">
              <div class="row">
                <!-- Trending Articles-->
				<div class="col-lg-12">
                  <div class="articles card">
                    
                    <div class="card-header d-flex align-items-center">
                      <h2 class="h3">套餐列表 </h2>
                      
                    </div>
                    <div style='text-align:center;' class="card-body no-padding">

                        <c:forEach var="commodity" items="${commodityList}">
                            <div style="margin:20px;" class="project">
                                <div class="row bg-white has-shadow">
                                    <div class="left-col col-lg-12 d-flex align-items-center justify-content-between">
                                        <div class="project-title d-flex align-items-center">
                                            <div class="image has-shadow"><img src="${commodity.imgUrl}" alt="..." class="img-fluid"></div>
                                            <div style="text-align: left;" class="text">
                                                <h3 class="h4">${commodity.name}</h3><small>价格：${commodity.price}</small>
                                            </div>
                                        </div>
                                        <a href="pay?aid=${agent.id}&cid=${commodity.id}"><div class="project-date"><span class="hidden-sm-down"><input type="submit" value="购买" class="btn btn-primary"></span></div></a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
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
                    <p>科朗通信物联自管理门户 2019 &copy;</p>
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