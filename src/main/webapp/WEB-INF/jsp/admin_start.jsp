<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0, user-scalable=0">
    <title>续费充值中心</title>
    <!-- plugins:css -->
    <link rel="stylesheet" href="/vendors/iconfonts/mdi/css/materialdesignicons.min.css">
    <link rel="stylesheet" href="/vendors/css/vendor.bundle.base.css">
    <!-- endinject -->
    <!-- inject:css -->
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" type="text/css" href="/css/hui.css"/>
    <!-- endinject -->
    <link rel="shortcut icon" href="/images/favicon.png"/>
    <style>
        .bc1 {
            background: #F4F4F4;
        }

        .bg-box {
            background: linear-gradient(#f1c970, #f1c205);
            padding-bottom: 9rem;
        }

        .bg-box div, .bg-box span {
            color: #fff;
        }

        .bg-box .top {
            display: flex;
            justify-content: space-between;
            -webkit-display: flex;
            -webkit-justify-content: space-between;
            padding: 1rem;
        }

        .bg-box .top .b-img {
            width: 20%;
            height: auto;
            margin-right: 1rem;
            border-radius: 50%;
            border: 1px solid #fff;
        }

        .bg-box .top .b-info {
            color: #fff;
            display: flex;
            flex: 1;
            flex-direction: column;
            justify-content: space-between;
        }

        .bg-box .top .b-info span {
            font-size: 14px;
        }

        /*
  流量图页面*/
        /*环状图标信息*/
        #bgD .flow_chartPie {
            width: 100%;
            position: relative;
            margin: 0;
        }

        .flow-chartShade {
            width: 100%;
            position: absolute;
            bottom: 28%;
            left: 0;
        }

        div {
            overflow: initial
        }

        #flow_chartCvs {
            text-align: center;
        }

        .dis-block {
            width: 46%;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
        }

        .taocan {
            margin: 0 1rem;
            top: -4rem;
        }

        .taocan .card-body {
            padding: .9rem;
            font-size: 0.8rem;
        }

        .taocan .head {
            height: 6rem;
            display: flex;
            padding-bottom: 1rem;
            border-bottom: 1px solid #64a0ef;
        }

        .taocan .head .left {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .taocan .head .right {
            display: flex;
            justify-content: space-between;
            flex-direction: column;
        }

        .taocan span {
            color: #808080;
            font-size: 14px;
        }

        .taocan .foot {
            padding-top: 1rem;
            font-size: 14px;
            overflow: hidden;
            text-overflow: ellipsis;
            color: #64a0ef;
        }

        .lists {
            margin: 1rem;
            top: -4rem;
        }

        .lists ul {
            font-size: 0;
            padding: 0;
            margin-bottom: 0;
        }

        .lists li {
            display: inline-block;
            width: 25%;
            padding-bottom: 1rem;

        }

        .lists li .text {
            font-size: 14px;
            text-align: center;
            padding-top: 10px;
            color: #808080;
        }

        .lists li .hui-speed-dial-icons span {
            font-size: 30px;
            color: #64a0ef;
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
    </style>
</head>

<body class="bc1">

<div class="bg-box" id="bg-box">
    <div class="top">
        <img src="/assets/img/ryan.jpg" alt="" class="b-img">
        <div class="b-info">
            <span>小于</span>
            <span>7878554554545421</span>
            <span>中国移动-Y5通道</span>
        </div>
        <div>
            <div>退出</div>
        </div>
    </div>

    <div id="bgD" class="w-100 pos-abs">
        <div class="pull-left">
            <div class="w-100">
                <div class="flow_chartPie">
                    <div id="flow_chartCvs"></div>
                    <div class="flow-chartShade text-center">
                        <h1>0</h1>
                        <div>剩余流量/GB</div>
                        <div>停机</div>
                    </div>
                    <div class="dis-block text-center">
                        <div>
                            <h4>0</h4>
                            <div>总流量</div>
                        </div>
                        <div>
                            <h4>0</h4>
                            <div>已使用/GB</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

<div class="card taocan">
    <div class="card-body">
        <div class="head">
            <div class="left">
                <span class="c4">套餐名称：暂未订购套餐</span>
                <span>SIM:中国移动</span>
                <span>套餐有效期：2020-10-12</span>
            </div>
            <div class="right text-right">
                <span class="c3">更多</span>
                <div>
                    <i class="c4">￥1.00</i>
                    <span class="mdi mdi-cached c3"></span>
                </div>
            </div>
        </div>
        <div class="foot">
            <i class="mdi mdi-bullhorn c3 mr-1"></i>余额充值赠送活动开始啦
        </div>
    </div>
</div>


<div class="card lists">
    <ul>
        <li>
            <div class="hui-speed-dial-icons">
                <span class="mdi mdi-cash-usd"></span>
            </div>
            <div class="text">余额查询</div>
        </li>
        <li>
            <div class="hui-speed-dial-icons">
                <span class="hui-icons hui-icons-search"></span>
            </div>
            <div class="text">套餐订购</div>
        </li>
        <li>
            <div class="hui-speed-dial-icons">
                <span class="mdi mdi-account-circle"></span>
            </div>
            <div class="text">实名登记</div>
        </li>
        <li>
            <div class="hui-speed-dial-icons">
                <span class="mdi mdi-web"></span>
            </div>
            <div class="text">智能诊断</div>
        </li>
        <li>
            <div class="hui-speed-dial-icons">
                <span class="mdi mdi-webhook"></span>
            </div>
            <div class="text">充值记录</div>
        </li>
        <li>
            <div class="hui-speed-dial-icons">
                <span class="mdi mdi-credit-card-multiple"></span>
            </div>
            <div class="text">换卡申请</div>
        </li>
    </ul>
</div>

</body>
<!-- plugins:js -->

</html>
<script src="/js/jquery.js"></script>
<script type="text/javascript" src="/js/raphael.js"></script>
<%--<script type="text/javascript" src="/js/config.js"></script>--%>
<script>
    $(window).load(function () {
        initStyles();
    })
    // $(window).resize(function () {
    //     initStyles();
    //     window.location.replace(location);
    // });

    function initStyles() {
        $("#topD").css("height", $("#bg-box").height() + "px");
        $("#bgD").css("height", $("#bg-box").height() + "px");

        // 设置环状统计报表
        var viewWidth = $(window).width();  //屏幕宽度
        var diameter = viewWidth * 0.5;       // 图标宽度
        var high = diameter * 0.8;            // 图标高度
        var radius1 = high / 2;               // 外环半径
        var radius2 = radius1 - 10;           // 内环半径
        var cx = diameter / 2;                // x轴坐标
        var cy = high * 0.65;                 // y轴坐标
        dial(60, diameter, high, cx, cy, radius1, radius2, "flow_chartCvs", "gradient");  // 第一个数值即为百分比数值

    }

    function dial(percent, width, height, cx, cy, r1, r2, eleId, colorFlag) {
        var paper = Raphael(document.getElementById(eleId), width, height);
        var a = 225 - percent * 270 / 100, a0 = 225;
        var dial_0 = paper.path(doughnut_path(cx, cy, r1, r2, -45, 225)).attr({"fill": "#FFF", "stroke": "none"}),
            dial_1 = paper.path(doughnut_path(cx, cy, r1, r2, 225, 225)).attr({"fill": "#FE7E56", "stroke": "none"});
        if (colorFlag == "gradient") {
            dial_0.attr(
                {
                    "fill": "#FFFFFF"
                }
            )
            dial_1.attr(
                {
                    gradient: '#FE7E56',
                    'stroke-linejoin': 'round',
                    rotation: -90
                }
            );
        }
        ;
        drawTemp();

        function drawTemp() {
            if (a0 > a) {
                a0--;
                dial_0.attr({"path": doughnut_path(cx, cy, r1, r2, -45, a0)});
                dial_1.attr({"path": doughnut_path(cx, cy, r1, r2, a0 - 1, 225)});
                setTimeout(drawTemp, 1);
            }
        }

        function doughnut_path(cx, cy, r1, r2, startAngle, endAngle) {
            var rad = Math.PI / 180;
            var x1 = cx + r1 * Math.cos(-startAngle * rad), y1 = cy + r1 * Math.sin(-startAngle * rad),
                x2 = cx + r2 * Math.cos(-startAngle * rad), y2 = cy + r2 * Math.sin(-startAngle * rad),
                x3 = cx + r2 * Math.cos(-endAngle * rad), y3 = cy + r2 * Math.sin(-endAngle * rad),
                x4 = cx + r1 * Math.cos(-endAngle * rad), y4 = cy + r1 * Math.sin(-endAngle * rad);    //四点坐标
            return ["M", x2, y2, "A", r2, r2, 0, +(endAngle - startAngle > 180), 0, x3, y3, "L", x4, y4, "A", r1, r1, 0, +(endAngle - startAngle > 180), 1, x1, y1, "z"];
        }
    }
</script>