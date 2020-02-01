<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
  <title>${agent.websiteName}</title>
  <link rel="stylesheet" type="text/css" href="./css/hui.css" />
</head>
<body>
<header class="hui-header">
  <h1>${agent.websiteName}</h1>
</header>
<div class="hui-wrap">
  <div style="height: 10px;"></div>
  <div class="hui-img-list">
    <ul>
      <li>
        <a href="javascript:hui.toast('hi...');">
          <img style="height: 170px;" src="${agent.img}" />
          <div class="hui-img-list-content">
            <h1>您的卡号：${phoneCard.iccid}</h1>
          </div>
        </a>
      </li>
    </ul>
  </div>
  <div class="hui-speed-dial">
    <div class="hui-img-list-content">
      <h1>
        <span>状态：<span style="color: red;">${phoneCard.gotime == null?'停机':'使用中'}</span></span>
        <span style="float: right;">实名：<span style="color: red;">${phoneCard.phone == null?'未认证':'已认证'}</span></span>
      </h1>
    </div>
    <ul>
      <li onclick="tiao('setmeal?d=true')">
        <div class="hui-speed-dial-icons">
          <span class="hui-icons hui-icons-loading"></span>
        </div>
        <div class="hui-speed-dial-text">套餐订购</div>
      </li>



    </ul>
  </div>
</div>
<script src="./js/hui.js" type="text/javascript" charset="utf-8"></script>
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
        hui.post("/address",{address:address},function (a) {
          if(a == 1){
            hui.toast("ok");

          }
        })
      };
    });

  }
    function tiao(u) {
        var istiao = ${grant};
        if(istiao){
          alert("首次必须实名认证");
          window.location.href = "/grant?d=t";
        }else{
          window.location.href = "/"+u;
        }

    }
</script>
</body>
</html>