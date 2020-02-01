<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>后台管理</title>
    <!-- plugins:css -->
    <link rel="stylesheet" href="/vendors/iconfonts/mdi/css/materialdesignicons.min.css">
    <link rel="stylesheet" href="/vendors/css/vendor.bundle.base.css">
    <!-- endinject -->
    <!-- inject:css -->
    <link rel="stylesheet" href="/css/style.css">
    <!-- endinject -->
    <link rel="shortcut icon" href="/images/favicon.png" />
</head>
<body>
<div class="container-scroller">
    <!-- partial:partials/_navbar.html -->
    <nav class="navbar default-layout-navbar col-lg-12 col-12 p-0 fixed-top d-flex flex-row">
        <div class="text-center navbar-brand-wrapper d-flex align-items-center justify-content-center">
            <a class="navbar-brand brand-logo" href="/admin/main"><img src="/images/logo.svg" alt="logo"/></a>
      <a class="navbar-brand brand-logo-mini" href="/admin/main"><img src="/images/logo-mini.svg" alt="logo"/></a>
        </div>
        <div class="navbar-menu-wrapper d-flex align-items-stretch">

            <ul class="navbar-nav navbar-nav-right">
                <li class="nav-item d-none d-lg-block full-screen-link">
                    <a class="nav-link">
                        <i class="mdi mdi-fullscreen" id="fullscreen-button"></i>
                    </a>
                </li>
                <li class="nav-item nav-profile dropdown">
                    <a class="nav-link dropdown-toggle" id="profileDropdown" href="#" data-toggle="dropdown" aria-expanded="false">
                        <div class="nav-profile-img">
                            <img src="/images/faces/face1.jpg" alt="image">
                            <span class="availability-status online"></span>
                        </div>
                        <div class="nav-profile-text">
                            <p class="mb-1 text-black">嗨，你好</p>
                        </div>
                    </a>
                    <div class="dropdown-menu navbar-dropdown" aria-labelledby="profileDropdown">
                        <a class="dropdown-item" href="/admin/out">
              <i class="mdi mdi-logout mr-2 text-primary"></i>
                            退出
                        </a>
                    </div>
                </li>

            </ul>

        </div>
    </nav>
    <!-- partial -->
    <div class="container-fluid page-body-wrapper">
        <!-- partial:partials/_sidebar.html -->
        <nav class="sidebar sidebar-offcanvas" id="sidebar">
            <ul class="nav">

                <li class="nav-item">
                    <a class="nav-link" href="/admin/main">
                        <span class="menu-title">首页</span>
                        <i class="mdi mdi-home menu-icon"></i>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="collapse" href="#ui-basic" aria-expanded="false" aria-controls="ui-basic">
                        <span class="menu-title">套餐管理</span>
                        <i class="menu-arrow"></i>
                        <i class="mdi mdi-crosshairs-gps menu-icon"></i>
                    </a>
                    <div class="collapse" id="ui-basic">
                        <ul class="nav flex-column sub-menu">
                            <li class="nav-item"> <a class="nav-link" href="/admin/commodityList">套餐列表</a></li>
                            <li class="nav-item"> <a class="nav-link" href="/admin/addCommodity">添加套餐</a></li>
                            <li class="nav-item"> <a class="nav-link" href="/admin/commodityClass">卡池</a></li>
                        </ul>
                    </div>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="collapse" href="#daili" aria-expanded="false" aria-controls="ui-basic">
                        <span class="menu-title">代理管理</span>
                        <i class="menu-arrow"></i>
                        <i class="mdi mdi mdi-account-multiple-outline menu-icon"></i>
                    </a>
                    <div class="collapse" id="daili">
                        <ul class="nav flex-column sub-menu">
                            <li class="nav-item"> <a class="nav-link" href="/admin/agentList">代理列表</a></li>
                            <li class="nav-item"> <a class="nav-link" href="/admin/addAgent">添加代理</a></li>
                        </ul>
                    </div>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/admin/hf">
                        <span class="menu-title">卡片划分</span>
                        <i class="mdi mdi mdi-account-card-details menu-icon"></i>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="collapse" href="#tixian" aria-expanded="false" aria-controls="ui-basic">
                        <span class="menu-title">提现</span>
                        <i class="menu-arrow"></i>
                        <i class="mdi mdi mdi-airplane menu-icon"></i>
                    </a>
                    <div class="collapse" id="tixian">
                        <ul class="nav flex-column sub-menu">
                            <li class="nav-item"> <a class="nav-link" href="/admin/extract">申请提现</a></li>
                            <li class="nav-item"> <a class="nav-link" href="/admin/extractLog">提现记录</a></li>
                        </ul>
                    </div>
                </li>
                <c:if test="${user_agent.parentId==0}">
                    <li class="nav-item">
                        <a class="nav-link" href="/admin/websiteConfig">
                            <span class="menu-title">网站配置</span>
                            <i class="mdi mdi-chart-bar menu-icon"></i>
                        </a>
                    </li>
                </c:if>
                <li class="nav-item">
                    <a class="nav-link" href="/admin/orderList">
                        <span class="menu-title">订单管理</span>
                        <i class="mdi mdi-table-large menu-icon"></i>
                    </a>
                </li>
                <li class="nav-item">
          <a class="nav-link" href="/admin/updatePassword">
            <span class="menu-title">修改密码</span>
            <i class="mdi mdi-medical-bag menu-icon"></i>
          </a>
        </li>
                <li class="nav-item">
                    <a class="nav-link" href="/admin/cardList">
                        <span class="menu-title">卡片列表</span>
                        <i class="mdi mdi-format-list-bulleted menu-icon"></i>
                    </a>
                </li>
                <li class="nav-item sidebar-actions">
            <span class="nav-link">
              <div class="mt-4">
                <div class="border-bottom">
                  <p class="text-secondary">admin</p>
                </div>
                <ul class="gradient-bullet-list mt-4">
                  <li>物联卡后台管理系统</li>
                </ul>
              </div>
            </span>
                </li>
            </ul>
        </nav>
        <!-- partial -->
        <div class="main-panel">
            <div class="content-wrapper">
                <c:if test="${user_agent.parentId == 0}">
                    <div class="col-lg-12 grid-margin stretch-card">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">本站订单</h4>
                                <br>
                                <select style="width: 200px;" name="pclass.id" onchange="classChange(options[selectedIndex].value)" class="selectpicker form-control">
                                    <option selected value ="all">全部</option>
                                    <c:forEach var="co" items="${commodityList}">
                                        <option value ="${co.id}">${co.name}</option>
                                    </c:forEach>
                                </select>
                                <table id="table"></table>
                                <br>
                                <button style="width: 100%;" type="button" class="btn btn-gradient-secondary btn-rounded btn-fw" onclick="viewLog()">查看返利明细</button>
                                <input type="hidden" id="admin_id" value="${system_admin.id}">
                                <input type="hidden" id="my_id" value="${user_agent.id}">
                            </div>
                        </div>
                    </div>
                </c:if>
                <c:if test="${user_agent.parentId != 0}">
                    <div class="col-lg-12 grid-margin stretch-card">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">全部订单</h4>
                                <br>
                                <table id="table2"></table>
                                <br>
                                <button style="width: 100%;" type="button" class="btn btn-gradient-secondary btn-rounded btn-fw" onclick="viewLog()">查看返利明细</button>
                            </div>
                        </div>
                    </div>
                </c:if>
            </div>
            <!-- content-wrapper ends -->
            <!-- partial:partials/_footer.html -->
            <footer class="footer">
                <div class="d-sm-flex justify-content-center justify-content-sm-between">
                    <span class="text-muted text-center text-sm-left d-block d-sm-inline-block">Copyright © 2020 <a href="#">SystemAdmin</a>. All rights reserved. </span>
                </div>
            </footer>
            <!-- partial -->
        </div>
        <!-- main-panel ends -->
    </div>
    <!-- page-body-wrapper ends -->
