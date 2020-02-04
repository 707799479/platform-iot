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
                            <form id="addForm" action="/admin/editCommodity" method="post" enctype="multipart/form-data">
                                <c:if test="${user_agent.parentId == -1}">
                                    <div class="form-group">
                                        <label for="search-input">所属分类：</label>
                                        <div class="input-group" style="width:100%;">
                                            <select name="pclass.id" onchange="classChange(options[selectedIndex].value)"
                                                    class="selectpicker form-control">
                                                <c:forEach var="cl" items="${temp_pclass}">
                                                    <option
                                                            <c:if test="${cl.id == temp_commodity.pclass.id}">selected</c:if>
                                                            value="${cl.id}">${cl.name}</option>
                                                </c:forEach>

                                            </select>

                                        </div>
                                    </div>

                                    <input name="id" value="${temp_commodity.id}" type="text" style="display: none">
                                    <div class="form-group">
                                        <label for="search-input">套餐名称：</label>
                                        <div class="input-group" style="width:100%;">
                                            <input name="name" type="text" id="name" value="${temp_commodity.name}"
                                                   class="form-control">
                                            <span class="input-group-btn">
                                      </span>
                                        </div>
                                    </div>
                                    <input name="edit" value="zhu" type="text" style="display: none">

                                    <div class="form-group">
                                        <label for="search-input">包含流量(M)：</label>
                                        <div class="input-group" style="width:100%;">
                                            <input oninput="document.getElementById('ll').innerText = document.getElementById('note').value * document.getElementById('xuliang').value"
                                                   value="${temp_commodity.note}" name="note" type="number" id="note"
                                                   class="form-control">
                                            <span class="input-group-btn">
                                            </span>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="search-input">虚量倍数(1为无虚量)：</label>
                                        <div class="input-group" style="width:100%;">
                                            <input id="xuliang" oninput="xujia()" name="xuliang" type="number"
                                                   value="${temp_commodity.xuliang}" class="form-control">
                                            <span class="input-group-btn">
                                            </span>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="search-input">实际流量(M)：</label>
                                        <div class="input-group" style="width:100%;">
                                            <p id="ll">${temp_commodity.note * temp_commodity.xuliang}</p>
                                            <span class="input-group-btn">
                                      </span>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="search-input">达额限速(单位是M，0则为不限速 这里不要写虚流量 按真实的来写)：</label>
                                        <div class="input-group" style="width:100%;">
                                            <input name="xiansu" type="number" value="${temp_commodity.xiansu}"
                                                   class="form-control">
                                            <span class="input-group-btn">
                                            </span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="search-input">套餐天数：</label>
                                        <div class="input-group" style="width:100%;">
                                            <input name="day" type="number" value="${temp_commodity.day}" class="form-control">
                                            <span class="input-group-btn">
                                            </span>
                                        </div>
                                    </div>

                                    <%--   <div class="form-group">
                                           <label for="search-input">限速流量(M)到达之后限速 0代表不限速：</label>
                                           <div class="input-group" style="width:100%;">
                                               <input value="${temp_commodity.imgUrl}" name="imgUrl" type="number" id="xiansu" class="form-control">
                                               <span class="input-group-btn">
                                       </span>
                                           </div>
                                       </div>--%>


                                    <div class="form-group">
                                        <label for="search-input">套餐价格：</label>
                                        <div class="input-group" style="width:100%;">
                                            <input name="price" type="number" id="price" value="${temp_commodity.price}"
                                                   class="form-control">
                                            <span class="input-group-btn">
                                      </span>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="search-input">排序顺序：</label>
                                        <div class="input-group" style="width:100%;">
                                            <input name="sort" type="number" id="sort" value="${temp_commodity.sort}"
                                                   class="form-control">
                                            <span class="input-group-btn">
                                      </span>
                                        </div>
                                    </div>
                                    <a style="width: 100%;" class="btn btn-gradient-secondary btn-rounded btn-fw" href="javascript:saveCommodity()">保存</a>
                                </c:if>
                                <c:if test="${user_agent.parentId != -1}">
                                    <input name="edit" value="fen" type="text" style="display: none">
                                    <input name="id" value="${temp_commodity.id}" type="text" style="display: none">
                                    <div class="form-group">
                                        <label for="search-input">所属分类：</label>
                                        <div class="input-group" style="width:100%;">
                                            <p>${temp_commodity.pclass.name}</p>
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
                                        <label for="search-input">包含流量（M）：</label>
                                        <div class="input-group" style="width:100%;">
                                            <p>${temp_commodity.note}</p>
                                            <span class="input-group-btn">
                                      </span>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="search-input">上家给的价格：</label>
                                        <div class="input-group" style="width:100%;">
                                            <p>${temp_commodity.parentPrice}</p>
                                            <span class="input-group-btn">
                                      </span>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="search-input">套餐价格：</label>
                                        <div class="input-group" style="width:100%;">
                                            <input name="price" type="number" id="price" value="${temp_commodity.price}"
                                                   class="form-control">
                                            <span class="input-group-btn">
                                                    </span>
                                        </div>
                                    </div>
                                    <a style="width: 100%;" class="btn btn-gradient-secondary btn-rounded btn-fw"
                                       href="javascript:saveCommodityTwo()">保存</a>
                                </c:if>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

        </div>
        <!-- content-wrapper ends -->

        <%@ include file="footer.jsp" %>

<script type="text/javascript">
    function classChange(pcid) {
        $.get("/admin/getAddCommoditySort", {pcid: pcid}, function (sort) {
            $("#sort").val(sort);
        });
    }

    function save() {
        var name = $("#name").val();
        var note = $("#note").val();
        var sort = $("#sort").val();
        if (name.length < 1 || note.length < 1 || sort.length < 1) {
            alert("请完善内容再保存");
            return;
        }
        window.location.href = "/admin/addClass?name=" + name + "&note=" + note + "&sort=" + sort;
    }

    function xujia() {
        var xujia = document.getElementById('xuliang').value;
        document.getElementById('ll').innerText = document.getElementById('note').value * xujia;
    }

    //SelectImg
    $("#uploadimg").click(function () {
        $("#upload").click();
    });
    $("#upload").change(function () {
        var file = document.getElementById("upload").files[0];
        if ((file.type).indexOf("image/") == -1) {
            alert("格式不正确，请重新上传!");
            return;
        }
        $("#uploadimg").attr("src", URL.createObjectURL($(this)[0].files[0]));
    });

    /**
     * 提交 非空验证
     * 主站专用
     */
    function saveCommodity() {
        if ($("#name").val().length < 1 || $("#price").val().length < 1 || $("#sort").val().length < 1) {
            alert("不能有空项");
        } else {
            $("#addForm").submit();
        }
    }

    /**
     * 分站专用
     */
    function saveCommodityTwo() {
        if ($("#price").val().length < 1) {
            alert("不能有空项");
        } else {
            $("#addForm").submit();
        }
    }

</script>