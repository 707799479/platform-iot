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
                <div class="col-lg-6 grid-margin stretch-card">
                    <div class="card">
                        <div class="card-body">
                            <h4 class="card-title">编辑套餐</h4>
                            <br>
                            <div class="body">
                                <form id="addForm" action="/admin/editCommodityAgent" method="post" enctype="multipart/form-data">
                                    <div class="form-group">
                                        <label for="search-input">所属分类：</label>
                                        <div class="input-group" style="width:100%;">
                                            <p >${temp_commodity.pclass.name}</p>
                                            <span class="input-group-btn">
                                  </span>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="search-input">套餐名称：</label>
                                        <div class="input-group" style="width:100%;">
                                            <p>${temp_commodity.name}</p>
                                            <span class="input-group-btn">
                                  </span>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="search-input">包含流量(M)：</label>
                                        <div class="input-group" style="width:100%;">
                                            <p>${temp_commodity.note}</p>
                                            <span class="input-group-btn">
                                  </span>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="search-input">您的底价(元)：</label>
                                        <div class="input-group" style="width:100%;">
                                            <p>${temp_mycommodity.parentPrice == null ? '-' :temp_mycommodity.parentPrice}</p>
                                            <span class="input-group-btn">
                                  </span>
                                        </div>
                                    </div>
                                    <input type="hidden" value="${temp_mycommodity.parentPrice == null ? '-' :temp_mycommodity.parentPrice}" id="myprice">


                                    <input name="aid" value="${aid}" type="text" style="display: none">
                                    <input name="cid" value="${cid}" type="text" style="display: none">



                                    <div class="form-group">
                                        <label for="search-input">底价(元)：</label>
                                        <div class="input-group" style="width:100%;">
                                            <input name="parentPrice" type="number" id="parentPrice" value="${temp_commodity.parentPrice}" class="form-control">
                                            <span class="input-group-btn">
                                  </span>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="search-input">价格(元)：</label>
                                        <div class="input-group" style="width:100%;">
                                            <input name="price" type="number" id="price" value="${temp_commodity.price}" class="form-control">
                                            <span class="input-group-btn">
                                  </span>
                                        </div>
                                    </div>


                                    <a style="width: 100%;" class="btn btn-gradient-secondary btn-rounded btn-fw" href="javascript:saveCommodity()">保存</a>
                                </form>
                            </div>
                        </div>
                    </div>
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

    /**
     * 提交 非空验证
     * 主站专用
     */
    function saveCommodity() {
        if($("#price").val().length < 1 || $("#parentPrice").val().length < 1){
            alert("不能有空项");
        }else if($("#myprice").val() != "-" && $("#myprice").val() > $("#parentPrice").val()){
            alert("给代理的底价不能低于您的底价");
        }else if( parseFloat($("#price").val()) <  parseFloat($("#parentPrice").val())){
            alert("价格不能低于底价");
        }else{
            $("#addForm").submit();
        }
    }


</script>