<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0, user-scalable=0">
    <title>套餐订购</title>
    <link rel="stylesheet" type="text/css" href="/css/hui.css"/>
    <link rel="stylesheet" href="/vendors/css/vendor.bundle.base.css">
    <link rel="stylesheet" href="/vendors/iconfonts/mdi/css/materialdesignicons.min.css">
    <link rel="stylesheet" href="/css/style.css">
    <style type="text/css">
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
          background: #f1c205!important;
        }

        .hui-header h1 {
          padding-left: 0;
        }

        .hui-form-radios input[type="radio"]:checked + label:before {
            color: #fe7e56!important;
        }

        .btn-gradient-secondary {
            background: linear-gradient(to right, #e7ebf0, #868e96);
            border: 0;
            -webkit-transition: opacity 0.3s ease;
            -moz-transition: opacity 0.3s ease;
            -ms-transition: opacity 0.3s ease;
            -o-transition: opacity 0.3s ease;
            transition: opacity 0.3s ease;
            color: #fff;
            height: 40px;
            margin: 10px;
        }

        .btn.btn-rounded {
            border-radius: 50px;
        }

        .hui-header {
            background: linear-gradient(to right, #e7ebf0, #868e96);
            border: 0;
            -webkit-transition: opacity 0.3s ease;
            -moz-transition: opacity 0.3s ease;
            -ms-transition: opacity 0.3s ease;
            -o-transition: opacity 0.3s ease;
            transition: opacity 0.3s ease;
        }

        .pd1 {
            padding: 1rem;
        }

        .mr-b-1 {
            margin-bottom: 1rem;
        }

        .llb {

        }

        .llb ul {
            padding: 1rem;
            padding-bottom: 0;
        }

        .llb li {
            display: flex;
            justify-content: space-between;
            padding: 1rem;
            border: 1px solid #dddddd;
            margin-bottom: 1rem;
        }

        .llb li:last-child {
            margin-bottom: 0;
        }

        .llb li .left, .llb li .right {
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .llb li .right {
            color: #fff;
        }

        .llb li .time {
            font-size: 0.8rem;
            color: #808080;
        }

        .llb li span {
            font-size: 0.8rem;
        }

        .llb li.active {
            border-color: #fe7e56;
        }

        .fs-1 {
            font-size: 1rem !important;
        }

        .fs-08 {
            font-size: 0.8rem !important;
        }

        #hui-footer {
            height: auto;
            flex-direction: column;
            padding: 1rem 0 0 1rem;
        }

        #hui-footer .hui-form-radios {
            display: flex;
            align-items: center;
        }

        #hui-footer .hui-form-radios input[type="radio"] + label:before {
            padding-right: 10px;
        }

        #hui-footer .hui-form-radios input[type="radio"] + label {
            padding-right: 16px;
            font-size: 0.8rem;
            /* padding-bottom: 0.2rem; */
            display: flex;
            align-items: center;
            margin-bottom: 0.6rem;
        }

        .btn_wrap {
            display: flex;
            justify-content: flex-end;
            align-items: center;
        }

        .btn_wrap .okBtn {
            width: 36%;
            padding: 0.8rem 0;
            font-size: 1rem;
            text-align: center;
            background: #f1c205;
            margin-left: 1rem;
            color: #fff;
        }

        .c1 {
            color: #808080;
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

        .c5 {
            color: #f5707a;
        }
    </style>
</head>
<body class="bc1">
<header class="hui-header">
    <div id="hui-back"></div>
    <h1>套餐订购</h1>
    <div class="hui-menu"></div>
</header>
<div class="hui-wrap">
    <div class="pd1 mr-b-1 bg-white">ICCID号：8988955844545456</div>
    <div class="llb bg-white">
        <ul>
            <h6 class="mr-b-1">选择流量包</h6>
            <li class="active">
                <div class="left">
                    <span class="fs-1 c2">襄王黄金版5G</span>
                    <span class="time">有效期：2015-02-20 至 2020-02-20</span>
                </div>
                <div class="right text-center text-white">
                    <span class="c1">优惠价</span>
                    <span class="fs-1 c2">48元</span>
                </div>
            </li>
            <li>
                <div class="left">
                    <span class="fs-1 c2">襄王黄金版5G</span>
                    <span class="time">有效期：2015-02-20 至 2020-02-20</span>
                </div>
                <div class="right text-center text-white">
                    <span class="c1">优惠价</span>
                    <span class="fs-1 c2">48元</span>
                </div>
            </li>
        </ul>
    </div>
</div>

<footer id="hui-footer">
    <div class="hui-form-radios">
        <input type="radio" value="" name="setmeal" id="nowMonth" checked/><label for="nowMonth">当月生效</label>
        <input type="radio" value="" name="setmeal" id="nextMonth"/><label for="nextMonth">次月生效</label>
    </div>
    <div class="fs-08 c5">请在有效时间内使用，月底清零。</div>
    <div class="btn_wrap">
        <div class="fs-08">金额：<span class="fs-08 c5">15.00 元</span></div>
        <div class="okBtn">订购</div>
    </div>
</footer>
<script src="/js/jquery.js" type="text/javascript"></script>
<script src="/js/hui.js" type="text/javascript"></script>
<script type="text/javascript">
    $('.llb li').click(function () {
        $(this).addClass('active').siblings('li').removeClass('active');
    })
</script>
</body>
</html>