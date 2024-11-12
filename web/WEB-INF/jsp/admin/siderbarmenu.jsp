
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>

        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Admin Simple Bakery</title>
        <!-- Main CSS-->

        <link rel="stylesheet" type="text/css" href="<c:url value='./assets/css/main.css'/>">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css">
        <link rel="stylesheet" href="https://cdn.datatables.net/2.1.3/css/dataTables.dataTables.css">
        <link rel="stylesheet" href="https://cdn.datatables.net/buttons/3.1.1/css/buttons.dataTables.css">
        <!-- JS -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
        <script src="https://cdn.datatables.net/2.1.3/js/dataTables.js"></script>
        <script src="https://cdn.datatables.net/buttons/3.1.1/js/dataTables.buttons.js"></script>
        <script src="https://cdn.datatables.net/buttons/3.1.1/js/buttons.dataTables.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/pdfmake.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/vfs_fonts.js"></script>
        <script src="https://cdn.datatables.net/buttons/3.1.1/js/buttons.html5.min.js"></script>
        <script src="https://cdn.datatables.net/buttons/3.1.1/js/buttons.colVis.min.js"></script>
    </head>
    <body>
        <header class="app-header">
            <!-- Sidebar toggle button--><a class="app-sidebar__toggle" href="#" data-toggle="sidebar"
                                            aria-label="Hide Sidebar"></a>
            <!-- Navbar Right Menu-->
            <ul class="app-nav">


                <!-- User Menu-->
                <li><a class="app-nav__item" href="index.htm"><i class='bx bx-log-out bx-rotate-180'></i> </a>

                </li>
            </ul>
        </header>
        <div class="app-sidebar__overlay" data-toggle="sidebar"></div>
        <aside class="app-sidebar">
            <div class="app-sidebar__user"><img class="app-sidebar__user-avatar" src="./assets/logo.png" width="50px"
                                                alt="User Image">
                <div>
                    <p class="app-sidebar__user-name"><b>SimpleBakery</b></p>
                    <p class="app-sidebar__user-designation">Welcome Admin !</p>
                </div>
            </div>
            <hr>
            <ul class="app-menu">

                <li><a class="app-menu__item active" href="admin.htm"><i class='app-menu__icon bx bx-tachometer'></i><span
                            class="app-menu__label">Dashboard</span></a></li>
                <li><a class="app-menu__item " href="formuser.htm"><i class='app-menu__icon bx bx-id-card'></i> <span
                            class="app-menu__label">Manage User</span></a></li>
                             <li><a class="app-menu__item" href="formadmin.htm"><i class='app-menu__icon bx bx-calendar-check'></i><span
                            class="app-menu__label">Manage Admin </span></a></li>
                <li><a class="app-menu__item" href="products_tb.htm"><i class='app-menu__icon bx bx-user-voice'></i><span
                            class="app-menu__label">Manage Products</span></a></li>
                <li><a class="app-menu__item" href="categories_tb.htm"><i
                            class='app-menu__icon bx bx-purchase-tag-alt'></i><span class="app-menu__label">Manage Categories</span></a>
                </li>
                <li><a class="app-menu__item" href="orders_tb.htm"><i class='app-menu__icon bx bx-task'></i><span
                            class="app-menu__label">Manage Orders</span></a></li>
                <li><a class="app-menu__item" href="formpayment.htm"><i class='app-menu__icon bx bx-run'></i><span
                            class="app-menu__label">Manage Payments
                        </span></a></li>
                <li><a class="app-menu__item" href="formdelivery.htm"><i class='app-menu__icon bx bx-dollar'></i><span
                            class="app-menu__label">Manage Deliveries</span></a></li>
                <li><a class="app-menu__item" href="formvoucher.htm"><i
                            class='app-menu__icon bx bx-pie-chart-alt-2'></i><span class="app-menu__label">Manage Voucher</span></a>
                </li>
                <li><a class="app-menu__item" href="formfaqs.htm"><i class='app-menu__icon bx bx-calendar-check'></i><span
                            class="app-menu__label">Manage FAQs </span></a></li>


            </ul>
        </aside>

        <script src="./assets/js/popper.min.js"></script>
        <script src="./assets/js/bootstrap.min.js"></script>

        <script src="./assets/js/main.js"></script>
        <script src="./assets/js/plugins/pace.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.js"></script>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
    </body>
</html>
