<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${empty sessionScope.user || sessionScope.user.role != 'admin'}">
    <c:redirect url="${pageContext.request.contextPath}/login.jsp?error=unauthorized"/>
</c:if>

<html>
<head>
    <title>View User Details - Admin</title>
    <style>
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

        .user-details {
            width: 400px;
            margin: 30px auto;
            padding: 20px;
            background-color: white;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }

        .user-details p {
            margin: 12px 0;
            font-size: 16px;
        }

        .user-details strong {
            display: inline-block;
            width: 110px;
            color: #333;
        }

        .back-link {
            text-align: center;
            margin-top: 20px;
        }

        .back-link a {
            background-color: #0077b6;
            color: white;
            padding: 10px 18px;
            border-radius: 5px;
            text-decoration: none;
            font-weight: bold;
        }

        .back-link a:hover {
            background-color: #005f8c;
        }

        .not-found {
            text-align: center;
            margin-top: 50px;
            color: #721c24;
            font-weight: bold;
            background-color: #f8d7da;
            padding: 10px;
            width: fit-content;
            margin-left: auto;
            margin-right: auto;
            border-radius: 6px;
            border: 1px solid #f5c6cb;
        }
    </style>
</head>
<body>
    <jsp:include page="/_navbar.jsp" />

    <h1>User Details</h1>

    <c:if test="${not empty userToView}">
        <div class="user-details">
            <p><strong>ID:</strong> <c:out value="${userToView.id}"/></p>
            <p><strong>Username:</strong> <c:out value="${userToView.username}"/></p>
            <p><strong>Email:</strong> <c:out value="${userToView.email}"/></p>
            <p><strong>Role:</strong> <c:out value="${userToView.role}"/></p>
            <%-- Add other fields like registrationDate if available --%>
        </div>
    </c:if>

    <c:if test="${empty userToView}">
        <div class="not-found">
            User not found or you do not have permission to view this user.
        </div>
    </c:if>

    <div class="back-link">
        <a href="${pageContext.request.contextPath}/admin/users">Back to User List</a>
    </div>
</body>
</html>
