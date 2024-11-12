<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
        <style>

            .checkout__input {
                margin-bottom: 20px;
                display: flex;
                flex-direction: column;
            }

            .checkout__input p {
                font-size: 16px;
                margin-bottom: 5px;
            }

            .checkout__input__add {
                width: 100%;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
                font-size: 16px;
                background-color: #fff;
                box-sizing: border-box;
            }

            .checkout__input__add:focus {
                border-color: #007bff;
                outline: none;
                box-shadow: 0 0 0 0.2rem rgba(38, 143, 255, 0.25);
            }

            .checkout__input__add option {
                padding: 10px;
            }
            .checkout__input__checkbox {
                margin-bottom: 15px;
            }

            .checkout__input__checkbox label {
                display: flex;
                align-items: center;
                cursor: pointer;
                position: relative;
                padding-left: 25px;
                margin-bottom: 10px;
                font-size: 16px;
                user-select: none;
            }

            .checkout__input__checkbox input {
                position: absolute;
                opacity: 0;
                cursor: pointer;
            }

            .checkout__input__checkbox .checkmark {
                position: absolute;
                top: 0;
                left: 0;
                height: 20px;
                width: 20px;
                background-color: white;
                border: 1px solid #ccc;
                border-radius: 4px;
            }

            .checkout__input__checkbox input:checked ~ .checkmark {
                background-color: white;
                border-color: #2196F3;
            }

            .checkout__input__checkbox .checkmark:after {
                content: "";
                position: absolute;
                display: none;
            }

            .checkout__input__checkbox input:checked ~ .checkmark:after {
                display: block;
            }

            .checkout__input__checkbox .checkmark:after {
                left: 7px;
                top: 4px;
                width: 5px;
                height: 10px;
                border: solid white;
                border-width: 0 2px 2px 0;
                transform: rotate(45deg);
            }

        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>
            <!-- Breadcrumb Begin -->
            <div class="breadcrumb-option">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-6 col-md-6 col-sm-6">
                            <div class="breadcrumb__text">
                                <h2>Checkout</h2>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6">
                            <div class="breadcrumb__links">
                                <a href="./index.html">Home</a>
                                <span>Checkout</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Breadcrumb End -->
            <section class="checkout spad">
                <div class="container">
                    <div class="checkout__form">
                        <form action="/SimpleBakeryWebsite/submitOrder.htm" method="post">
                            <div class="row">
                                <div class="col-lg-8 col-md-6">
                                    <h6 class="coupon__code"> <c:choose>
                                        <c:when test="${not empty sessionScope.uname}">
                                            <span>Welcome, ${sessionScope.uname}!</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span>
                                                Have an account? <a href="loginCheckout.htm">Click here</a> to log in
                                            </span>
                                        </c:otherwise>
                                    </c:choose></h6>
                                <h6 class="checkout__title">Billing Details</h6>
                                <div class="row">
                                    <div class="col-lg-6">
                                        <div class="checkout__input">
                                            <p>Phone<span>*</span></p>
                                            <input type="text" name="phone" required>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="checkout__input">
                                            <p>Your Name<span>*</span></p>
                                            <input type="text" name="yourName" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="checkout__input">
                                    <p>Address<span>*</span></p>
                                    <input type="text" name="shipAddress" placeholder="Street Address" class="checkout__input__add" required>
                                </div>


                                <div class="checkout__input">
                                    <p>Delivery <span>*</span></p>
                                    <select name="delivery" id="deliverySelect" class="checkout__input__add" required>
                                        <c:forEach var="delivery" items="${deliveries}">
                                            <option value="${delivery.deliveryID}" data-cost="${delivery.price}">
                                                ${delivery.deliveryName} - ${delivery.price}.000 VND
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="checkout__input">
                                    <p>Voucher  <span>*</span></p>
                                    <select name="voucher" id="voucherSelect" class="checkout__input__add" required>
                                        <c:forEach var="voucher" items="${vouchers}">
                                            <option value="${voucher.voucherID}" data-cost="${voucher.discountAmount}">
                                                ${voucher.voucherCode} - ${voucher.discountAmount}.000 VND
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="checkout__input">
                                    <p>Order notes<span>*</span></p>
                                    <input type="text" name="note" placeholder="Notes about your order, e.g., special notes for delivery.">
                                </div>

                            </div>
                            <div class="col-lg-4 col-md-6">
                                <div class="checkout__order">
                                    <h6 class="order__title">Your order</h6>
                                    <div class="checkout__order__products">Product <span>Total</span></div>
                                    <ul class="checkout__total__products">
                                        <!-- Dynamically populated products -->
                                        <c:forEach var="item" items="${cart}">
                                            <li>
                                                <samp>${item.quantityCart}</samp> ${item.productName}
                                                <span>${item.unitPrice}.000VND</span>
                                                <!-- Use a unique name for each product's hidden input -->
                                                <input type="hidden" name="productIDs" value="${item.productID}">
                                                <input type="hidden" name="quantities" value="${item.quantityCart}">
                                            </li>
                                        </c:forEach>
                                    </ul>
                                    <ul class="checkout__total__all">
                                        <li>Subtotal: <span id="subtotal">${subtotal}.000 VND</span></li>
                                        <li>Delivery Cost: <span id="deliveryCost">${deliveryCost}.000 VND</span></li>
                                        <li>Voucher Discount: <span id="voucherDiscount">${voucherDiscount}.000 VND</span></li>
                                        <li>Total: <span id="totalPrice">${totalPrice}.000 VND</span></li> <!-- Correctly display totalPrice here -->
                                    </ul>
                                    <p></p>
                                    <div class="checkout__input__checkbox">
                                        <p>Payment Method <span>*</span></p>
                                        <c:forEach var="payment" items="${payments}">
                                            <label for="payment${payment.paymentID}">
                                                <input type="radio" id="payment${payment.paymentID}" name="paymentMethod" value="${payment.paymentID}" required>
                                                <span class="checkmark"></span>
                                                ${payment.paymentName}
                                            </label>
                                        </c:forEach>
                                    </div>

                                    <button type="submit" class="site-btn">PLACE ORDER</button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </section>


        <!-- Checkout Section End -->
        <jsp:include page="footer.jsp"></jsp:include>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const deliverySelect = document.getElementById('deliverySelect');
                const voucherSelect = document.getElementById('voucherSelect'); // Voucher select element
                const subtotalElem = document.getElementById('subtotal');
                const deliveryCostElem = document.getElementById('deliveryCost');
                const voucherDiscountElem = document.getElementById('voucherDiscount'); // Voucher discount element
                const totalElem = document.getElementById('totalPrice');

                function updateTotal() {
                    // Get the selected delivery option
                    const selectedDelivery = deliverySelect.options[deliverySelect.selectedIndex];
                    const deliveryCost = parseFloat(selectedDelivery.getAttribute('data-cost')) || 0; // Default to 0 if undefined

                    // Get the selected voucher option
                    const selectedVoucher = voucherSelect.options[voucherSelect.selectedIndex];
                    const voucherDiscount = parseFloat(selectedVoucher.getAttribute('data-cost')) || 0; // Default to 0 if undefined

                    // Get the subtotal and parse it to a number
                    const subtotalText = subtotalElem.innerText.replace('.000 VND', '').replace(',', '');
                    const subtotal = parseFloat(subtotalText) || 0; // Default to 0 if NaN

                    // Calculate the new total
                    const totalPrice = subtotal + deliveryCost - voucherDiscount;

                    // Update the DOM with the new values
                    deliveryCostElem.innerText = deliveryCost + '.000 VND'; // Ensure 3 decimal places
                    voucherDiscountElem.innerText = voucherDiscount + '.000 VND'; // Ensure 3 decimal places
                    totalElem.innerText = totalPrice + '.000 VND'; // Ensure 3 decimal places
                }

                // Attach event listeners to the delivery and voucher select elements
                deliverySelect.addEventListener('change', updateTotal);
                voucherSelect.addEventListener('change', updateTotal); // Add listener for voucher change

                // Initialize total on page load
                updateTotal();
            });

        </script>

    </body>
</html>
