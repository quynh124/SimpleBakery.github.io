
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="description" content="Cake Template">
        <meta name="keywords" content="Cake, unica, creative, html">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Simple Bakery</title>


    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>
            <!-- Breadcrumb Begin -->
            <div class="breadcrumb-option">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-6 col-md-6 col-sm-6">
                            <div class="breadcrumb__text">
                                <h2>Product detail</h2>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6">
                            <div class="breadcrumb__links">
                                <a href="./index.htm">Home</a>
                                <a href="./shop.htm">Shop</a>
                                <span><c:out value="${product.productName}"/></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Breadcrumb End -->

        <!-- Shop Details Section Begin -->
        <section class="product-details spad">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6">
                        <div class="product__details__img">
                            <div class="product__details__big__img">
                                <img class="big_img" src="<c:out value="${product.image}"/>" alt="">
                            </div>

                        </div>
                    </div>

                    <div class="col-lg-6">
                        <form action="/SimpleBakeryWebsite/add-to-cart.htm" method="post">
                            <div class="product__details__text">
                                <input type="hidden" name="id" value="${item.id}">
                                <input type="hidden" name="productID" value="${product.productID}">
                                <input type="hidden" name="productName" value="${product.productName}">
                                <input type="hidden" name="size" value="${product.size}">
                                <input type="hidden" name="unitPrice" value="${product.unitPrice}">
                                <input type="hidden" name="image" value="${product.image}">
                                <input type="hidden" name="total" value="${item.total}">

                                <div class="product__label"><c:out value="${product.categoryName}"/></div>
                                <h4><c:out value="${product.productName}"/></h4>
                                <h5><c:out value="${product.unitPrice}"/>.000VNĐ</h5>
                                <p><c:out value="${product.decription}"/></p>
                                <ul>
                                    <li>Size: <span><c:out value="${product.size}"/> cm</span></li>
                                    <li>Category: <span><c:out value="${product.categoryName}"/></span></li>
                                    <li>Quantity: <span><c:out value="${product.quantity}"/> cake</span></li>
                                </ul>
                                <div class="product__details__option">
                                    <div class="quantity">
                                        <div class="pro-qty">
                                            <span class="dec qtybtn">-</span>
                                            <input type="text" name="quantityCart" value="1" />
                                            <span class="inc qtybtn">+</span>
                                        </div>
                                    </div>
                                    <button type="submit" class="primary-btn">Add to cart</button>
                                </div>
                        </form>
                    </div>

                </div>
                <div class="product__details__tab">
                    <div class="col-lg-12">
                        <ul class="nav nav-tabs" role="tablist">
                            <li class="nav-item">
                                <a class="nav-link active" data-toggle="tab" href="#tabs-1" role="tab">Description</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" data-toggle="tab" href="#tabs-2" role="tab">Additional information</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" data-toggle="tab" href="#tabs-3" role="tab">FAQs(1)</a>
                            </li>
                        </ul>
                        <div class="tab-content">
                            <div class="tab-pane active" id="tabs-1" role="tabpanel">
                                <div class="row d-flex justify-content-center">
                                    <div class="col-lg-8">
                                        <p><c:out value="${product.decription}"/></p>
                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane" id="tabs-2" role="tabpanel">
                                <div class="row d-flex justify-content-center">
                                    <div class="col-lg-8">
                                        <p>This delectable Strawberry Pie is an extraordinary treat filled with sweet and
                                            tasty chunks of delicious strawberries. Made with the freshest ingredients, one
                                            bite will send you to summertime. Each gift arrives in an elegant gift box and
                                            arrives with a greeting card of your choice that you can personalize online!2
                                        </p>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </section>


       <section class="related-products spad">
    <div class="container">
        <div class="row">
            <div class="col-lg-12 text-center">
                <div class="section-title">
                    <h2>Other Products</h2>
                </div>
            </div>
        </div>
        <div class="categories">
            <div class="row">
                <div class="categories__slider owl-carousel">
                    <c:forEach var="item" items="${listProduct}" varStatus="status">
                      <c:if test="${item.isDeleted == false}">
                            <div class="product__item">
                                <div class="product__item__pic set-bg">
                                    <img src="${item.image}" alt="${item.productName}" style="width: 250px; height: 270px;" />
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
                                        <c:out value="${item.unitPrice}"/>.000 VND
                                    </div>
                                    <div class="cart_add">
                                        <a href="/SimpleBakeryWebsite/shop-details.htm?id=${item.productID}">Show detail</a>
                                    </div>
                                </div>
                            </div>
                      </c:if>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</section>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                var qtyButtons = document.querySelectorAll('.qtybtn');

                qtyButtons.forEach(function (button) {
                    button.addEventListener('click', function () {
                        var input = this.parentElement.querySelector('input');
                        var currentValue = parseInt(input.value);

                        if (this.classList.contains('inc')) {
                            input.value = currentValue + 1;
                        } else if (this.classList.contains('dec')) {
                            if (currentValue > 1) {
                                input.value = currentValue - 1;
                            }
                        }
                    });
                });
            });

        </script>
  <script>
      $(document).ready(function () {
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

        <!-- Related Products Section End -->
        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>
