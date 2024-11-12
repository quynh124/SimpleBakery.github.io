
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Manager Voucher</title>
       
    </head>
    <body onload="time()" class="app sidebar-mini rtl">
        <!-- Navbar-->
        <header class="app-header">
            <!-- Sidebar toggle button--><a class="app-sidebar__toggle" href="#" data-toggle="sidebar"
                                            aria-label="Hide Sidebar"></a>
            <!-- Navbar Right Menu-->
            <ul class="app-nav">


                <!-- Voucher Menu-->
                <li><a class="app-nav__item" href="../voucher/index.htm"><i class='bx bx-log-out bx-rotate-180'></i></a>

                </li>
            </ul>
        </header>
        <!-- Sidebar menu-->
        <jsp:include page="siderbarmenu.jsp"></jsp:include>
            <main class="app-content">
                <div class="app-title">
                    <ul class="app-breadcrumb breadcrumb side">
                        <li class="breadcrumb-item active"><a href="#"><b>Manager Voucher</b></a></li>
                    </ul>
                    <div id="clock"></div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="tile">
                            <div class="tile-body">
                                <div class="row element-button">
                                    <div class="col-sm-2">
                                        <a class="btn btn-add btn-sm" href="addvoucher.htm" title="Thêm"><i class="fas fa-plus"></i>
                                            Add Voucher</a>
                                    </div>
                                </div>
                                <c:if test="${not empty errorMessage}">
                                <div class="alert alert-danger">
                                    ${errorMessage}
                                </div>
                            </c:if>
                                <table class="table table-hover table-bordered" id="example" style="width:100%">
                                    <thead>
                                        <tr>
                                            <th width="10">
                                                <input type="checkbox" id="all">
                                            </th>
                                            <th>Voucher ID</th>
                                            <th>Voucher Code</th>
                                            <th>Discount Amount</th>
                                            <th>Start Date</th>
                                            <th>End Date</th>
                                            <th>Event Name</th>
                                            <th>Image Url</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="voucher" items="${listVoucher}" varStatus="status">
                                        <tr data-id="${voucher.voucherID}">
                                            <td width="10">
                                                <input type="checkbox" name="check${status.index}" value="${voucher.voucherID}">
                                            </td>
                                            <td><c:out value="${voucher.voucherID}"/></td>
                                            <td><c:out value="${voucher.voucherCode}"/></td>
                                            <td><c:out value="${voucher.discountAmount}"/></td>
                                            <td><c:out value="${voucher.startDate}"/></td>
                                            <td><c:out value="${voucher.endDate}"/></td>
                                            <td><c:out value="${voucher.eventName}"/></td>
                                            <td><img src="<c:out value='./assets/img/voucher/${voucher.imagesUrl}'/>" alt="Product Image" width="80px;" height="80px;"/></td>
                                            <td>
                                                <button class="btn btn-primary btn-sm edit" type="button" title="Edit" id="show-emp" data-toggle="modal" data-target="#ModalUP">
                                                    <i class="fas fa-edit"></i>
                                                </button>
                                                <a class="btn btn-primary btn-sm trash" href="voucherdelete.htm?id=<c:out value='${voucher.voucherID}'/>"> <i class="fas fa-trash-alt"></i></a>
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
                                    <h5>Edit update </h5>
                                </span>
                            </div>
                        </div>
                        <form:form action="/SimpleBakeryWebsite/updateVoucher.htm" modelAttribute="voucherToUpdate" method="POST">
                            <table border="0">
                                <thead>
                                    <tr>
                                        <th colspan="2">Edit Voucher</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td><label for="voucherID" class="control-label">Voucher ID</label></td>
                                        <td><input name="voucherID" id="voucherID"  class="form-control" readonly="readonly"/></td>
                                    </tr>
                                    <tr>
                                        <td><label for="voucherCode" class="control-label">Voucher Code</label></td>
                                        <td><input name="voucherCode" id="voucherCode"  class="form-control" required="true" /></td>
                                    </tr>
                                    <tr>
                                        <td><label for="discountAmount" class="control-label">Discount Amount</label></td>
                                        <td><input name="discountAmount" id="discountAmount"  class="form-control" required="true" /></td>
                                    </tr>
                                    <tr>
                                        <td><label for="startDate" class="control-label">Start Date</label></td>
                                        <td><input name="startDate" id="startDate"  class="form-control" required="true" type="date" /></td>
                                    </tr>
                                    <tr>
                                        <td><label for="endDate" class="control-label">End Date</label></td>
                                        <td><input name="endDate" id="endDate"  class="form-control" required="true" type="date" /></td>
                                    </tr>
                                    <tr>
                                        <td><label for="eventName" class="control-label">Event Name</label></td>
                                        <td><input name="eventName" id="eventName"  class="form-control" required="true" /></td>
                                    </tr>
                                    <tr>
                                        <td><label for="imagesUrl" class="control-label">Image URL</label></td>
                                        <td><input name="imagesUrl" id="imagesUrl"  type="file" class="form-control" /></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <button class="btn btn-save" type="submit">Save</button>
                                            <a class="btn btn-cancel" href="formvoucher.htm">Cancel</a>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </form:form>
                        <BR>
                        <a href="#" style="float: right; font-weight: 600; color: #ea0000;"></a>
                    </div>
                    <div class="modal-footer">
                    </div>
                </div>
            </div>
        </div>

        <!-- jQuery -->
        <script src="https://code.jquery.com/jquery-3.7.1.js"></script>

        <!-- DataTables JS -->
        <script src="https://cdn.datatables.net/2.1.3/js/dataTables.js"></script>

        <!-- DataTables Buttons JS -->
        <script src="https://cdn.datatables.net/buttons/3.1.1/js/dataTables.buttons.js"></script>
        <script src="https://cdn.datatables.net/buttons/3.1.1/js/buttons.dataTables.js"></script>

        <!-- JSZip (required for Excel export) -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>

        <!-- pdfmake (required for PDF export) -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/pdfmake.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/vfs_fonts.js"></script>

        <!-- Buttons for Excel, PDF, and Print export -->
        <script src="https://cdn.datatables.net/buttons/3.1.1/js/buttons.html5.min.js"></script>
        <script src="https://cdn.datatables.net/buttons/3.1.1/js/buttons.print.min.js"></script>

        <!-- Essential javascripts for application to work-->
        <script src="./assets/js/jquery-3.2.1.min.js"></script>
        <script src="./assets/js/popper.min.js"></script>
        <script src="./assets/js/bootstrap.min.js"></script>
        <script src="./assets///ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
        <script src="./assets/src/jquery.table2excel.js"></script>
        <script src="./assets/js/main.js"></script>
        <!-- The javascript plugin to display page loading on top-->
        <script src="./assets/js/plugins/pace.min.js"></script>
        <!-- Page specific javascripts-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.js"></script>
        <!-- Data table plugin-->
        <script type="text/javascript" src="./assets/js/plugins/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="./assets/js/plugins/dataTables.bootstrap.min.js"></script>
        <!-- DataTables CSS -->
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css"/>
        <!-- DataTables Buttons CSS -->
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/1.7.1/css/buttons.dataTables.min.css"/>

        <!-- jQuery -->
        <script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <!-- DataTables JS -->
        <script type="text/javascript" src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
        <!-- DataTables Buttons JS -->
        <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.7.1/js/dataTables.buttons.min.js"></script>
        <!-- JSZip (required for Excel export) -->
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
        <!-- pdfmake (required for PDF export) -->
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
        <!-- Buttons for Excel and PDF export -->
        <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.7.1/js/buttons.html5.min.js"></script>
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
            $(document).on('click', '.edit', function () {
                var voucherID = $(this).closest('tr').data("id");
                $.ajax({
                    url: '/SimpleBakeryWebsite/voucherupdateshow.htm',
                    type: 'GET',
                    data: {id: voucherID},
                    success: function (response) {
                        console.log(response); // Kiểm tra phản hồi từ máy chủ

                        // Phân tích dữ liệu từ phản hồi
                        var params = new URLSearchParams(response);
                        $("#voucherID").val(params.get('voucherID'));
                        $("#voucherCode").val(params.get('voucherCode'));
                        $("#discountAmount").val(params.get('discountAmount'));
                        $("#startDate").val(params.get('startDate'));
                        $("#endDate").val(params.get('endDate'));
                        $("#eventName").val(params.get('eventName'));
                        $("#imagesUrl").val(params.get('imagesUrl'));
                        $("#userID").val(params.get('userID'));

// Hiển thị modal
                        $("#ModalUP").modal('show');
                    },
                    error: function (xhr, status, error) {
                        console.log(xhr.responseText); // Xem lỗi chi tiết
                        swal("Lỗi khi tải dữ liệu", {icon: "error"});
                    }
                });
            });
