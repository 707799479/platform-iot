<%@ page contentType="text/html;charset=UTF-8" language="java" %>

  <%@ include file="header.jsp" %>

    <%@ include file="nav.jsp" %>

    <div class="content-wrapper">
        <div class="col-lg-12 grid-margin stretch-card">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">提现</h4>
                    <br>
                    <div class="body">
                        <c:if test="${user_agent.parentId == 0}">
                            <h1> 您还没有此权限</h1>
                        </c:if>
                        <c:if test="${user_agent.parentId == -1}">
                            <div>
                            <div class="form-group">
                                <label for="search-input">账户余额：</label>
                                <div class="input-group" style="width:100%;">
                                    <p>${user_agent.money}</p>
                                    <span class="input-group-btn">
                            </span></div>
                            </div>
                            <div class="form-group">
                                <label for="search-input">提现金额：</label>
                                <div class="input-group" style="width:100%;">
                                    <input type="text" id="money" value="${user_agent.money}" class="form-control">
                                    <input type="hidden" id="oldMoney" value="${user_agent.money}">
                                    <span class="input-group-btn">
                            </span></div>
                            </div>


                            <a style="width: 100%" class="btn btn-gradient-secondary btn-rounded btn-fw"
                               href="javascript:go(${user_agent.id})">申请提现</a>
                        </div>
                        </c:if>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <!-- content-wrapper ends -->
    <%@ include file="footer.jsp" %>

<script type="text/javascript">
    //提现
    function go(id) {
        var money = $("#money").val();
        var oldMoney = $("#oldMoney").val();
        if (money > oldMoney) {
            alert("提现金额不能大于账户余额！");
        } else if (money < 1) {
            alert("提现金额有问题");

        } else {
            window.location.href = '/admin/extract?s=1&money=' + money;
        }
    }
</script>