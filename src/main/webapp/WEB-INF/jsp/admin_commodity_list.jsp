<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ include file="header.jsp" %>

    <%@ include file="nav.jsp" %>

    <div class="content-wrapper">
        <div class="col-lg-12 grid-margin stretch-card">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">套餐列表</h4>
                    <table id="table"></table>
                    <br>
                    <button style="width: 100%;" type="button" onclick="addClass()" class="btn btn-gradient-secondary btn-rounded btn-fw">添加一个套餐</button>
                    <input type="hidden" id="admin_id" value="${system_admin.id}">
                    <input type="hidden" id="my_id" value="${user_agent.id}">
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
        url : "/admin/getCommodityData",
        async : false,
        success : function(result){
            requestJson = jQuery.parseJSON(result);
        }
    });

    $('#table').bootstrapTable({
        url: '/admin/getCommodityData',
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
            title: '所属通道',
            valign: 'middle',
            formatter: loadText
        }, {
            field: 'parentPrice',
            align: 'center',
            title: '成本价',
            valign: 'middle',
            formatter: loadText
        }, {
            field: 'price',
            align: 'center',
            title: '售价',
            valign: 'middle',
            formatter: loadText
        }, {
            field: 'sort',
            align: 'center',
            title: '套餐ID',
            valign: 'middle',
            formatter: loadText
        }, {
            field: 'trueTraffic',
            align: 'center',
            title: '真实流量（M）',
            valign: 'middle',
            formatter: loadText
        }, {
            field: 'termOfValidity',
            align: 'center',
            title: '有效期（天）',
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
        var adminId = $("#admin_id").val();
        var myId = $("#my_id").val();
        var id = value;
        var result = "";
        for(var i = 0;i<requestJson.length;i++){
            if(id ==requestJson[i].id){
                if(requestJson[i].agent.id != adminId || requestJson[i].agent.id == myId) {
                    result += '<button id="bianji" onclick="edit('+id+')" type="button" class="btn btn-gradient-primary btn-sm">编辑</button>&nbsp;';
                    result += '<button id="shanchu" onclick="deletes('+id+')" type="button" class="btn btn-gradient-danger btn-sm">删除</button>&nbsp;';
                }else{
                    result += '<button id="bianji" onclick="edit('+id+')" type="button" class="btn btn-gradient-primary btn-sm">编辑</button>&nbsp;';
                }
            }
        }
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
                if(confirm("确定要删除“"+requestJson[i].name+"”吗？’")){
                    $.post("/admin/deleteCommodity",{cid:id},function(result){
                        if(result > 0){
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

    //添加
    function addClass(){
        window.location.href='/admin/addCommodity';
    }
    $("#bianji").click(function (id) {
        edit(id)
    });
    $("#shanchu").click(function (id) {
        deletes(id)
    });
</script>