//                        // Hiển thị URL hình ảnh
//                        var imageUrl = data.imagesUrl;
//                        if (imageUrl) {
//                            $("#thumbimage").attr('src', imageUrl).show();
//                            $(".removeimg").show();
//                            $(".Choicefile").css('background', '#ccc').css('cursor', 'default');
//                        } else {
//                            $("#thumbimage").hide();
//                            $(".removeimg").hide();
//                        }
//
//                        // Hiển thị modal
//                        $("#ModalUP").modal('show');
//                    },
//                    error: function (xhr, status, error) {
//                        console.log(xhr.responseText); // Xem lỗi chi tiết
//                        swal("Lỗi khi tải dữ liệu", {icon: "error"});
//                    }
//                });
//            });
//
//            // Xử lý khi chọn file hình ảnh
//            $(".Choicefile").on('click', function () {
//                $("#imagesUrl").click();
//            });
//
//            // Xử lý khi xóa hình ảnh
//            $(".removeimg").on('click', function () {
//                $("#thumbimage").attr('src', '').hide();
//                $("#imagesUrl").val('');
//                $('.filename').text('');
//                $(".removeimg").hide();
//                $(".Choicefile").css('background', '#14142B').css('cursor', 'pointer');
//            });
//
//            // Hàm để đọc và hiển thị hình ảnh khi chọn file
//            $("#imagesUrl").on('change', function () {
//                readURL(this);
//            });
//
//            // Hàm để đọc và hiển thị hình ảnh khi chọn file
//            function readURL(input) {
//                if (input.files && input.files[0]) {
//                    var reader = new FileReader();
//                    reader.onload = function (e) {
//                        $("#thumbimage").attr('src', e.target.result).show();
//                        $(".removeimg").show();
//                        $(".Choicefile").css('background', '#ccc').css('cursor', 'default');
//                    }
//                    reader.readAsDataURL(input.files[0]);
//                    }
//                }
//            }
//            );
        </script>
        <script>
            //    function deleteRow(r) {
            //      var i = r.parentNode.parentNode.rowIndex;
            //      document.getElementById("myTable").deleteRow(i);
            //    }
            //    jQuery(function () {
            //      jQuery(".trash").click(function () {
            //        swal({
            //          title: "Cảnh báo",
            //         
            //          text: "Bạn có chắc chắn là muốn xóa?",
            //          buttons: ["Hủy bỏ", "Đồng ý"],
            //        })
            //          .then((willDelete) => {
            //            if (willDelete) {
            //              swal("Đã xóa thành công.!", {
            //                
            //              });
            //            }
            //          });
            //      });
            //    });
            //    oTable = $('#sampleTable').dataTable();
            //    $('#all').click(function (e) {
            //      $('#sampleTable tbody :checkbox').prop('checked', $(this).is(':checked'));
            //      e.stopImmediatePropagation();
            //    });

            //    //EXCEL
            //     $(document).ready(function () {
            //       $('#').DataTable({
            //
            //        dom: 'Bfrtip',
            //        "buttons": [
            //         'excel'
            //       ]
            //       });
            //     });



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
            //     //Sao chép dữ liệu
            //     var copyTextareaBtn = document.querySelector('.js-textareacopybtn');

            // copyTextareaBtn.addEventListener('click', function(event) {
            //   var copyTextarea = document.querySelector('.js-copytextarea');
            //   copyTextarea.focus();
            //   copyTextarea.select();

            //   try {
            //     var successful = document.execCommand('copy');
            //     var msg = successful ? 'successful' : 'unsuccessful';
            //     console.log('Copying text command was ' + msg);
            //   } catch (err) {
            //     console.log('Oops, unable to copy');
            //   }
            // });


            //Modal
            $("#show-emp").on("click", function () {
                $("#ModalUP").modal({backdrop: false, keyboard: false})
            });
        </script>
    </body>
</html>