</div>
<!-- container-scroller -->

<!-- plugins:js -->
<script src="/vendors/js/vendor.bundle.base.js"></script>
<script src="/vendors/js/vendor.bundle.addons.js"></script>
<!-- endinject -->
<!-- Plugin js for this page-->
<!-- End plugin js for this page-->
<!-- inject:js -->
<script src="/js/off-canvas.js"></script>
<script src="/js/misc.js"></script>
<!-- endinject -->
<!-- Custom js for this page-->
<script src="/js/dashboard.js"></script>
<!-- End custom js for this page-->
</body>

</html>
<script src="/js/jquery.js"></script>
<script src="/js/bootstrap-table.js"></script>
<script src="/js/locale/bootstrap-table-zh-CN.js"></script>
<script type="text/javascript">


    var requestJson;
    var countOrder = 0;

    var coid = 'all';
    function classChange(cid) {
        coid = cid;
    }

    $("#count").text("共有"+countOrder+"个订单未处理。");
    $.ajax({
        type : "post",
        url : "/admin/getOrderListData",
        async : false,
        success : function(result){
            requestJson = jQuery.parseJSON(result);
            for(var i = 0;i < requestJson.length;i++){
                if(requestJson[i].status == 1){
                    countOrder ++;
                }
            }

            $("#count").text("共有"+countOrder+"个订单未处理。");
        }
    });

    $('#table').bootstrapTable({
        url: '/admin/getOrderListData',
        pagination: true,//是否分页
        sidePagination: "client", //分页方式：client客户端分页，server服务端分页（*）
        pageNumber: 1,//初始化加载第一页，默认第一页,并记录
        search: true,//是否显示搜索
        pageSize: 10,//每页的记录行数（*）
        columns: [ {
            field:'number',
            title: '订单编号',
            align: 'center',
            valign: 'middle',
            formatter: loadText
        },{
            field:'commodity.name',
            title: '商品名称',
            align: 'center',
            valign: 'middle',
            formatter: loadText
        },{
            field:'createTime',
            title: '下单时间',
            align: 'center',
            valign: 'middle',
            formatter: loadDate
        }, {
            field: 'xdPhone',
            align: 'center',
            title: 'ICCID',
            valign: 'middle',
            formatter: loadText
        }, {
            field: 'xdAddress',
            align: 'center',
            title: '地址',
            valign: 'middle',
            formatter: loadText
        }, {
            field: 'count',
            align: 'center',
            title: '数量',
            valign: 'middle',
            formatter: loadText
        }, {
            field: 'totalPrice',
            align: 'center',
            title: '总价',
            valign: 'middle',
            formatter: loadText
        },{
            field: 'payType',
            align: 'center',
            title: '生效时间(now当月 down次月)',
            valign: 'middle',
            formatter: loadPay
        } ]
    });

    //加载支付方式
    function loadPay(value, row, index) {
        if(value == undefined || value == null){
            value = "-";
        }
        if(value == 'qqpay'){
            value = "QQ钱包";
        }else if(value == 'wxpay'){
            value = "微信";
        }else if(value == 'alipay'){
            value = "支付宝";
        }
        return '<p>'+value+'</p>';
    }

    //加载状态
    function status(value, row, index) {
        if(value == undefined || value == null){
            value = "-";
        }
        if(value == 1){
            value = "未处理";
        }else if(value == 2){
            value = "已处理";
        }else{
            value = "异常状态,请联系开发者";
        }
        return '<p>'+value+'</p>';
    }

    //加载居中效果
    function loadText(value, row, index) {
        if(value == undefined || value == null){
            value = "-";
        }
        return '<p>'+value+'</p>';
    }

    //导出订单
    function outData() {
        if(coid == 'all'){
            window.location.href = "/admin/outData?status=1";
        }else{
            window.location.href = "/admin/outData?status=1&cid="+coid;
        }

        //window.location.reload();
    }

    //加载时间
    function loadDate(value, row, index) {
        var time = new Date(value).toLocaleString().replace(/:\d{1,2}$/,' ');
        var result = "";
        result += '<p> '+time+'</p>';
        return result;
    }

    //操作栏的格式化
    function loadImg(value, row, index) {
        if(value == undefined || value == null){
            return "<p>无</p>";
        }
        var img = value;
        var result = "";
        result += '<a href="/'+img+'"><img style="width: 60px;height: 60px;" src="'+img+'"></a>';
        return result;
    }

    //操作栏的格式化
    function actionFormatter(value, row, index) {
        var adminId = $("#admin_id").val();
        var myId = $("#my_id").val();
        var id = value;
        var result = "";

        result += '<a class="btn btn-sm btn-default" href="javascript:update('+id+')">改为已处理</a>&nbsp;';

        return result;
    }


    //更改
    function update(id) {
        if(confirm("确定要把状态改为已完成吗？")){
            $.post("/admin/updateOrderStatus",{no:id},function(result){
                if(result == 1){
                    window.location.reload();
                    alert("修改成功");
                }else{
                    alert("修改失败");
                }
            });
        }
    }

    <c:if test="${user_agent.parentId != 0}">
    $('#table2').bootstrapTable({
        url: '/admin/getOrderListData?a=1',
        pagination: true,//是否分页
        sidePagination: "client", //分页方式：client客户端分页，server服务端分页（*）
        pageNumber: 1,//初始化加载第一页，默认第一页,并记录
        search: true,//是否显示搜索
        pageSize: 10,//每页的记录行数（*）
        columns: [ {
            field:'number',
            title: '订单编号',
            align: 'center',
            valign: 'middle',
            formatter: loadText
        },{
            field:'commodity.name',
            title: '商品名称',
            align: 'center',
            valign: 'middle',
            formatter: loadText
        }, {
            field: 'xdPhone',
            align: 'center',
            title: 'ICCID',
            valign: 'middle',
            formatter: loadText
        },{
            field:'createTime',
            title: '下单时间',
            align: 'center',
            valign: 'middle',
            formatter: loadDate
        }, {
            field: 'xdAddress',
            align: 'center',
            title: '地址',
            valign: 'middle',
            formatter: loadText
        }, {
            field: 'totalPrice',
            align: 'center',
            title: '总价',
            valign: 'middle',
            formatter: loadText
        },{
            field: 'payType',
            align: 'center',
            title: '生效时间(now当月 down次月)',
            valign: 'middle',
            formatter: loadPay
        },{
            field:'meiyou',
            title: '操作',
            align: 'center'
        } ]
    });
    </c:if>


    function viewLog() {
        window.location.href = "/admin/viewPriceLog";
    }
</script>