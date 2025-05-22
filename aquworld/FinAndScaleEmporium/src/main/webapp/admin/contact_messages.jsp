<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${empty sessionScope.user || sessionScope.user.role != 'admin'}">
    <c:redirect url="${pageContext.request.contextPath}/login.jsp?error=unauthorized"/>
</c:if>
<html>
<head>
    <title>Admin - Contact Messages</title>
    <style>
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 10px; border: 1px solid #ccc; text-align: left; vertical-align: top; }
        th { background-color: #f2f2f2; }
        h1 { text-align: center; margin: 20px 0; }
    </style>
</head>
<body>
<jsp:include page="/_navbar.jsp" />

    <h1>Contact Form Submissions</h1>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Submitted At</th>
                <th>Name</th>
                <th>Email</th>
                <th>Subject</th>
                <th>Message</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="msg" items="${messages}">
                <tr>
                    <td>${msg.id}</td>
                    <td>${msg.submittedAt}</td>
                    <td>${msg.name}</td>
                    <td>${msg.email}</td>
                    <td>${msg.subject}</td>
                    <td>${msg.message}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>
