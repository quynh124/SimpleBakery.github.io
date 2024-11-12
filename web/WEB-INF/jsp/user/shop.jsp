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
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <!-- Include jQuery UI (if needed) after jQuery -->
        <script src="https://code.jquery.com/ui/1.13.0/jquery-ui.min.js"></script>
        <style>
            .product__item {
                margin: 10px; /* Khoảng cách giữa các sản phẩm */
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
                                <h2>Shop</h2>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6">
                            <div class="breadcrumb__links">
                                <a href="./index.htm">Home</a>
                                <a href="./shop.htm"><span>Shop</span></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Breadcrumb End -->

            <!-- Shop Section Begin -->
            <section class="shop spad">
                <div class="container">
                    <div class="shop__option">
                        <div class="row">
                            <div class="col-lg-7 col-md-7">
                                <div class="shop__option__search">
                                    <form action="/SimpleBakeryWebsite/search.htm" method="get">
                                        <select name="category" id="category-select">
                                            <option value="">Categories</option>
                                        <c:forEach var="category" items="${listCategory}">
                                            <c:if test="${category.isDeleted == false}">
                                                <option value="${category.categoryID}" <c:if test="${category.categoryID == param.category}">selected</c:if>>
                                                    ${category.categoryName}
                                                </option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                    <input type="text" name="search" id="search-input" list="productNames" placeholder="Search" 
                                           value="${param.search}" onchange="this.form.submit()">       
                                    <datalist id="productNames">
                                        <c:forEach var="product" items="${listProduct}">
                                            <c:if test="${product.isDeleted == false}">
                                                <option value="${product.productName}"></option>
                                            </c:if>
                                        </c:forEach>
                                    </datalist>
                                    <button type="submit"><i class="fa fa-search"></i></button>
                                </form>
                            </div>
                            <br>
                        </div>


                        <div class="col-lg-5 col-md-5">
                            <div class="shop__option__right">
                                <select id="price-select">
                                    <option value="">Select Price</option>
                                    <option value="low-to-high">Low to High</option>
                                    <option value="high-to-low">High to Low</option>
                                </select>

                            </div>
                        </div>
                    </div>
                </div>
                <div class="row" id="images-container">
                    <c:forEach var="item" items="${listProduct}">

                        <div class="col-lg-3 col-md-6 col-sm-6">
                            <div class="product__item" data-category="${item.categoryID}">
                                <div class="product__item__pic set-bg">
                                    <img src="${item.image}" style="width: 250px; height: 280px" />
                                    <div class="product__label">

                                        <c:forEach var="category" items="${listCategory}">
                                             <c:if test="${category.isDeleted == false}">
                                            <c:if test="${category.categoryID == item.categoryID}">
                                                <span>${category.categoryName}</span>
                                            </c:if>
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
                    </c:forEach>
                </div>

                <div class="shop__last__option">
                    <div class="row">
                        <div class="col-lg-6 col-md-6 col-sm-6">
                            <div class="shop__pagination">
                                <c:if test="${currentPage > 1}">
                                    <a href="?page=${currentPage - 1}"></a>
                                </c:if>
                                <c:forEach var="i" begin="1" end="${totalPages}">
                                    <a href="?page=${i}" class="${i == currentPage ? 'active' : ''}">${i}</a>
                                </c:forEach>
                                <c:if test="${currentPage < totalPages}">
                                    <a href="?page=${currentPage + 1}"></a>
                                </c:if>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6">
                            <div class="shop__last__text">
                                <p>Showing ${(currentPage - 1) * pageSize + 1}-${Math.min(currentPage * pageSize, totalProducts)} of ${totalProducts} results</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Shop Section End -->
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                var categorySelect = document.getElementById('category-select');
                var priceSelect = document.getElementById('price-select');
                var imagesContainer = document.getElementById('images-container');
                var allProducts = Array.from(document.querySelectorAll('.product__item')); // Store all products

                // Function to filter products based on the selected category
                function filterProducts(selectedCategory) {
                    return allProducts.filter(function (product) {
                        var productCategory = product.getAttribute('data-category');
                        return selectedCategory === "" || productCategory === selectedCategory;
                    });
                }

                // Function to sort products based on selected price
                function sortProducts(filteredProducts, selectedPrice) {
                    if (selectedPrice === "low-to-high") {
                        return filteredProducts.sort(function (a, b) {
                            var priceA = parseFloat(a.querySelector('.product__item__price').textContent.replace(/[^0-9.-]+/g, ""));
                            var priceB = parseFloat(b.querySelector('.product__item__price').textContent.replace(/[^0-9.-]+/g, ""));
                            return priceA - priceB; // Ascending order
                        });
                    } else if (selectedPrice === "high-to-low") {
                        return filteredProducts.sort(function (a, b) {
                            var priceA = parseFloat(a.querySelector('.product__item__price').textContent.replace(/[^0-9.-]+/g, ""));
                            var priceB = parseFloat(b.querySelector('.product__item__price').textContent.replace(/[^0-9.-]+/g, ""));
                            return priceB - priceA; // Descending order
                        });
                    }
                    return filteredProducts; // Return as is if no price filter is selected
                }

                // Function to update the displayed products
                function updateDisplayedProducts() {
                    var selectedCategory = categorySelect.value;
                    var selectedPrice = priceSelect.value;

                    // Filter and then sort the products
                    var filteredProducts = filterProducts(selectedCategory);
                    var sortedProducts = sortProducts(filteredProducts, selectedPrice);

                    // Clear current products
                    imagesContainer.innerHTML = '';

                    // Append sorted products to the container
                    sortedProducts.forEach(function (product) {
                        imagesContainer.appendChild(product);
                    });
                }

                // Event listeners for both selects
                categorySelect.addEventListener('change', updateDisplayedProducts);
                priceSelect.addEventListener('change', updateDisplayedProducts);
            });
        </script>


        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>
