<%@ page contentType="text/html;charset=UTF-8" language="java" %>

    <%@ include file="header.jsp" %>

        <%@ include file="nav.jsp" %>

        <div class="content-wrapper">
                <div class="col-lg-12 grid-margin stretch-card">
                    <div class="card">
                        <div class="card-body">
                            <h4 class="card-title">代理列表</h4>
                            <br>
                            <table id="table"></table>
                            <br>
                            <button style="width: 100%;" type="button" onclick="addClass()" class="btn btn-gradient-secondary btn-rounded btn-fw">添加一个代理</button>
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
        columns: [{
            field: 'account',
            align: 'center',
            title: '账号',
            valign: 'middle'
        },{
            field: 'money',
            align: 'center',
            title: '余额',
            valign: 'middle'
        },{
            field: 'qq',
            align: 'center',
            title: '联系电话',
            valign: 'middle'
        }, {
            field: 'createTime',
            align: 'center',
            title: '开通时间',
            valign: 'middle'
        }, {
            field: 'agentNum',
            align: 'center',
            title: '旗下代理',
            valign: 'middle'
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
        result += '<img style="width: 45px;height: 45px;" src="http://q1.qlogo.cn/g?b=qq&nk='+value+'&s=640">';
        return result;
    }

    //操作栏的格式化
    function actionFormatter(value, row, index) {
        var adminId = $("#admin_id").val();
        var myId = $("#my_id").val();
        var id = value;
        var result = "";

        result += '<button id="shanchu" onclick="setMeal('+id+')" type="button" class="btn btn-gradient-primary btn-sm">分配套餐</button>&nbsp;';
        result += '<button id="shanchu" onclick="newPwd('+id+')" type="button" class="btn btn-gradient-primary btn-sm">重置密码</button>&nbsp;';
        result += '<button id="shanchu" onclick="deletes('+id+')" type="button" class="btn btn-gradient-danger btn-sm">删除</button>&nbsp;';
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