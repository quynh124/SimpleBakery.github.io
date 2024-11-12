

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
        <title>FORM | REGISTER</title>

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
        <link rel="stylesheet" href="<c:url value='/assets/flaticon.css' />" type="text/css">
        <link rel="stylesheet" href="<c:url value='/assets/css/barfiller.css" type="text/css' />">
        <link rel="stylesheet" href="<c:url value='/assets/css/magnific-popup.css" type="text/css' />">
        <link rel="stylesheet" href="<c:url value='/assets/css/font-awesome.min.css" type="text/css' />">
        <link rel="stylesheet" href="<c:url value='/assets/css/elegant-icons.css" type="text/css' />">
        <link rel="stylesheet" href="<c:url value='/assets/css/nice-select.css" type="text/css' />">
        <link rel="stylesheet" href="<c:url value='/assets/css/owl.carousel.min.css" type="text/css' />">
        <link rel="stylesheet" href="<c:url value='/assets/css/slicknav.min.css" type="text/css' />">
        <link rel="stylesheet" href="<c:url value='/assets/css/style.css" type="text/css' />">


    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>

            <div class="row justify-content-md-center h-100">
                <div class="card-wrapper">
                    <!-- <div class="brand">
                            <img src="img/logo.png" id="logo" class="animated flipInX">
                    </div> -->
                    <div class="card fat animated bounceIn">
                        <div class="card-body">

                        <form:form action="register.htm" method="POST" modelAttribute="registerForm">

                            <div class="form-group">
                                <form:label path="fullname">Full Name</form:label>
                                <form:input path="fullname" cssClass="form-control" required="true"/>
                            </div>
                            <div class="form-group">
                                <form:label path="username">User Name</form:label>
                                <form:input path="username" cssClass="form-control" required="true"/>
                                <span class="error">
                                    <form:errors path="username" />
                                </span>
                            </div>
                            <div class="form-group">
                                <form:label path="password">Password</form:label>
                                <form:password path="password" cssClass="form-control" required="true"/>
                            </div>

                            <div class="form-group">
                                <form:label path="email">E-Mail Address</form:label>
                                <form:input path="email" cssClass="form-control" type="email" required="true"/>
                            </div>
                            <div class="form-group">
                                <form:label path="phone">Phone</form:label>
                                <form:input path="phone" cssClass="form-control" type="phone" required="true"/>
                            </div>
                            <div class="form-group">
                                <form:label path="address">Address</form:label>
                                <form:input path="address" cssClass="form-control" required="true"/>
                            </div>

                            <div class="form-group">
                                <label class="chek">
                                    <input type="checkbox" name="remember" required> I agree to the Terms and Conditions
                                    <span class="checkmark"></span>
                                </label>
                            </div>
                            <div class="form-group no-margin">
                                <form:button type="submit" class="btn btn-primary btn-block">Register</form:button>
                                </div>
                                <div class="margin-top20 text-center">
                                    <span class="inf">Already have an account?</span> <a href="login.htm">Login</a>
                                </div>
                        </form:form>

                        </body>
                        </html>
                    </div>
                </div>


            </div>
        </div>
        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>
