<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>Checkout - Fin & Scale</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f7fa;
            color: #333;
        }

        h1 {
            text-align: center;
            margin-top: 30px;
            color: #2c3e50;
        }

        table {
            width: 80%;
            margin: 30px auto;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
            border-radius: 8px;
            overflow: hidden;
        }

        th, td {
            padding: 15px 20px;
            text-align: center;
        }

        th {
            background-color: #3498db;
            color: white;
            font-weight: normal;
        }

        tbody tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        tfoot {
            background-color: #ecf0f1;
            font-weight: bold;
        }

        form {
            text-align: center;
            margin-top: 30px;
        }

        button {
            background-color: #27ae60;
            color: white;
            border: none;
            padding: 12px 25px;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #219150;
        }

        p {
            text-align: center;
            font-size: 18px;
            margin-top: 40px;
        }

        a {
            color: #3498db;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<jsp:include page="_navbar.jsp" />

<h1>Checkout Summary</h1>

<c:set var="cart" value="${sessionScope.cart}" />
<c:if test="${not empty cart && not empty cart.items}">
    <table>
        <thead>
            <tr>
                <th>Product</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Subtotal</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="item" items="${cart.items}">
                <tr>
                    <td><c:out value="${item.product.name}" /></td>
                    <td><fmt:formatNumber value="${item.product.price}" type="currency" currencySymbol="$"/></td>
                    <td>${item.quantity}</td>
                    <td><fmt:formatNumber value="${item.subtotal}" type="currency" currencySymbol="$"/></td>
                </tr>
            </c:forEach>
        </tbody>
        <tfoot>
            <tr>
                <td colspan="3" style="text-align: right;"><strong>Total:</strong></td>
                <td><fmt:formatNumber value="${cart.total}" type="currency" currencySymbol="$"/></td>
            </tr>
        </tfoot>
    </table>

    <form action="${pageContext.request.contextPath}/checkout" method="post">
        <button type="submit">Confirm & Place Order</button>
    </form>
</c:if>

<c:if test="${empty cart || empty cart.items}">
    <p>Your cart is empty. <a href="${pageContext.request.contextPath}/shop">Go shopping</a>.</p>
</c:if>

<jsp:include page="_footer.jsp" />
</body>
</html>
