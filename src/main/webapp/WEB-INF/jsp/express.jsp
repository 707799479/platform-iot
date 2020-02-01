<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>单号查询</title>
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
            <li><a href="/index"> <i class="icon-home"></i>首页 </a></li>
            <li><a href="/admin"> <i class="icon-interface-windows"></i>后台登录</a></li>
            <li class="active"><a href="/express"> <i class="icon-grid"></i>单号查询 </a></li>
            <li><a href="/feedback"> <i class="fa fa-bar-chart"></i>留言反馈 </a></li>
          </ul>
          
        </nav>
        <div class="content-inner">
          <!-- Page Header-->
          <header class="page-header">
            <div class="container-fluid">
              <h2 class="no-margin-bottom">单号查询</h2>
            </div>
          </header>
          <!-- Dashboard Counts Section-->
		  
       
          <!-- Feeds Section-->
		  
           <section style="margin-top:20px;width:100%;text-align:center;" class="feeds no-padding-top">
		
		  
		    <c:if test="${expressList == null}">
              <div class="col-md-6 " style="margin: 0 auto;">
                <div class="card">
                  <div class="card-header">请输入您下单时的手机号</div>
                  <div class="card-body"><input id="phone" maxlength="11" type="number" placeholder="手机号" class="form-control"> </div>

                  <div class="card-footer"> <input type="button" onclick="query()" style="width: 100%;" value="马上查询" class="btn btn-primary"> </div>
                </div>
              </div>
            </c:if>
             <c:if test="${expressList != null}">
               共找到了&nbsp;${fn:length(expressList)}&nbsp;条记录
               <c:forEach var="exp" items="${expressList}" varStatus="status">

                 <div class="col-md-6 " style="margin: 0 auto;">
                   <div class="card">
                     <div class="card-header">第${status.index + 1}个</div>
                     <div class="card-body" style="text-align: left;">
                       <p>下单姓名：${exp.xdName}</p>
                       <p>录入时间：<fmt:formatDate value="${exp.createTime}" type="date" pattern="yyyy-MM-dd HH:mm"/></p>
                       <p>快递单号：${exp.expressNumber}</p>
                     </div>
                     <div class="card-footer"> <input type="button" onclick="queryExpress(${exp.expressNumber})" style="width: 100%;" value="查询物流" class="btn btn-primary"> </div>
                   </div>
                 </div>

               </c:forEach>
             </c:if>

		  
            
              
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
                  <p>单号查询 &copy; 2017-2019</p>
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
<script type="text/javascript">
	function query(){
		var phone = $("#phone").val();
		if(phone.length != 11){
			alert("请输入合法的手机号");
		}else{
            window.location.href='/express?phone='+phone;
		}
	}
    function queryExpress(express){
        window.location.href='https://m.kuaidi100.com/index_all.html?postid='+express+'&callbackurl='+window.location.href;
    }
</script>