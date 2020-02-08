<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0, user-scalable=0">
    <title>实名认证</title>
    <link rel="stylesheet" type="text/css" href="/css/hui.css"/>
    <link rel="stylesheet" href="/css/style.css">
    <style>
        * {
            padding: 0;
            margin: 0;
            color: #5d5d5d;
        }

        h1, h2, h3, h4, h5, h6, .h1, .h2, .h3, .h4, .h5, .h6 {
            margin: 0;
        }

        .bc1 {
            background: #F4F4F4;
        }

        .hui-header {
            background: #f1c205 !important;
        }

        .hui-form-items {
            padding: 0.8rem 1rem;
            font-size: 0.94rem;
        }

        .hui-form-items-title {
            width: 26%;
            font-size: 0.94rem;
        }

        .hui-button:active {
            background: #f1c720;
        }

        .mr-b-1 {
            margin-bottom: 1rem;
        }

        .bc2 {
            background: #f1c205;
        }

        .c2 {
            color: #fe7e56 !important;
        }

        .c3 {
            color: #64a0ef !important;
        }

        .c4 {
            color: #f0ad4e !important;
        }

        .pd1 {
            padding: 1rem;
        }
    </style>
</head>
<body class="bc1">
<header class="hui-header">
    <h1>充值续费</h1>
</header>
<div class="hui-wrap">
    <div class="bg-white text-center mr-b-1 pd1">
        <img src="/img/bg-cz.png" alt="" style="width: 50%;">
    </div>
    <form method="post" action="/start" class="hui-form" id="form1">
        <div class="text-center c2 pd1">请输入ICCID账号</div>
        <div class="hui-form-items">
            <div class="hui-form-items-title">输入卡号:</div>
            <input type="text" class="hui-input hui-input-clear" name="iccid" placeholder="如：199554654654XXX"/>
        </div>
    </form>

</div>
</div>
<div class="pd1 mr-t-10">
    <button id="submitBtn" type="button" class="hui-button bc2 text-white hui-button-large" onclick="window.location.href='start'">查询</button>
</div>
<script src="/js/hui.js" type="text/javascript"></script>
</body>
</html>