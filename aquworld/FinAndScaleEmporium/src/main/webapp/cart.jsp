<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>Your Shopping Cart - Fin & Scale Emporium</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            color: #333;
            margin: 0;
            padding: 0;
        }

        h1 {
            text-align: center;
            margin-top: 30px;
            color: #333;
        }

        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            background-color: #fff;
        }

        th, td {
            padding: 12px 15px;
            border: 1px solid #e0e0e0;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
            font-weight: bold;
        }

        .cart-total {
            text-align: right;
            font-weight: bold;
            font-size: 1.1em;
        }

        .empty-cart {
            text-align: center;
            padding: 50px;
            font-size: 1.2em;
        }

        .error {
            color: #d9534f;
            text-align: center;
            font-weight: bold;
        }

        .success {
            color: #5cb85c;
            text-align: center;
            font-weight: bold;
        }

        button {
            padding: 6px 12px;
            background-color: #0275d8;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 4px;
        }

        button:hover {
            background-color: #025aa5;
        }

        a {
            color: #0275d8;
            text-decoration: none;
            margin: 0 10px;
        }

        a:hover {
            text-decoration: underline;
        }

        @media (max-width: 768px) {
            table, thead, tbody, th, td, tr {
                display: block;
            }

            th {
                display: none;
            }

            td {
                position: relative;
                padding-left: 50%;
                border: none;
                border-bottom: 1px solid #eee;
            }

            td:before {
                position: absolute;
                top: 12px;
                left: 12px;
                width: 45%;
                white-space: nowrap;
                font-weight: bold;
            }

            td:nth-of-type(1):before { content: "Product"; }
            td:nth-of-type(2):before { content: "Price"; }
            td:nth-of-type(3):before { content: "Quantity"; }
            td:nth-of-type(4):before { content: "Subtotal"; }
            td:nth-of-type(5):before { content: "Action"; }
        }
    </style>
</head>
<body>
<jsp:include page="_navbar.jsp" />

<h1>Your Shopping Cart</h1>

<c:if test="${not empty sessionScope.cartError}">
    <p class="error"><c:out value="${sessionScope.cartError}"/></p>
    <c:set var="cartError" value="" scope="session"/>
</c:if>

<c:if test="${not empty sessionScope.cartMessage}">
    <p class="success"><c:out value="${sessionScope.cartMessage}"/></p>
    <c:set var="cartMessage" value="" scope="session"/>
</c:if>

<c:set var="cart" value="${sessionScope.cart}" />
<c:choose>
    <c:when test="${not empty cart && not empty cart.items}">
        <table>
            <thead>
                <tr>
                    <th>Product</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Subtotal</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="item" items="${cart.items}">
                    <tr>
                        <td>
                            <c:if test="${not empty item.product.imageUrl}">
                                <img src="${pageContext.request.contextPath}/${item.product.imageUrl}" alt="${item.product.name}" style="width:50px; height:50px; vertical-align: middle; margin-right: 10px;">
                            </c:if>
                            <c:out value="${item.product.name}"/>
                        </td>
                        <td><fmt:formatNumber value="${item.product.price}" type="currency" currencySymbol="$"/></td>
                        <td>
                            <form action="${pageContext.request.contextPath}/cart/update" method="post" style="display: inline;">
                                <input type="hidden" name="productId" value="${item.product.id}">
                                <input type="number" name="quantity" value="${item.quantity}" min="1" max="${item.product.stockQuantity}" style="width: 60px;">
                                <button type="submit">Update</button>
                            </form>
                        </td>
                        <td><fmt:formatNumber value="${item.subtotal}" type="currency" currencySymbol="$"/></td>
                        <td>
                            <form action="${pageContext.request.contextPath}/cart/remove" method="post" style="display: inline;">
                                <input type="hidden" name="productId" value="${item.product.id}">
                                <button type="submit">Remove</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
            <tfoot>
                <tr>
                    <td colspan="3" class="cart-total">Total:</td>
                    <td class="cart-total"><fmt:formatNumber value="${cart.total}" type="currency" currencySymbol="$"/></td>
                    <td></td>
                </tr>
            </tfoot>
        </table>
        <div style="text-align: center; margin-top: 20px;">
            <a href="${pageContext.request.contextPath}/shop">Continue Shopping</a>
            <form action="${pageContext.request.contextPath}/checkout" method="get" style="display: inline;">
    <button type="submit">Proceed to Checkout</button>
</form>
            
        </div>
    </c:when>
    <c:otherwise>
        <div class="empty-cart">
            <p>Your cart is empty.</p>
            <p><a href="${pageContext.request.contextPath}/shop">Start Shopping!</a></p>
        </div>
    </c:otherwise>
</c:choose>

<jsp:include page="_footer.jsp" />
</body>
</html>
