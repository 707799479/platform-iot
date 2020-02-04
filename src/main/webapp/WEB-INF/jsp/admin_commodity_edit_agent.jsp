<%@ page contentType="text/html;charset=UTF-8" language="java" %>

    <%@ include file="header.jsp" %>

        <%@ include file="nav.jsp" %>

        <div class="content-wrapper">
            <div class="col-lg-12 grid-margin stretch-card">
                <div class="card">
                    <div class="card-body">
                        <h4 class="card-title">编辑套餐</h4>
                        <br>
                        <div class="body">
                            <form id="addForm" action="/admin/editCommodityAgent" method="post" enctype="multipart/form-data">
                                <div class="form-group">
                                    <label for="search-input">所属分类：</label>
                                    <div class="input-group" style="width:100%;">
                                        <p >${temp_commodity.pclass.name}</p>
                                        <span class="input-group-btn">
                              </span>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="search-input">套餐名称：</label>
                                    <div class="input-group" style="width:100%;">
                                        <p>${temp_commodity.name}</p>
                                        <span class="input-group-btn">
                              </span>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="search-input">包含流量(M)：</label>
                                    <div class="input-group" style="width:100%;">
                                        <p>${temp_commodity.note}</p>
                                        <span class="input-group-btn">
                              </span>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="search-input">您的底价(元)：</label>
                                    <div class="input-group" style="width:100%;">
                                        <p>${temp_mycommodity.parentPrice == null ? '-' :temp_mycommodity.parentPrice}</p>
                                        <span class="input-group-btn">
                              </span>
                                    </div>
                                </div>
                                <input type="hidden" value="${temp_mycommodity.parentPrice == null ? '-' :temp_mycommodity.parentPrice}" id="myprice">


                                <input name="aid" value="${aid}" type="text" style="display: none">
                                <input name="cid" value="${cid}" type="text" style="display: none">



                                <div class="form-group">
                                    <label for="search-input">底价(元)：</label>
                                    <div class="input-group" style="width:100%;">
                                        <input name="parentPrice" type="number" id="parentPrice" value="${temp_commodity.parentPrice}" class="form-control">
                                        <span class="input-group-btn">
                              </span>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="search-input">价格(元)：</label>
                                    <div class="input-group" style="width:100%;">
                                        <input name="price" type="number" id="price" value="${temp_commodity.price}" class="form-control">
                                        <span class="input-group-btn">
                              </span>
                                    </div>
                                </div>


                                <a style="width: 100%;" class="btn btn-gradient-secondary btn-rounded btn-fw" href="javascript:saveCommodity()">保存</a>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%@ include file="footer.jsp" %>

<script type="text/javascript">

    /**
     * 提交 非空验证
     * 主站专用
     */
    function saveCommodity() {
        if($("#price").val().length < 1 || $("#parentPrice").val().length < 1){
            alert("不能有空项");
        }else if($("#myprice").val() != "-" && $("#myprice").val() > $("#parentPrice").val()){
            alert("给代理的底价不能低于您的底价");
        }else if( parseFloat($("#price").val()) <  parseFloat($("#parentPrice").val())){
            alert("价格不能低于底价");
        }else{
            $("#addForm").submit();
        }
    }


</script>