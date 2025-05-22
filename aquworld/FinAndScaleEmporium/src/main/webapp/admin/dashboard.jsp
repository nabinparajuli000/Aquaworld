<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%-- Redirect unauthorized or not-logged-in users --%>
<c:if test="${empty sessionScope.user || sessionScope.user.role != 'admin'}">
    <c:redirect url="${pageContext.request.contextPath}/login.jsp?error=unauthorized"/>
</c:if>

<%-- Only render HTML if session is valid and user is admin --%>
<c:if test="${not empty sessionScope.user && sessionScope.user.role == 'admin'}">
    <html>
    <head>
        <title>Admin Dashboard - Fin & Scale Emporium</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f0f2f5;
                margin: 0;
                padding: 0;
            }

            .container {
                width: 85%;
                margin: 40px auto;
                padding: 30px;
                background: #ffffff;
                border-radius: 10px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
            }

            h1 {
                color: #007bff;
                margin-bottom: 20px;
            }

            p {
                font-size: 1.1em;
                color: #333;
                margin-bottom: 30px;
            }

            ul {
                list-style: none;
                padding: 0;
            }

            ul li {
                margin: 10px 0;
            }

            ul li a {
                display: inline-block;
                padding: 12px 20px;
                background-color: #007bff;
                color: white;
                text-decoration: none;
                border-radius: 6px;
                transition: background-color 0.3s ease;
            }

            ul li a:hover {
                background-color: #0056b3;
            }

            @media (max-width: 768px) {
                .container {
                    width: 95%;
                    padding: 20px;
                }
            }
        </style>
    </head>
    <body>

        <jsp:include page="/_navbar.jsp" />

        <div class="container">
            <h1>Admin Dashboard</h1>
            <p>Welcome, Admin <c:out value="${sessionScope.user.username}"/>!</p>

            <ul>
                <li><a href="${pageContext.request.contextPath}/admin/users">Manage Users</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/products">Manage Products</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/contact_messages">Manage Feedback</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/order-details">Manage Orders</a></li>
            </ul>
        </div>

    </body>
    </html>
</c:if>
