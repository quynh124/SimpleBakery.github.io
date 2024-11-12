<%-- 
    Document   : login
    Created on : Jul 13, 2024, 10:37:30 PM
    Author     : Hp
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="author" content="lotfio lakehal">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
        <title>FORM | LOGIN</title>

        <!-- Bootstrap -->
        <link rel="stylesheet" type="text/css" href="<c:url value='css/bootstrap.min.css'/>">
        <link rel="stylesheet" type="text/css" href="<c:url value='css/animate.min.css'/>">
        <link rel="stylesheet" type="text/css" href="<c:url value='css/my-login.css'/>">

        <link rel="shortcut icon" href="./assets/img/logo.png"/>
        <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700;800;900&display=swap"
              rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700;800;900&display=swap"
              rel="stylesheet">

        <!-- Css Styles -->


        <link rel="stylesheet" href="<c:url value='./assets/css/bootstrap.min.css'/>" type="text/css">
        <link rel="stylesheet" href="<c:url value='./assets/flaticon.css' />" type="text/css">
        <link rel="stylesheet" href="<c:url value='./assets/css/barfiller.css" type="text/css' />">
        <link rel="stylesheet" href="<c:url value='./assets/css/magnific-popup.css" type="text/css' />">
        <link rel="stylesheet" href="<c:url value='./assets/css/font-awesome.min.css" type="text/css' />">
        <link rel="stylesheet" href="<c:url value='./assets/css/elegant-icons.css" type="text/css' />">
        <link rel="stylesheet" href="<c:url value='./assets/css/nice-select.css" type="text/css' />">
        <link rel="stylesheet" href="<c:url value='./assets/css/owl.carousel.min.css" type="text/css' />">
        <link rel="stylesheet" href="<c:url value='./assets/css/slicknav.min.css" type="text/css' />">
        <link rel="stylesheet" href="<c:url value='./assets/css/style.css" type="text/css' />">


    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>

            <!-- Show error message if login fails -->
        <c:if test="${not empty loginError}">
            <div class="alert alert-danger text-center">
                Invalid username or password
            </div>
        </c:if>
        <c:if test="${not empty logoutMessage}">
            <div class="alert alert-success">${logoutMessage}</div>
        </c:if>

        <div class="row justify-content-md-center h-100">
            <div class="card-wrapper">
                <div class="card fat animated bounceIn">
                    <div class="card-body">
                        <!-- Login form -->
                        <form:form action="login_checkout.htm" modelAttribute="loginUserForm" method="POST">

                            <div class="form-group">
                                <label for="username">User Name</label>
                                <form:input path="username" class="form-control" id="username" />
                            </div>

                            <div class="form-group">
                                <label for="password">Password
                                    <a href="forgot.htm" class="float-right">Forgot Password?</a>
                                </label>
                                <form:password path="password" class="form-control" id="password" />
                                <div>
                                    <img src="${pageContext.request.contextPath}/captcha-image" alt="Captcha Image">
                                </div>
                                <form:input path="captcha" class="form-control" id="captcha" required="required" placeholder="Enter Captcha" />
                            </div>
                            <div class="form-group">
                                <label class="chek">
                                    <input type="checkbox" name="remember"> Remember Me
                                    <span class="checkmark"></span>
                                </label>
                            </div>

                            <div class="form-group no-margin">
                                <button type="submit" class="btn btn-primary btn-block">LOGIN</button>
                            </div>

                            <div class="margin-top20 text-center">
                                <span class="inf">Don't have an account?</span> <a href="register.htm">Create One</a>
                            </div>

                        </form:form>
                        
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>
