

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

 <div class="col-lg-8">
<div class="faq-section">
        <h2>Frequently Asked Questions</h2>
        <div class="faq-item">
            <button class="faq-question">What are your opening hours?</button>
            <div class="faq-answer">
                <p>We are open from 8 AM to 8 PM from Monday to Saturday. We are closed on Sundays.</p>
            </div>
        </div>
        <div class="faq-item">
            <button class="faq-question">Do you offer custom cake designs?</button>
            <div class="faq-answer">
                <p>Yes, we offer custom cake designs for all occasions. Please contact us for more details.</p>
            </div>
        </div>
        <div class="faq-item">
            <button class="faq-question">How can I place an order?</button>
            <div class="faq-answer">
                <p>You can place an order through our website, by phone, or by visiting our shop in person.</p>
            </div>
        </div>
    </div>
 </div>
    <script src="script.js"></script>
                
                <div class="col-lg-4">
                    <div class="class__sidebar">
                        <h5>Please send us your questions</h5>
                        <form action="#">
                            <input type="text" placeholder="UserName">
                            <input type="text" placeholder="Email">
<!--                            <select>
                                <option value="">Studying Class</option>
                                <option value="">Writting Class</option>
                                <option value="">Reading Class</option>
                            </select>-->
                            <input type="text" placeholder="Comment">
                            <button type="submit" class="site-btn">Submit</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Class Section End -->
    <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>
