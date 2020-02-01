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
                        <li > <a href="/admin/commodityList"> <i class="icon-angle-right"></i>套餐列表</a> </li>
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
                    <h2 class="page-title">套餐分配<small>正在给账号为：${tempAgent.account}，的代理分配套餐。</small></h2>
                    <input id="account" value="${tempAgent.id}" type="hidden">
                </div>
            </div>
            <div class="row col-lg-6">
                <div class="widget">
                    <div class="widget-header"> <i class="icon-arrow-down"></i>
                        <h3>套餐分配</h3>
                    </div>
                    <div class="widget-content">
                        <div class="body">
                            <form id="addForm" action="/admin/addCommodity" method="post" enctype="multipart/form-data">
                            <div class="form-group">
                                <label for="search-input">所属分类：</label>
                                <div class="input-group" style="width:100%;">
                                    <select id="pclass" name="pclass.id" class="selectpicker form-control">
                                        <c:forEach var="cl" items="${temp_pclass}">
                                            <option value ="${cl.id}">${cl.name}</option>
                                        </c:forEach>

                                    </select>
                                  </span>
                                </div>

                            </div>

                                <div class="form-group">
                                    <label for="search-input">选择套餐：</label>
                                    <div class="input-group" style="width:100%;">
                                        <select id="setmeal" name="commodity.id" class="selectpicker form-control">
                                            <c:forEach var="co" items="${temp_commodity}">
                                                <option value ="${co.id}">${co.name}</option>
                                            </c:forEach>

                                        </select>
                                        </span>
                                    </div>

                                </div>

                                <div class="form-group">
                                    <label for="search-input">您的底价(元)：</label>
                                    <div class="input-group" style="width:100%;">
                                        <p id="myprice">${temp_commodity[0].parentPrice == null ? '-' :temp_commodity[0].parentPrice}</p>
                                        <span class="input-group-btn">
                                  </span>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="search-input">设置底价(元)：</label>
                                    <div class="input-group" style="width:100%;">
                                        <input name="parentPrice" type="number" id="parentPrice" class="form-control">
                                        <span class="input-group-btn">
                                  </span>
                                    </div>
                                </div>


                            <div class="form-group">
                                <label for="search-input">设置价格(元)：</label>
                                <div class="input-group" style="width:100%;">
                                    <input name="price" type="number" id="price" class="form-control">
                                    <span class="input-group-btn">
                                  </span>
                                </div>
                            </div>

                                    <a style="width: 100%;" class="btn btn-s-md btn-default" href="javascript:save()">分配</a>

                            </form>

                        </div>

                    </div>
                </div>
            </div>
            <div class="row">
                <div class="widget">
                    <div class="widget-header"> <i class="icon-arrow-down"></i>
                        <h3>代理套餐列表</h3>
                    </div>
                    <div class="widget-content">
                        <div class="body">


                            <table id="table"></table>
                            <br>


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
        url : "/admin/getCommodityData?aid="+$("#account").val(),
        async : false,
        success : function(result){
            requestJson = jQuery.parseJSON(result);
        }
    });

    $('#table').bootstrapTable({
        url: '/admin/getCommodityData?aid='+$("#account").val(),
        pagination: true,//是否分页
        sidePagination: "client", //分页方式：client客户端分页，server服务端分页（*）
        pageNumber: 1,//初始化加载第一页，默认第一页,并记录
        search: true,//是否显示搜索
        pageSize: 10,//每页的记录行数（*）
        columns: [ {
            field: 'name',
            title: '套餐名称',
            align: 'center',
            width: 130,
            valign: 'middle',
            formatter: loadText
        }, {
            field: 'note',
            align: 'center',
            title: '流量(M)',
            valign: 'middle',
            formatter: loadText
        },{
            field: 'pclass.name',
            align: 'center',
            title: '所属分类',
            valign: 'middle',
            formatter: loadText
        }, {
            field: 'parentPrice',
            align: 'center',
            title: '底价',
            valign: 'middle',
            formatter: loadText
        }, {
            field: 'price',
            align: 'center',
            title: '价格',
            valign: 'middle',
            formatter: loadText
        }, {
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


    //操作栏的格式化
    function actionFormatter(value, row, index) {

        var id = value;
        var result = "";
        for(var i = 0;i<requestJson.length;i++){
            if(id ==requestJson[i].id){
                result += '<a class="btn btn-sm btn-default" href="javascript:edit('+id+')">编辑</a>&nbsp;';
                result += '<a class="btn btn-sm btn-default" href="javascript:deletes('+id+')">删除</a>&nbsp;';
            }
        }
        return result;
    }

    //编辑
    function edit(id){
        window.location.href='/admin/editCommodityAgent?aid='+$("#account").val()+'&cid='+id;
    }
    //删除
    function deletes(id) {
        for(var i = 0;i<requestJson.length;i++){
            if(requestJson[i].id == id){
                if(confirm("确定要删除“"+requestJson[i].name+"”吗？’")){
                    $.post("/admin/deleteCommodity2",{cid:id,aid: $("#account").val()},function(result){
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

    $("#pclass").change(function(){
        changeSetMeal($("#pclass option:selected").val());
    });

    //切换类更改套餐
    function changeSetMeal(cid) {
        var jsonstr = null;
        $.ajax({
            type : "post",
            url : "/admin/getCommodityData?cid="+cid,
            async : false,
            success : function(result){
                requestJson = jQuery.parseJSON(result);
                jsonstr = requestJson;
                $("#setmeal").html("");
                var result = "";
                for(var i = 0;i < requestJson.length;i++){
                    var aid = requestJson[i].id;
                    var name = requestJson[i].name;
                    result += '<option value ="'+aid+'">'+name+'</option>';
                }
                if(result == ""){
                    result += '<option value ="">该分类下暂无套餐</option>';
                }
                $("#setmeal").html(result);
            }
        });
        if(jsonstr == null){
            $("#myprice").html("请选择套餐");
        }else{
            var selectid = $("#setmeal option:selected").val();
            for(var i = 0; i < jsonstr.length;i++){
                if(selectid == jsonstr[0].id){
                    $("#myprice").html(jsonstr[0].parentPrice);
                }
            }
        }

    }
    
    function save() {
        var cid = $("#pclass option:selected").val();
        var sid = $("#setmeal option:selected").val();
        var parentPrice = $("#parentPrice").val();
        var price = $("#price").val();
        var id = $("#account").val();

        if(cid.length < 1 || sid.length < 1 || price.length < 1 || parentPrice.length < 1){
            alert("请完善内容再保存");
        }else if(parseFloat(parentPrice) > parseFloat(price)){
            console.log("parentPrice:"+parentPrice);
            console.log(price);
            alert("价格不能低于底价");
        }else{
            //验证成功发起请求
            $.ajax({
                type : "post",
                url : "/admin/setMealSubmit",
                data:{
                    'commodity.id':sid,
                    'price':price,
                    'agent.id':id,
                    'parentPrice':parentPrice
                },
                async : false,
                success : function(result){
                    if(result > 0){
                        alert("分配成功");
                        window.location.reload();
                    }else if(result == -1){
                        alert("分配失败，可能该代理已有此套餐。");
                    }else if(result == -5){
                        alert("给代理的底价不能低于您的底价");
                    }
                }
            });
        }
    }



</script>