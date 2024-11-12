

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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">


    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>
            <!-- Breadcrumb Begin -->
            <div class="breadcrumb-option">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-6 col-md-6 col-sm-6">
                            <div class="breadcrumb__text">
                                <h2>Shopping cart</h2>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6">
                            <div class="breadcrumb__links">
                                <a href="./index.html">Home</a>
                                <span>Shopping cart</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Breadcrumb End -->

            <!-- Shopping Cart Section Begin -->
            <section class="shopping-cart spad">

                <div class="container">

                    <div class="row">

                        <div class="col-lg-8">

                            <div class="shopping__cart__table">
                                <table>
                                    <thead>
                                        <tr>
                                            <th>Product Name</th>
                                            <th>Size</th>
                                            <th>Quantity</th>
                                            <th>Total</th>
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="item" items="${cart}">
                                        <tr>
                                            <td class="product__cart__item">
                                                <div class="product__cart__item__pic" style="width: 100px; height: 100px; overflow: hidden; display: flex; align-items: center; justify-content: center;">
                                                    <img src="${item.image}" style="width: 100%; height: 100%; object-fit: cover;">
                                                </div>
                                                <div class="product__cart__item__text">
                                                    <h6>${item.productName}</h6>
                                                    <h5>${item.unitPrice}.000VND</h5>
                                                </div>
                                            </td>

                                            <td class="cart__price">${item.size} cm</td>
                                            <td class="quantity__item">
                                                <div class="quantity">
                                                    <div class="pro-qty">
                                                        <!--<span class="dec qtybtn">-</span>-->
                                                        <input type="text" value="${item.quantityCart}"><i class="fa-solid fa-cake-candles fa-lg" style="color: #ffc800;"></i>
                                                        <!--<span class="inc qtybtn">+</span>-->
                                                    </div>
                                                </div>
                                            </td>
                                            <td class="cart__price">${item.total}.000VND</td>
                                            <td class="cart__price">
                                                <form action="/SimpleBakeryWebsite/remove.htm" method="post">
                                                    <input type="hidden" name="productID" value="${item.productID}">
                                                    <input type="hidden" name="size" value="${item.size}">
                                                    <button type="submit" style="border: none; background: none; cursor: pointer;">
                                                        <i class="fas fa-trash-can" style="color: red; font-size: 24px;"></i>
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach> 
                                </tbody>
                            </table>
                        </div>
                        <div class="row">
                            <div class="col-lg-6 col-md-6 col-sm-6">
                                <div class="continue__btn">
                                    <a href="shop.htm">Continue Shopping</a>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6">
                                <div class="continue__btn update__btn">
                                    <a href="#" onclick="clearCart(); return false;">
                                        <i class="fa fa-spinner"></i> Clear cart
                                    </a>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="col-lg-4">
                      
                        <div class="cart__total">
                            <h6>Cart total</h6>
                            <ul>
                                <!-- Use a c:forEach loop to calculate subtotal and total -->
                                <c:set var="subtotal" value="0" scope="page"/>
                                <c:forEach var="item" items="${cart}">
                                    <c:set var="subtotal" value="${subtotal + item.total}" scope="page"/>
                                </c:forEach>
                                <li>Subtotal <span>${subtotal}.000VND</span></li>
                                <li>Total <span>${subtotal}.000VND</span></li>
                            </ul>
                            <a href="checkout.htm" class="primary-btn">Proceed to checkout</a>
                        </div>
                    </div>

                </div>

            </div>

        </section>
        <script>
            function clearCart() {
                fetch('/SimpleBakeryWebsite/clear-cart.htm', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                })
                        .then(response => {
                            if (response.ok) {
                                window.location.reload(); // Tải lại trang để cập nhật giỏ hàng
                            } else {
                                console.error('Failed to clear cart:', response.statusText);
                            }
                        })
                        .catch(error => console.error('Error:', error));
            }
        </script>
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



        <!-- Shopping Cart Section End -->
        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>
