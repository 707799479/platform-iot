<%@ page contentType="text/html;charset=UTF-8" language="java" %>

  <%@ include file="header.jsp" %>

      <%@ include file="nav.jsp" %>

      <div class="content-wrapper">
        <div class="col-lg-12 grid-margin stretch-card">
          <div class="card">
            <div class="card-body">
              <h4 class="card-title">添加代理</h4>
              <br>
              <br>
              <div class="body">
                <form id="regForm" action="/admin/addAgent" method="post">
                  <div>
                    <div class="form-group">
                      <label for="search-input">账号：</label>
                      <div class="input-group" style="width:100%;">
                        <input onKeyUp="value=value.replace(/[^\w|chun]/g,'')" type="text" id="account" name="account" class="form-control">
                        <span class="input-group-btn">
                        </span> </div>
                    </div>
                    <input type="hidden" value="123456" id="passowrd" name="password" class="form-control">
                    <div class="form-group">
                      <label for="search-input">提现账号：</label>
                      <div class="input-group" style="width:100%;">
                        <input type="text" id="tAccount" name="tAccount" class="form-control">
                        <span class="input-group-btn">
                        </span> </div>
                    </div>
                    <div class="form-group">
                      <label for="search-input">提现姓名(真实姓名用于提现)：</label>
                      <div class="input-group" style="width:100%;">
                        <input type="text" id="tName" name="tName" class="form-control">
                        <span class="input-group-btn">
                        </span> </div>
                    </div>
                    <a style="width: 100%;" type="button" onclick="addAgent()" class="btn btn-gradient-secondary btn-rounded btn-fw">开通代理</a>
                  </div>
                </form>

              </div>
            </div>
          </div>
        </div>

      </div>
      <!-- content-wrapper ends -->
      <%@ include file="footer.jsp" %>

<script type="text/javascript">
  var ok = '${alert}';
  if(ok.length > 1){
    alert("添加成功");
    window.location.href = "/admin/addAgent";
  }
  function addAgent() {
    var num = $(":input").length;
    for(var i = 0;i < num;i++){
      var t = $(":input").eq(i).val().length;
      if(t < 1){
        alert("不能有空项");
        console.log($(":input").eq(i).html())
        return;
      }
    }
    $.get("/checkAccount",{a:$("#account").val()},function (result) {
      if(result == 0){
        $("#regForm").submit();
       /* $.get("/checkDomain",{d:$("#domain").val()},function (res) {
          if(res == 0){
            $("#regForm").submit();
          }else{
            alert("域名已被使用，请换一个吧。");
          }
        });*/
      }else{
        alert("用户名已存在");
        return;
      }
    });
  }
</script>