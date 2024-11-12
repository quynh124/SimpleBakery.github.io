<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="zxx">

    <head>
        <meta charset="UTF-8">
        <meta name="description" content="Cake Template">
        <meta name="keywords" content="Cake, unica, creative, html">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Simple Bakery</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style>
            body{
                font-size: 14px;
            }
            .card{
                margin: auto;
                width: 38%;
                max-width:600px;
                padding: 4vh 0;
                box-shadow: 0 6px 20px 0 rgba(0, 0, 0, 0.19);
                border-top: 3px solid rgb(252, 103, 49);
                border-bottom: 3px solid rgb(252, 103, 49);
                border-left: none;
                border-right: none;
            }
            @media(max-width:768px){
                .card{
                    width: 90%;
                }
            }
            .title{
                font-size: 30px;
                text-align: center;
                color: rgb(252, 103, 49);
                font-weight: 600;
                margin-bottom: 2vh;
                padding: 0 8%;

            }
            #details{
                font-weight: 400;
            }
            .info{
                padding: 5% 8%;
            }
            .info .col-5{
                padding: 0;
            }
            #heading{
                color: grey;
                line-height: 6vh;
            }
            .pricing{
                background-color: #ddd3;
                padding: 2vh 8%;
                font-weight: 400;
                line-height: 2.5;
            }
            .pricing .col-3{
                padding: 0;
            }
            .total{
                padding: 2vh 8%;
                color: rgb(252, 103, 49);
                font-weight: bold;
            }
            .total .col-3{
                padding: 0;
            }
            .footer img{
                height: 5vh;
                opacity: 0.2;
            }
            .footer a{
                color: rgb(252, 103, 49);
            }
            .footer .col-10, .col-2{
                display: flex;
                padding: 3vh 0 0;
                align-items: center;
            }
            .footer .row{
                margin: 0;
            }


            .progress-track {
                margin: 20px 0;
            }

            .progressbar {
                list-style-type: none;
                display: flex;
                justify-content: space-between;
                padding: 0;
            }

            .progressbar li {
                flex: 1;
                text-align: center;
                position: relative;
            }

            .progressbar li::before {
                content: "";
                position: absolute;
                left: 50%;
                top: 50%;
                width: 100%;
                height: 2px;
                background-color: #ddd;
                z-index: -1;
            }

            .progressbar li:first-child::before {
                content: none;
            }

            .progressbar li.active {
                color: red;
            }

            .progressbar li i {
                font-size: 24px;
            }

            .progressbar li.active i {
                color: red;
            }

        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>
            <!-- Page Preloder -->
            <br></br>
            <form action="order_tracking.htm" method="get">
            <c:if test="${not empty message}">
                <div class="alert alert-warning">${message}</div>
            </c:if>

            <form action="order_tracking.htm" method="get">
                <c:if test="${not empty message}">
                    <div class="alert alert-warning">${message}</div>
                </c:if>

                <c:forEach var="order" items="${orders}">
                    <c:if test="${order.isDeleted == false}"> 
                        <div class="card">
                            <div class="title">PURCHASE RECEIPT</div>
                            <div class="info">
                                <div class="row">
                                    <div class="col-7">
                                        <span id="heading">Order Date</span><br>
                                        <span id="orderDate"><fmt:formatDate value="${order.orderDate}" pattern="dd-MM-yyyy"/></span>
                                    </div>
                                    <div class="col-5 pull-right">
                                        <span id="heading">Delivery Date</span><br>
                                        <span id="deliveryDate"><fmt:formatDate value="${order.deliveryDate}" pattern="dd-MM-yyyy"/></span>
                                    </div>
                                </div>
                            </div>
                            <div class="pricing">
                                <c:forEach var="detail" items="${orderDetailsList[order.orderID]}">
                                    <div class="row">
                                        <div class="col-9">
                                            <img src="${detail.image}" alt="${detail.productName}" style="width: 50px; height: 50px; margin-right: 10px;"/> 
                                            <span id="productID">${detail.quantity} ${detail.productName}</span>  
                                        </div>
                                        <div class="col-3">
                                            <span id="unitPrice">${detail.unitPrice}.000 VND</span>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>

                            <div class="total">
                                <div class="row">
                                    <div class="col-9">Total Price</div>
                                    <div class="col-3"><big><span id="totalPrice">${order.totalPrice}.000 VND</span></big></div>
                                </div>
                            </div>
                            <div class="tracking">
                                <div class="title">Tracking Order</div>
                            </div>
                            <div class="progress-track">
                                <ul id="progressbar-${order.orderID}" class="progressbar"> <!-- Giữ lại lớp CSS cho progressbar -->
                                    <li class="step0" id="step1-${order.orderID}"><i class="fas fa-receipt"></i><br>Ordered</li>
                                    <li class="step0" id="step2-${order.orderID}"><i class="fas fa-check"></i><br>Confirmed</li>
                                    <li class="step0" id="step3-${order.orderID}"><i class="fas fa-box"></i><br>Preparing</li>
                                    <li class="step0" id="step4-${order.orderID}"><i class="fas fa-truck"></i><br>Shipped</li>
                                </ul>
                            </div>
                            <div class="footer">
                                <div class="row">
                                    <div class="col-2"><img class="img-fluid" src="https://i.imgur.com/YBWc55P.png"></div>
                                    <div class="col-10">Want any help? Please &nbsp;<a href="faqs.htm">contact us</a></div>
                                </div>
                            </div>
                        </div>

                        <script>
                            document.addEventListener('DOMContentLoaded', function () {
                                // Lấy danh sách chi tiết đơn hàng từ Map
                                var orderDetails = [];
                            <c:forEach var="order" items="${orders}">
                                <c:forEach var="detail" items="${orderDetailsList[order.orderID]}">
                                orderDetails.push({
                                    orderDetailID: '${detail.orderDetailID}',
                                    orderID: '${detail.orderID}',
                                    productID: '${detail.productID}',
                                    quantity: '${detail.quantity}',
                                    status: '${detail.status}',
                                    unitPrice: '${detail.unitPrice}',
                                    totalPrice: '${detail.totalPrice}',
                                    yourName: '${detail.yourName}',
                                    phone: '${detail.phone}',
                                    shipAddress: '${detail.shipAddress}',
                                    note: '${detail.note}',
                                    orderDate: '${detail.orderDate}',
                                    deliveryDate: '${detail.deliveryDate}',
                                    paymentID: '${detail.paymentID}',
                                    deliveryID: '${detail.deliveryID}',
                                    voucherID: '${detail.voucherID}',
                                    deliveryName: '${detail.deliveryName}',
                                    distance: '${detail.distance}',
                                    productName: '${detail.productName}',
                                    price: '${detail.price}',
                                    image: '${detail.image}'
                                });
                                </c:forEach>
                            </c:forEach>

                                // Thiết lập trạng thái cho mỗi đơn hàng
                                orderDetails.forEach(function (order) {
                                    var orderStatus = order.status;
                                    var progressbar = document.getElementById('progressbar-' + order.orderID);
                                    if (progressbar) {
                                        var steps = progressbar.querySelectorAll('li');

                                        // Reset tất cả các bước
                                        steps.forEach(function (step) {
                                            step.classList.remove('active');
                                        });

                                        // Xác định bước nào để kích hoạt dựa trên trạng thái đơn hàng
                                        switch (orderStatus) {
                                            case 'Ordered':
                                                steps[0].classList.add('active');
                                                break;
                                            case 'Confirmed':
                                                steps[1].classList.add('active');
                                                break;
                                            case 'Preparing':
                                                steps[2].classList.add('active');
                                                break;
                                            case 'Shipped':
                                                steps[3].classList.add('active');
                                                break;
                                            default:
                                                break;
                                        }
                                    }
                                });
                            });
                        </script>

                    </c:if>
                </c:forEach>
            </form>

            <br><br>
            <jsp:include page="footer.jsp"></jsp:include>

            </body>
            </html>