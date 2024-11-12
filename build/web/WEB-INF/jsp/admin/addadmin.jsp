

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
    <head>
  <title>Add Admin</title>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- Main CSS-->
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/main.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">
  <!-- or -->
  <link rel="stylesheet" href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">
  <!-- Font-icon css-->
  <link rel="stylesheet" type="text/css"
    href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
  <script src="http://code.jquery.com/jquery.min.js" type="text/javascript"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css">
  
    </head>
    <body class="app sidebar-mini rtl">
  
  <!-- Navbar-->
  <header class="app-header">
    <!-- Sidebar toggle button--><a class="app-sidebar__toggle" href="#" data-toggle="sidebar"
      aria-label="Hide Sidebar"></a>
    <!-- Navbar Right Menu-->
    <ul class="app-nav">


      <!-- Admin Menu-->
      <li><a class="app-nav__item" href="/index.html"><i class='bx bx-log-out bx-rotate-180'></i> </a>

      </li>
    </ul>
  </header>
        <jsp:include page="siderbarmenu.jsp"></jsp:include>
    <main class="app-content">
    <div class="app-title">
      <ul class="app-breadcrumb breadcrumb">
        <li class="breadcrumb-item">Manage Admin</li>
        <li class="breadcrumb-item"><a href="#">Add Admin</a></li>
      </ul>
    </div>
    <div class="row">
      <div class="col-md-12">

        <div class="tile">

            <h3 class="tile-title">Add Admin</h3>
          <div class="tile-body">
            <div class="row element-button">
              <div class="col-sm-2">
                <a class="btn btn-add btn-sm" data-toggle="modal" data-target="#exampleModalCenter"><b><i
                      class="fas fa-folder-plus"></i>Add Admin </b></a>
              </div>

            </div>
            <form:form action="${pageContext.request.contextPath}/addadmin.htm" modelAttribute="adminForm" method="POST">
    <table border="0">
        <thead>
            <tr>
                <th colspan="3">Admin Registration Form</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td><label class="control-label">Admin ID</label></td>
                <td><form:input class="form-control" path="adminID" readonly="true" /></td>
            </tr>
            
            <tr>
                <td><label class="control-label">Username</label></td>
                <td><form:input class="form-control" path="username" /></td>
            </tr>
            
            <tr>
                <td><label class="control-label">Password</label></td>
                <td><form:password class="form-control" path="password" /></td>
            </tr>

            <tr>
                <td>
                    <form:button class="btn btn-save" type="submit">Submit</form:button>
                    <a class="btn btn-cancel" href="${pageContext.request.contextPath}/formadmin.htm">Cancel</a>
                </td>
            </tr>
        </tbody>
    </table>
</form:form>
           
          </div>

        </div>

  </main>


  
  <!-- Essential javascripts for application to work-->
  <script src="js/jquery-3.2.1.min.js"></script>
  <script src="js/popper.min.js"></script>
  <script src="js/bootstrap.min.js"></script>
  <script src="js/main.js"></script>
  <!-- The javascript plugin to display page loading on top-->
  <script src="js/plugins/pace.min.js"></script>

</body>
</html>
