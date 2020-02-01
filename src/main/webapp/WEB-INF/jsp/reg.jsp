<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	  <title>开通代理</title>
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

      <div class="page-content d-flex align-items-stretch">
        <!-- Side Navbar -->

        <div style="width:120%;" class="content-inner">
          <!-- Page Header-->
          <header  style="background-color:#2f333e;color:#fff" class="page-header">
            <div class="container-fluid">
              <h2 class="no-margin-bottom">申请成为通信服务商</h2>
            </div>
          </header>
          <!-- Dashboard Counts Section-->


          <!-- Feeds Section-->

          <section style="margin-top:20px;width:100%;text-align:center;" class="feeds no-padding-top">

		  <div class="col-md-6" style="margin: 0 auto;">
		 <div class="card ">

			<div class="card-header d-flex align-items-center">
			  <h3 class="h4">服务商入驻信息提交</h3>
			</div>
			<div class="card-body">
			  <!-- pay fomr -->
			  <form id="regForm" method="post" action="/reg">
				<div class="form-group">
				  <input onKeyUp="value=value.replace(/[^\w|chun]/g,'')" name="account"type="text" id="account" placeholder="账号" class="form-control">
				</div>
				<div class="form-group">
				  <input name="password" type="password" id="password" placeholder="密码" class="form-control">
				</div>
				<div class="form-group">
				  <input onKeyUp="value=value.replace(/[^\w|chun]/g,'')" name="domain" maxlength="50" type="text" id="domain" placeholder="域名(如填：abc，则网站域名为：abc.${config.domain})" class="form-control">
				</div>
                  <div class="form-group">
                      <input name="websiteName" type="text" id="webname" placeholder="网站名称" class="form-control">
                  </div>
				  <div class="form-group">
					  <input name="qq" type="number" id="qq" placeholder="联系电话" class="form-control">
				  </div>
				  <div class="form-group">
					  <input name="tAccount" id="tAccount" type="text" placeholder="提现账号(支付宝账号)" class="form-control">
				  </div>
				  <div class="form-group">
					  <input id="tName" name="tName" type="text" placeholder="提现姓名(真实姓名用于提现)" class="form-control">
				  </div>
				<div class="form-group">


				<br>
				<p>付款方式</p>
				<input checked="" value="qqpay" type="radio" name="paytype">QQ钱包 <img style="width: 18px;" src="img/qqpay.ico"> &nbsp;
				<input value="alipay" type="radio" name="paytype">支付宝 <img style="width: 18px;" src="img/alipay.ico"> &nbsp;
				<input value="wxpay" type="radio" name="paytype">微信 <img style="width: 18px;" src="img/wechat.ico"> &nbsp;<br>
					<br>
					<p>代理价格为: <strong style="color:#FF8917;">${agent.agentPrice}</strong>元</p>
				<br>
				  <input type="button" id="buy" value="马上开通" class="btn btn-primary">
				</div>
			  </form>

			</div>
		  </div>
		  </div>



          </section>


          <!-- Page Footer-->
          <footer class="main-footer">
            <div class="container-fluid">
              <div class="row">
                <div class="col-sm-6">

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
	<script type="text/javascript">


		(function ($) {
		  $('.spinner .btn:first-of-type').on('click', function() {
			$('.spinner input').val( parseInt($('.spinner input').val(), 10) + 1);
		  });
		  $('.spinner .btn:last-of-type').on('click', function() {
			$('.spinner input').val( parseInt($('.spinner input').val(), 10) - 1);
		  });
		})(jQuery);


		//This product click is a Buy status
		$("#buy").click(function(){
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



        });


	</script>
  </body>
</html>
