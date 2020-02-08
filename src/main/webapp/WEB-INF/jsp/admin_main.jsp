<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ include file="header.jsp" %>

<style>
    .stretch-card {
        cursor: pointer;
    }
</style>

<%@ include file="nav.jsp" %>

<div class="content-wrapper">
    <div class="row">
        <div class="col-12">
                <span class="d-flex align-items-center purchase-popup">
                  <p>系统公告：祝您生意兴隆</p>
                </span>
        </div>
    </div>
    <div class="page-header">
        <h3 class="page-title">
                <span class="page-title-icon bg-gradient-primary text-white mr-2">
                  <i class="mdi mdi-home"></i>
                </span>
            数据概览
        </h3>
        <%--            <nav aria-label="breadcrumb">--%>
        <%--                <ul class="breadcrumb">--%>
        <%--                    <li class="breadcrumb-item active" aria-current="page">--%>
        <%--                        <span></span>--%>
        <%--                        <i class="mdi mdi-alert-circle-outline icon-sm text-primary align-middle"></i>--%>
        <%--                    </li>--%>
        <%--                </ul>--%>
        <%--            </nav>--%>
    </div>
    <div class="row c-pd-0 grid-cus">


        <div class="col-lg-3 col-md-6 stretch-card grid-margin" onclick="location='/admin/cardList'">
            <div class="card text-63">
                <div class="card-body">
                    <h3 class="font-weight-normal mb-3">${phoneCardByCount}
                        <i class="mdi mdi-arrow-up mdi-36px c1"></i>
                    </h3>
                    <h6>卡板总数</h6>
                </div>
            </div>
        </div>

        <div class="col-lg-3 col-md-6 stretch-card grid-margin" onclick="location='/admin/orderList'">
            <div class="card text-63">
                <div class="card-body">
                    <h3 class="font-weight-normal mb-3">${orderCount}
                        <i class="mdi mdi-arrow-up mdi-36px c1"></i>
                    </h3>
                    <h6>订单数量</h6>
                </div>
            </div>
        </div>

        <div class="col-lg-3 col-md-6 stretch-card grid-margin" onclick="location='/admin/agentList'">
            <div class="card text-63">
                <div class="card-body">
                    <h3 class="font-weight-normal mb-3">${agentCount}
                        <i class="mdi mdi-arrow-up mdi-36px c1"></i>
                    </h3>
                    <h6>旗下代理</h6>
                </div>
            </div>
        </div>

        <div class="col-lg-3 col-md-6 stretch-card grid-margin" onclick="location='/admin/extract'">
            <div class="card text-63">
                <div class="card-body">
                    <h3 class="font-weight-normal mb-3">$ ${money}
                        <i class="mdi mdi-arrow-up mdi-36px c1"></i>
                    </h3>
                    <h6>账户余额</h6>
                </div>
            </div>
        </div>

    </div>
</div>
<!-- content-wrapper ends -->
<%@ include file="footer.jsp" %>

