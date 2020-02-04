<%@ page contentType="text/html;charset=UTF-8" language="java" %>

    <%@ include file="header.jsp" %>

        <%@ include file="nav.jsp" %>

        <div class="content-wrapper">
            <div class="col-lg-12 grid-margin stretch-card">
                <div class="card">
                    <div class="card-body">
                        <h4 class="card-title">卡片列表</h4>
                        <br>
                        <table id="table"></table>
                        <br>
                        <input type="hidden" id="admin_id" value="${system_admin.id}">
                        <input type="hidden" id="my_id" value="${user_agent.id}">
                    </div>
                </div>
            </div>
        </div>
        <!-- content-wrapper ends -->
        <%@ include file="footer.jsp" %>

<script type="text/javascript">
    function loadTable() {
        $('#table').bootstrapTable({
            url: '/admin/getCardListData',
            pagination: true,//是否分页
            sidePagination: "server", //分页方式：client客户端分页，server服务端分页（*）
            pageNumber: 1,//初始化加载第一页，默认第一页,并记录
            search: true,//是否显示搜索
            pageSize: 10,//每页的记录行数（*）
            columns: [{
                field: 'iccid',
                title: 'ICCID'
            }, {
                field: 'grant',
                title: '实名认证'
            }, {
                field: 'coname',
                title: '套餐名称'
            }, {
                field: 'countData',
                title: '套餐流量'
            }, {
                field: 'data',
                title: '已用流量'
            }, {
                field: 'iccid',
                title: '操作',
                align: 'center',
                valign: 'middle',
                formatter: actionFormatter
            }]
        });
    }

    loadTable();

    //操作栏的格式化
    function actionFormatter(value, row, index) {
        var adminId = $("#admin_id").val();
        var myId = $("#my_id").val();
        var id = value;
        var result = "";
        if (myId == 1) {
            result += '<button id="tingji" onclick="edit(\'' + id + '\',0)" type="button" class="btn btn-gradient-primary btn-sm">停机</button>&nbsp;';

        } else {
            result += '<button id="tingji" onclick="edit(\'' + id + '\',0)" type="button" class="btn btn-gradient-primary btn-sm">停机</button>&nbsp;';
        }
        return result;
    }


    function edit(iccid, type) {
        $.get("/admin/cardUpdate?iccid=" + iccid + "&type=" + type, function (res) {
            if (res == 1) {
                if (type == 1) {
                    alert("xxx")
                } else {
                    alert("停机成功");
                }
            } else {
                alert("操作失败\r\n注意：\r\n1、如果执行停机，此卡必须是充值过并且有套餐的\r\n2、停机或者复机 30分钟内只能执行一次");
            }
        })
    }

</script>
<style type="text/css">
    .page-list {
        display: none !important;
    }

</style>