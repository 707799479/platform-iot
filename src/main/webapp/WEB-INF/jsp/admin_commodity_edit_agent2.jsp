<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>后台管理中心</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootstrap -->
    <link href="/css/bootstrap.css" rel="stylesheet" media="screen">
    <link href="/css/thin-admin.css" rel="stylesheet" media="screen">
    <link href="/css/font-awesome.css" rel="stylesheet" media="screen">
    <link href="/style/style.css" rel="stylesheet">
    <link href="/style/dashboard.css" rel="stylesheet">
    <link href="http://zm921.com:8080/grant/statics/layui/css/layui.css" rel="stylesheet">
    <link href="/css/bootstrap-table.scss" rel="stylesheet">

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="../../assets/js/html5shiv.js"></script>
    <script src="../../assets/js/respond.min.js"></script>
    <![endif]-->

</head>
<body>
<div class="container">
    <div class="top-navbar header b-b"> <a data-original-title="Toggle navigation" class="toggle-side-nav pull-left" href="#"><i style="position: relative;top: 7px;" class="icon-reorder"></i> </a>
        <div class="brand pull-left"> <a href="index.html"> </a></div>

        <ul class="nav navbar-nav navbar-right  hidden-xs">
            <li class="dropdown user  hidden-xs"> <a data-toggle="dropdown" class="dropdown-toggle" href="#"> <i class="icon-male"></i> <span class="username">我的</span> <i class="icon-caret-down small"></i> </a>
                <ul class="dropdown-menu">
                    <li class="divider"></li>
                     <li><a href="/admin/out"><i class="icon-key"></i>退出</a></li>
                </ul>
            </li>
        </ul>
        <form class="pull-right" >
            <input type="search" placeholder="Search..." class="search" id="search-input">
        </form>
    </div>
</div>
<div class="wrapper">
    <div class="left-nav">
        <div id="side-nav">
            <ul id="nav">
                <li > <a href="/admin/main"> <i class="icon-list"></i> 首页 </a> </li>
                <li> <a href="#"> <i class="icon-edit"></i>套餐管理<i class="arrow icon-angle-left"></i></a>
                    <ul class="sub-menu">
                        <li> <a href="/admin/commodityClass"> <i class="icon-angle-right"></i>卡分类</a> </li>
                        <li> <a href="/admin/addClass"> <i class="icon-angle-right"></i>添加分类</a> </li>
                        <li> <a href="/admin/commodityList"> <i class="icon-angle-right"></i>套餐列表</a> </li>
                        <li> <a href="/admin/addCommodity"> <i class="icon-angle-right"></i>添加套餐</a> </li>
                    </ul>
                </li>
                <li> <a href="#"> <i class="icon-user"></i>代理管理<i class="arrow icon-angle-left"></i></a>
                    <ul class="sub-menu">
                        <li> <a href="/admin/agentList"> <i class="icon-angle-right"></i>代理列表</a> </li>
                        <li> <a href="/admin/addAgent"> <i class="icon-angle-right"></i>添加代理</a> </li>
                    </ul>
                </li>
                <li> <a href="#"> <i class="icon-money"></i>提现<i class="arrow icon-angle-left"></i></a>
                    <ul class="sub-menu">
                        <li> <a href="/admin/extract"> <i class="icon-angle-right"></i>申请提现</a> </li>
                        <li> <a href="/admin/extractLog"> <i class="icon-angle-right"></i>提现记录</a> </li>
                    </ul>
                </li>
                <li > <a href="/admin/websiteConfig"> <i class="icon-cogs"></i>网站配置</a> </li>
                <li> <a href="/admin/dataCenter"> <i class="icon-bar-chart"></i>数据中心</a> </li>
                <li > <a href="/admin/express"> <i class="icon-flag"></i>单号管理</a> </li>
                <li> <a href="/admin/feedback"> <i class="icon-tags"></i>反馈管理</a> </li>
                <li  > <a href="/admin/updatePassword"> <i class="icon-cogs"></i>修改密码</a> </li>
                <li> <a href="/admin/orderList"> <i class="icon-tags"></i>订单管理</a> </li>  <li> <a href="http://${user_agent.domain}.${web_config.domain}"> <i class="icon-tags"></i>跳转我的网站</a> </li>

            </ul>
        </div>
    </div>
    <div class="page-content">
        <div class="content container">
            <div class="row">
                <div class="col-lg-12">
                    <h2 class="page-title">套餐<small>您可以在这里管理商套餐</small></h2>
                </div>
            </div>
            <div class="row col-lg-6">
                <div class="widget">
                    <div class="widget-header"> <i class="icon-arrow-down"></i>
                        <h3>编辑套餐</h3>
                    </div>
                    <div class="widget-content">
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


                                    <a style="width: 100%;" class="btn btn-s-md btn-default" href="javascript:saveCommodity()">保存</a>
                            </form>
                        </div>

                    </div>
                </div>
            </div>

        </div>
    </div>
</div>


<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="/js/jquery.js"></script>
<script src="/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/js/smooth-sliding-menu.js"></script>
<script type="text/javascript" src="http://zm921.com:8080/grant/statics/layui/layui.js"></script>

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