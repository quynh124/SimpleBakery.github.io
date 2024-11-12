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
        <title>Manager FAQs</title>
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

        <!-- Sidebar menu-->
        <jsp:include page="siderbarmenu.jsp"></jsp:include>
            <main class="app-content">
                <div class="app-title">
                    <ul class="app-breadcrumb breadcrumb side">
                        <li class="breadcrumb-item active"><a href="#"><b>Manager FAQs</b></a></li>
                    </ul>
                    <div id="clock"></div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="tile">
                            <div class="tile-body">
                                <div class="row element-button">
                                    
                                </div>

                                <table class="table table-hover table-bordered display nowrap" id="example" style="width:100%">
                                    <thead>
                                        <tr>
                                            <th width="10"><input type="checkbox" id="all"></th>
                                            <th>FAQs ID</th>
                                            <th>Email</th>

                                            <th>Content</th>
                                            <th>Reply</th>
                                            <th>Status</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="faq" items="${listFaq}" varStatus="status">
                                        <tr data-id="${faq.faqID}">
                                            <td width="10"><input type="checkbox" name="check${status.index}" value="${faq.faqID}"></td>
                                            <td><c:out value="${faq.faqID}"/></td>

                                            <td><c:out value="${faq.emailUser}"/></td>
                                            <td><c:out value="${faq.content}"/></td>

                                            <td><c:out value="${faq.reply}"/></td>
                                            <td><c:out value="${faq.status}"/></td>
                                            <td>
                                                <a class="btn btn-primary btn-sm edit" type="button" title="Edit" data-id="${faq.faqID}" id="show-emp" data-toggle="modal" data-target="#ModalUP">
                                                    <i class="fas fa-edit"></i> Update
                                                </a>
                                                <a class="btn btn-primary btn-sm trash" href="faqdelete.htm?id=<c:out value='${faq.faqID}'/>">Delete</a>
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
                        <form:form action="/SimpleBakeryWebsite/updateFaq.htm" method="POST" modelAttribute="faqToUpdate">
                            <div class="row">
                                <div class="form-group col-md-6">
                                    <label class="control-label">Faq ID</label>
                                    <input  name="faqID" class="form-control" required="true" readonly="readonly" id="faqID"/>

                                </div>
                                <div class="form-group col-md-6">
                                    <label class="control-label">Email User</label>
                                    <input class="form-control" id="emailUser" type="text" name="emailUser" required="true"/>
                                </div>

                                <div class="form-group col-md-6">
                                    <label class="control-label">Content</label>
                                    <input class="form-control" id="content" type="text" name="content" required="true" />
                                </div>
                                <div class="form-group col-md-6">
                                    <label class="control-label">Reply</label>
                                    <input class="form-control" id="reply" type="text" name="reply" required="true" />
                                </div>
                                <div class="form-group col-md-6">
                                    <label class="control-label">Status</label>
                                    <input class="form-control" id="status" type="text" name="status" required="true" />
                                </div>
                            </div>
                            <button class="btn btn-save" type="submit">Save</button>
                            <a class="btn btn-cancel" href="formfaqs.htm">Cancel</a>
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
                        buttons: ['copy', 'excel', 'pdf', 'print']
                    }
                }
            });
        </script>
        <script>
            $(document).ready(function () {
                $('.reply-input').on('change', function () {
                    var faqID = $(this).data('id');
                    var reply = $(this).val();

                    $.ajax({
                        url: '<c:url value="/viewfaq.htm"/>',
                        type: 'POST',
                        data: {
                            faqID: faqID,
                            reply: reply
                        },
                        success: function (response) {
                            if (response === 'Success') {
                                alert('Reply updated successfully!');
                            } else {
                                alert('An error occurred while updating the reply.');
                            }
                        },
                        error: function (xhr, status, error) {
                            console.error('Error:', xhr.responseText);
                            alert('An error occurred while updating the reply.');
                        }
                    });
                });
            });
        </script>
        <script>
            $.ajax({
                url: '/viewfaq.htm',
                type: 'POST',
                data: {
                    faqID: 1, // Replace with dynamic ID if necessary
                    reply: 'This is a test reply'
                },
                success: function (response) {
                    console.log('Response: ' + response);
                },
                error: function (error) {
                    console.log('Error: ' + error);
                }
            });
        </script>
        <script>

            $(document).on('click', '.edit', function () {
                var faqID = $(this).closest('tr').data("id");
                $.ajax({
                    url: '/SimpleBakeryWebsite/faqupdateshow.htm',
                    type: 'GET',
                    data: {id: faqID},
                    success: function (response) {
                        console.log(response); // Kiểm tra phản hồi từ máy chủ

                        // Phân tích dữ liệu từ phản hồi
                        var params = new URLSearchParams(response);
                        $("#faqID").val(params.get('faqID'));
                        $("#emailUser").val(params.get('emailUser'));

                        $("#content").val(params.get('content'));
                        $("#reply").val(params.get('reply'));
                        $("#status").val(params.get('status'));



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
