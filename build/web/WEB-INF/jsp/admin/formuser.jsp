<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="th" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Manager User</title>
        <!-- Main CSS-->

     
    </head>
    <body onload="time()" class="app sidebar-mini rtl">

        <!-- Sidebar menu-->
        <jsp:include page="siderbarmenu.jsp"></jsp:include>
            <main class="app-content">
                <div class="app-title">
                    <ul class="app-breadcrumb breadcrumb side">
                        <li class="breadcrumb-item active"><a href="#"><b>Manager User</b></a></li>
                    </ul>
                    <div id="clock"></div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="tile">
                            <div class="tile-body">
                               
                            <c:if test="${not empty errorMessage}">
                                <div class="alert alert-danger">
                                    ${errorMessage}
                                </div>
                            </c:if>
                            <table class="table table-hover table-bordered " id="example" >
                                <thead>
                                    <tr>
                                        <th width="10"><input type="checkbox" id="all"></th>
                                        <th>UserID</th>
                                        <th>FullName</th>
                                        <th>UserName</th>
                                        <th>Password</th>
                                        <th>Email</th>
                                        <th>Phone</th>
                                        <th>Address</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="user" items="${listUser}" >
                                        <tr data-id="${user.userID}">
                                            <td width="10"> 
                                                <input type="checkbox" name="check1">
                                            </td>
                                            <td><c:out value="${user.userID}"/></td>
                                            <td><c:out value="${user.fullname}"/></td>
                                            <td><c:out value="${user.username}"/></td>
                                            <td><c:out value="${user.password}"/></td>
                                            <td><c:out value="${user.email}"/></td>
                                            <td><c:out value="${user.phone}"/></td>
                                            <td><c:out value="${user.address}"/></td>
                                            <td>
                                                <a class="btn btn-primary btn-sm edit" type="button" title="Edit" data-id="${user.userID}" id="show-emp" data-toggle="modal" data-target="#ModalUP">
                                                    <i class="fas fa-edit"></i> Update
                                                </a>             
                                                <a class="btn btn-danger btn-sm trash" href="userdelete.htm?id=<c:out value='${user.userID}'/>">Delete</a>
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
        <div class="modal fade" id="ModalUP" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static"
             data-keyboard="false">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-body">
                        <div class="row">
                            <div class="form-group  col-md-12">
                                <span class="thong-tin-thanh-toan">
                                    <h5>Edit update </h5>
                                </span>
                            </div>
                        </div>
                        <form:form action="/SimpleBakeryWebsite/updateUser.htm" method="POST" modelAttribute="userToUpdate">
                            <div class="row">
                                <div class="form-group col-md-6">
                                    <label class="control-label">User ID</label>
                                    <input name="userID" class="form-control" id="userID" readonly="readonly" required="true" />
                                </div>

                                <div class="form-group col-md-6">
                                    <label class="control-label">Fullname</label>
                                    <input type="text" class="form-control" id="fullname" required="true" name="fullname" />
                                </div>

                                <div class="form-group col-md-6">
                                    <label class="control-label">Username</label>
                                    <input type="text" class="form-control" id="username" required="true" name="username" />
                                </div>


                                <div class="form-group col-md-6">
                                    <label class="control-label">Password</label>
                                    <input type="text"  class="form-control" id="password" required="true" name="password" />
                                </div>

                                <div class="form-group col-md-6">
                                    <label class="control-label">Email</label>
                                    <input type="text"  class="form-control" id="email" required="true" name="email" />
                                </div>

                                <div class="form-group col-md-6">
                                    <label class="control-label">Phone</label>
                                    <input type="text"  class="form-control" id="phone" required="true" name="phone" />
                                </div>



                                <div class="form-group col-md-6">
                                    <label class="control-label">Address</label>
                                    <input type="text" class="form-control" id="address" required="true" name="address" />
                                </div>



                            </div>

                            <button class="btn btn-save" type="submit">Save</button>
                            <a class="btn btn-cancel" data-dismiss="modal" href="formuser.htm">Cancel</a>
                        </form:form>
                        <BR>
                        <a href="#" style="float: right; font-weight: 600; color: #ea0000;"></a>
                    </div>
                    <div class="modal-footer">
                    </div>
                </div>
            </div>
        </div>
        <script src="./assets/js/popper.min.js"></script>
        <script src="./assets/js/bootstrap.min.js"></script>
        <!--<script src="./assets/js/jquery.table2excel.js"></script>-->
        <script src="./assets/js/main.js"></script>
        <script src="./assets/js/plugins/pace.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.js"></script>
        <!--        <script src="./assets/js/plugins/jquery.dataTables.min.js"></script>
                <script src="./assets/js/plugins/dataTables.bootstrap.min.js"></script>-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <script type="text/javascript">$('#sampleTable').DataTable();</script>
        <script>
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

        </script>
        <script>
            $(document).ready(function () {
                // Khởi tạo DataTable nếu chưa được khởi tạo
                if (!$.fn.dataTable.isDataTable('#example')) {
                    $('#example').DataTable({
                        paging: true,
                        // Các cấu hình DataTable khác nếu cần
                    });
                }

                // Sử dụng ủy quyền sự kiện để xử lý sự kiện nhấp chuột vào nút chỉnh sửa
                $('#example').on('click', '.edit', function () {
                    var userID = $(this).closest('tr').data("id");

                    $.ajax({
                        url: '/SimpleBakeryWebsite/userupdateshow.htm',
                        type: 'GET',
                        data: {id: userID},
                        success: function (response) {
                            console.log(response); // Kiểm tra phản hồi từ máy chủ

                            var params = new URLSearchParams(response);
                            $("#userID").val(params.get('userID'));
                            $("#fullname").val(params.get('fullname'));
                            $("#username").val(params.get('username'));
                            $("#password").val(params.get('password'));
                            $("#email").val(params.get('email'));
                            $("#phone").val(params.get('phone'));
                            $("#address").val(params.get('address'));

                            // Hiển thị modal để chỉnh sửa
                            $("#ModalUP").modal('show');
                        },
                        error: function (xhr, status, error) {
                            console.log(xhr.responseText); // Đăng chi tiết lỗi
                            swal("Lỗi khi tải dữ liệu", {icon: "error"});
                        }
                    });
                });

                // Chọn/Bỏ chọn tất cả các hộp kiểm khi hộp kiểm chính được nhấp
                $('#all').click(function (e) {
                    $('#example tbody :checkbox').prop('checked', $(this).is(':checked'));
                    e.stopImmediatePropagation();
                });
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
