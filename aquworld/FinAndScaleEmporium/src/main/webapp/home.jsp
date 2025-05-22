<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>Welcome to Fin & Scale Emporium - Your Aquatic Paradise!</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f4f4f4; color: #333; }
         .hero-section {
        background-image: url('${pageContext.request.contextPath}/images/site/hero_fish.jpg'); /* Make sure this path is correct */
        background-size: cover;
        background-position: center;
        background-repeat: no-repeat;
        color: white;
        text-align: center;
        padding: 100px 20px;
        text-shadow: 2px 2px 6px rgba(0, 0, 0, 0.7);
        position: relative;
    }

    .hero-section::before {
        content: '';
        position: absolute;
        top: 0; left: 0; right: 0; bottom: 0;
        background-color: rgba(0, 0, 0, 0.4); /* dark overlay */
        z-index: 0;
    }

    .hero-section h1,
    .hero-section p,
    .hero-section .cta-button {
        position: relative;
        z-index: 1;
    }

    .hero-section h1 {
        font-size: 3em;
        margin-bottom: 15px;
    }

    .hero-section p {
        font-size: 1.4em;
        margin-bottom: 30px;
    }

    .hero-section .cta-button {
        background-color: #007bff;
        color: white;
        padding: 15px 30px;
        text-decoration: none;
        font-size: 1.2em;
        border-radius: 5px;
        transition: background-color 0.3s ease;
    }

    .hero-section .cta-button:hover {
        background-color: #0056b3;
    }
        .container { width: 90%; max-width: 1200px; margin: 20px auto; padding: 0 15px; }
        .section-title { text-align: center; font-size: 2em; margin-top: 40px; margin-bottom: 30px; color: #333; }

        .featured-products-grid { display: flex; flex-wrap: wrap; gap: 20px; justify-content: center; }
        .product-card {
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 20px;
            width: calc(25% - 20px); /* 4 cards per row, accounting for gap */
            min-width: 220px; /* Minimum width for smaller screens */
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            text-align: center;
            transition: transform 0.2s ease-in-out;
        }
        .product-card:hover { transform: translateY(-5px); }
        .product-card img {
            max-width: 100%;
            height: 150px; /* Fixed height for consistency */
            object-fit: contain; /* Or 'cover' if you prefer cropping */
            margin-bottom: 15px;
            border-bottom: 1px solid #eee;
            padding-bottom: 10px;
        }
        .product-card h3 { font-size: 1.2em; margin-bottom: 8px; color: #0056b3;}
        .product-card .price { font-size: 1.1em; font-weight: bold; color: #28a745; margin-bottom: 10px; }
        .product-card .view-details-btn {
            display: inline-block;
            background-color: #5cb85c;
            color: white;
            padding: 8px 15px;
            text-decoration: none;
            border-radius: 4px;
            font-size: 0.9em;
        }
        .product-card .view-details-btn:hover { background-color: #4cae4c; }

        .marketing-sections { display: flex; flex-wrap: wrap; gap: 20px; margin-top: 40px; }
        .marketing-card {
            background-color: #e9ecef;
            padding: 20px;
            border-radius: 5px;
            flex: 1;
            min-width: 280px;
            text-align: center;
        }
        .marketing-card h3 { margin-top: 0; }
        .marketing-card a.btn {
             display: inline-block; padding: 10px 15px; background-color: #17a2b8; color:white; text-decoration:none; border-radius:4px; margin-top:10px;
        }
        .marketing-card a.btn:hover { background-color: #138496; }

        /* Responsive adjustments */
        @media (max-width: 992px) {
            .product-card { width: calc(33.333% - 20px); } /* 3 cards */
        }
        @media (max-width: 768px) {
            .hero-section h1 { font-size: 2.2em; }
            .hero-section p { font-size: 1.1em; }
            .product-card { width: calc(50% - 20px); } /* 2 cards */
        }
        @media (max-width: 576px) {
            .product-card { width: 100%; } /* 1 card */
        }

    </style>
</head>
<body>
    <jsp:include page="_navbar.jsp" />

    <header class="hero-section">
        <h1>Dive Into a World of Wonder</h1>
        <p>Your Premier Destination for Healthy Fish, Lush Plants, and Quality Aquarium Supplies.</p>
        <a href="${pageContext.request.contextPath}/shop" class="cta-button">Shop Now</a>
    </header>

    <div class="container">
        <section id="featured-products">
            <h2 class="section-title">Featured Products</h2>
            <c:if test="${not empty featuredProducts}">
                <div class="featured-products-grid">
                    <c:forEach var="product" items="${featuredProducts}">
                        <div class="product-card">
                            <c:if test="${not empty product.imageUrl}">
                                <img src="${pageContext.request.contextPath}/${product.imageUrl}" alt="<c:out value='${product.name}'/>">
                            </c:if>
                            <h3><c:out value="${product.name}"/></h3>
                            <p class="price"><fmt:formatNumber value="${product.price}" type="currency" currencySymbol="$"/></p>
                            <%-- Optional: Short description or category --%>
                            <%-- <p style="font-size:0.9em; color:#666;">Category: <c:out value="${product.category}"/></p> --%>
                            <a href="${pageContext.request.contextPath}/product?id=${product.id}" class="view-details-btn">View Details</a>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
            <c:if test="${empty featuredProducts}">
                <p style="text-align:center;">Check back soon for our featured items!</p>
            </c:if>
        </section>

        <section id="marketing-highlights">
            <h2 class="section-title">Discover More</h2>
            <div class="marketing-sections">
                <div class="marketing-card">
                    <h3>Vibrant Freshwater Fish</h3>
                    <p>Explore our wide selection of healthy and colorful freshwater species.</p>
                    <a href="${pageContext.request.contextPath}/shop?category=fish" class="btn">Shop Fish</a>
                </div>
                <div class="marketing-card">
                    <h3>Lush Aquarium Plants</h3>
                    <p>Create a stunning underwater landscape with our variety of live plants.</p>
                    <a href="${pageContext.request.contextPath}/shop?category=plant" class="btn">Shop Plants</a>
                </div>
                <div class="marketing-card">
                    <h3>Essential Equipment</h3>
                    <p>Find reliable filters, heaters, lighting, and more for your aquarium.</p>
                    <a href="${pageContext.request.contextPath}/shop?category=equipment" class="btn">Shop Equipment</a>
                </div>
            </div>
        </section>

        <%-- You could add an "About Us Snippet" section here too --%>
        <section id="about-snippet" style="text-align:center; margin-top:40px; padding:20px; background-color:#fff; border-radius:5px;">
            <h2 class="section-title">About Fin & Scale Emporium</h2>
            <p>We are passionate about aquatics and dedicated to providing you with the best products and advice.
               Learn more about our story and commitment to the hobby.</p>
            <a href="${pageContext.request.contextPath}/about" class="cta-button" style="background-color:#6c757d;">Learn More About Us</a>
        </section>

    </div>

    <jsp:include page="_footer.jsp" />
    

</body>
</html>