<%@ page contentType="text/html;charset=UTF-8" language="java" %>

    <%@ include file="header.jsp" %>

        <%@ include file="nav.jsp" %>

        <div class="content-wrapper">
            <div class="col-lg-12 grid-margin stretch-card">
                <div class="card">
                    <div class="card-body">
                        <h4 class="card-title">返利明细</h4>
                        <br>
                        <table id="table"></table>
                        <br>
                        <input type="hidden" id="admin_id" value="${system_admin.id}">
                        <input type="hidden" id="my_id" value="${user_agent.id}">
                    </div>
                </div>
            </div>
        </div>

        <%@ include file="footer.jsp" %>

<script type="text/javascript">



    $('#table').bootstrapTable({
        url: '/admin/getPriceLog',
        pagination: true,//是否分页
        sidePagination: "client", //分页方式：client客户端分页，server服务端分页（*）
        pageNumber: 1,//初始化加载第一页，默认第一页,并记录
        search: true,//是否显示搜索
        pageSize: 10,//每页的记录行数（*）
        columns: [{
            field: 'id',
            title: '返利编号',
            align: 'center',
            width: 130
        }, {
            field: 'number',
            title: '订单编号',
            align: 'center',
        }, {
            field: 'time',
            title: '返利时间',
            align: 'center',
        }, {
            field: 'note',
            title: '细节详情',
            align: 'center',
        } ]
    });


</script>