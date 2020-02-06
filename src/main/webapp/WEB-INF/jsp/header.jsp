<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="UTF-8">

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
    <!-- partial:partials/_sidebar.html -->
    <nav class="sidebar sidebar-offcanvas" id="sidebar">

        <div class="text-center navbar-brand-wrapper d-flex align-items-center justify-content-center">
            <a class="navbar-brand brand-logo" href="/admin/main"><img src="/images/logo.svg" alt="logo"/></a>
        </div>
        <ul class="nav">

            <li class="nav-item">
                <a class="nav-link" href="/admin/main">
                    <i class="mdi mdi-home menu-icon"></i>
                    <span class="menu-title">首页</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-toggle="collapse" href="#ui-basic" aria-expanded="false" aria-controls="ui-basic">
                    <i class="mdi mdi-apple-keyboard-command menu-icon"></i>
                    <span class="menu-title">套餐管理</span>
                    <i class="menu-arrow"></i>
                </a>
                <div class="collapse" id="ui-basic">
                    <ul class="nav flex-column sub-menu">
                        <li class="nav-item"> <a class="nav-link" href="/admin/commodityList">套餐列表</a></li>
                        <li class="nav-item"> <a class="nav-link" href="/admin/addCommodity">添加套餐</a></li>
                        <li class="nav-item"> <a class="nav-link" href="/admin/commodityClass">通道列表</a></li>
                    </ul>
                </div>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-toggle="collapse" href="#daili" aria-expanded="false" aria-controls="ui-basic">
                    <i class="mdi mdi-account-convert menu-icon"></i>
                    <span class="menu-title">代理管理</span>
                    <i class="menu-arrow"></i>
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
                    <i class="mdi mdi-collage menu-icon"></i>
                    <span class="menu-title">卡片划分</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-toggle="collapse" href="#tixian" aria-expanded="false" aria-controls="ui-basic">
                    <i class="mdi mdi-cash-usd menu-icon"></i>
                    <span class="menu-title">提现</span>
                    <i class="menu-arrow"></i>
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
                        <i class="mdi mdi-earth menu-icon"></i>
                        <span class="menu-title">网站配置</span>
                    </a>
                </li>
            </c:if>
            <li class="nav-item">
                <a class="nav-link" href="/admin/orderList">
                    <i class="mdi mdi-elevation-decline menu-icon"></i>
                    <span class="menu-title">订单管理</span>
                </a>
            </li>
<%--            <li class="nav-item">--%>
<%--                <a class="nav-link" href="/admin/updatePassword">--%>
<%--                    <i class="mdi mdi-compass-outline menu-icon"></i>--%>
<%--                    <span class="menu-title">修改密码</span>--%>
<%--                </a>--%>
<%--            </li>--%>
            <li class="nav-item">
                <a class="nav-link" href="/admin/cardList">
                    <i class="mdi mdi-clipboard-text menu-icon"></i>
                    <span class="menu-title">卡片列表</span>
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

    <div class="container-fluid page-body-wrapper">
        <div class="main-panel">