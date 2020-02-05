<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<style>
    .wrap-flex {
        align-items: center;
        justify-content: center;
        display: flex;
        flex-direction: column;
        -webkit-flex-direction: column;
        -webkit-align-items: center;
        -webkit-justify-content: center;
        -webkit-display: flex;
    }

    .content-wrapper h4 {
        margin-top: 1rem;
        color: #77baff;
    }
</style>
<%@ include file="header.jsp" %>

<%@ include file="nav.jsp" %>

<div class="content-wrapper wrap-flex">
    <img src="/assets/img/404.png" alt="">
    <h4>页面找不到</h4>
</div>

<%@ include file="footer.jsp" %>

<script type="text/javascript">


    (function ($) {
        $('.spinner .btn:first-of-type').on('click', function () {
            $('.spinner input').val(parseInt($('.spinner input').val(), 10) + 1);
        });
        $('.spinner .btn:last-of-type').on('click', function () {
            $('.spinner input').val(parseInt($('.spinner input').val(), 10) - 1);
        });
    })(jQuery);


    //This product click is a Buy status
    $("#buy").click(function () {
        var name = $(":input")[0].value;
        var phone = $(":input")[1].value;
        var address = $(":input")[2].value;
        if (!(name.length > 0 && phone.length > 0 && address.length > 0)) {
            alert("数据不能为空");
        } else {
            if (document.getElementById("upload").value == '' || document.getElementById("upload2").value == '' || document.getElementById("upload3").value == '') {
                alert("请上传照片！");
                return;
            }
            var productName = '手机卡';
            var price = '1024';
            var productNumber = '2';
            var payType = '支付宝';
            if (confirm("商品名称：" + productName + "\r\n商品单价：" + price + "\r\n商品数量：" + productNumber + "\r\n商品总价：" + (price * productNumber) + "\r\n付款方式：" + payType + "\r\n请确认以上信息 是否购买？")) {
                //确认购买
                $("#payform").submit();
            }
        }
    });

    //SelectImg
    $("#uploadimg").click(function () {
        $("#upload").click();
    });
    $("#uploadimg2").click(function () {
        $("#upload2").click();
    });
    $("#uploadimg3").click(function () {
        $("#upload3").click();
    });

    $("#upload").change(function () {
        var file = document.getElementById("upload").files[0];
        if ((file.type).indexOf("image/") == -1) {
            alert("格式不正确，请重新上传!");
            return;
        }
        $("#uploadimg").attr("src", URL.createObjectURL($(this)[0].files[0]));
    });
    $("#upload2").change(function () {
        var file = document.getElementById("upload2").files[0];
        if ((file.type).indexOf("image/") == -1) {
            alert("格式不正确，请重新上传!");
            return;
        }
        $("#uploadimg2").attr("src", URL.createObjectURL($(this)[0].files[0]));
    });
    $("#upload3").change(function () {
        var file = document.getElementById("upload3").files[0];
        if ((file.type).indexOf("image/") == -1) {
            alert("格式不正确，请重新上传!");
            return;
        }
        $("#uploadimg3").attr("src", URL.createObjectURL($(this)[0].files[0]));
    });
    //SelectImg

</script>
