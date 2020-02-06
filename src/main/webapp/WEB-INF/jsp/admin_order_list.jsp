<%@ page contentType="text/html;charset=UTF-8" language="java" %>

    <%@ include file="header.jsp" %>

        <%@ include file="nav.jsp" %>

        <div class="content-wrapper">
                <c:if test="${user_agent.parentId == 0}">
                    <div class="col-lg-12 grid-margin stretch-card">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">本站订单</h4>
                                <br>
                                <select style="width: 200px;" name="pclass.id" onchange="classChange(options[selectedIndex].value)" class="selectpicker form-control">
                                    <option selected value ="all">全部</option>
                                    <c:forEach var="co" items="${commodityList}">
                                        <option value ="${co.id}">${co.name}</option>
                                    </c:forEach>
                                </select>
                                <table id="table"></table>
                                <br>
                                <button style="width: 100%;" type="button" class="btn btn-gradient-secondary btn-rounded btn-fw" onclick="viewLog()">查看返利明细</button>
                                <input type="hidden" id="admin_id" value="${system_admin.id}">
                                <input type="hidden" id="my_id" value="${user_agent.id}">
                            </div>
                        </div>
                    </div>
                </c:if>
                <c:if test="${user_agent.parentId != 0}">
                    <div class="col-lg-12 grid-margin stretch-card">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">全部订单</h4>
                                <br>
                                <table id="table2"></table>
                                <br>
                                <button style="width: 100%;" type="button" class="btn btn-gradient-secondary btn-rounded btn-fw" onclick="viewLog()">查看返利明细</button>
                            </div>
                        </div>
                    </div>
                </c:if>
            </div>
            <!-- content-wrapper ends -->
        <%@ include file="footer.jsp" %>

<script type="text/javascript">


    var requestJson;
    var countOrder = 0;

    var coid = 'all';
    function classChange(cid) {
        coid = cid;
    }

    $("#count").text("共有"+countOrder+"个订单未处理。");
    $.ajax({
        type : "post",
        url : "/admin/getOrderListData",
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
        url: '/admin/getOrderListData',
        pagination: true,//是否分页
        sidePagination: "client", //分页方式：client客户端分页，server服务端分页（*）
        pageNumber: 1,//初始化加载第一页，默认第一页,并记录
        search: true,//是否显示搜索
        pageSize: 10,//每页的记录行数（*）
        columns: [ {
            field:'number',
            title: '订单编号',
            align: 'center',
            valign: 'middle',
            formatter: loadText
        },{
            field:'commodity.name',
            title: '套餐名称',
            align: 'center',
            valign: 'middle',
            formatter: loadText
        }, {
            field: 'xdPhone',
            align: 'center',
            title: 'ICCID',
            valign: 'middle',
            formatter: loadText
        },{
            field:'createTime',
            title: '充值时间',
            align: 'center',
            valign: 'middle',
            formatter: loadDate
        }, {
            field: 'xdAddress',
            align: 'center',
            title: '激活地址',
            valign: 'middle',
            formatter: loadText
        },
        //     {
        //     field: 'count',
        //     align: 'center',
        //     title: '数量',
        //     valign: 'middle',
        //     formatter: loadText
        // },
        {
            field: 'totalPrice',
            align: 'center',
            title: '充值金额',
            valign: 'middle',
            formatter: loadText
        },{
            field: 'payType',
            align: 'center',
            title: '生效时间',
            valign: 'middle',
            formatter: loadPay
        } ]
    });

    //加载支付方式
    function loadPay(value, row, index) {
        if(value == undefined || value == null){
            value = "-";
        }
        // if(value == 'qqpay'){
        //     value = "QQ钱包";
        // }else if(value == 'wxpay'){
        //     value = "微信";
        // }else if(value == 'alipay'){
        //     value = "支付宝";
        // }
        if(value == 'now'){
            value = "本月到账";
        }else if (value == 'down'){
            value = "次月到账";
        }else {
            value = "其它";
        }
        return '<p>'+value+'</p>';
    }

    //加载状态
    function status(value, row, index) {
        if(value == undefined || value == null){
            value = "-";
        }
        if(value == 1){
            value = "未处理";
        }else if(value == 2){
            value = "已处理";
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

    //导出订单
    function outData() {
        if(coid == 'all'){
            window.location.href = "/admin/outData?status=1";
        }else{
            window.location.href = "/admin/outData?status=1&cid="+coid;
        }

        //window.location.reload();
    }

    //加载时间
    function loadDate(value, row, index) {
        var time = new Date(value).toLocaleString().replace(/:\d{1,2}$/,' ');
        var result = "";
        result += '<p> '+time+'</p>';
        return result;
    }

    //操作栏的格式化
    function loadImg(value, row, index) {
        if(value == undefined || value == null){
            return "<p>无</p>";
        }
        var img = value;
        var result = "";
        result += '<a href="/'+img+'"><img style="width: 60px;height: 60px;" src="'+img+'"></a>';
        return result;
    }

    //操作栏的格式化
    function actionFormatter(value, row, index) {
        var adminId = $("#admin_id").val();
        var myId = $("#my_id").val();
        var id = value;
        var result = "";

        result += '<a class="btn btn-sm btn-default" href="javascript:update('+id+')">改为已处理</a>&nbsp;';

        return result;
    }


    //更改
    function update(id) {
        if(confirm("确定要把状态改为已完成吗？")){
            $.post("/admin/updateOrderStatus",{no:id},function(result){
                if(result == 1){
                    window.location.reload();
                    alert("修改成功");
                }else{
                    alert("修改失败");
                }
            });
        }
    }

    <c:if test="${user_agent.parentId != 0}">
    $('#table2').bootstrapTable({
        url: '/admin/getOrderListData?a=1',
        pagination: true,//是否分页
        sidePagination: "client", //分页方式：client客户端分页，server服务端分页（*）
        pageNumber: 1,//初始化加载第一页，默认第一页,并记录
        search: true,//是否显示搜索
        pageSize: 10,//每页的记录行数（*）
        columns: [ {
            field:'number',
            title: '订单编号',
            align: 'center',
            valign: 'middle',
            formatter: loadText
        },{
            field:'commodity.name',
            title: '套餐名称',
            align: 'center',
            valign: 'middle',
            formatter: loadText
        }, {
            field: 'xdPhone',
            align: 'center',
            title: 'ICCID',
            valign: 'middle',
            formatter: loadText
        },{
            field:'createTime',
            title: '充值时间',
            align: 'center',
            valign: 'middle',
            formatter: loadDate
        }, {
            field: 'xdAddress',
            align: 'center',
            title: '激活地址',
            valign: 'middle',
            formatter: loadText
        }, {
            field: 'totalPrice',
            align: 'center',
            title: '充值金额',
            valign: 'middle',
            formatter: loadText
        },{
            field: 'payType',
            align: 'center',
            title: '生效时间',
            valign: 'middle',
            formatter: loadPay
        },{
            field:'meiyou',
            title: '操作',
            align: 'center'
        } ]
    });
    </c:if>


    function viewLog() {
        window.location.href = "/admin/viewPriceLog";
    }
</script>