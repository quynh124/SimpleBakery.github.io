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
        <title>Manager Product</title>

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
        <jsp:include page="siderbarmenu.jsp"></jsp:include>
            <main class="app-content">
                <div class="app-title">
                    <ul class="app-breadcrumb breadcrumb side">
                        <li class="breadcrumb-item active"><a href="#"><b>Manager Product</b></a></li>
                    </ul>
                    <div id="clock"></div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="tile">
                            <div class="tile-body">
                                <div class="row element-button">
                                    <div class="col-sm-2">
                                        <a class="btn btn-add btn-sm" href="products_add.htm" title="Add"><i class="fas fa-plus"></i>
                                            Add new product</a>
                                    </div>
                                    <div class="col-sm-2">
                                        <a class="btn btn-delete btn-sm print-file" type="button" title="In" onclick="myApp.printTable()"><i
                                                class="fas fa-print"></i> Print Data</a>
                                    </div>
                                </div>
                                <table class="table table-hover table-bordered" id="example">
                                    <thead>
                                        <tr>
                                            <th width="10"><input type="checkbox" id="all"></th>
                                            <th>Product ID</th>
                                            <th>Product Name</th>
                                            <th>UnitPrice</th>
                                            <th>Size</th>
                                            <th>Image</th>
                                            <th>Quantity</th>
                                            <th>Description</th>
                                            <th>CategoryID</th>

                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="item" items="${listProduct}">
                                        <c:if test="${item.isDeleted == false}">  <!-- Kiểm tra isDeleted -->
                                            <tr data-id="${item.productID}">
                                                <td width="10">
                                                    <input type="checkbox" name="checkBox">
                                                </td>
                                                <td><c:out value="${item.productID}"/></td>
                                                <td><c:out value="${item.productName}"/></td>
                                                <td><span class="badge bg-danger"><c:out value="${item.unitPrice}"/>.000</span></td>
                                                <td><span class="badge bg-success"><c:out value="${item.size}"/>cm</span></td>
                                                <td>
                                                    <img src="<c:out value='${item.image}'/>" alt="Product Image" width="80px;" height="80px;">
                                                </td>
                                                <td><span class="badge bg-danger"><c:out value="${item.quantity}"/></span></td>
                                                <td><c:out value="${item.decription}"/></td>
                                                <td><span class="badge bg-success"><c:out value="${item.categoryID}"/></span></td>

                                                <td>
                                                    <a href="/SimpleBakeryWebsite/productdelete.htm?id=<c:out value='${item.productID}'/>" 
                                                       class="btn btn-danger btn-sm" 
                                                       title="Delete" 
                                                       data-toggle="modal" 
                                                       data-target="#deleteProductModal" 
                                                       data-id="${item.productID}">
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
        <!-- Delete Confirmation Modal -->
        <div class="modal fade" id="deleteProductModal" tabindex="-1" role="dialog" aria-labelledby="deleteProductModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="deleteProductModal">Confirm Delete</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        Are you sure you want to delete this product?
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
                            <div class="form-group  col-md-12">
                                <span class="thong-tin-thanh-toan">
                                    <h5>Edit Product</h5>
                                </span>
                            </div>
                        </div>
                        <form:form action="/SimpleBakeryWebsite/updateProduct.htm" method="POST" modelAttribute="productToUpdate"  enctype="multipart/form-data">
                            <div class="row">
                                <div class="form-group col-md-6">
                                    <label class="control-label">Product ID</label>
                                    <input class="form-control" type="text" id="productID" readonly="readonly" name="productID">
                                </div>
                                <div class="form-group col-md-6">
                                    <label class="control-label">Product Name</label>
                                    <input class="form-control" type="text" id="productName" name="productName">
                                </div>
                                <div class="form-group  col-md-6">
                                    <label class="control-label">Quantity</label>
                                    <input class="form-control" type="number" id="quantity" name="quantity">
                                </div>
                                <div class="form-group  col-md-6">
                                    <label class="control-label">Size</label>
                                    <select name="size" class="form-control" required="true" id="size">
                                        <option value="15">15cm</option>
                                        <option value="20">20cm</option>
                                        <option value="25">25cm</option>
                                    </select>
                                </div>
                                <div class="form-group col-md-6">
                                    <label class="control-label">UnitPrice</label>
                                    <input class="form-control" type="text" id="unitPrice" name="unitPrice">
                                </div>

                                <div class="form-group col-md-6">
                                    <label for="category" class="control-label">Category</label>
                                    <form:select path="categoryID" cssClass="form-control" id="category">
                                        <form:option value="" label="-- Select Category --" />
                                        <c:forEach var="category" items="${categories}">
                                            <c:if test="${!category.isDeleted}">
                                                <option value="${category.categoryID}">${category.categoryName}</option>
                                            </c:if>
                                        </c:forEach>
                                    </form:select>
                                </div>

                                <div class="form-group col-md-12">
                                    <label class="control-label">Image</label>
                                    <div id="myfileupload">
                                        <input type="file" accept="image/*" id="image" name="image" style="display: none;" onchange="readURL(this);" />
                                    </div>
                                    <div id="thumbbox">
                                        <img height="200" width="200" alt="Thumb image" id="thumbimage" style="display: none"/>
                                        <a class="removeimg" href="javascript:void(0);"></a> 
                                    </div>
                                    <div id="boxchoice">
                                        <a href="javascript:void(0);" class="Choicefile"><i class="fas fa-cloud-upload-alt"></i> Choose File</a>
                                        <p style="clear:both"></p>
                                    </div>
                                </div>

                                <div class="form-group col-md-12">
                                    <label class="control-label">Description</label>
                                    <textarea class="form-control" name="decription" id="decription"></textarea>
                                    <script>CKEDITOR.replace('mota');</script>
                                </div>
                            </div>
                            <BR>
                            <a href="#" style="    float: right;
                               font-weight: 600;
                               color: #ea0000;"></a>
                            <BR>
                            <BR>
                            <button class="btn btn-save" type="submit">Save</button>
                            <a class="btn btn-cancel" data-dismiss="modal" href="#">Cancel</a>
                            <BR>
                        </form:form>
                    </div>

                    <div class="modal-footer">
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

        <script type="text/javascript">
            $(document).ready(function () {
                // Khởi tạo DataTable
                $('#example').DataTable();

                // Xử lý khi nhấn nút chỉnh sửa
                $(document).on('click', '.edit', function () {
                    var productID = $(this).closest('tr').data("id");
                    $.ajax({
                        url: '/SimpleBakeryWebsite/productupdateshow.htm',
                        type: 'GET',
                        data: {id: productID},
                        success: function (response) {
                            console.log(response); // Kiểm tra phản hồi từ server

                            // Giải mã chuỗi URL-encoded
                            var params = new URLSearchParams(response);

                            // Cập nhật giá trị vào các trường form
                            $("#productID").val(params.get('productID'));
                            $("#productName").val(params.get('productName'));
                            $("#unitPrice").val(params.get('unitPrice'));
                            $("#size").val(params.get('size'));
                            $("#quantity").val(params.get('quantity'));
                            $("#decription").val(params.get('decription'));

                            // Hiển thị hình ảnh hiện tại
                            $("#thumbimage").attr('src', params.get('image')).show();

                            // Cập nhật giá trị cho dropdown
                            $("#category").val(params.get('categoryID'));

                            // Hiển thị modal
                            $("#ModalUP").modal('show');
                        },
                        error: function (xhr, status, error) {
                            console.log(xhr.responseText); // Hiển thị chi tiết lỗi
                            swal("Lỗi khi tải dữ liệu", {icon: "error"});
                        }
                    });
                });

                // Xử lý khi chọn file hình ảnh
                $(".Choicefile").on('click', function () {
                    $("#image").click();
                });

                // Xử lý khi xóa hình ảnh
                $(".removeimg").on('click', function () {
                    $("#thumbimage").attr('src', '').hide();
                    $("#image").val('');
                    $('.filename').text('');
                    $(".removeimg").hide();
                    $(".Choicefile").css('background', '#14142B').css('cursor', 'pointer');
                });

                // Hàm để đọc và hiển thị hình ảnh khi chọn file
                $("#image").on('change', function () {
                    readURL(this);
                });

                // Hàm để đọc và hiển thị hình ảnh khi chọn file
                function readURL(input) {
                    if (input.files && input.files[0]) {
                        var reader = new FileReader();
                        reader.onload = function (e) {
                            $("#thumbimage").attr('src', e.target.result).show();
                            $(".removeimg").show();
                            $(".Choicefile").css('background', '#ccc').css('cursor', 'default');
                        }
                        reader.readAsDataURL(input.files[0]);
                    }
                }
            });

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
                $('#deleteProductModal').on('show.bs.modal', function (event) {
                    var button = $(event.relatedTarget); // Button that triggered the modal
                    var productID = button.data('id'); // Extract info from data-* attributes

                    // Update the modal's confirm delete button with the correct href
                    var modal = $(this);
                    var deleteUrl = '/SimpleBakeryWebsite/productdelete.htm?id=' + productID;
                    modal.find('#confirmDeleteBtn').attr('href', deleteUrl);
                });
            });
        </script>
        <script>
            oTable = $('#example').dataTable();
            $('#all').click(function (e) {
                $('#example tbody :checkbox').prop('checked', $(this).is(':checked'));
                e.stopImmediatePropagation();
            });
        </script>


    </body>
</html>
