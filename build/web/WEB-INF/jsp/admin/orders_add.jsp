<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Add Order</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
    </head>
    <body class="app sidebar-mini rtl">
        <header class="app-header">
            <!-- Sidebar toggle button--><a class="app-sidebar__toggle" href="#" data-toggle="sidebar"
                                            aria-label="Hide Sidebar"></a>
            <ul class="app-nav">
                <!-- User Menu-->
                <li><a class="app-nav__item" href="/index.html"><i class='bx bx-log-out bx-rotate-180'></i> </a>
                </li>
            </ul>
        </header>
        <jsp:include page="siderbarmenu.jsp"></jsp:include>
            <main class="app-content">
                <div class="app-title">
                   
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="tile">
                            <h3 class="tile-title">New order</h3>
                            <div class="tile-body"> 
                            <form:form class="row" action="orders_add.htm" method="POST" modelAttribute="orderForm">
                                <!-- Các trường cho Orders -->
                                <div class="form-group col-md-4">
                                    <label class="control-label">Order ID</label>
                                    <form:input path="orderID" cssClass="form-control"/>
                                </div>
                                 <div class="form-group col-md-4">
                                    <label class="control-label">Order ID</label>
                                    <form:input path="orderDate" cssClass="form-control"/>
                                </div>
                                 <div class="form-group col-md-4">
                                    <label class="control-label">Order ID</label>
                                    <form:input path="deliveryDate" cssClass="form-control"/>
                                </div>
                                <div class="form-group col-md-4">
                                    <label class="control-label">Status</label>
                                    <select name="status" class="form-control" required="true" id="status">
                                        <option value="Confirmed">Confirmed</option>
                                        <option value="Preparing">Preparing</option>
                                        <option value="Shipped">Shipped</option>
                                    </select>
                                </div>
                                <div class="form-group col-md-4">
                                    <label class="control-label">User ID</label>
                                    <form:input path="userID" cssClass="form-control"/>
                                </div>
                                <div class="form-group col-md-4">
                                    <label class="control-label">Voucher ID</label>
                                    <form:input path="voucherID" cssClass="form-control"/>
                                </div>
                                <div class="form-group col-md-4">
                                    <label class="control-label">Payment ID</label>
                                    <form:input path="paymentID" cssClass="form-control"/>
                                </div>
                                <div class="form-group col-md-4">
                                    <label class="control-label">Delivery ID</label>
                                    <form:input path="deliveryID" cssClass="form-control"/>
                                </div>
<!--                                <div class="form-group col-md-4">
                                    <label class="control-label">Product ID</label>
                                    <%--<form:input path="productID" cssClass="form-control"/>--%>
                                </div>
                                <div class="form-group col-md-4">
                                    <label class="control-label">quantity </label>
                                    <%--<form:input path="quantity" cssClass="form-control"/>--%>
                                </div>
                                <div class="form-group col-md-4">
                                    <label class="control-label">totalPrice </label>
                                    <%--<form:input path="totalPrice" cssClass="form-control"/>--%>
                                </div>
                                <div class="form-group col-md-4">
                                    <label class="control-label">Ship Address </label>
                                    <%--<form:input path="shipAddress" cssClass="form-control"/>--%>
                                </div>
                                <div class="form-group col-md-4">
                                    <label class="control-label">note </label>
                                    <%--<form:input path="note" cssClass="form-control"/>--%>
                                </div>
                                  <div class="form-group col-md-4">
                                    <label class="control-label">User Name </label>
                                    <%--<form:input path="userName" cssClass="form-control"/>--%>
                                </div>
                                <div class="form-group col-md-4">
                                    <label class="control-label">Phone </label>
                                    <%--<form:input path="phone" cssClass="form-control"/>--%>
                                </div>-->


                                <div class="tile-footer">
                                    <button class="btn btn-save" type="submit">Save</button>
                                    <a class="btn btn-cancel" href="orders_tb.htm">Cancel</a>
                                </div>
                            </form:form>


                        </div>

                    </div>

                    </main>

                    </body>
                    </html>
