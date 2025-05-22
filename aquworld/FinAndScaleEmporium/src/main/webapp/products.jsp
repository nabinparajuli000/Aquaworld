<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>Shop Products - Fin & Scale Emporium</title>
    <style>
    body {
        font-family: 'Segoe UI', sans-serif;
        background: #f0f4f8;
        margin: 0;
        padding: 0;
        color: #333;
    }

    h1 {
        text-align: center;
        padding: 20px 0;
        color: #0077cc;
    }

    .filters {
        margin: 0 auto 20px auto;
        padding: 20px;
        max-width: 1100px;
        background-color: #fff;
        border-radius: 10px;
        box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
        display: flex;
        flex-wrap: wrap;
        gap: 15px;
        justify-content: center;
    }

    .filters label {
        margin-right: 5px;
        font-weight: 500;
    }

    .filters select,
    .filters input[type="text"],
    .filters button {
        padding: 10px;
        border-radius: 6px;
        border: 1px solid #ccc;
        font-size: 14px;
    }

    .filters button {
        background-color: #0077cc;
        color: white;
        cursor: pointer;
        border: none;
        transition: background-color 0.3s ease;
    }

    .filters button:hover {
        background-color: #005fa3;
    }

    .product-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
        gap: 20px;
        padding: 20px;
        max-width: 1200px;
        margin: 0 auto;
    }

    .product-card {
        background-color: white;
        border-radius: 10px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
        padding: 20px;
        text-align: center;
        transition: transform 0.2s ease, box-shadow 0.2s ease;
    }

    .product-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
    }

    .product-card img {
        max-width: 100%;
        height: 150px;
        object-fit: contain;
        margin-bottom: 15px;
    }

    .product-card h3 {
        margin: 10px 0 5px;
        font-size: 18px;
        color: #0077cc;
    }

    .product-card p {
        margin: 5px 0;
    }

    .product-card a {
        text-decoration: none;
        color: #0077cc;
        font-weight: 500;
    }

    .product-card a:hover {
        text-decoration: underline;
    }

    .product-card form {
        margin-top: 10px;
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 10px;
    }

    .product-card input[type="number"] {
        padding: 6px;
        width: 60px;
        text-align: center;
        border-radius: 4px;
        border: 1px solid #ccc;
    }

    .product-card button {
        background-color: #28a745;
        color: white;
        border: none;
        padding: 8px 12px;
        border-radius: 5px;
        cursor: pointer;
        font-size: 14px;
        transition: background-color 0.3s ease;
    }

    .product-card button[disabled] {
        background-color: #ccc;
        cursor: not-allowed;
    }

    .product-card button:hover:not([disabled]) {
        background-color: #218838;
    }

    a {
        color: #0077cc;
        text-decoration: none;
    }

    a:hover {
        text-decoration: underline;
    }

    @media screen and (max-width: 768px) {
        .filters {
            flex-direction: column;
            align-items: stretch;
        }

        .product-card form {
            flex-direction: column;
        }

        .product-card input[type="number"] {
            width: 100%;
        }
    }
</style>
    
</head>
<body>
    <jsp:include page="_navbar.jsp" />
    <h1>Our Products</h1>

    <div class="filters">
        <form action="${pageContext.request.contextPath}/shop" method="get" style="display: flex; gap: 15px; align-items: center;">
            <div>
                <label for="category">Category:</label>
                <select id="category" name="category">
                    <option value="all" ${empty selectedCategory || selectedCategory == 'all' ? 'selected' : ''}>All Categories</option>
                    <c:forEach var="cat" items="${categories}">
                        <option value="${cat}" ${selectedCategory == cat ? 'selected' : ''}><c:out value="${cat}"/></option>
                    </c:forEach>
                </select>
            </div>
            <div>
                <label for="searchTerm">Search:</label>
                <input type="text" id="searchTerm" name="searchTerm" value="<c:out value='${currentSearchTerm}'/>" placeholder="Search products...">
            </div>
            <%-- Conceptual: Price Range Filter --%>
            <%--
            <div>
                <label for="priceMin">Min Price:</label>
                <input type="number" id="priceMin" name="priceMin" value="${currentPriceMin}" step="0.01" placeholder="Min">
            </div>
            <div>
                <label for="priceMax">Max Price:</label>
                <input type="number" id="priceMax" name="priceMax" value="${currentPriceMax}" step="0.01" placeholder="Max">
            </div>
            --%>
            <%-- Conceptual: Sort By --%>
            <%--
            <div>
                <label for="sortBy">Sort By:</label>
                <select id="sortBy" name="sortBy">
                    <option value="" ${empty selectedSortBy ? 'selected' : ''}>Default</option>
                    <option value="price_asc" ${selectedSortBy == 'price_asc' ? 'selected' : ''}>Price: Low to High</option>
                    <option value="price_desc" ${selectedSortBy == 'price_desc' ? 'selected' : ''}>Price: High to Low</option>
                    <option value="name_asc" ${selectedSortBy == 'name_asc' ? 'selected' : ''}>Name: A to Z</option>
                    <option value="name_desc" ${selectedSortBy == 'name_desc' ? 'selected' : ''}>Name: Z to A</option>
                </select>
            </div>
            --%>
            <div>
                <button type="submit">Filter / Search</button>
                <a href="${pageContext.request.contextPath}/shop" style="margin-left:10px;">Clear Filters</a>
            </div>
        </form>
    </div>

    <div class="product-grid">
        <c:if test="${empty products}">
            <p>No products found matching your criteria.</p>
        </c:if>
        <c:forEach var="product" items="${products}">
            <div class="product-card">
                <c:if test="${not empty product.imageUrl}">
                    <img src="${pageContext.request.contextPath}/${product.imageUrl}" alt="${product.name}">
                </c:if>
                <h3><c:out value="${product.name}"/></h3>
                <p>Category: <c:out value="${product.category}"/></p>
                <p>Price: <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="$"/></p>
                <p><a href="${pageContext.request.contextPath}/product?id=${product.id}">View Details</a></p>
                <form action="${pageContext.request.contextPath}/cart/add" method="post">
                    <input type="hidden" name="productId" value="${product.id}">
                    <input type="number" name="quantity" value="1" min="1" max="${product.stockQuantity}" style="width: 50px;" <c:if test="${product.stockQuantity <= 0}">disabled</c:if>>
                    <button type="submit" <c:if test="${product.stockQuantity <= 0}">disabled</c:if>>Add to Cart</button>
                </form>
            </div>
        </c:forEach>
    </div>
<jsp:include page="_footer.jsp" />
</body>
</html>