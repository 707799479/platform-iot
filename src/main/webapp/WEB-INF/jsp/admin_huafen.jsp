<%@ page contentType="text/html;charset=UTF-8" language="java" %>

    <%@ include file="header.jsp" %>

        <%@ include file="nav.jsp" %>

        <div class="content-wrapper">
            <div class="col-lg-4 grid-margin stretch-card">
                <div class="card">
                    <div class="card-body">
                        <h4 class="card-title">批量划分</h4>
                        <br>
                        <div class="body">
                            <form id="addForm" action="/admin/editCommodityAgent" method="post" enctype="multipart/form-data">

                                <div class="form-group">
                                    <label for="search-input">代理账号：</label>
                                    <div class="input-group" style="width:100%;">
                                        <input name="parentPrice" type="number" id="aid" value="${temp_commodity.parentPrice}" class="form-control">
                                        <span class="input-group-btn">
                                        </span>
                                    </div>
                                </div>


                                <div class="form-group">
                                    <label for="search-input">起始卡号(只需输入后17位)：</label>
                                    <div class="input-group" style="width:100%;">
                                        <input name="parentPrice" type="number" id="start" value="${temp_commodity.parentPrice}" class="form-control">
                                        <span class="input-group-btn">
                                        </span>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="search-input">结束卡号(只需输入后17位)：</label>
                                    <div class="input-group" style="width:100%;">
                                        <input name="price" type="number" id="end" value="${temp_commodity.price}" class="form-control">
                                        <span class="input-group-btn">
                                        </span>
                                    </div>
                                </div>


                                <a style="width: 100%;" class="btn btn-gradient-secondary btn-rounded btn-fw" href="javascript:pi()">分配</a>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-4 grid-margin stretch-card">
                <div class="card">
                    <div class="card-body">
                        <h4 class="card-title">单张划分</h4>
                        <br>
                        <div class="body">
                            <form id="addForm" action="/admin/editCommodityAgent" method="post" enctype="multipart/form-data">


                                <div class="form-group">
                                    <label for="search-input">代理账号：</label>
                                    <div class="input-group" style="width:100%;">
                                        <input name="parentPrice" type="number" id="aid2" value="${temp_commodity.parentPrice}" class="form-control">
                                        <span class="input-group-btn">
                                        </span>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="search-input">卡号(请输入完整卡号)：</label>
                                    <div class="input-group" style="width:100%;">
                                        <input name="parentPrice" type="number" id="card" value="${temp_commodity.parentPrice}" class="form-control">
                                        <span class="input-group-btn">
                                        </span>
                                    </div>
                                </div>

                                <a style="width: 100%;" class="btn btn-gradient-secondary btn-rounded btn-fw" href="javascript:dan()">分配</a>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%@ include file="footer.jsp" %>

<script type="text/javascript">

//单个划分
function dan() {
var aid = $("#aid2").val();
var cardNumber = $("#card").val();

$.get("/admin/changCardOne",{aid:aid,iccid:cardNumber},function (res) {
alert(res);
});

}

//批量划分
function pi() {
var aid = $("#aid").val();
var start = $("#start").val();
var end = $("#end").val();

$.get("/admin/changeCard",{aid:aid,start:start,end:end},function (res) {
alert(res);
});
}

</script>