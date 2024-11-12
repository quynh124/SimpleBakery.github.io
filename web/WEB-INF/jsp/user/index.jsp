<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="description" content="Cake Template">
        <meta name="keywords" content="Cake, unica, creative, html">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Cake | Template</title>
        <style>
            /* Basic styling for the section */
            .team {
                padding: 50px 0;
            }

            .team .section-title {
                text-align: center;
                margin-bottom: 40px;
            }

            .team .section-title span {
                display: block;
                font-size: 16px;
                color: #f39c12;
            }

            .team .section-title h2 {
                font-size: 36px;
                font-weight: 700;
                color: #333;
            }

            /* Flexbox layout for centering images */
            .team .row {
                display: flex;
                justify-content: center;
                gap: 20px; /* Adjust spacing between items as needed */
            }

            .team .col-lg-3,
            .team .col-md-6,
            .team .col-sm-6 {
                display: flex;
                justify-content: center;
            }

            /* Styling for the team items */
            .team__item {
                position: relative;
                overflow: hidden;
                background-color: #f8f8f8;
                border-radius: 10px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                width: 100%; /* Make sure items take full width of their column */
                max-width: 300px; /* Adjust the max-width to your preference */
            }

            .team__item img {
                width: 100%;
                height: auto;
                display: block;
                border-bottom: 2px solid #ddd;
            }

            .team__item__text {
                padding: 20px;
                text-align: center;
            }

            .team__item__text h6 {
                font-size: 18px;
                font-weight: 600;
                margin-bottom: 10px;
                color: #333;
            }

            .team__item__text span {
                display: block;
                font-size: 14px;
                color: #777;
                margin-bottom: 20px;
            }

            .team__item__social a {
                margin: 0 5px;
                font-size: 20px;
                color: #333;
            }


        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>

            <section class="hero">
                <div class="hero__slider owl-carousel">
                    <div class="hero__item set-bg" data-setbg="./assets/img/hero/hero-1.jpg">
                        <div class="container">
                            <div class="row d-flex justify-content-center">
                                <div class="col-lg-8">
                                    <div class="hero__text">
                                        <h2>Making your life sweeter one bite at a time!</h2>
                                        <a href="#" class="primary-btn">Our cakes</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="hero__item set-bg" data-setbg="./assets/img/hero/hero-1.jpg">
                        <div class="container">
                            <div class="row d-flex justify-content-center">
                                <div class="col-lg-8">
                                    <div class="hero__text">
                                        <h2>Making your life sweeter one bite at a time!</h2>


                                    <a href="#" class="primary-btn">Our cakes</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Hero Section End -->

        <!-- About Section Begin -->
        <section class="about spad">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6 col-md-6">
                        <div class="about__text">
                            <div class="section-title">
                                <span>About Cake shop</span>
                                <h2>Cakes and bakes from the house of Queens!</h2>
                            </div>
                            <p>The "Cake Shop" is a Jordanian Brand that started as a small family business. The owners are
                                Dr. Iyad Sultan and Dr. Sereen Sharabati, supported by a staff of 80 employees.</p>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-6">
                        <div class="about__bar">
                            <div class="about__bar__item">
                                <p>Cake design</p>
                                <div id="bar1" class="barfiller">
                                    <div class="tipWrap"><span class="tip"></span></div>
                                    <span class="fill" data-percentage="95"></span>
                                </div>
                            </div>
                            <div class="about__bar__item">
                                <p>Cake Class</p>
                                <div id="bar2" class="barfiller">
                                    <div class="tipWrap"><span class="tip"></span></div>
                                    <span class="fill" data-percentage="80"></span>
                                </div>
                            </div>
                            <div class="about__bar__item">
                                <p>Cake Recipes</p>
                                <div id="bar3" class="barfiller">
                                    <div class="tipWrap"><span class="tip"></span></div>
                                    <span class="fill" data-percentage="90"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- About Section End -->

        <!-- Categories Section Begin -->
        <div class="categories">
            <div class="container">
                <div class="row">
                    <div class="categories__slider owl-carousel">
                        <c:forEach var="category" items="${listCategory}">
                              <c:if test="${category.isDeleted == false}"> 
                            <div class="categories__item">
                                <div class="categories__item__icon">
                                    <span class="flaticon-034-chocolate-roll"></span> 
                                    <h5><c:out value="${category.categoryName}"/></h5>
                                </div>
                            </div>
                              </c:if>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
       <section class="product spad">
    <div class="container">
        <div class="row">
            <c:forEach var="item" items="${listProduct}">
                <c:if test="${item.isDeleted == false}">
                    <div class="col-lg-3 col-md-6 col-sm-6">
                        <div class="product__item">
                            <div class="product__item__pic set-bg">
                                <img src="${item.image}" style="width: 250px;height: 300px" />
                                <div class="product__label">
                                    <c:forEach var="category" items="${listCategory}">
                                        <c:if test="${category.categoryID == item.categoryID}">
                                            <span>${category.categoryName}</span>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </div>
                            <div class="product__item__text">
                                <h6>
                                    <a href="/SimpleBakeryWebsite/shop-details.htm?id=${item.productID}">
                                        <c:out value="${item.productName}"/>
                                    </a>
                                </h6>
                                <div class="product__item__price">
                                    <c:out value="${item.unitPrice}"/>.000VND
                                </div>
                                <div class="cart_add">
                                    <a href="/SimpleBakeryWebsite/shop-details.htm?id=${item.productID}">Show detail</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
        </div>
    </div>
