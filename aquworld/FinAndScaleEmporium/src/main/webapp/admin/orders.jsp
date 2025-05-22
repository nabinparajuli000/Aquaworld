<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin - Order Management - Fin & Scale</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <style>
        .table th, .table td {
            vertical-align: middle;
        }
        .top-links {
            margin-top: 30px;
            padding-top: 10px;
            border-top: 1px solid #ddd;
        }
        .top-links a {
            margin-right: 15px;
        }
    </style>
</head>
<body>

<jsp:include page="/_navbar.jsp" />

<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2>Order Management</h2>
    </div>

    <c:choose>
        <c:when test="${not empty orders}">
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead class="thead-dark">
                        <tr>
                            <th>Order ID</th>
                            <th>Customer</th>
                            <th>Date</th>
                            <th>Total</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="order" items="${orders}">
                            <tr>
                                <td>#${order.orderId}</td>
                                <td>
                                    <c:out value="${order.customerUsername != null ? order.customerUsername : 'N/A'}" /><br />
                                    <small><c:out value="${order.customerEmail != null ? order.customerEmail : 'Guest Order'}" /></small>
                                </td>
                                <td><fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                                <td>
                                    <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="$" maxFractionDigits="2" />
                                </td>
                                <td>
                                    <span class="badge 
                                        <c:choose>
                                            <c:when test="${order.status == 'PENDING'}">bg-warning text-dark</c:when>
                                            <c:when test="${order.status == 'PROCESSING'}">bg-info text-dark</c:when>
                                            <c:when test="${order.status == 'SHIPPED'}">bg-primary</c:when>
                                            <c:when test="${order.status == 'DELIVERED'}">bg-success</c:when>
                                            <c:when test="${order.status == 'CANCELED'}">bg-danger</c:when>
                                            <c:otherwise>bg-secondary</c:otherwise>
                                        </c:choose>">
                                        ${order.status}
                                    </span>
                                </td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/admin/order-details?orderId=${order.orderId}" class="btn btn-sm btn-info">
                                        <i class="fas fa-eye"></i> View
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:when>
        <c:otherwise>
            <div class="alert alert-info">No orders found.</div>
        </c:otherwise>
    </c:choose>

    <div class="top-links">
        <a href="${pageContext.request.contextPath}/admin/dashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
    </div>
</div>

</body>
</html>
