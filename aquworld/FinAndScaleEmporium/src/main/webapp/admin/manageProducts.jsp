<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:if test="${empty sessionScope.user || sessionScope.user.role != 'admin'}">
    <c:redirect url="${pageContext.request.contextPath}/login.jsp?error=unauthorized"/>
</c:if>

<html>
<head>
    <title>Manage Products - Admin</title>
    <style>
        /* (Same styling as provided) */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f6f8;
            margin: 0;
            padding: 0;
        }

        h1 {
            text-align: center;
            color: #003049;
            margin-top: 30px;
        }

        .container {
            width: 90%;
            max-width: 1200px;
            margin: 20px auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: white;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            border-radius: 8px;
            overflow: hidden;
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }

        th {
            background-color: #0a9396;
            color: white;
            text-transform: uppercase;
            font-size: 14px;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        img {
            max-width: 50px;
            height: auto;
            border-radius: 4px;
        }

        .action-links a,
        .action-links button {
            margin-right: 10px;
            padding: 6px 10px;
            font-size: 14px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
        }

        .action-links a {
            background-color: #0077b6;
            color: white;
        }

        .action-links button {
            background-color: #d00000;
            color: white;
        }

        .action-links button:hover,
        .action-links a:hover {
            opacity: 0.85;
        }

        .message {
            padding: 12px;
            border-radius: 6px;
            text-align: center;
            width: 90%;
            margin: 20px auto 0;
        }

        .success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .top-links {
            text-align: center;
            margin-top: 15px;
        }

        .top-links a {
            background-color: #38b000;
            color: white;
            padding: 8px 14px;
            border-radius: 5px;
            text-decoration: none;
            margin: 0 10px;
            font-weight: bold;
        }

        .top-links a:hover {
            background-color: #2c8e00;
        }
    </style>
</head>
<body>

<jsp:include page="/_navbar.jsp" />

<div class="container">
    <h1>Manage Products</h1>

    <c:if test="${not empty sessionScope.flashMessage}">
        <p class="message ${sessionScope.flashMessageType eq 'success' ? 'success' : 'error'}">
            <c:out value="${sessionScope.flashMessage}"/>
        </p>
        <c:remove var="flashMessage" scope="session"/>
        <c:remove var="flashMessageType" scope="session"/>
    </c:if>

    <div class="top-links">
        <a href="${pageContext.request.contextPath}/admin/products/add">Add New Product</a>
        <a href="${pageContext.request.contextPath}/admin/dashboard.jsp">Back to Dashboard</a>
    </div>

    <c:if test="${empty products}">
        <p class="message error">No products found. Add one!</p>
    </c:if>

    <c:if test="${not empty products}">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Image</th>
                    <th>Name</th>
                    <th>Category</th>
                    <th>Price</th>
                    <th>Stock</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="product" items="${products}">
                    <tr>
                        <td><c:out value="${product.id}"/></td>
                        <td>
                            <c:if test="${not empty product.imageUrl}">
                                <img src="${pageContext.request.contextPath}/${product.imageUrl}" alt="${product.name}">
                            </c:if>
                        </td>
                        <td><c:out value="${product.name}"/></td>
                        <td><c:out value="${product.category}"/></td>
                        <td><fmt:formatNumber value="${product.price}" type="currency" currencySymbol="$"/></td>
                        <td><c:out value="${product.quantity}"/></td>
                        <td class="action-links">
                            <a href="${pageContext.request.contextPath}/admin/products/edit?id=${product.id}">Edit</a>
                            <form action="${pageContext.request.contextPath}/admin/products/delete" method="post" style="display:inline;">
                                <input type="hidden" name="id" value="${product.id}">
                                <button type="submit" onclick="return confirm('Are you sure you want to delete this product?');">Delete</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>
</div>

</body>
</html>
