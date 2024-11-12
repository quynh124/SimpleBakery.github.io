<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Simple Bakery | Admin system</title>
        <!-- Main CSS-->
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">

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
        <!-- Sidebar menu-->
        <jsp:include page="siderbarmenu.jsp"></jsp:include>
            <main class="app-content">
                <div class="row">
                    <div class="col-md-12">
                        <div class="app-title">
                            <ul class="app-breadcrumb breadcrumb">
                                <li class="breadcrumb-item"><a href="#"><b>Dashboard</b></a></li>
                            </ul>
                            <div id="clock"></div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <!--Left-->
                    <div class="col-md-12 col-lg-6">
                        <div class="row">
                            <!-- col-6 -->
                            <div class="col-md-6">
                                <div class="widget-small primary coloured-icon"><i class='icon bx bxs-user-account fa-3x'></i>
                                    <div class="info">
                                        <h4>All User</h4>
                                        <p><b>${totalUser} user</b></p>
                                    <p class="info-tong">Total number of users managed</p>
                                </div>
                            </div>
                        </div>

                        <!-- col-6 -->
                        <div class="col-md-6">
                            <div class="widget-small info coloured-icon">
                                <i class='icon bx bxs-data fa-3x'></i>
                                <div class="info">
                                    <h4>All products</h4>
                                    <!-- Hiển thị tổng số sản phẩm -->
                                    <p><b>${totalProducts} product</b></p>
                                    <p class="info-tong">Total number of products managed.</p>
                                </div>
                            </div>
                        </div>
                        <!-- col-6 -->
                        <div class="col-md-6">
                            <div class="widget-small warning coloured-icon"><i class='icon bx bxs-shopping-bags fa-3x'></i>
                                <div class="info">
                                    <h4>All Order</h4>
                                    <p><b>${totalOrders} order</b></p>
                                    <p class="info-tong">Total number of order managed.</p>
                                </div>
                            </div>
                        </div>
                        <!-- col-6 -->
                        <div class="col-md-6">
                            <div class="widget-small danger coloured-icon"><i class='icon bx bxs-error-alt fa-3x'></i>
                                <div class="info">
                                    <h4>All Voucher</h4>
                                    <p><b>${totalVoucher} voucher</b></p>
                                    <p class="info-tong">Total number of voucher managed.</p>
                                </div>
                            </div>
                        </div>
                        <!-- col-12 -->
                        <div class="col-md-12">
                            <div class="tile">
                                <h3 class="tile-title">New orders</h3>
                                <div>
                                    <table class="table table-bordered" id="example">
                                        <thead>
                                            <tr>
                                                <th>Order ID</th>
                                                <th>Customer Name</th>
                                                <th>Order Date</th>
                                                <th>Total Price</th>
                                                <th>Status</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="item" items="${listOrders}">
                                                <tr>
                                                    <td><c:out value="${item.orderID}"/> 
                                                        <i class="fas fa-star" title="New Order" style="color: orange;"></i>
                                                    </td>
                                                    <td><c:out value="${item.yourName}"/></td>
                                                    <td><fmt:formatDate value="${item.orderDate}" pattern="dd-MM-yyyy"/></td>
                                                    <td><span class="badge bg-danger"><c:out value="${item.totalPrice}"/></span></td> 
                                                    <td><span class="badge bg-success"><c:out value="${item.status}"/></span></td> 
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>  
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="tile">
                                <h3 class="tile-title">Monthly revenue statistics</h3>

                                <div>
                                    <div class="col-sm-2">
                                        <a class="btn btn-delete btn-sm print-file" type="button" title="In" onclick="myApp.printTable()"><i class="fas fa-print"></i> Print Data</a>
                                    </div>
                                    <table class="table table-hover table-bordered" id="example">
                                        <thead>
                                            <tr>
                                                <th>Month</th>
                                                <th>Total Revenue</th>

                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="revenue" items="${revenueList}">
                                                <tr>
                                                    <td>${revenue.month}</td>
                                                    <td>${revenue.totalRevenue}</td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>

                                </div>
                            </div>
                        </div>     
                    </div>
                </div>
                <!--END left-->
                <!--Right-->
                <div class="col-md-12 col-lg-6">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="tile">
                                <h3 class="tile-title">Top 5 Best-Selling Products</h3>
                                <button id="showYearlyTopProductsBtn"><i class="fa-solid fa-chart-column" style="color: #74C0FC;"></i>Year 2024</button>
                                <button id="showMonthlyTopProductsBtn"><i class="fa-solid fa-chart-column" style="color: #74C0FC;"></i>Current Month</button>
                                <br>
                                <div class="embed-responsive embed-responsive-16by9">
                                    <canvas class="embed-responsive-item" id="sellingChart"></canvas>              

                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="tile">
                                <h3 class="tile-title">Revenue statistics</h3>

                                <button id="showMonthlyChartBtn"><i class="fa-solid fa-chart-column" style="color: #74C0FC;"></i> Monthly Revenue</button>                              
                                <button id="showQuarterlyChartBtn"><i class="fa-solid fa-chart-column" style="color: #74C0FC;"></i> Quarterly Revenue</button>
                                <button id="showMonthlyComparisonBtn"><i class="fa-solid fa-chart-line" style="color: #74C0FC;"></i> Compare Monthly Revenue</button> 
                                <br>
                                <br>
                                <div class="embed-responsive embed-responsive-16by9">
                                    <canvas class="embed-responsive-item" id="revenueChart"></canvas>
                                </div>                             

                            </div>

                        </div>
                    </div>
                </div>        
            </div>
            <script>
                new DataTable('#example', {
                    layout: {
                        topStart: {
                            buttons: [

                                {
                                    extend: 'excelHtml5',
                                    exportOptions: {
                                        columns: ':visible'
                                    }
                                },
                                {
                                    extend: 'pdfHtml5',
                                    exportOptions: {
                                        columns: ':visible'
                                    }
                                },
                                'colvis'
                            ]
                        }
                    }
                });
            </script>
            <script type="text/javascript">$('#example').DataTable();</script>

            <script>
                var yearLabels = [];
                var yearData = [];
                var monthLabels = [];
                var monthData = [];
                var backgroundColors = [];
                for (let i = 0; i < 5; i++) {
                    backgroundColors.push('rgba(' + Math.floor(Math.random() * 256) + ', ' +
                            Math.floor(Math.random() * 256) + ', ' +
                            Math.floor(Math.random() * 256) + ', 0.5)');
                }
                <c:forEach var="entry" items="${topSelling}">
                yearLabels.push('${entry.key}');
                yearData.push(${entry.value});
                </c:forEach>


                <c:forEach var="entry" items="${topSellingbyMonth}">
                monthLabels.push('${entry.key}');
                monthData.push(${entry.value});
                </c:forEach>
                var ctx = document.getElementById('sellingChart').getContext('2d');
                var sellingChart = new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: yearLabels,
                        datasets: [{
                                label: 'Top 5 Products of the Year',
                                data: yearData,
                                backgroundColor: backgroundColors,
                                borderColor: 'rgba(75, 192, 192, 1)',
                                borderWidth: 1
                            }]
                    },
                    options: {
                        scales: {
                            y: {
                                beginAtZero: true
                            }
                        }
                    }
                });
                document.getElementById('showYearlyTopProductsBtn').addEventListener('click', function () {
                    sellingChart.data.labels = yearLabels;
                    sellingChart.data.datasets[0].data = yearData;
                    sellingChart.data.datasets[0].label = 'Top 5 Products of the Year';
                    sellingChart.update();
                });

                document.getElementById('showMonthlyTopProductsBtn').addEventListener('click', function () {
                    sellingChart.data.labels = monthLabels;
                    sellingChart.data.datasets[0].data = monthData;
                    sellingChart.data.datasets[0].label = 'Top 5 Products of the Month';
                    sellingChart.update();
                });
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

        </main>
        <script>
            var monthlyLabels = [];
            var monthlyData = [];
            var quarterlyLabels = ['Q1', 'Q2', 'Q3', 'Q4'];
            var quarterlyData = [];
            var comparisonLabels = ['Previous Month', 'Current Month'];
            var comparisonData = [];
            var backgroundColors = [];

            for (let i = 0; i < 5; i++) {
                backgroundColors.push('rgba(' + Math.floor(Math.random() * 256) + ', ' +
                        Math.floor(Math.random() * 256) + ', ' +
                        Math.floor(Math.random() * 256) + ', 0.5)');
            }

            <c:forEach var="entry" items="${revenueList}">
            monthlyLabels.push('Month ' + ${entry.month});
            monthlyData.push(${entry.totalRevenue});
            </c:forEach>

            <c:forEach var="entry" items="${quarterList}">
            quarterlyData.push(${entry.totalRevenue});
            </c:forEach>

            <c:forEach var="entry" items="${monthlyRevenue}">
            comparisonData.push(${entry.totalRevenue});
            </c:forEach>

            var ctx = document.getElementById('revenueChart').getContext('2d');
            var revenueChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: monthlyLabels,
                    datasets: [{
                            label: 'Monthly Revenue',
                            data: monthlyData,
                            backgroundColor: backgroundColors,
                            borderColor: 'rgba(75, 192, 192, 1)',
                            borderWidth: 1
                        }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });

            document.getElementById('showMonthlyChartBtn').addEventListener('click', function () {
                revenueChart.data.labels = monthlyLabels;
                revenueChart.data.datasets[0].data = monthlyData;
                revenueChart.data.datasets[0].label = 'Monthly Revenue';
                revenueChart.update();
            });

            document.getElementById('showQuarterlyChartBtn').addEventListener('click', function () {
                revenueChart.data.labels = quarterlyLabels;
                revenueChart.data.datasets[0].data = quarterlyData;
                revenueChart.data.datasets[0].label = 'Quarterly Revenue (3 months per quarter)';
                revenueChart.update();
            });


            document.getElementById('showMonthlyComparisonBtn').addEventListener('click', function () {
                revenueChart.data.labels = comparisonLabels;
                revenueChart.data.datasets[0].data = comparisonData;
                revenueChart.data.datasets[0].label = 'Revenue Comparison (Previous vs Current Month)';
                revenueChart.update();
            });
        </script>


        <!--===============================================================================================-->
        <script type="text/javascript" src="./assets/js/plugins/chart.js"></script>
        <script type="text/javascript">
            //Thời Gian
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

        </script>

    </body>
</html>
