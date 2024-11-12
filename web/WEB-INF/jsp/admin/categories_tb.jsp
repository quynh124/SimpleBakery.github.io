<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Manager Categories</title>

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
                <div class="app-title">
                    <ul class="app-breadcrumb breadcrumb side">
                        <li class="breadcrumb-item active"><a href="#"><b>Manager Categories</b></a></li>
                    </ul>
                    <div id="clock"></div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="tile">
                            <div class="tile-body">
                                <div class="row element-button">
                                    <div class="col-sm-2">
                                        <a class="btn btn-add btn-sm" href="categories_add.htm" title="Add"><i class="fas fa-plus"></i> Add new product</a>
                                    </div>
                                    <div class="col-sm-2">
                                        <a class="btn btn-delete btn-sm print-file" type="button" title="In" onclick="myApp.printTable()"><i class="fas fa-print"></i> Print Data</a>
                                    </div>
                                </div>

                                <!-- Display the error message if it exists -->
                            <c:if test="${not empty errorMessage}">
                                <div class="alert alert-danger">${errorMessage}</div>
                            </c:if>

                            <table class="table table-hover table-bordered" id="example">
                                <thead>
                                    <tr>
                                        <th width="10"><input type="checkbox" id="all"></th>
                                        <th>Category ID</th>
                                        <th>Category Name</th>
                                        <th>Description</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="category" items="${listCategory}">
                                        <c:if test="${category.isDeleted == false}"> 
                                        <tr data-id="${category.categoryID}">
                                            <td width="10">
                                                <input type="checkbox" name="check1">
                                            </td>
                                            <td><c:out value="${category.categoryID}"/></td>
                                            <td><c:out value="${category.categoryName}"/></td>
                                            <td><c:out value="${category.decription}"/></td>
                                            <td>
                                                <a href="/SimpleBakeryWebsite/categorydelete.htm?id=<c:out value='${category.categoryID}'/>" 
                                                   class="btn btn-danger btn-sm" 
                                                   title="Delete" 
                                                   data-toggle="modal" 
                                                   data-target="#deleteCategoryModal" 
                                                   data-id="${category.categoryID}">
                                                    <i class="fas fa-trash-alt"></i>
                                                </a>
                                                <button class="btn btn-primary btn-sm edit" type="button" title="Edit" data-id="${category.categoryID}" id="show-emp" data-toggle="modal" data-target="#ModalUP">
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
        <!-- Delete Confirmation Modal -->
        <div class="modal fade" id="deleteCategoryModal" tabindex="-1" role="dialog" aria-labelledby="deleteCategoryModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="deleteCategoryModalLabel">Confirm Delete</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        Are you sure you want to delete this category?
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
                                    <h5>Edit Category</h5>
                                </span>
                            </div>
                        </div>

                        <form:form action="/SimpleBakeryWebsite/updateCategory.htm" method="POST" modelAttribute="categoryToUpdate">
                            <div class="row">
                                <div class="form-group col-md-6">
                                    <label class="control-label">Category ID</label>
                                    <input type="text" name="categoryID" class="form-control" required="true" readonly="readonly" id="categoryID"/>
                                </div>
                                <div class="form-group col-md-6">
                                    <label class="control-label">Category Name</label>
                                    <input type="text" name="categoryName" class="form-control" required="true" id="categoryName"/>
                                </div>
                                <div class="form-group col-md-6">
                                    <label class="control-label">Description</label>
                                    <input type="text" name="decription" class="form-control" required="true" id="decription"/>
                                </div>


                            </div>
                            <button class="btn btn-save" type="submit">Save</button>
                            <a class="btn btn-cancel" data-dismiss="modal" href="#">Cancel</a>

                        </form:form>
                        <br>
                        <a href="#" style="float: right; font-weight: 600; color: #ea0000;"></a>
                        <br><br>
                    </div>
                    <div class="modal-footer"></div>
                </div>
            </div>
        </div>
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

        <script type="text/javascript">$('#example').DataTable();</script>
        <script>

            $(document).on('click', '.edit', function () {
                var categoryID = $(this).closest('tr').data("id");
                $.ajax({
                    url: '/SimpleBakeryWebsite/categoryupdateshow.htm',
                    type: 'GET',
                    data: {id: categoryID},
                    success: function (response) {
                        console.log(response); // Kiểm tra phản hồi từ máy chủ

                        // Phân tích dữ liệu từ phản hồi
                        var params = new URLSearchParams(response);
                        $("#categoryID").val(params.get('categoryID'));
                        $("#categoryName").val(params.get('categoryName'));
                        $("#decription").val(params.get('decription'));

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
            //In dữ liệu
            var myApp = new function () {
                this.printTable = function () {
                    var tab = document.getElementById('example');
                    var win = window.open('', '', 'height=700,width=700');
                    win.document.write(tab.outerHTML);
                    win.document.close();
                    win.print();
                }
            }
            $(document).ready(function () {
                $('#deleteCategoryModal').on('show.bs.modal', function (event) {
                    var button = $(event.relatedTarget); // Button that triggered the modal
                    var categoryId = button.data('id'); // Extract info from data-* attributes

                    // Update the modal's confirm delete button with the correct href
                    var modal = $(this);
                    var deleteUrl = '/SimpleBakeryWebsite/categorydelete.htm?id=' + categoryId;
                    modal.find('#confirmDeleteBtn').attr('href', deleteUrl);
                });
            });

        </script>

    </body>
</html>
