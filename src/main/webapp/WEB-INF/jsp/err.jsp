<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>error page</title>
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
              <h2 class="no-margin-bottom">物联在线下单平台</h2>
            </div>
          </header>
          <!-- Dashboard Counts Section-->


          <!-- Feeds Section-->

          <section style="margin-top:20px;width:100%;text-align:center;" class="feeds no-padding-top">


		  <div class="col-md-6 " style="margin: 0 auto;">
		  	<div class="card">
				<div class="card-header">${errorText}</div>
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
			var name = $(":input")[0].value;
			var phone = $(":input")[1].value;
			var address = $(":input")[2].value;
			if( !(name.length > 0 && phone.length > 0 && address.length > 0)){
				alert("数据不能为空");
			}else{
				if(document.getElementById("upload").value == '' || document.getElementById("upload2").value == '' || document.getElementById("upload3").value == ''){
					alert("请上传照片！");
					return;
				}
				var productName = '手机卡';
				var price = '1024';
				var productNumber = '2';
				var payType = '支付宝';
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
        navigator.geolocation.getCurrentPosition(function(pos){

          var latitude = pos.coords.latitude;

          var longitude = pos.coords.longitude;

          alert('您的位置经纬度是：' + latitude + " , " + longitude)
          showPosition(pos);

        })

        function getLocation(){
          if (navigator.geolocation){
            navigator.geolocation.getCurrentPosition(showPosition,showError);
          }else{
            alert("浏览器不支持地理定位。");
          }
        }
        function showPosition(position){
          var latlon = position.coords.latitude+','+position.coords.longitude;

          //google
          var url = 'http://maps.google.cn/maps/api/geocode/json?latlng='+latlon+'&language=CN';
          $.ajax({
            type: "GET",
            url: url,
            beforeSend: function(){

            },
            success: function (json) {
              if(json.status=='OK'){
                var results = json.results;
                $.each(results,function(index,array){
                  if(index==0){
                    alert(array['formatted_address']);
                  }
                });
              }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
              alert(latlon+"地址位置获取失败");
            }
          });
        }

        function showError(error){
          switch(error.code) {
            case error.PERMISSION_DENIED:
              alert("定位失败,用户拒绝请求地理定位");
              break;
            case error.POSITION_UNAVAILABLE:
              alert("定位失败,位置信息是不可用");
              break;
            case error.TIMEOUT:
              alert("定位失败,请求获取用户位置超时");
              break;
            case error.UNKNOWN_ERROR:
              alert("定位失败,定位系统失效");
              break;
          }
        }


    </script>
  </body>
</html>
