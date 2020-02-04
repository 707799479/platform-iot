<%@ page contentType="text/html;charset=UTF-8" language="java" %>

    <%@ include file="header.jsp" %>

        <%@ include file="nav.jsp" %>

        <div class="content-wrapper">
            <div class="col-lg-12 grid-margin stretch-card">
                <div class="card">
                    <div class="card-body">
                        <h4 class="card-title">提现记录</h4>
                        <br>
                        <c:if test="${user_agent.parentId == 0}">
                            <a class="btn btn-outline-primary btn-fw" href="/admin/outAllExtract">导出未处理并标记已处理</a>
                            <a class="btn btn-outline-primary btn-fw" href="/admin/allExtractChange?type=2">全部退回</a>
                            <br>
                        </c:if>

                        <table id="table"></table>
                        <br>
                    </div>
                </div>
            </div>

        </div>
        <!-- content-wrapper ends -->
        <%@ include file="footer.jsp" %>

<script type="text/javascript">

    var requestJson;

    $.ajax({
        type : "post",
        url : "/admin/getExtractData?aid=${user_agent.id}",
        async : false,
        success : function(result){
            requestJson = jQuery.parseJSON(result);
            for(var i = 0;i < requestJson.length;i++){
                if(requestJson[i].status == 1){
                    countOrder ++;
                }
            }

            $("#count").text("共有"+countOrder+"个订单未处理。");
        }
    });

    $('#table').bootstrapTable({
        url: '/admin/getExtractData?aid=${user_agent.id}',
        pagination: true,//是否分页
        sidePagination: "client", //分页方式：client客户端分页，server服务端分页（*）
        pageNumber: 1,//初始化加载第一页，默认第一页,并记录
        search: true,//是否显示搜索
        pageSize: 10,//每页的记录行数（*）
        columns: [ {
            field:'agent.websiteName',
            title: '代理站名',
            align: 'center',
            valign: 'middle',
            formatter: loadText
        },{
            field:'money',
            title: '提现金额',
            align: 'center',
            valign: 'middle',
            formatter: loadText
        },{
            field:'agent.tName',
            title: '真实姓名',
            align: 'center',
            valign: 'middle',
            formatter: loadText
        },{
            field: 'agent.tAccount',
            align: 'center',
            title: '提现账号',
            valign: 'middle',
            formatter: loadText
        },{
            field: 'status',
            title: '状态',
            align: 'center',
            valign: 'middle',
            formatter: status
        }, {
            field: 'createTime',
            align: 'center',
            title: '创建时间',
            valign: 'middle',
            formatter: loadDate
        },{
            field:'id',
            title: '操作',
            align: 'center',
            valign: 'middle',
            formatter: actionFormatter
        } ]
    });

    //加载状态
    function status(value, row, index) {
        if(value == undefined || value == null){
            value = "-";
        }
        if(value == 0){
            value = "未处理";
        }else if(value == 1){
            value = "已完成";
        }else if(value == 2){
            value = "已退回";
        }else{
            value = "异常状态,请联系开发者";
        }
        return '<p>'+value+'</p>';
    }

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

    //操作栏的格式化
    function actionFormatter(value, row, index) {
        var id = value;
        var result = "";
        <c:if test="${user_agent.parentId == 0}">
        result += '<button id="bianji" onclick="update('+id+')" type="button" class="btn btn-gradient-primary btn-sm">完成</button>&nbsp;';
        result += '<button id="bianji" onclick="updateTwo('+id+')" type="button" class="btn btn-gradient-primary btn-sm">退回</button>&nbsp;';
        result += '<a class="btn btn-gradient-primary btn-sm" href="/admin/outPriceLog?id='+id+'">导出明细</a>&nbsp;';
        </c:if>
        <c:if test="${user_agent.parentId != 0}">
        result += '<p>-</p>&nbsp;';
        </c:if>

        return result;
    }


    //完成
    function update(id) {
        if(confirm("确定要完成该笔提现吗？")){
            $.post("/admin/updateExtract",{eid:id,type:1},function(result){
                if(result == 1){
                    window.location.reload();
                    alert("成功");
                }else{
                    alert("失败");
                }
            });
        }
    }

    //退回
    function updateTwo(id) {
        if(confirm("确定要退回该笔提现吗？（钱会退回到用户余额里）")){
            $.post("/admin/updateExtract",{eid:id,type:2},function(result){
                if(result == 1){
                    window.location.reload();
                    alert("成功");
                }else{
                    alert("失败");
                }
            });
        }
    }

</script>