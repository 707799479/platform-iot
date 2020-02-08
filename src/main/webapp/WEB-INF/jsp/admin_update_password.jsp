<%@ page contentType="text/html;charset=UTF-8" language="java" %>

  <%@ include file="header.jsp" %>

    <%@ include file="nav.jsp" %>

    <div class="content-wrapper">
        <div class="col-lg-4 grid-margin stretch-card">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">修改密码</h4>
                    <br>
                    <div class="body">
                        <div>
                            <form id="updateForm" action="/admin/updatePassword" method="post">
                                <div class="form-group">
                                    <label for="search-input" style="color:red;">${updatePasswordNote}</label>
                                    <div class="input-group" style="width:100%;">
                                        <p></p>
                                        <span class="input-group-btn">
                            </span></div>
                                </div>
                                <div class="form-group">
                                    <label for="search-input">旧密码：</label>
                                    <div class="input-group" style="width:100%;">
                                        <input id="oldPwd" name="oldPwd" type="password" class="form-control">
                                        <span class="input-group-btn">
                            </span></div>
                                </div>
                                <div class="form-group">
                                    <label for="search-input">新密码：</label>
                                    <div class="input-group" style="width:100%;">
                                        <input type="password" id="newPwd" class="form-control">
                                        <span class="input-group-btn">
                            </span></div>
                                </div>
                                <div class="form-group">
                                    <label for="search-input">确认新密码：</label>
                                    <div class="input-group" style="width:100%;">
                                        <input type="password" name="newPwd" id="newPwdTwo" class="form-control">
                                        <span class="input-group-btn">
                        </span></div>
                                </div>

                                <a style="width: 100%;" class="btn btn-gradient-secondary btn-rounded btn-fw"
                                   href="javascript:save();">确认修改</a>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
    <!-- content-wrapper ends -->
    <%@ include file="footer.jsp" %>

<script type="text/javascript">
    var test = "${updateSuccess}";

    function save() {
        var oldPwd = $("#oldPwd").val();
        var newPwd = $("#newPwd").val();
        var newPwdTwo = $("#newPwdTwo").val();

        if (oldPwd.length < 1 || newPwd.length < 1 || newPwdTwo.length < 1) {
            alert("不能有空项");
        } else if (newPwd == newPwdTwo) {
            $("#updateForm").submit();
        } else {
            alert("两次密码不一致");
        }
    }

    if (test == 'ok') {
        alert("修改密码成功");
        window.location.href = '/admin/updatePassword';
    }
</script>