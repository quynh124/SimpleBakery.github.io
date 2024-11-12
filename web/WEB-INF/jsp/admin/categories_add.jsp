<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Add Categories</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">


        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
        <link rel="stylesheet" href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">


    </head>

    <body class="app sidebar-mini rtl">

        <!-- Navbar-->
        <header class="app-header">
            <!-- Sidebar toggle button--><a class="app-sidebar__toggle" href="categories_tb.htm" data-toggle="sidebar"
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
                        <li class="breadcrumb-item">List Categories</li>
                        <li class="breadcrumb-item"><a href="#">Add New Category</a></li>
                    </ul>
                </div>

                <div class="row">
                    <div class="col-md-12">
                        <div class="tile">
                            <h3 class="tile-title">Add new category</h3>
                            <div class="tile-body">
                            <c:if test="${not empty error_message}">
                                <div id="error-dialog" title="Error" style="color: red">
                                    <p>${error_message}</p>
                                </div>
                                <script>
                                    $(function () {
                                        $("#error-dialog").dialog({
                                            modal: true,
                                            buttons: {
                                                Ok: function () {
                                                    $(this).dialog("close");
                                                }
                                            }
                                        });
                                    });
                                </script>
                            </c:if>
                            <form:form class="row" action="categories_add.htm" modelAttribute="categoryForm" method="POST">


                                <div class="form-group col-md-4">
                                    <label class="control-label">Name</label>
                                    <form:input path="categoryName" id="categoryName" cssClass="form-control"/>
                                </div>

                                <div class="form-group col-md-4">
                                    <label class="control-label">Description</label>
                                    <form:input path="decription" cssClass="form-control"/>
                                </div>

                                <div class="tile-footer">
                                    <button class="btn btn-save" type="submit">Save</button>
                                    <a class="btn btn-cancel" href="categories_tb.htm">Cancel</a>
                                </div>
                            </form:form>
                        </div>
                    </div>
                </div>
        </main>


    </body>
</html>
