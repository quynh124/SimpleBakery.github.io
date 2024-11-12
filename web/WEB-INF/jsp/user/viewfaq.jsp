<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
      <head>
        <meta charset="UTF-8">
        <meta name="description" content="Cake Template">
        <meta name="keywords" content="Cake, unica, creative, html">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Cake | Template</title>

        <!-- Google Font -->
        <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700;800;900&display=swap"
              rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700;800;900&display=swap"
              rel="stylesheet">

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
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
    .faq-answer {
    display: none;
}

.faq-answer.show {
    display: block;
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
                        <h2>FAQs</h2>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-6">
                    <div class="breadcrumb__links">
                        <a href="./index.htm">Home</a>
                        <span>FAQs</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Breadcrumb End -->

    <!-- Class Section Begin -->
<section class="class-page spad">
    <div class="container">
        <div class="row">
            <div class="col-lg-8 mx-auto mt-5">
                <div class="faq-section">
                    <h2>Frequently Asked Questions</h2>

                    <div class="faq-item">
                        <button class="faq-question" onclick="toggleAnswer(this)">What are your opening hours?</button>
                        <div class="faq-answer" style="display: none;">
                            <p>We are open from 8 AM to 8 PM from Monday to Saturday. We are closed on Sundays.</p>
                        </div>
                    </div>

                    <div class="faq-item">
                        <button class="faq-question" onclick="toggleAnswer(this)">Do you offer custom cake designs?</button>
                        <div class="faq-answer" style="display: none;">
                            <p>Yes, we offer custom cake designs for all occasions. Please contact us for more details.</p>
                        </div>
                    </div>

                    <div class="faq-item">
                        <button class="faq-question" onclick="toggleAnswer(this)">How can I place an order?</button>
                        <div class="faq-answer" style="display: none;">
                            <p>You can place an order through our website, by phone, or by visiting our shop in person.</p>
                        </div>
                    </div>
                </div>

                <!-- Pagination controls -->
                <nav aria-label="Page navigation example">
                    <ul class="pagination justify-content-center">
                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link" href="/viewfaq?page=${currentPage - 1}">Previous</a>
                        </li>
                        <c:forEach var="i" begin="1" end="${totalPages}">
                            <li class="page-item ${currentPage == i ? 'active' : ''}">
                                <a class="page-link" href="/viewfaq?page=${i}">${i}</a>
                            </li>
                        </c:forEach>
                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link" href="/viewfaq?page=${currentPage + 1}">Next</a>
                        </li>
                    </ul>
                </nav>
            </div>

            <div class="col-lg-4">
                <div class="class__sidebar">
                    <h5>Please send us your questions</h5>
                    <form action="/SimpleBakeryWebsite/faqs.htm" method="POST">
                        <input type="text" placeholder="Email" name="emailUser" required />
                        <input type="text" placeholder="Comment" name="content" id="content">

                        <button type="submit" class="site-btn">Submit</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>

<script src="script.js"></script>
<script>
    function toggleAnswer(button) {
        const answer = button.nextElementSibling;
        if (answer.style.display === "none" || answer.style.display === "") {
            answer.style.display = "block";
        } else {
            answer.style.display = "none";
        }
    }
</script>

<script src="script.js"></script>
    <!-- Class Section End -->
    <jsp:include page="footer.jsp"></jsp:include>
    <script>
        // Ẩn phần trả lời khi nhấp vào câu hỏi
$('.faq-question').on('click', function() {
    var target = $(this).data('target');
    $(target).toggleClass('show');
});
    </script>
    <script>
       $.ajax({
    url: '/viewfaq.htm',
    type: 'POST',
    data: {
        faqID: 1, // Replace with dynamic ID if necessary
        reply: 'This is a test reply'
    },
    success: function(response) {
        console.log('Response: ' + response);
    },
    error: function(error) {
        console.log('Error: ' + error);
    }
});
    </script>
    </body>
</html>
