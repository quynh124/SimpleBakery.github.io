<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Manager Order</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">


    </head>
    <body onload="time()" class="app sidebar-mini rtl">
        <!-- Navbar-->

        <!-- Sidebar menu-->
        <jsp:include page="siderbarmenu.jsp"></jsp:include>
            <main class="app-content">
                <div class="app-title">
                    <ul class="app-breadcrumb breadcrumb side">
                        <li class="breadcrumb-item active"><a href="#"><b>Manager Order</b></a></li>
                    </ul>
                    <div id="clock"></div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="tile">
                            <div class="tile-body">
                                <div class="row element-button">

                                    <div class="col-sm-2">
                                        <a class="btn btn-delete btn-sm print-file" type="button" title="In" onclick="myApp.printTable()"><i
                                                class="fas fa-print"></i> Print Data</a>
                                    </div>
                                </div>
                                <table class="table table-hover table-bordered" id="example">
                                    <thead>
                                        <tr>
                                            <th width="10"><input type="checkbox" id="all"></th>
                                            <th>Order ID</th>
                                            <th>Order Date</th>
                                            <th>Delivery Date</th>
                                            <th>Total price</th>
                                            <th>Status</th>
                                            <th>User</th>
                                            <th>Voucher</th>
                                            <th>Payment</th>
                                            <th>Delivery</th>
                                            <th>Order Detail</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="item" items="${listOrders}">
                                        <c:if test="${item.isDeleted == false}"> 
                                        <tr data-id="${item.orderID}">
                                            <td width="10">
                                                <input type="checkbox" name="checkBox">
                                            </td>
                                            <td><c:out value="${item.orderID}"/></td>
                                            <td><fmt:formatDate value="${item.orderDate}" pattern="dd-MM-yyyy"/></td>
                                            <td><fmt:formatDate value="${item.deliveryDate}" pattern="dd-MM-yyyy"/></td>
                                            <td><span class="badge bg-danger"><c:out value="${item.totalPrice}"/></span></td> 
                                            <td><span class="badge bg-success"><c:out value="${item.status}"/></span></td> 
                                            <td><c:out value="${item.userID}"/></td>
                                            <td><c:out value="${item.voucherID}"/></td>
                                            <td><c:out value="${item.paymentID}"/></td> 
                                            <td><c:out value="${item.deliveryID}"/></td>
                                            <td>
                                                <button type="button" class="btn btn-info" onclick="window.location.href = 'viewdetail.htm?orderID=${item.orderID}'">
                                                    View Details
                                                </button>

                                            </td>

                                            <td>
                                                
                                                     <a href="/SimpleBakeryWebsite/orderdelete.htm?id=<c:out value='${item.orderID}'/>"
                                                   class="btn btn-danger btn-sm" 
                                                   title="Delete" 
                                                   data-toggle="modal" 
                                                   data-target="#deleteOrderModal" 
                                                   data-id="${item.orderID}">
                                                    <i class="fas fa-trash-alt"></i>
                                                </a>
                                                <button class="btn btn-primary btn-sm edit" type="button" title="Edit" id="show-emp" data-toggle="modal" data-target="#ModalUP">
                                                    <i class="fas fa-edit"></i>
                                                </button>
                                            </td>
                                        </tr>
                                        </c:if>
                                    </c:forEach>

                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </main>
              <div class="modal fade" id="deleteOrderModal" tabindex="-1" role="dialog" aria-labelledby="deleteOrderModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="deleteOrderModal">Confirm Delete</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        Are you sure you want to delete this order?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                        <a id="confirmDeleteBtn" href="#" class="btn btn-danger">Delete</a>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="ModalUP" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static"
             data-keyboard="false">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-body">
                        <div class="row">
                            <div class="form-group col-md-12">
                                <span class="thong-tin-thanh-toan">
                                    <h5>Edit Order</h5>
                                </span>
                            </div>
                        </div>
                        <form action="/SimpleBakeryWebsite/updateOrder.htm" method="POST">
                            <div class="row">
                                <div class="form-group col-md-6">
                                    <label class="control-label">Order ID</label>
                                    <input type="text" name="orderID" class="form-control" required="true" readonly="readonly" id="orderID"/>
                                </div>
                                <div class="form-group col-md-6">
                                    <label class="control-label">Order Date</label>
                                    <input type="text" name="orderDate" class="form-control" required="true" readonly="readonly" id="orderDate"/>
                                </div>
                                <div class="form-group col-md-6">
                                    <label class="control-label">Delivery Date</label>
                                    <input type="text" name="deliveryDate" class="form-control" readonly="readonly" required="true" id="deliveryDate"/>
                                </div>
                                <div class="form-group col-md-6">
                                    <label class="control-label">Total Price</label>
                                    <input type="text" name="totalPrice" class="form-control" readonly="readonly" required="true" id="totalPrice"/>
                                </div>
                                <div class="form-group col-md-6">
                                    <label class="control-label">User</label>
                                    <input type="text" name="userID" class="form-control" readonly="readonly" required="true" id="userID"/>
                                </div>
                                <div class="form-group col-md-6">
                                    <label class="control-label">Voucher</label>
                                    <input type="text" name="voucherID" class="form-control" readonly="readonly" required="true" id="voucherID"/>
                                </div>
                                <div class="form-group col-md-6">
                                    <label class="control-label">Payment</label>
                                    <input type="text" name="paymentID" class="form-control" readonly="readonly" required="true" id="paymentID"/>
                                </div>
                                <div class="form-group col-md-6">
                                    <label class="control-label">Delivery</label>
                                    <input type="text" name="deliveryID" class="form-control" readonly="readonly" required="true" id="deliveryID"/>
                                </div>
                                <div class="form-group col-md-6">
                                    <label class="control-label">Status</label>
                                    <select name="status" class="form-control" required="true" id="status">
                                        <option value="Ordered">Ordered</option>
                                        <option value="Confirmed">Confirmed</option>
                                        <option value="Preparing">Preparing</option>
                                        <option value="Shipped">Shipped</option>
                                    </select>
                                </div>
                            </div>
                            <button class="btn btn-save" type="submit">Save</button>
                            <a class="btn btn-cancel" data-dismiss="modal" href="#">Cancel</a>
                        </form>

                        <br>
                        <a href="#" style="float: right; font-weight: 600; color: #ea0000;"></a>
                        <br><br>
                    </div>
                    <div class="modal-footer"></div>
                </div>
            </div>
        </div>
        <!-- Modal HTML -->
      

        <script type="text/javascript">$('#sampleTable').DataTable();</script>
       
        <script>
            var myApp = new function () {
                this.printTable = function () {
                    var tab = document.getElementById('example');
                    var win = window.open('', '', 'height=700,width=700');
                    win.document.write(tab.outerHTML);
                    win.document.close();
                    win.print();
                }
            }
            new DataTable('#example', {
                layout: {
                    topStart: {
                        buttons: [
                            {
                                extend: 'copyHtml5',
                                exportOptions: {
                                    columns: [0, ':visible']
                                }
                            },
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

            $(document).on('click', '.edit', function () {
                var orderID = $(this).closest('tr').data("id");
                $.ajax({
                    url: '/SimpleBakeryWebsite/orderupdateshow.htm',
                    type: 'GET',
                    data: {id: orderID},
                    success: function (response) {
                        console.log(response); // Kiểm tra phản hồi từ máy chủ

                        // Phân tích dữ liệu từ phản hồi
                        var params = new URLSearchParams(response);
                        $("#orderID").val(params.get('orderID'));
                        $("#orderDate").val(params.get('orderDate'));
                        $("#deliveryDate").val(params.get('deliveryDate'));
                        $("#totalPrice").val(params.get('totalPrice'));
                        $("#status").val(params.get('status'));
                        $("#userID").val(params.get('userID'));
                        $("#voucherID").val(params.get('voucherID'));
                        $("#paymentID").val(params.get('paymentID'));
                        $("#deliveryID").val(params.get('deliveryID'));
                        // Hiển thị modal
                        $("#ModalUP").modal('show');
                    },
                    error: function (xhr, status, error) {
                        console.log(xhr.responseText); // Xem lỗi chi tiết
                        swal("Lỗi khi tải dữ liệu", {icon: "error"});
                    }
                });
            });
            oTable = $('#example').dataTable();
            $('#all').click(function (e) {
                $('#example tbody :checkbox').prop('checked', $(this).is(':checked'));
                e.stopImmediatePropagation();
            });
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
            //Modal
            $("#show-emp").on("click", function () {
                $("#ModalUP").modal({backdrop: false, keyboard: false})
            });
             $(document).ready(function () {
                $('#deleteOrderModal').on('show.bs.modal', function (event) {
                    var button = $(event.relatedTarget); // Button that triggered the modal
                    var orderID = button.data('id'); // Extract info from data-* attributes

                    // Update the modal's confirm delete button with the correct href
                    var modal = $(this);
                    var deleteUrl = '/SimpleBakeryWebsite/orderdelete.htm?id=' + orderID;
                    modal.find('#confirmDeleteBtn').attr('href', deleteUrl);
                });
            });
        </script>
    </body>
</html>
