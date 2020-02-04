<%@ page contentType="text/html;charset=UTF-8" language="java" %>

    <%@ include file="header.jsp" %>

        <%@ include file="nav.jsp" %>

        <div class="content-wrapper">
            <div class="col-lg-12 grid-margin stretch-card">
                <div class="card">
                    <div class="card-body">
                        <h4 class="card-title">添加套餐</h4>
                        <br>
                        <div class="body">
                            <c:if test="${user_agent.parentId == -1}">
                                <form id="addForm" action="/admin/addCommodity" method="post" enctype="multipart/form-data">
                                    <div class="form-group">
                                        <label >所属分类：</label>
                                        <div class="input-group" style="width:100%;">
                                            <select name="pclass.id" onchange="classChange(options[selectedIndex].value)" class="selectpicker form-control">
                                                <c:forEach var="cl" items="${temp_pclass}">
                                                    <option value ="${cl.id}">${cl.name}</option>
                                                </c:forEach>

                                            </select>
                                            </span>
                                        </div>

                                    </div>

                                    <div class="form-group">
                                        <label >套餐名称：</label>
                                        <div class="input-group" style="width:100%;">
                                            <input name="name" type="text" id="name" class="form-control">
                                            <span class="input-group-btn">
                              </span>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label >包含流量(M)：</label>
                                        <div class="input-group" style="width:100%;">
                                            <input oninput="document.getElementById('ll').innerText = document.getElementById('note').value * document.getElementById('xuliang').value" name="note" type="number" id="note" class="form-control">
                                            <span class="input-group-btn">
                              </span>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label >虚量倍数(1为无虚量)：</label>
                                        <div class="input-group" style="width:100%;">
                                            <input oninput="document.getElementById('ll').innerText = document.getElementById('note').value * document.getElementById('xuliang').value" name="xuliang" type="number" id="xuliang" value="1" class="form-control">
                                            <span class="input-group-btn">
                              </span>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label >实际流量(M)：</label>
                                        <div class="input-group" style="width:100%;">
                                            <p id="ll">0</p>
                                            <span class="input-group-btn">
                              </span>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label >达额限速(单位是M，0则为不限速  这里不要写虚流量 按真实的来写)：</label>
                                        <div class="input-group" style="width:100%;">
                                            <input name="xiansu" type="number" id="xiansu" class="form-control">
                                            <span class="input-group-btn">
                              </span>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label >套餐天数：</label>
                                        <div class="input-group" style="width:100%;">
                                            <input value="30" name="day" type="number" id="tiansu" class="form-control">
                                            <span class="input-group-btn">
                              </span>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label >套餐价格：</label>
                                        <div class="input-group" style="width:100%;">
                                            <input name="price" type="number" id="price" class="form-control">
                                            <span class="input-group-btn">
                              </span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label >排序顺序：</label>
                                        <div class="input-group" style="width:100%;">
                                            <input name="sort" type="number" id="sort" value="${sort}" class="form-control">
                                            <span class="input-group-btn">
                              </span>
                                        </div>
                                    </div>

                                    <button type="button" onclick="addCommodity()" style="width: 100%;" class="btn btn-gradient-secondary btn-rounded btn-fw">添加</button>

                                </form>
                            </c:if>
                            <c:if test="${user_agent.parentId == 0}">
                                <h1> 您还没有此权限</h1>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>

        </div>
        <!-- content-wrapper ends -->
        <%@ include file="footer.jsp" %>

<script type="text/javascript">
    function classChange(pcid) {
        $.get("/admin/getAddCommoditySort",{pcid:pcid},function (sort) {
            $("#sort").val(sort);
        });
    }
    function save() {
        var name = $("#name").val();
        var note = $("#note").val();
        var sort = $("#sort").val();
        if(name.length < 1 || note.length < 1 || sort.length < 1){
            alert("请完善内容再保存");
            return;
        }
        window.location.href = "/admin/addClass?name="+name+"&note="+note+"&sort="+sort;
    }

    //SelectImg
    $("#uploadimg").click(function(){
        $("#upload").click();
    });
    $("#upload").change(function(){
        var file = document.getElementById("upload").files[0];
        if((file.type).indexOf("image/")==-1){
            alert("格式不正确，请重新上传!");
            return;
        }
        $("#uploadimg").attr("src",URL.createObjectURL($(this)[0].files[0]));
    });

    /**
     * 提交 非空验证
     * 主站专用
     */
    function addCommodity() {
        if($("#name").val().length < 1 || $("#note").val().length < 1 || $("#price").val().length < 1 || $("#sort").val().length < 1) {
            alert("请确保每一项都填写");
        }else{
            $("#addForm").submit();
        }
    }

    /**
     * 分站专用
     */
    function addCommodityTwo() {
        if($("#name").val().length < 1 || $("#note").val().length < 1 || $("#price").val().length < 1 || $("#sort").val().length < 1 ){
            alert("请确保每一项都填写");
        }else if(document.getElementById("upload").value == '' ){
            alert("请上传商品图片");
        }else{
            $("#addForm").submit();
        }
    }
</script>