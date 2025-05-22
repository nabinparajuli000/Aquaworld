<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title><c:out value="${product.name}"/> - Fin & Scale Emporium</title>
    <style>
        .product-detail { display: flex; gap: 20px; }
        .product-detail img { max-width: 300px; max-height: 300px; }
        .product-info { flex-grow: 1; }
    </style>
</head>
<body>
    <jsp:include page="_navbar.jsp" />

    <c:if test="${not empty product}">
        <h1><c:out value="${product.name}"/></h1>
        <div class="product-detail">
            <div>
                <c:if test="${not empty product.imageUrl}">
                    <img src="${pageContext.request.contextPath}/${product.imageUrl}" alt="${product.name}">
                </c:if>
            </div>
            <div class="product-info">
                <p><strong>Category:</strong> <c:out value="${product.category}"/></p>
                <p><strong>Price:</strong> <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="$"/></p>
                <p><strong>Availability:</strong>
                    <c:if test="${product.stockQuantity > 0}">In Stock (<c:out value="${product.stockQuantity}"/>)</c:if>
                    <c:if test="${product.stockQuantity <= 0}">Out of Stock</c:if>
                </p>
                <p><strong>Description:</strong></p>
                <p><c:out value="${product.description}"/></p>

                <%-- ... inside the product-info div ... --%>
<form action="${pageContext.request.contextPath}/cart/add" method="post">
    <input type="hidden" name="productId" value="${product.id}">
    <label for="quantity-${product.id}">Quantity:</label> <%-- Unique ID for label --%>
    <input type="number" id="quantity-${product.id}" name="quantity" value="1" min="1" max="${product.stockQuantity}" style="width: 60px;" <c:if test="${product.stockQuantity <= 0}">disabled</c:if>>
    <button type="submit" <c:if test="${product.stockQuantity <= 0}">disabled</c:if>>
        Add to Cart
    </button>
</form>
            </div>
        </div>
    </c:if>
    <c:if test="${empty product}">
        <p>Product not found.</p>
    </c:if>

    <p><a href="${pageContext.request.contextPath}/shop">Back to Shop</a></p>

     <jsp:include page="_footer.jsp" /> 
</body>
</html>