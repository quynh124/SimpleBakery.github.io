

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="author" content="lotfio lakehal">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
        <title>FORM | FORGOT</title>

        <!-- Bootstrap -->
        <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="css/animate.min.css">
        <link rel="stylesheet" type="text/css" href="css/my-login.css">

        <link rel="shortcut icon" href="img/logo.png"/>
        <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700;800;900&display=swap"
              rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700;800;900&display=swap"
              rel="stylesheet">

        <!-- Css Styles -->


        <link rel="stylesheet" href="<c:url value='/assets/css/bootstrap.min.css'/>" type="text/css">
        <link rel="stylesheet" href="<c:url value='./assets/flaticon.css' />" type="text/css">
        <link rel="stylesheet" href="<c:url value='./assets/css/barfiller.css" type="text/css' />">
        <link rel="stylesheet" href="<c:url value='./assets/css/magnific-popup.css" type="text/css' />">
        <link rel="stylesheet" href="<c:url value='./assets/css/font-awesome.min.css" type="text/css' />">
        <link rel="stylesheet" href="<c:url value='./assets/css/elegant-icons.css" type="text/css' />">
        <link rel="stylesheet" href="<c:url value='./assets/css/nice-select.css" type="text/css' />">
        <link rel="stylesheet" href="<c:url value='./assets/css/owl.carousel.min.css" type="text/css' />">
        <link rel="stylesheet" href="<c:url value='./assets/css/slicknav.min.css" type="text/css' />">
        <link rel="stylesheet" href="<c:url value='./assets/css/style.css" type="text/css' />">

        <!--  <style>
                .h-100 {
                    height: 100vh;
                }
                .card-wrapper {
                    max-width: 400px;
                    margin: auto;
                }
                .card {
                    margin-top: 50px;
                }
                .inf {
                    font-size: 0.9rem;
                    color: #6c757d;
                }
            </style>-->
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>

        <c:if test="${not empty error}">
            <div class="alert alert-danger text-center">
                ${error}
            </div>
        </c:if>

        <c:if test="${not empty message}">
            <div class="alert alert-success text-center">
                ${message}
            </div>
        </c:if>
        <div class="row justify-content-md-center align-items-center h-100">
            <div class="card-wrapper">
                <div class="card fat animated bounceIn">
                    <div class="card-body">
                        <h4 class="card-title">Forgot Password</h4>
                        <form method="POST" action="/SimpleBakeryWebsite/forgot.htm">
                            <div class="form-group">
                                <label for="email">Email</label>
                                <input id="email" type="email" class="form-control" name="email" required autofocus>
                            </div>
                            <div class="form-group">
                                <label for="newPassword">New Password</label>
                                <input id="newPassword" type="password" class="form-control" name="newPassword" required>
                            </div>
                            <div class="form-group no-margin">
                                <button type="submit" class="btn btn-primary btn-block">
                                    Reset Password
                                </button>
                            </div>
                            <div class="form-group mt-3 text-center">
                                <a href="register.htm">Create a new account</a>
                            </div>
                        </form>


                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="footer.jsp"></jsp:include>

    </body>
</html>
