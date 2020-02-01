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
                <div class="col-lg-6 grid-margin stretch-card">
                    <div class="card">
                        <div class="card-body">
                            <h4 class="card-title">编辑套餐</h4>
                            <br>
                            <div class="body">
                                <form id="addForm" action="/admin/editCommodity" method="post" enctype="multipart/form-data">
                                    <c:if test="${user_agent.parentId == -1}" >
                                        <div class="form-group">
                                            <label for="search-input">所属分类：</label>
                                            <div class="input-group" style="width:100%;">
                                                <select name="pclass.id" onchange="classChange(options[selectedIndex].value)" class="selectpicker form-control">
                                                    <c:forEach var="cl" items="${temp_pclass}">
                                                        <option <c:if test="${cl.id == temp_commodity.pclass.id}">selected</c:if> value ="${cl.id}">${cl.name}</option>
                                                    </c:forEach>

                                                </select>

                                            </div>
                                        </div>

                                        <input name="id" value="${temp_commodity.id}" type="text" style="display: none">
                                        <div class="form-group">
                                            <label for="search-input">套餐名称：</label>
                                            <div class="input-group" style="width:100%;">
                                                <input name="name" type="text" id="name" value="${temp_commodity.name}" class="form-control">
                                                <span class="input-group-btn">
                                  </span>
                                            </div>
                                        </div>
                                        <input name="edit" value="zhu" type="text" style="display: none">

                                        <div class="form-group">
                                            <label for="search-input">包含流量(M)：</label>
                                            <div class="input-group" style="width:100%;">
                                                <input oninput="document.getElementById('ll').innerText = document.getElementById('note').value * document.getElementById('xuliang').value" value="${temp_commodity.note}" name="note" type="number" id="note" class="form-control">
                                                <span class="input-group-btn">
                                        </span>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="search-input">虚量倍数(1为无虚量)：</label>
                                            <div class="input-group" style="width:100%;">
                                                <input id="xuliang" oninput="xujia()" name="xuliang" type="number" value="${temp_commodity.xuliang}" class="form-control">
                                                <span class="input-group-btn">
                                        </span>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="search-input">实际流量(M)：</label>
                                            <div class="input-group" style="width:100%;">
                                                <p id="ll">${temp_commodity.note * temp_commodity.xuliang}</p>
                                                <span class="input-group-btn">
                                  </span>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="search-input">达额限速(单位是M，0则为不限速  这里不要写虚流量 按真实的来写)：</label>
                                            <div class="input-group" style="width:100%;">
                                                <input name="xiansu" type="number" value="${temp_commodity.xiansu}" class="form-control">
                                                <span class="input-group-btn">
                                        </span>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="search-input">套餐天数：</label>
                                            <div class="input-group" style="width:100%;">
                                                <input name="day" type="number" value="${temp_commodity.day}" class="form-control">
                                                <span class="input-group-btn">
                                        </span>
                                            </div>
                                        </div>

                                     <%--   <div class="form-group">
                                            <label for="search-input">限速流量(M)到达之后限速 0代表不限速：</label>
                                            <div class="input-group" style="width:100%;">
                                                <input value="${temp_commodity.imgUrl}" name="imgUrl" type="number" id="xiansu" class="form-control">
                                                <span class="input-group-btn">
                                        </span>
                                            </div>
                                        </div>--%>



                                        <div class="form-group">
                                            <label for="search-input">套餐价格：</label>
                                            <div class="input-group" style="width:100%;">
                                                <input name="price" type="number" id="price" value="${temp_commodity.price}" class="form-control">
                                                <span class="input-group-btn">
                                  </span>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="search-input">排序顺序：</label>
                                            <div class="input-group" style="width:100%;">
                                                <input name="sort" type="number" id="sort" value="${temp_commodity.sort}" class="form-control">
                                                <span class="input-group-btn">
                                  </span>
                                            </div>
                                        </div>
                                        <a style="width: 100%;" class="btn btn-s-md btn-default" href="javascript:saveCommodity()">保存</a>
                                    </c:if>
                                    <c:if test="${user_agent.parentId != -1}">
                                        <input name="edit" value="fen" type="text" style="display: none">
                                        <input name="id" value="${temp_commodity.id}" type="text" style="display: none">
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
                                                <p >${temp_commodity.name}</p>
                                                <span class="input-group-btn">
                                  </span>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="search-input">包含流量（M）：</label>
                                            <div class="input-group" style="width:100%;">
                                                <p >${temp_commodity.note}</p>
                                                <span class="input-group-btn">
                                  </span>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="search-input">上家给的价格：</label>
                                            <div class="input-group" style="width:100%;">
                                                <p >${temp_commodity.parentPrice}</p>
                                                <span class="input-group-btn">
                                  </span>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="search-input">套餐价格：</label>
                                            <div class="input-group" style="width:100%;">
                                                <input name="price" type="number" id="price" value="${temp_commodity.price}" class="form-control">
                                                <span class="input-group-btn">
                                                </span>
                                            </div>
                                        </div>
                                        <a style="width: 100%;" class="btn btn-gradient-secondary btn-rounded btn-fw" href="javascript:saveCommodityTwo()">保存</a>
                                    </c:if>
                                </form>
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
    function classChange(pcid) {
        $.get("/admin/getAddCommoditySort",{pcid:pcid},function (sort) {
            $("#sort").val(sort);
        });
    }
    function save() {
        var name = $("#name").val();
        var note = $("#note").val();
        var sort = $("#sort").val();
        if(name.length < 1 || note.length < 1 || sort.length < 1){
            alert("请完善内容再保存");
            return;
        }
        window.location.href = "/admin/addClass?name="+name+"&note="+note+"&sort="+sort;
    }

    function xujia(){
        var xujia = document.getElementById('xuliang').value ;
        document.getElementById('ll').innerText = document.getElementById('note').value * xujia;
    }

    //SelectImg
    $("#uploadimg").click(function(){
        $("#upload").click();
    });
    $("#upload").change(function(){
        var file = document.getElementById("upload").files[0];
        if((file.type).indexOf("image/")==-1){
            alert("格式不正确，请重新上传!");
            return;
        }
        $("#uploadimg").attr("src",URL.createObjectURL($(this)[0].files[0]));
    });

    /**
     * 提交 非空验证
     * 主站专用
     */
    function saveCommodity() {
        if($("#name").val().length < 1 || $("#price").val().length < 1 || $("#sort").val().length < 1 ){
            alert("不能有空项");
        }else{
            $("#addForm").submit();
        }
    }

    /**
     * 分站专用
     */
    function saveCommodityTwo() {
        if($("#price").val().length < 1){
            alert("不能有空项");
        }else{
            $("#addForm").submit();
        }
    }

</script>