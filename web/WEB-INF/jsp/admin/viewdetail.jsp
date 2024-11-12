<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Order Detail</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <style>
            body {
                background-color: #f8f9fa;
            }
            .container {
                margin-top: 50px;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                background-color: white;
                padding: 20px;
            }
            h2 {
                text-align: center;
                margin-bottom: 20px;
                color: #dc3545; /* Deep red color */
            }
            .card {
                border: none;
                margin-bottom: 30px;
                background-color: #ffe5e5; /* Light red background for card */
            }
            .card-title {
                color: #dc3545; /* Deep red color for card title */
            }
            .table th, .table td {
                text-align: center;
            }
            .table th {
                background-color: #bd2130; /* Orange background for table header */
                color: white;
            }
            .btn-primary {
                background-color: #dc3545; /* Deep red color for button */
                border-color: #dc3545;
            }
            .btn-primary:hover {
                background-color: #c82333; /* Darker red for button hover */
                border-color: #bd2130;
            }
            .info-label {
                font-weight: bold;
                color: #6c757d; /* Gray color for labels */
            }
        </style>
    </head>
    <body onload="time()" class="app sidebar-mini rtl">
        <!-- Navbar-->
        <header class="app-header">
            <!-- Sidebar toggle button--><a class="app-sidebar__toggle" href="#" data-toggle="sidebar"
                                            aria-label="Hide Sidebar"></a>
            <!-- Navbar Right Menu-->
            <ul class="app-nav">
                <!-- User Menu-->
                <li><a class="app-nav__item" href="/index.html"><i class='bx bx-log-out bx-rotate-180'></i> </a>

                </li>
            </ul>
        </header>
        <jsp:include page="siderbarmenu.jsp"></jsp:include>
            <br></br>
            <div class="container" id="example">
                <h2>ORDER DETAIL</h2>
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Order Information</h5>
                        <p><span class="info-label">Order ID:</span> <c:out value="${order.orderID}"/></p>
                    <p><span class="info-label">Order Date:</span> <fmt:formatDate value="${order.orderDate}" pattern="dd-MM-yyyy"/></p>
                    <p><span class="info-label">Delivery Date:</span> <fmt:formatDate value="${order.deliveryDate}" pattern="dd-MM-yyyy"/></p>
                    <p><span class="info-label">Total Price:</span> <c:out value="${order.totalPrice}"/>.000 VND</p>
                    <p><span class="info-label">Customer Name:</span> <c:out value="${order.yourName}"/></p>
                    <p><span class="info-label">Phone:</span> <c:out value="${order.phone}"/></p>
                    <p><span class="info-label">Ship Address:</span> <c:out value="${order.shipAddress}"/></p>
                    <p><span class="info-label">Note:</span> <c:out value="${order.note}"/></p>
                </div>
            </div>

            <h5 class="mt-4">Product Details</h5>
            <table class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Product ID</th>
                        <th>Product Name</th>
                        <th>Quantity</th>
                        <th>Unit Price (VND)</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="detail" items="${orderDetails}">
                        <tr>
                            <td><c:out value="${detail.productID}"/></td>
                            <td><c:out value="${detail.productName}"/></td>
                            <td><c:out value="${detail.quantity}"/></td>
                            <td><c:out value="${detail.unitPrice}"/>.000 VND</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <div class="button-group mt-4">
                 <a href="orders_tb.htm" class="btn btn-primary">Back to Orders</a>
                <a class="btn btn-delete btn-sm print-file" type="button" title="In" onclick="myApp.printTable()">
                    <i class="fas fa-print"></i> Print Data
                </a>
            </div>
        </div>

        <script>
            function time() {
                var today = new Date();
                var weekday = new Array(7);
                weekday[0] = "Chủ Nhật";
                weekday[1] = "Thứ Hai";
                weekday[2] = "Thứ Ba";
                weekday[3] = "Thứ Tư";
                weekday[4] = "Thứ Năm";
                weekday[5] = "Thứ Sáu";
                weekday[6] = "Thứ Bảy";
                var day = weekday[today.getDay()];
                var dd = today.getDate();
                var mm = today.getMonth() + 1;
                var yyyy = today.getFullYear();
                var h = today.getHours();
                var m = today.getMinutes();
                var s = today.getSeconds();
                m = checkTime(m);
                s = checkTime(s);
                nowTime = h + " giờ " + m + " phút " + s + " giây";
                if (dd < 10) {
                    dd = '0' + dd
                }
                if (mm < 10) {
                    mm = '0' + mm
                }
                today = day + ', ' + dd + '/' + mm + '/' + yyyy;
                tmp = '<span class="date"> ' + today + ' - ' + nowTime +
                        '</span>';
                document.getElementById("clock").innerHTML = tmp;
                clocktime = setTimeout("time()", "1000", "Javascript");

                function checkTime(i) {
                    if (i < 10) {
                        i = "0" + i;
                    }
                    return i;
                }
            }
            var myApp = new function () {
                this.printTable = function () {
                    var tab = document.getElementById('example');
                    var win = window.open('', '', 'height=700,width=700');
                    win.document.write(tab.outerHTML);
                    win.document.close();
                    win.print();
                }
            }
        </script>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
