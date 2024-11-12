
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>
            <!-- Breadcrumb Begin -->
            <div class="breadcrumb-option">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-6 col-md-6 col-sm-6">
                            <div class="breadcrumb__text">
                                <h2></h2>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6">
                            <div class="breadcrumb__links">
                                <a href="index.htm">Home</a>
                                <a href="vouchers.htm"> <span>Voucher</span></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Breadcrumb End -->

            <!-- Class Section Begin -->
            <section class="class-page spad">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-8">
                            <div class="row">
                            <c:forEach var="voucher" items="${listVoucher}" varStatus="status">
                                <div class="col-lg-6 col-md-6 col-sm-6">
                                    <div class="class__item">
                                        <div class="class__item__pic set-bg" style="background-image: url('./assets/img/voucher/<c:out value="${voucher.imagesUrl}"/>')">
                                            <div class="label"><c:out value="${voucher.discountAmount}"/> %</div>
                                        </div>
                                        <div class="class__item__text">
                                            <h5><a href="<c:url value='/vouchers/${voucher.voucherID}'/>"><c:out value="${voucher.eventName}"/></a></h5>
                                            <span><c:out value="${voucher.startDate}" /> to <c:out value="${voucher.endDate}"/></span>
                                            <a href="checkout.htm" class="read_more">Check Out</a>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>

                        </div>
                    </div>

                </div>
            </div>
        </section>
        <!-- Class Section End -->
        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>
