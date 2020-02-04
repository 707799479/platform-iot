<%@ page contentType="text/html;charset=UTF-8" language="java" %>

    <%@ include file="header.jsp" %>

        <%@ include file="nav.jsp" %>

        <div class="content-wrapper">
                <div class="col-lg-12 grid-margin stretch-card">
                    <div class="card">
                        <div class="card-body">
                            <h4 class="card-title">套餐分配(正在给账号：${tempAgent.account}，的代理分配套餐)</h4>
                            <input id="account" value="${tempAgent.id}" type="hidden">
                            <br>
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

                                    <a style="width: 100%;" class="btn btn-gradient-secondary btn-rounded btn-fw" href="javascript:save()">分配</a>

                                </form>

                            </div>

                        </div>
                    </div>
                </div>
                <div class="col-lg-12 grid-margin stretch-card">
                    <div class="card">
                        <div class="card-body">
                            <h4 class="card-title">代理套餐列表</h4>
                            <br>
                            <table id="table"></table>
                        </div>
                    </div>
                </div>
            </div>

        <%@ include file="footer.jsp" %>

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
                result += '<button id="bianji" onclick="edit('+id+')" type="button" class="btn btn-gradient-primary btn-sm">编辑</button>&nbsp;';
                result += '<button id="shanchu" onclick="deletes('+id+')" type="button" class="btn btn-gradient-danger btn-sm">删除</button>&nbsp;';
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