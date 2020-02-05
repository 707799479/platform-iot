<%@ page contentType="text/html;charset=UTF-8" language="java" %>

  <%@ include file="header.jsp" %>

    <%@ include file="nav.jsp" %>

    <div class="content-wrapper">
        <c:if test="${user_agent.parentId==0}">
            <div class="col-lg-12 grid-margin stretch-card">
                <div class="card">
                    <div class="card-body">
                        <h4 class="card-title">总配置</h4>
                        <br>
                        <div class="body">
                            <div>
                                <div class="form-group">
                                    <label for="search-input">虚假倍数：</label>
                                    <div class="input-group" style="width:100%;">
                                        <input type="number" value="${main_config.number}" id="number" class="form-control">
                                        <span class="input-group-btn"></span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="search-input">主站域名：</label>
                                    <div class="input-group" style="width:100%;">
                                        <input type="text" value="${main_config.domain}" id="domain" class="form-control">
                                        <span class="input-group-btn"></span>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="search-input">公告：</label>
                                    <div class="input-group" style="width:100%;">
                                        <input type="text" value="${main_config.notice}" id="notice" class="form-control">
                                        <span class="input-group-btn"></span>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="search-input">禁用地区：(多个请用#分隔开，如：山东#深圳)</label>
                                    <div class="input-group" style="width:100%;">
                                        <input type="text" value="${main_config.noaddress}" id="noaddress"
                                               class="form-control">
                                        <span class="input-group-btn"></span>
                                    </div>
                                </div>
                                <button onclick="saveWebsiteMain()" style="width: 100%;" type="button"
                                        class="btn btn-gradient-secondary btn-rounded btn-fw">保存
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
    </div>
    <!-- content-wrapper ends -->

    <%@include file="footer.jsp" %>

<script type="text/javascript">
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

    function saveWebsiteMain() {
        var number = $("#number").val();
        var notice = $("#notice").val();
        var domain = $("#domain").val();
        var noaddress = $("#noaddress").val();
        $.post("/admin/saveWebsiteMain", {
            number: number,
            domain: domain,
            noaddress: noaddress,
            notice: notice
        }, function (result) {
            if (result == 1) {
                alert("保存成功");
            } else {
                alert("保存失败");
            }
        });
    }

    function saveConfig() {
        var webName = $("#webName").val();
        var webNote = $("#webNote").val();
        var webQq = $("#webQq").val();
        var domainTwo = $("#domainTwo").val();
        var upload = document.getElementById("upload").files[0];

        var formData = new FormData();

        formData.append("websiteName", webName);
        formData.append("notice", webNote);
        formData.append("qq", webQq);
        formData.append("domain", domainTwo);
        formData.append("file", upload);

        $.ajax({
            type: "post",
            url: "/admin/saveWebsite",
            processData: false,
            contentType: false,
            async: false,
            data: formData,
            success: function (result) {
                if (result == 1) {
                    alert("保存成功");
                } else {
                    alert("保存失败");
                }
            }
        });
    }
</script>