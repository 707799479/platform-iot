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
                        <li > <a href="/admin/commodityClass"> <i class="icon-angle-right"></i>卡分类</a> </li>
                        <li> <a href="/admin/addClass"> <i class="icon-angle-right"></i>添加分类</a> </li>
                        <li > <a href="/admin/commodityList"> <i class="icon-angle-right"></i>套餐列表</a> </li>
                        <li > <a href="/admin/addCommodity"> <i class="icon-angle-right"></i>添加套餐</a> </li>
                    </ul>
                </li>
                <li> <a href="#"> <i class="icon-user"></i>代理管理<i class="arrow icon-angle-left"></i></a>
                    <ul class="sub-menu">
                        <li class="current"> <a href="/admin/agentList"> <i class="icon-angle-right"></i>代理列表</a> </li>
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
                    <h2 class="page-title">代理列表<small>您可以在这里管理您的代理</small></h2>
                </div>
            </div>
            <div class="row">
                <div class="widget">
                    <div class="widget-header"> <i class="icon-arrow-down"></i>
                        <h3>旗下代理</h3>
                    </div>
                    <div class="widget-content">
                        <div class="body">


                            <table id="table"></table>
                            <br>
                            <a style="width: 100%;" class="btn btn-s-md btn-default" href="javascript:addClass()">添加一个代理</a> <br>
                            <input type="hidden" id="admin_id" value="${system_admin.id}">
                            <input type="hidden" id="my_id" value="${user_agent.id}">
                            
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
        columns: [ {
            field:'qq',
            title: ' ',
            align: 'center',
            valign: 'middle',
            formatter: loadImg
        },{
            field: 'account',
            align: 'center',
            title: '账号',
            valign: 'middle',
            formatter: loadText
        },{
            field: 'domain',
            title: '域名',
            align: 'center',
            valign: 'middle',
            formatter: loadDomain
        }, {
            field: 'websiteName',
            align: 'center',
            title: '网站名称',
            valign: 'middle',
            formatter: loadText
        }, {
            field: 'money',
            align: 'center',
            title: '钱包',
            valign: 'middle',
            formatter: loadText
        }, {
            field: 'qq',
            align: 'center',
            title: '联系电话',
            valign: 'middle',
            formatter: loadText
        }, {
            field: 'createTime',
            align: 'center',
            title: '开通时间',
            valign: 'middle',
            formatter: loadDate
        }, {
            field: 'agentNum',
            align: 'center',
            title: '旗下代理',
            valign: 'middle',
            formatter: loadText
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
        result += '<img style="width: 60px;height: 60px;" src="http://q1.qlogo.cn/g?b=qq&nk='+value+'&s=640">';
        return result;
    }

    //操作栏的格式化
    function actionFormatter(value, row, index) {
        var adminId = $("#admin_id").val();
        var myId = $("#my_id").val();
        var id = value;
        var result = "";

        result += '<a class="btn btn-sm btn-default" href="javascript:setMeal('+id+')">分配套餐</a>&nbsp;';
        result += '<a class="btn btn-sm btn-default" href="javascript:newPwd('+id+')">重置密码</a>&nbsp;';
        result += '<a class="btn btn-sm btn-default" href="javascript:deletes('+id+')">删除</a>&nbsp;';
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