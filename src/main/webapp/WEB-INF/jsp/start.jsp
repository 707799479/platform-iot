<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>续费充值中心</title>
  <!-- plugins:css -->
  <link rel="stylesheet" href="/vendors/iconfonts/mdi/css/materialdesignicons.min.css">
  <link rel="stylesheet" href="/vendors/css/vendor.bundle.base.css">
  <!-- endinject -->
  <!-- inject:css -->
  <link rel="stylesheet" href="/css/style.css">
  <link rel="stylesheet" type="text/css" href="/css/hui.css" />
  <!-- endinject -->
  <link rel="shortcut icon" href="/images/favicon.png" />
</head>

<body style="background-color: #F4F4F4;">
<div class="card bg-gradient-danger card-img-holder text-white">
  <div style="color: #fff" class="card-body">
    <img src="/images/dashboard/circle.svg" class="card-img-absolute" alt="circle-image"/>
    <h4 class="font-weight-normal mb-3">续费充值中心
      <div style="color: #fff" class="float-right">
        <i style="color: #fff" class="mdi mdi-bookmark-outline mdi-24px"></i>
        ${phoneCard.phone == null?'未实名认证':'已实名认证'}
      </div>
    </h4>
    <h5>状态：${phoneCard.cid == null?'停机':'使用中'}</h5>
    <h4 style="position: relative;top: 50px;" class="mb-5">${phoneCard.iccid}</h4>
  </div>

</div>
<div style="background:#FFF; padding:0px 15px; height: 40px; margin:10px;" class="hui-flex">
  <div style="height:35px; margin-bottom: 5px; width:20px;">
    <img src="http://www.hcoder.net/hui3/img/spiker.png" width="20" style="padding:13px 0px;">
  </div>
  <div class="hui-scroll-news" id="scrollnew1">
    <div class="hui-scroll-news-items ">
      <p>${config.notice}</p>
    </div>
  </div>
</div>
<div style="background-color: #fff; height: 235px;margin: 10px; border-radius:5px; ">
  <div class="hui-speed-dial">

    <ul style="font-size: 14px;">
      <li onclick="tiao('setmeal')">
        <div class="hui-speed-dial-icons">
          <span class="hui-icons hui-icons-clone"></span>
        </div>
        <div class="hui-speed-dial-text">套餐订购</div>
      </li>
      <li onclick="tiao('query')">
        <div class="hui-speed-dial-icons">
          <span class="hui-icons hui-icons-search"></span>
        </div>
        <div class="hui-speed-dial-text">流量查询</div>
      </li>
      <li>
        <div class="hui-speed-dial-icons">
          <span class="hui-icons hui-icons-my"></span>
        </div>
        <div class="hui-speed-dial-text">实名认证</div>
      </li>
      <li>
        <div class="hui-speed-dial-icons">
          <span class="hui-icons hui-icons-progress"></span>
        </div>
        <div class="hui-speed-dial-text">APN设置</div>
      </li>
      <li>
        <div class="hui-speed-dial-icons">
          <span class="hui-icons hui-icons-loading2"></span>
        </div>
        <div class="hui-speed-dial-text">故障处理</div>
      </li>
    </ul>
  </div>
</div>
</body>
<!-- plugins:js -->
<script src="/vendors/js/vendor.bundle.base.js"></script>
<script src="/vendors/js/vendor.bundle.addons.js"></script>
<script src="/js/off-canvas.js"></script>
<script src="/js/misc.js"></script>

<script src="/js/dashboard.js"></script>

</html>
<script src="/js/jquery.js"></script>
<script src="/js/bootstrap-table.js"></script>
<script src="/js/locale/bootstrap-table-zh-CN.js"></script>
<script src="http://api.map.baidu.com/api?v=2.0&ak=RGS5BvFbpaRq1L9yL3Og58FdIwo1rBcM"></script>
<script type="text/javascript">
  //获取当前位置
  var geolocation = new BMap.Geolocation();
  geolocation.getCurrentPosition(function(r){
    if(this.getStatus() == BMAP_STATUS_SUCCESS){
      mk = new BMap.Marker(r.point);
      getAddress(r.point);
    }else {
      //alert('failed'+this.getStatus());
    }
  });
  //获取地址信息，设置地址label
  function getAddress(point){
    var gc = new BMap.Geocoder();
    gc.getLocation(point, function(rs){
      var addComp = rs.addressComponents;
      var address =  addComp.province +  addComp.city + addComp.district + addComp.street + addComp.streetNumber;//获取地址
      if(address.length > 1){
        bl = true;
        $.get("/address",{address:address},function (a) {
          if(a == 1){
            console.log("ok")
          }
        })
      };
    });

  }
  function tiao(u) {
    var istiao = ${grant};
    if(istiao){
      window.location.href = "/"+u;
      /* alert("首次必须实名认证");
       window.location.href = "/grant";*/
    }else{
      window.location.href = "/"+u;
    }

  }
</script>
<style type="text/css">
  .hui-speed-dial-text{

    font-size: 14px;
  }
  .hui-icons{
    font-size: 30px !important;
    color: #F69F2E !important;
  }
</style>