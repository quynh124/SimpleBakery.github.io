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
        <title>Manager Admin</title>
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
    <body onload="time()" class="app sidebar-mini rtl">
        <jsp:include page="siderbarmenu.jsp"></jsp:include> 
    <main class="app-content">
                <div class="app-title">
                    <ul class="app-breadcrumb breadcrumb side">
                        <li class="breadcrumb-item active"><a href="#"><b>Manager Admin</b></a></li>
                    </ul>
                    <div id="clock"></div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="tile">
                            <div class="tile-body">
                                <div class="row element-button">
                                    <div class="col-sm-2">
                                        <a class="btn btn-add btn-sm" href="addadmin.htm" title="Thêm"><i class="fas fa-plus"></i>
                                            Add Amdin</a>
                                    </div>
                                </div>
                                <table class="table table-hover table-bordered " id="example" >
                                    <thead>
                                        <tr>
                                            <th width="10"><input type="checkbox" id="all"></th>
                                            <th>Admin ID</th>
                                            <th>User Name</th>
                                            <th>Password</th>
                                            <th>Actions</th>


                                        </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="admin" items="${listAdmin}" >
                                        <tr data-id="${admin.adminID}">
                                            <td width="10"> 
                                                <input type="checkbox" name="check1">
                                            </td>
                                            <td><c:out value="${admin.adminID}"/></td>
                                            <td><c:out value="${admin.username}"/></td>
                                            <td><c:out value="${admin.password}"/></td>
                                            <td>
                                                <a class="btn btn-primary btn-sm edit" type="button" title="Edit" data-id="${admin.adminID}" id="show-emp" data-toggle="modal" data-target="#ModalUP">
                                                    <i class="fas fa-edit"></i> Update
                                                </a>             
                                                <a class="btn btn-danger btn-sm trash" href="admindelete.htm?id=<c:out value='${admin.adminID}'/>">Delete</a>
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
                        <form:form action="/SimpleBakeryWebsite/updateAdmin.htm" method="POST" modelAttribute="adminToUpdate">
                            <div class="row">
                                <div class="form-group col-md-6">
                                    <label class="control-label">Admin ID</label>
                                    <input name="adminID" class="form-control" id="adminID" readonly="readonly" required="true" />
                                </div>
                                <div class="form-group col-md-6">
                                    <label class="control-label">User name</label>
                                    <input type="text" class="form-control" id="username" required="true" name="username" />
                                </div>
                                
                                <div class="form-group col-md-6">
                                    <label class="control-label">Password</label>
                                    <input type="text"  class="form-control" id="password" required="true" name="password" />
                                </div>
                                
                                

                            </div>

                            <button class="btn btn-save" type="submit">Save</button>
                            <a class="btn btn-cancel" data-dismiss="modal" href="formadmin.htm">Cancel</a>
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
       $(document).ready(function() {
    // Khởi tạo DataTable nếu chưa được khởi tạo
    if (!$.fn.dataTable.isDataTable('#example')) {
        $('#example').DataTable({
            paging: true,
            // Các cấu hình DataTable khác nếu cần
        });
    }

    // Sử dụng ủy quyền sự kiện để xử lý sự kiện nhấp chuột vào nút chỉnh sửa
    $('#example').on('click', '.edit', function() {
        var adminID = $(this).closest('tr').data("id");

        $.ajax({
            url: '/SimpleBakeryWebsite/adminupdateshow.htm',
            type: 'GET',
            data: { id: adminID },
            success: function(response) {
                console.log(response); // Kiểm tra phản hồi từ máy chủ

                var params = new URLSearchParams(response);
                $("#adminID").val(params.get('adminID'));
                $("#username").val(params.get('username'));
                $("#password").val(params.get('password'));

                // Hiển thị modal để chỉnh sửa
                $("#ModalUP").modal('show');
            },
            error: function(xhr, status, error) {
                console.log(xhr.responseText); // Đăng chi tiết lỗi
                swal("Lỗi khi tải dữ liệu", { icon: "error" });
            }
        });
    });

    // Chọn/Bỏ chọn tất cả các hộp kiểm khi hộp kiểm chính được nhấp
    $('#all').click(function(e) {
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

