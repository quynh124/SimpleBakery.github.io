<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Add Product</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
            function readURL(input) {
                if (input.files && input.files[0]) { // Sử dụng cho Firefox và Chrome
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $("#thumbimage").attr('src', e.target.result).show();
                    }
                    reader.readAsDataURL(input.files[0]);
                } else { // Sử dụng cho IE
                    $("#thumbimage").attr('src', input.value).show();
                }

                $('.filename').text(input.files[0].name); // Hiển thị tên file đã chọn
                $('.Choicefile').css('background', '#14142B').css('cursor', 'default');
                $(".removeimg").show();
                $(".Choicefile").off('click'); // Ngừng bám sự kiện để tránh hành động không mong muốn
            }

            $(document).ready(function () {
                $(".Choicefile").on('click', function () {
                    $("#uploadfile").click();
                });

                $(".removeimg").on('click', function () {
                    $("#thumbimage").attr('src', '').hide(); // Ẩn hình ảnh
                    $("#uploadfile").val(''); // Xóa giá trị của input file
                    $('.filename').text(''); // Xóa tên file hiển thị
                    $(".removeimg").hide();
                    $(".Choicefile").css('background', '#14142B').css('cursor', 'pointer');
                    $(".Choicefile").on('click', function () {
                        $("#uploadfile").click();
                    });
                });

                $("#uploadfile").on('change', function () {
                    readURL(this); // Gọi hàm readURL khi chọn file
                });
            });

        </script>
    </head>

    <body class="app sidebar-mini rtl">
        <style>
            .Choicefile {
                display: block;
                background: #14142B;
                border: 1px solid #fff;
                color: #fff;
                width: 150px;
                text-align: center;
                text-decoration: none;
                cursor: pointer;
                padding: 5px 0px;
                border-radius: 5px;
                font-weight: 500;
                align-items: center;
                justify-content: center;
            }

            .Choicefile:hover {
                text-decoration: none;
                color: white;
            }

            #uploadfile,
            .removeimg {
                display: none;
            }

            #thumbbox {
                position: relative;
                width: 100%;
                margin-bottom: 20px;
            }

            .removeimg {
                height: 25px;
                position: absolute;
                background-repeat: no-repeat;
                top: 5px;
                left: 5px;
                background-size: 25px;
                width: 25px;
                /* border: 3px solid red; */
                border-radius: 50%;

            }

            .removeimg::before {
                -webkit-box-sizing: border-box;
                box-sizing: border-box;
                content: '';
                border: 1px solid red;
                background: red;
                text-align: center;
                display: block;
                margin-top: 11px;
                transform: rotate(45deg);
            }

            .removeimg::after {
                /* color: #FFF; */
                /* background-color: #DC403B; */
                content: '';
                background: red;
                border: 1px solid red;
                text-align: center;
                display: block;
                transform: rotate(-45deg);
                margin-top: -2px;
            }
        </style>
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
                    <ul class="app-breadcrumb breadcrumb">
                        <li class="breadcrumb-item">List Products</li>
                        <li class="breadcrumb-item"><a href="#">Add new product</a></li>
                    </ul>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="tile">
                            <h3 class="tile-title">Add new product</h3>

                        <form:form class="row" enctype="multipart/form-data" action="/SimpleBakeryWebsite/products_add.htm" modelAttribute="productForm" method="POST" >
                            <div class="tile-body">
                                <div class="row">


                                    <form:input path="productID" type="hidden" />

                                    <div class="form-group col-md-3">
                                        <label class="control-label">Product Name</label>
                                        <form:input cssClass="form-control" path="productName"/>
                                    </div>
                                    <div class="form-group col-md-3">
                                        <label class="control-label">Quantity</label>
                                        <form:input cssClass="form-control" path="quantity"/>
                                    </div>


                                    <form:input path="createDate" type="hidden" />


                                    <div class="form-group col-md-3">
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


                                    <div class="form-group col-md-3">
                                        <label class="control-label">Unit Price</label>
                                        <form:input cssClass="form-control" path="unitPrice"/>
                                    </div>

                                    <div class="form-group col-md-3">
                                        <label class="control-label">Size</label>
                                        <select name="size" class="form-control" required="true" id="status">
                                            <option value="15">15cm</option>
                                            <option value="20">20cm</option>
                                            <option value="25">25cm</option>
                                        </select>
                                    </div>
                                    <div>
                                        <form:label path="image">Image:</form:label>
                                        <form:input type="file" path="image" id="image" name="image" accept="image/*"/>
                                    </div>

                                    <div class="form-group col-md-12">
                                        <label class="control-label">Description</label>
                                        <form:textarea cssClass="form-control" path="decription" id="decription"/>

                                    </div>
                                </div>

                                <div class="tile-footer">

                                    <button class="btn btn-save" type="submit">Save</button>
                                    <a class="btn btn-cancel" href="products_tb.htm">Cancel</a>
                                </div>
                            </div>
                        </form:form>

                        </main>
                        </body>
                        </html>
