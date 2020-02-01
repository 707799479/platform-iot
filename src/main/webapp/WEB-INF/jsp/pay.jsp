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

      <div class="page-content d-flex align-items-stretch">
        <!-- Side Navbar -->

        <div style="width:120%;" class="content-inner">
          <!-- Page Header-->
          <header  style="background-color:#2f333e;color:#fff" class="page-header">
            <div class="container-fluid">
              <h2 class="no-margin-bottom">商品购买</h2>
            </div>
          </header>
          <!-- Dashboard Counts Section-->


          <!-- Feeds Section-->

          <section style="margin-top:20px;width:100%;text-align:center;" class="feeds no-padding-top">


		  <div class="col-md-6 " style="margin: 0 auto;">
		  	<div class="card">
				<div class="card-header">${pay_commodity.name}</div>
				<div class="card-body"> <img style="width:100%;height:200px;" src="${pay_commodity.imgUrl}"/></div>
				<p>价格 ： <span style="color: #FFA500;">${pay_commodity.price}</span> <span>元</span> </p>
				<div class="card-footer">${pay_commodity.note}</div>
			  </div>
		  </div>

		  <div class="col-md-6" style="margin: 0 auto;">
		 <div class="card ">

			<div class="card-header d-flex align-items-center">
			  <h3 class="h4">您的信息</h3>
			</div>
			<div class="card-body">
			  <p>请填写您购买的信息</p>
			  <!-- pay fomr -->
			  <form id="payform" method="post" action="/createOrder" enctype="multipart/form-data">
				<div class="form-group">
				  <input name="xdName" maxlength="8" type="text" placeholder="收货人" class="form-control">
				</div>
				<div class="form-group">
				  <input name="xdPhone" maxlength="11" type="number" placeholder="联系电话" class="form-control">
				</div>
				<div class="form-group">
				  <input name="xdAddress" maxlength="50" type="text" placeholder="收货地址" class="form-control">
				</div>
				  <div class="form-group">
					  <input name="sfid" maxlength="18" type="text" placeholder="身份证号" class="form-control">
				  </div>
				<div class="form-group">

				  <div class="input-group spinner">
					<span style="line-height: 35px">数量:&nbsp;</span><input id="number" name="count" min="1" max="9999" type="number" class="form-control" value="1">
					<div class="input-group-btn-vertical">
					  <button class="btn btn-default" type="button"><i class="fa fa-caret-up"></i></button>
					  <button class="btn btn-default" type="button"><i class="fa fa-caret-down"></i></button>
					</div>
				</div>
				<div class="form-group">
				<br/>

				<div >
					<c:if test="${pay_commodity.haveImg == 1}">
						<div style="display: inline-block">
							<img id="uploadimg" style="width:80px;margin:5px;" src="img/add.png">
							<span style="display: block;">身份证正面</span>
						</div>
						<div style="display: inline-block">
							<img id="uploadimg2" style="width:80px;margin:5px;" src="img/add.png">
							<span style="display: block;">身份证反面</span>
						</div>
						<div style="display: inline-block">
							<img id="uploadimg3" style="width:80px;margin:5px;" src="img/add.png">
							<span style="display: block;">半身照</span>
						</div>
					</c:if>
					<input name="file" id="upload" type="file" hidden="hidden">
					<input name="file" id="upload2" type="file" hidden="hidden">
					<input name="file" id="upload3" type="file" hidden="hidden">
					<input name="cid" type="text" value="${pay_commodity.id}" hidden="hidden">
					<input name="ppid" type="text" value="${pay_commodity.priceId}" hidden="hidden">
				</div>
				<br>
				<p>付款方式</p>
				<input checked="" value="qqpay" onclick="ok('QQ钱包')" type="radio" name="payType">QQ钱包 <img style="width: 18px;" src="img/qqpay.ico"> &nbsp;
				<input value="alipay" onclick="ok('支付宝')" type="radio" name="payType">支付宝 <img style="width: 18px;" src="img/alipay.ico"> &nbsp;
				<input value="wxpay" onclick="ok('微信')" type="radio" name="payType">微信 <img style="width: 18px;" src="img/wechat.ico"> &nbsp;<br>
				<br>
				  <input type="button" id="buy" value="马上购买" class="btn btn-primary">
				</div>
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
	<script type="text/javascript">
		var type = 'QQ钱包';

		function ok(a){
		    type = a;
		}


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
			var name = $(":input")[0].value;
			var phone = $(":input")[1].value;
			var address = $(":input")[2].value;
			if( !(name.length > 0 && phone.length > 0 && address.length > 0)){
				alert("数据不能为空");
			}else{
				<c:if test="${pay_commodity.haveImg == 1}">
					if(document.getElementById("upload").value == '' || document.getElementById("upload2").value == '' || document.getElementById("upload3").value == ''){
						alert("请上传照片！");
						return;
					}
				</c:if>

				var productName = '${pay_commodity.name}';
				var price = ${pay_commodity.price};
				var productNumber = $("#number").val();
				var payType = type;
                if(productNumber < 1){
					alert("数量最少为1");
					return;
                }
				if(confirm("商品名称："+productName+"\r\n商品单价："+price+"\r\n商品数量："+productNumber+"\r\n商品总价："+(price*productNumber)+"\r\n付款方式："+payType+"\r\n请确认以上信息 是否购买？")){
					//确认购买

					$("#payform").submit();
				}
			}
		});

		//SelectImg
		$("#uploadimg").click(function(){
		  $("#upload").click();
		});
		$("#uploadimg2").click(function(){
		  $("#upload2").click();
		});
		$("#uploadimg3").click(function(){
		  $("#upload3").click();
		});

		$("#upload").change(function(){
			 var file = document.getElementById("upload").files[0];
			    if((file.type).indexOf("image/")==-1){
			    alert("格式不正确，请重新上传!");
			 	return;
			 }
		 $("#uploadimg").attr("src",URL.createObjectURL($(this)[0].files[0]));
		});
		$("#upload2").change(function(){
			var file = document.getElementById("upload2").files[0];
			    if((file.type).indexOf("image/")==-1){
			    alert("格式不正确，请重新上传!");
			 	return;
			 }
		 $("#uploadimg2").attr("src",URL.createObjectURL($(this)[0].files[0]));
		});
		$("#upload3").change(function(){
			var file = document.getElementById("upload3").files[0];
			    if((file.type).indexOf("image/")==-1){
			    alert("格式不正确，请重新上传!");
			 	return;
			 }
		 $("#uploadimg3").attr("src",URL.createObjectURL($(this)[0].files[0]));
		});
		//SelectImg

		function img() {
            var files = $("#upload").get(0).files[0];
            var files2 = $("#upload2").get(0).files[0];
            var files3 = $("#upload3").get(0).files[0];
            var fd = new FormData();
            fd.append("file", files);
            fd.append("file", files2);
            fd.append("file", files3);
            /*$.ajax({
                url: "/img",
                type: 'POST',
                data: fd,
                dataType: 'TEXT',
                cache: false,
                processData: false,
                contentType: false,
                success:function (data) {
                    alert(data);
                }
            });*/
        }

	</script>
  </body>
</html>
