
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Manager Payment</title>


    </head>
    <body onload="time()" class="app sidebar-mini rtl">

        <!-- Sidebar menu-->
        <jsp:include page="siderbarmenu.jsp"></jsp:include>
            <main class="app-content">
                <div class="app-title">
                    <ul class="app-breadcrumb breadcrumb side">
                        <li class="breadcrumb-item active"><a href="#"><b>Manager Payment</b></a></li>
                    </ul>
                    <div id="clock"></div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="tile">
                            <div class="tile-body">
                                <div class="row element-button">
                                   
                                </div>
                            <c:if test="${not empty errorMessage}">
                                <div class="alert alert-danger">
                                    ${errorMessage}
                                </div>
                            </c:if>
                            <table class="table table-hover table-bordered display nowrap" id="example" style="width:100%">
                                <thead>
                                    <tr>
                                        <th width="10"><input type="checkbox" id="all"></th>
                                        <th>Payment ID</th>
                                        <th>Payment Name</th>
                                        <th>Description</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="payment" items="${listPayment}" varStatus="status">
                                        <tr data-id="${payment.paymentID}">
                                            <td width="10"><input type="checkbox" name="check${status.index}" value="${payment.paymentID}"></td>
                                            <td><c:out value="${payment.paymentID}"/></td>
                                            <td><c:out value="${payment.paymentName}"/></td>
                                            <td><c:out value="${payment.description}"/></td>
                                            <td>
                                                <a class="btn btn-primary btn-sm edit" type="button" title="Edit" data-id="${payment.paymentID}" data-toggle="modal" data-target="#ModalUP">Update</a>
                                                <a class="btn btn-primary btn-sm trash" href="paymentdelete.htm?id=<c:out value='${payment.paymentID}'/>">Delete</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <!--
      MODAL
        -->
        <div class="modal fade" id="ModalUP" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static"
             data-keyboard="false">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-body">
                        <div class="row">
                            <div class="form-group  col-md-12">
                                <span class="thong-tin-thanh-toan">
                                    <h5>Edit Payment </h5>
                                </span>
                            </div>
                        </div>
                        <form:form action="/SimpleBakeryWebsite/updatePayment.htm" method="POST" modelAttribute="paymentToUpdate">
                            <div class="row">
                                <div class="form-group col-md-6">
                                    <label class="control-label">Payment ID</label>
                                    <input class="form-control" type="text" name="paymentID" required="true"  id="paymentID" readonly="readonly">
                                </div>
                                <div class="form-group col-md-6">
                                    <label class="control-label">Payment Name</label>
                                    <input class="form-control" type="text" name="paymentName" required="true"  id="paymentName">
                                </div>
                                <div class="form-group col-md-6">
                                    <label class="control-label">Description</label>
                                    <input class="form-control" type="text" name="description" required="true"  id="description">
                                </div>
                            </div>
                            <button class="btn btn-save" type="submit">Save</button>
                            <a class="btn btn-cancel" href="formpayment.htm">Cancel</a>
                        </form:form>
                        <BR>
                        <a href="#" style="float: right; font-weight: 600; color: #ea0000;"></a>
                    </div>
                    <div class="modal-footer">
                    </div>
                </div>
            </div>
        </div>

    
        <script type="text/javascript">$('#sampleTable').DataTable();</script>
        <script>
            new DataTable('#example', {
                layout: {
                    topStart: {
                        buttons: ['copy',  'excel', 'pdf', 'print']
                    }
                }
            });
        </script>
        <script>

            $(document).on('click', '.edit', function () {
                var paymentID = $(this).closest('tr').data("id");
                $.ajax({
                    url: '/SimpleBakeryWebsite/paymentupdateshow.htm',
                    type: 'GET',
                    data: {id: paymentID},
                    success: function (response) {
                        console.log(response); // Kiểm tra phản hồi từ máy chủ

                        // Phân tích dữ liệu từ phản hồi
                        var params = new URLSearchParams(response);
                        $("#paymentID").val(params.get('paymentID'));
                        $("#paymentName").val(params.get('paymentName'));
                        $("#description").val(params.get('description'));

                        // Hiển thị modal
                        $("#ModalUP").modal('show');
                    },
                    error: function (xhr, status, error) {
                        console.log(xhr.responseText); // Xem lỗi chi tiết
                        swal("Lỗi khi tải dữ liệu", {icon: "error"});
                    }
                });
            });
        </script>
        <script>

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
            //In dữ liệu
            var myApp = new function () {
                this.printTable = function () {
                    var tab = document.getElementById('sampleTable');
                    var win = window.open('', '', 'height=700,width=700');
                    win.document.write(tab.outerHTML);
                    win.document.close();
                    win.print();
                }
            }

            //Modal
            $("#show-emp").on("click", function () {
                $("#ModalUP").modal({backdrop: false, keyboard: false})
            });
        </script>

    </body>
</html>
