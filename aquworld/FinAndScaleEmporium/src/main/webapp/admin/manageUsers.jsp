<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${empty sessionScope.user || sessionScope.user.role != 'admin'}">
    <c:redirect url="${pageContext.request.contextPath}/login.jsp?error=unauthorized"/>
</c:if>

<html>
<head>
    <title>Manage Users - Admin</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f7f9fc;
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
            max-width: 1000px;
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

        a {
            color: #0077b6;
            text-decoration: none;
            font-weight: bold;
        }

        a:hover {
            text-decoration: underline;
        }

        .message {
            padding: 12px;
            border-radius: 6px;
            text-align: center;
            width: 90%;
            margin: 20px auto 0;
            font-weight: bold;
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

        .back-link {
            display: block;
            text-align: center;
            margin: 30px auto;
        }

        .back-link a {
            background-color: #38b000;
            color: white;
            padding: 10px 16px;
            border-radius: 5px;
            text-decoration: none;
        }

        .back-link a:hover {
            background-color: #2c8e00;
        }
    </style>
</head>
<body>

<jsp:include page="/_navbar.jsp" />

<div class="container">
    <h1>Manage Users</h1>

    <c:if test="${not empty sessionScope.adminMessage}">
        <p class="message ${sessionScope.messageType == 'error' ? 'error' : 'success'}"><c:out value="${sessionScope.adminMessage}"/></p>
        <c:remove var="adminMessage" scope="session"/>
        <c:remove var="messageType" scope="session"/>
    </c:if>
    <c:if test="${not empty requestScope.adminMessage}">
        <p class="message ${requestScope.messageType == 'error' ? 'error' : 'success'}"><c:out value="${requestScope.adminMessage}"/></p>
    </c:if>

    <c:if test="${empty users}">
        <p class="message error">No users found in the system (except maybe the current admin).</p>
    </c:if>

    <c:if test="${not empty users}">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Username</th>
                    <th>Email</th>
                    <th>Role</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="u" items="${users}">
                    <tr>
                        <td><c:out value="${u.id}"/></td>
                        <td><c:out value="${u.username}"/></td>
                        <td><c:out value="${u.email}"/></td>
                        <td><c:out value="${u.role}"/></td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/users/view?id=${u.id}">View Details</a>
                            <%-- Add more actions (edit role, deactivate) if implemented --%>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>

    <div class="back-link">
        <a href="${pageContext.request.contextPath}/admin/dashboard.jsp">Back to Admin Dashboard</a>
    </div>
</div>

</body>
</html>
