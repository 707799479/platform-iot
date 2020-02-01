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
            <button class="navbar-toggler navbar-toggler-right d-lg-none align-self-center" type="button" data-toggle="offcanvas">
                <span class="mdi mdi-menu"></span>
            </button>
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
                <div class="col-lg-12 grid-margin stretch-card">
                    <div class="card">
                        <div class="card-body">
                            <h4 class="card-title">代理列表</h4>
                            <br>
                            <table id="table"></table>
                            <br>
                            <button style="width: 100%;" type="button" onclick="addClass()" class="btn btn-gradient-secondary btn-rounded btn-fw">添加一个代理</button>
                            <input type="hidden" id="admin_id" value="${system_admin.id}">
                            <input type="hidden" id="my_id" value="${user_agent.id}">
                        </div>
                    </div>
                </div>

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
    $.ajax({
        type : "post",
        url : "/admin/getMyAgentList",
        async : false,
        success : function(result){
            requestJson = jQuery.parseJSON(result);
        }
    });

    $('#table').bootstrapTable({
        url: '/admin/getMyAgentList',
        pagination: true,//是否分页
        sidePagination: "client", //分页方式：client客户端分页，server服务端分页（*）
        pageNumber: 1,//初始化加载第一页，默认第一页,并记录
        search: true,//是否显示搜索
        pageSize: 10,//每页的记录行数（*）
        columns: [{
            field: 'account',
            align: 'center',
            title: '账号',
            valign: 'middle'
        },{
            field: 'money',
            align: 'center',
            title: '余额',
            valign: 'middle'
        },{
            field: 'qq',
            align: 'center',
            title: '联系电话',
            valign: 'middle'
        }, {
            field: 'createTime',
            align: 'center',
            title: '开通时间',
            valign: 'middle'
        }, {
            field: 'agentNum',
            align: 'center',
            title: '旗下代理',
            valign: 'middle'
        },{
            field:'id',
            title: '操作',
            align: 'center',
            valign: 'middle',
            formatter: actionFormatter
        } ]
    });

    //加载居中效果
    function loadText(value, row, index) {
        if(value == undefined || value == null){
            value = "-";
        }
        return '<p>'+value+'</p>';
    }

    //加载时间
    function loadDate(value, row, index) {
        var time = new Date(value).toLocaleString().replace(/:\d{1,2}$/,' ');
        var result = "";
        result += '<p> '+time+'</p>';
        return result;
    }

    //加载域名
    function loadDomain(value, row, index) {
        var result = "";
        var domain = '${configMap.domain}';
        result += '<a style="color:blue;" href="http://'+value+'.'+domain+'">http://'+value+'.'+domain+'</a>';
        return result;
    }

    //操作栏的格式化
    function loadImg(value, row, index) {

        var img = value;
        var result = "";
        result += '<img style="width: 45px;height: 45px;" src="http://q1.qlogo.cn/g?b=qq&nk='+value+'&s=640">';
        return result;
    }

    //操作栏的格式化
    function actionFormatter(value, row, index) {
        var adminId = $("#admin_id").val();
        var myId = $("#my_id").val();
        var id = value;
        var result = "";

        result += '<button id="shanchu" onclick="setMeal('+id+')" type="button" class="btn btn-gradient-primary btn-sm">分配套餐</button>&nbsp;';
        result += '<button id="shanchu" onclick="newPwd('+id+')" type="button" class="btn btn-gradient-primary btn-sm">重置密码</button>&nbsp;';
        result += '<button id="shanchu" onclick="deletes('+id+')" type="button" class="btn btn-gradient-danger btn-sm">删除</button>&nbsp;';
        return result;
    }


    //编辑
    function edit(id){
        window.location.href='/admin/editCommodity?id='+id;
    }

    //删除
    function deletes(id) {
        for(var i = 0;i<requestJson.length;i++){
            if(requestJson[i].id == id){
                if(confirm("确定要删除“"+requestJson[i].account+"”吗？’")){
                    $.post("/admin/deleteAgent",{id:id},function(result){
                        if(result == 1){
                            window.location.reload();
                            alert("删除成功");
                        }else{
                            alert("删除失败");
                        }
                    });
                }
            }
        }
    }

    //分配套餐
    function setMeal(id) {
        window.location.href='/admin/setMeal?id='+id;
    }

    //添加
    function addClass(){
        window.location.href='/admin/addAgent';
    }

    //重置密码
    function newPwd(id) {
        if(confirm("将会把密码重置为：123456，确认要重置吗？")){
            $.post("/admin/newPwd",{id:id},function(result){
                if(result == 1){
                    window.location.reload();
                    alert("密码已重置为：123456，请牢记。");
                }else{
                    alert("重置失败");
                }
            });
        }
    }

</script>