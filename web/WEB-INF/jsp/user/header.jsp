
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
    <head>
        <meta charset="UTF-8">
        <meta name="description" content="Cake Template">
        <meta name="keywords" content="Cake, unica, creative, html">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Cake | Template</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <!-- Google Font -->
        <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700;800;900&display=swap"
              rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700;800;900&display=swap"
        <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>

        <!-- jQuery UI -->
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>

        <!-- jQuery UI CSS -->
        <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
        <!-- Css Styles -->
        <link rel="stylesheet" href="<c:url value='./assets/css/bootstrap.min.css' />" type="text/css">
        <link rel="stylesheet" href="<c:url value='./assets/css/flaticon.css' />" type="text/css">
        <link rel="stylesheet" href="<c:url value='./assets/css/barfiller.css' />" type="text/css">
        <link rel="stylesheet" href="<c:url value='./assets/css/magnific-popup.css' />" type="text/css">
        <link rel="stylesheet" href="<c:url value='./assets/css/font-awesome.min.css' />" type="text/css">
        <link rel="stylesheet" href="<c:url value='./assets/css/elegant-icons.css' />" type="text/css">
        <link rel="stylesheet" href="<c:url value='./assets/css/nice-select.css' />" type="text/css">
        <link rel="stylesheet" href="<c:url value='./assets/css/owl.carousel.min.css' />" type="text/css">
        <link rel="stylesheet" href="<c:url value='./assets/css/slicknav.min.css' />" type="text/css">
        <link rel="stylesheet" href="<c:url value='./assets/css/style.css' />" type="text/css">
        <style>
            .search-container {
                position: relative;
                display: flex;
                align-items: center; /* Center items vertically */
                transition: width 0.4s ease; /* Smooth transition for width */
            }

            .search-input {
                width: 60px; /* Initial width */
                padding: 10px 40px 10px 40px; /* Add padding to the input */
                border: 1px solid #ccc; /* Border styling */
                border-radius: 20px; /* Rounded corners */
                outline: none; /* Remove outline */
                transition: width 0.4s ease; /* Smooth transition for width */
                font-size: 16px; /* Font size */
            }

            .search-container:hover .search-input {
                width: 250px; /* Expanded width on hover */
            }

            .record-icon {
                position: absolute;
                right: 20px; /* Position the microphone icon */
                cursor: pointer; /* Change cursor to pointer on hover */
                color: #888; /* Change color of the icon */
                font-size: 20px; /* Adjust icon size */
            }

            .search-icon {
                position: absolute;
                left: 10px; /* Position the search icon */
                color: #888; /* Color of the icon */
                font-size: 20px; /* Icon size */
            }

            .search-input::placeholder {
                color: transparent; /* Initially hide placeholder text */
                transition: color 0.4s ease; /* Transition for placeholder color */
            }

            .search-container:hover .search-input::placeholder {
                color: #aaa; /* Show darker color on hover */
            }

            .search-container:hover .search-input {
                color: #000; /* Change input text color on hover */
            }

        </style>

    </head>
    <body>
        <!-- Header Section Begin -->
        <header class="header">
            <div class="header__top">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="header__top__inner">
                                <div class="header__top__left">
                                    <ul>

                                        <li>Contact <span class="arrow_carrot-down"></span>
                                            <ul>
                                                <li>Phone: +123546574</li>
                                                <li>SimpleBakery@gmail.com</li>
                                            </ul>
                                        </li>
                                        <li>
                                            <c:choose>
                                                <c:when test="${not empty sessionScope.uname}">
                                                    <span>Welcome, ${sessionScope.uname}!</span>
                                                    <a href="${pageContext.request.contextPath}/logout.htm">Logout</a>  
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="${pageContext.request.contextPath}/login.htm">Sign in!</a>
                                                </c:otherwise>
                                            </c:choose>
                                        </li>
                                    </ul>
                                </div>
                                <div class="header__logo">
                                    <a href="./index.htm"><img src="./assets/img/logo.png" alt=""></a>
                                </div>
                                <div class="header__top__right">
                                    <div class="header__top__right__links">
                                        <p id="status"></p>
                                        <form id="search-form" action="/SimpleBakeryWebsite/search.htm" method="get" class="search-container">
                                            <i class="fas fa-search search-icon" onclick="submitSearch()"></i>


                                            <input type="text" id="searchQuery" name="search" placeholder="Search" class="search-input" 
                                                   list="productNames" onchange="this.form.submit()">


                                            <datalist id="productNames">
                                                <c:forEach var="product" items="${listProduct}">
                                                    <c:if test="${product.isDeleted == false}">
                                                        <option value="${product.productName}"></option>
                                                    </c:if>
                                                </c:forEach>
                                            </datalist>

                                            <i class="fas fa-microphone record-icon" id="start-record-btn" onclick="startRecording()"></i>
                                        </form>
                                    </div>

                                    <div class="header__top__right__cart">
                                        <a href="cart.htm">
                                            <img src="./assets/img/icon/cart.png" alt="">
                                            <span>${sessionScope.totalCount != null ? sessionScope.totalCount : 0}</span>
                                        </a>
                                        <div class="cart__price">Cart: <span>${sessionScope.totalPrice != null ? sessionScope.totalPrice : '0.00'}</span>VND</div>
                                    </div>
                                </div>


                            </div>
                        </div>
                    </div>
                </div>
                <div class="canvas__open"><i class="fa fa-bars"></i></div>
            </div>
        </div>


        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <nav class="header__menu mobile-menu">
                        <ul>
                            <li class="active"><a  href="index.htm">Home</a></li>
                            <li><a href="shop.htm">Shop</a></li>
                            <li><a  href="about.htm">About</a></li>
                            <li><a href="blog.htm">Blog</a></li>
                            <li><a href="viewfaq.htm">FAQs</a>  </li>
                            <li><a href="vouchers.htm">Vouchers</a>  </li>
                            <li><a href="order_tracking.htm">Order Tracking</a>  </li>
                            <li><a href="contact.htm">Contact</a></li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
    </header>
    <script>
        function submitSearch() {
            const query = document.getElementById("searchQuery").value;
            if (query.trim() !== "") {
                document.getElementById("search-form").submit(); 
            }
        }
        function startRecording() {
            const recognition = new (window.SpeechRecognition || window.webkitSpeechRecognition)();
            recognition.lang = 'en-US'; 
            recognition.onstart = function () {
                document.getElementById("status").textContent = "Listening...";
            };

            recognition.onspeechend = function () {
                recognition.stop();
                document.getElementById("status").textContent = "Stopped listening";
            };

            recognition.onresult = function (event) {
                let transcript = event.results[0][0].transcript;
                console.log("Raw Transcript:", transcript); 

                transcript = transcript.toUpperCase().trim(); 
                console.log("Processed Transcript:", transcript); 

                if (transcript.endsWith('.')) {
                    transcript = transcript.slice(0, -1); 
                }

                console.log("Final Transcript:", transcript); 

                document.getElementById("searchQuery").value = transcript;
                document.getElementById("search-form").submit(); 
            };

            recognition.start();
        }
    </script>
    <!-- Header Section End -->
    <script src="./assets/js/jquery-3.3.1.min.js"></script>
    <script src="./assets/js/bootstrap.min.js"></script>
    <script src="./assets/js/jquery.nice-select.min.js"></script>
    <script src="./assets/js/jquery.barfiller.js"></script>
    <script src="./assets/js/jquery.magnific-popup.min.js"></script>
    <script src="./assets/js/jquery.slicknav.js"></script>
    <script src="./assets/js/owl.carousel.min.js"></script>
    <script src="./assets/js/jquery.nicescroll.min.js"></script>
    <script src="./assets/js/main.js"></script>
</body>
</html>
