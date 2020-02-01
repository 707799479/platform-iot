<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title>补卡通道</title>
    <link rel="stylesheet" type="text/css" href="./css/hui.css" />
</head>
<body>
<header class="hui-header">
    <div id="hui-back"></div>
    <h1>补卡通道</h1>
    <div id="hui-header-menu"></div>

</header>
<div class="hui-wrap">
    <c:if test="${isHave != 'ok'}">
        <div style="padding:20px; border-radius:8px; background:#FFFFFF; margin-top:20px;">
            <div style="text-align:center; line-height:28px; font-weight:700; padding-bottom:12px; font-size:16px;">距离补结束时间</div>
            <div id="countdown2"></div>
        </div>
        <br>
        <form style="padding:28px 10px;" class="hui-form" id="form1">
            <div class="hui-form-items">
                <div class="hui-form-items-title">输入卡号:</div>
                <input id="iccid" type="text" class="hui-input hui-input-clear" name="nickname" value="${phoneCard['iccid']}" placeholder="..." />
            </div>
            <div class="hui-form-items">
                <div class="hui-form-items-title">输入姓名:</div>
                <input id="name" type="text" class="hui-input hui-input-clear" name="nickname" placeholder="..." />
            </div>
            <div class="hui-form-items">
                <div class="hui-form-items-title">联系电话:</div>
                <input id="phone" type="text" class="hui-input hui-input-clear" name="nickname" placeholder="..." />
            </div>
            <div class="hui-form-items">
                <div class="hui-form-items-title">收货地址:</div>
                <input id="address" type="text" class="hui-input hui-input-clear" name="nickname" placeholder="..." />
            </div>
            <br>
            <p style="color: red;">注：收货地址必须写详细地址。精确到省、市、区、否则一律不发货。</p>
            <br>
        </form>
        <div style="padding:28px 20px 10px 20px;" id="btnList1">
            <p style="text-align: center;color: red;"></p><br>
            <button onclick="go()" type="button" class="hui-button hui-button-large hui-primary" >申请补卡</button>
        </div>
    </c:if>
    <c:if test="${isHave == 'ok'}">
        <h1>您已申请过补卡</h1>
        <a href="/express">点击跳转单号查询页面</a>
    </c:if>

</div>
</div>
<script src="./js/hui.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
    function go(){
        var name = hui("#name").val();
        var phone = hui("#phone").val();
        var address = hui("#address").val();
        var iccid = hui("#iccid").val();
        if(name.length < 1 || phone.length < 1 || address.length < 1 || iccid.length < 1){
            alert("请完善信息");
            return;
        }
        hui.post("/freecard",{i:iccid,name:name,phone:phone,address:address},function (res) {
            if(res > 0){
                alert("补卡成功，可去 查单页面 进行关注进展。");
            }else{
                alert("您的卡无需补");
            }
        })
    }

    hui.countdown("2019-04-21 23:59:59",'#countdown2', 1);
</script>
</body>
</html>