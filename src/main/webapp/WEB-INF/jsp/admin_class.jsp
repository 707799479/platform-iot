<%@ page contentType="text/html;charset=UTF-8" language="java" %>

    <%@ include file="header.jsp" %>

        <%@ include file="nav.jsp" %>

        <div class="content-wrapper">
            <div class="col-lg-12 grid-margin stretch-card">
                <div class="card">
                    <div class="card-body">
                        <h4 class="card-title">卡池</h4>
                        <table id="table"></table>
                        <input type="hidden" id="admin_id" value="${system_admin.id}">
                        <input type="hidden" id="my_id" value="${user_agent.id}">
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
        url : "/admin/getClassData",
        async : false,
        success : function(result){
            requestJson = jQuery.parseJSON(result);
        }
    });

    $('#table').bootstrapTable({
        url: '/admin/getClassData',
        pagination: true,//是否分页
        sidePagination: "client", //分页方式：client客户端分页，server服务端分页（*）
        pageNumber: 1,//初始化加载第一页，默认第一页,并记录
        search: true,//是否显示搜索
        pageSize: 10,//每页的记录行数（*）
        columns: [{
            field: 'name',
            title: '分类名称'
        }, {
            field: 'sort',
            title: '排序顺序'
        }]
    });

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
                    /*result += '<a class="btn btn-sm btn-default" href="javascript:deletes('+id+')">删除</a>&nbsp;';*/
                }else{
                    result = '<span>不可操作</span>';
                }
            }
        }
        return result;
    }

    //编辑
    function edit(id){
        for(var i = 0;i<requestJson.length;i++){
            if(requestJson[i].id == id){
                window.location.href='/admin/editClass?id='+id+'&name='+requestJson[i].name+'&note='+requestJson[i].note+'&sort='+requestJson[i].sort;
            }
        }
    }
    //删除
    function deletes(id) {
        for(var i = 0;i<requestJson.length;i++){
            if(requestJson[i].id == id){
                if(confirm("确定要删除“"+requestJson[i].name+"”吗？’")){
                    $.post("/admin/deleteClass",{id:id},function(result){
                        if(result == 1){
                            window.location.reload();
                            alert("删除成功");
                        }else{
                            alert("删除失败，请先删除该分类下的套餐。");
                        }
                    });
                }
            }
        }

    }
    //添加
    function addClass(){
        if(requestJson.length < 1){
            window.location.href='/admin/addClass?sort=1';
            return;
        }
        var sort = requestJson[requestJson.length-1].sort;
        window.location.href='/admin/addClass?sort='+(sort+1);
    }

    //查看
    function query(id){
        window.location.href='/admin/commodityList?cid='+id;
    }
</script>