</section>

 
        <section class="team spad">
            <div class="container">
                <div class="row">
                    <div class="col-lg-7 col-md-7 col-sm-7">
                        <div class="section-title">
                            <span>Our team</span>
                            <h2>Sweet Baker </h2>
                        </div>
                    </div>

                </div>
                <div class="row">
                    <div class="col-lg-3 col-md-6 col-sm-6">
                        <div class="team__item set-bg" >
                            <img src="./assets/img/team/team-1.jpg" />
                            <div class="team__item__text">
                                <h6>Randy Butler</h6>
                                <span>Decorater</span>
                                <div class="team__item__social">
                                    <a href="#"><i class="fa fa-facebook"></i></a>
                                    <a href="#"><i class="fa fa-twitter"></i></a>
                                    <a href="#"><i class="fa fa-instagram"></i></a>
                                    <a href="#"><i class="fa fa-youtube-play"></i></a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 col-sm-6">
                        <div class="team__item set-bg" >
                            <img src="./assets/img/team/team-2.jpg" />
                            <div class="team__item__text">
                                <h6>Randy Butler</h6>
                                <span>Decorater</span>
                                <div class="team__item__social">
                                    <a href="#"><i class="fa fa-facebook"></i></a>
                                    <a href="#"><i class="fa fa-twitter"></i></a>
                                    <a href="#"><i class="fa fa-instagram"></i></a>
                                    <a href="#"><i class="fa fa-youtube-play"></i></a>
                                </div>
                            </div>
                        </div>
                    </div>


                </div>
            </div>
        </section>
        <!-- Team Section End -->


        <!-- Instagram Section Begin -->
        <section class="instagram spad">
            <div class="container">
                <div class="row">
                    <div class="col-lg-4 p-0">
                        <div class="instagram__text">
                            <div class="section-title">
                                <span>Follow us on instagram</span>
                                <h2>Sweet moments are saved as memories.</h2>
                            </div>
                            <h5><i class="fa fa-instagram"></i> @sweetcake</h5>
                        </div>
                    </div>
                    <div class="col-lg-8">
                        <div class="row">
                            <div class="col-lg-4 col-md-4 col-sm-4 col-6">
                                <div class="instagram__pic">
                                    <img src="./assets/img/instagram/instagram-1.jpg" alt="">
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-6">
                                <div class="instagram__pic middle__pic">
                                    <img src="./assets/img/instagram/instagram-2.jpg" alt="">
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-6">
                                <div class="instagram__pic">
                                    <img src="./assets/img/instagram/instagram-3.jpg" alt="">
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-6">
                                <div class="instagram__pic">
                                    <img src="./assets/img/instagram/instagram-4.jpg" alt="">
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-6">
                                <div class="instagram__pic middle__pic">
                                    <img src="./assets/img/instagram/instagram-5.jpg" alt="">
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-6">
                                <div class="instagram__pic">
                                    <img src="./assets/img/instagram/instagram-3.jpg" alt="">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Instagram Section End -->


        <!-- Map Begin -->
        <div class="map">
            <div class="container">
                <div class="row">
                    <div class="col-lg-4 col-md-7">
                        <div class="map__inner">
                           <h6>SimpleBakery</h6>
                                <ul>
                                    <li>1Đ. Ly Tu Trong, An Phu, Ninh Kieu, Can Tho</li>
                                    <li>SimpleBakery@support.com</li>
                                    <li>02923731072</li>
                                </ul>
                        </div>
                    </div>
                </div>
            </div>
   
            <div class="map__iframe">
                    <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d245.54978220520977!2d105.77941048890345!3d10.033643724782094!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31a0881f9a732075%3A0xfa43fbeb2b00ca73!2sCUSC%20-%20Cantho%20University%20Software%20Center!5e0!3m2!1svi!2s!4v1721998064297!5m2!1svi!2s" height="300" style="border:0;" al</iframe>" height="300" stylelowfullscreen="" aria-hidden="false" tabindex="0"></iframe>
                </div>
        </div>
        <script>
            $(document).ready(function () {
                $('#bar1').barfiller();
                $('#bar2').barfiller();
                $('#bar3').barfiller();
            });
        </script>
        <script>$(document).ready(function () {
                // Khởi tạo Owl Carousel
                $('.categories__slider').owlCarousel({
                    loop: true, // Vòng lặp
                    margin: 10, // Khoảng cách giữa các item
                    nav: true, // Hiển thị nút điều hướng
                    responsive: {
                        0: {
                            items: 1 // Hiển thị 1 item trên màn hình nhỏ
                        },
                        600: {
                            items: 3 // Hiển thị 3 item trên màn hình vừa
                        },
                        1000: {
                            items: 5 // Hiển thị 5 item trên màn hình lớn
                        }
                    }
                });
            });
        </script>
        <script>
            $(document).ready(function () {
                // Khởi tạo Owl Carousel
                $('.hero__slider').owlCarousel({
                    loop: true, // Cho phép vòng lặp
                    margin: 10, // Khoảng cách giữa các item
                    nav: true, // Hiển thị nút điều hướng
                    items: 1, // Hiển thị một item tại một thời điểm
                    autoplay: true, // Tự động phát slideshow
                    autoplayTimeout: 5000, // Thời gian mỗi slide
                    autoplayHoverPause: true, // Tạm dừng khi di chuột vào slide
                    dots: true, // Hiển thị dấu chấm
                    responsive: {
                        0: {
                            items: 1 // Hiển thị một item trên màn hình nhỏ
                        },
                        600: {
                            items: 1 // Hiển thị một item trên màn hình vừa
                        },
                        1000: {
                            items: 1 // Hiển thị một item trên màn hình lớn
                        }
                    }
                });

                // Nếu bạn cần xử lý phần nền cho các slide
                $('.hero__item').each(function () {
                    var imgSrc = $(this).data('setbg');
                    $(this).css('background-image', 'url(' + imgSrc + ')');
                });
            });

        </script>

        <!-- Map End -->
        <jsp:include page="footer.jsp"></jsp:include>

    </body>
</html>
