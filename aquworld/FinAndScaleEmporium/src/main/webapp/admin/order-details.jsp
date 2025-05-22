<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin - Order Details - Fin & Scale</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .order-item-img {
            width: 80px;
            height: 80px;
            object-fit: cover;
            margin-right: 15px;
        }
        .card h5 {
            margin-bottom: 0;
        }
    </style>
</head>
<body>

<jsp:include page="/_navbar.jsp" />

<div class="container mt-4">
    <c:if test="${not empty order}">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h2>Order Details: #${order.orderId}</h2>
            <a href="${pageContext.request.contextPath}/admin/orders" class="btn btn-secondary">&larr; Back to Orders</a>
        </div>

        <div class="row">
            <!-- Order Summary -->
            <div class="col-md-7">
                <div class="card mb-4">
                    <div class="card-header"><h5>Order Summary</h5></div>
                    <div class="card-body">
                        <p><strong>Order ID:</strong> #${order.orderId}</p>
                        <p><strong>Order Date:</strong>
                            <fmt:formatDate value="${order.orderDate}" pattern="MMMM dd, yyyy 'at' HH:mm:ss" />
                        </p>
                        <p><strong>Customer:</strong>
                            <c:out value="${order.customerUsername != null ? order.customerUsername : 'N/A'}" />
                            (<c:out value="${order.customerEmail != null ? order.customerEmail : 'Guest'}" />)
                        </p>
                        <p><strong>Total Amount:</strong>
                            <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="$" maxFractionDigits="2" />
                        </p>
                        <p><strong>Payment Method:</strong>
                            <c:out value="${order.paymentMethod != null ? order.paymentMethod : 'N/A'}" />
                        </p>
                        <p><strong>Status:</strong>
                            <span class="badge 
                                <c:choose>
                                    <c:when test="${order.status == 'PENDING'}">badge-warning</c:when>
                                    <c:when test="${order.status == 'PROCESSING'}">badge-info</c:when>
                                    <c:when test="${order.status == 'SHIPPED'}">badge-primary</c:when>
                                    <c:when test="${order.status == 'DELIVERED'}">badge-success</c:when>
                                    <c:when test="${order.status == 'CANCELED'}">badge-danger</c:when>
                                    <c:otherwise>badge-secondary</c:otherwise>
                                </c:choose>">
                                ${order.status}
                            </span>
                        </p>
                    </div>
                </div>

                <div class="card mb-4">
                    <div class="card-header"><h5>Shipping Information</h5></div>
                    <div class="card-body">
                        <p><c:out value="${order.shippingAddress}" /></p>
                        <c:if test="${not empty order.billingAddress && order.billingAddress != order.shippingAddress}">
                            <h6>Billing Address (if different):</h6>
                            <p><c:out value="${order.billingAddress}" /></p>
                        </c:if>
                    </div>
                </div>
            </div>

            <!-- Update Status -->
            <div class="col-md-5">
                <div class="card mb-4">
                    <div class="card-header"><h5>Update Order Status</h5></div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/admin/orders" method="post">
                            <input type="hidden" name="action" value="updateStatus" />
                            <input type="hidden" name="orderId" value="${order.orderId}" />
                            <div class="form-group">
                                <label for="status">New Status:</label>
                                <select name="status" id="status" class="form-control" required>
                                    <option value="PENDING" <c:if test="${order.status == 'PENDING'}">selected</c:if>>Pending</option>
                                    <option value="PROCESSING" <c:if test="${order.status == 'PROCESSING'}">selected</c:if>>Processing</option>
                                    <option value="SHIPPED" <c:if test="${order.status == 'SHIPPED'}">selected</c:if>>Shipped</option>
                                    <option value="DELIVERED" <c:if test="${order.status == 'DELIVERED'}">selected</c:if>>Delivered</option>
                                    <option value="CANCELED" <c:if test="${order.status == 'CANCELED'}">selected</c:if>>Canceled</option>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-primary">Update Status</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Order Items -->
        <div class="card mt-4">
            <div class="card-header"><h5>Order Items</h5></div>
            <div class="card-body p-0">
                <c:if test="${not empty order.items}">
                    <ul class="list-group list-group-flush">
                        <c:forEach var="item" items="${order.items}">
                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                <div class="d-flex align-items-center">
                                    <img src="${pageContext.request.contextPath}/${not empty item.productImageUrl ? item.productImageUrl : 'images/placeholder.png'}"
                                         alt="${item.productName}" class="img-thumbnail order-item-img" />
                                    <div>
                                        <strong>${item.productName}</strong><br />
                                        <small>Product ID: ${item.productId}</small>
                                    </div>
                                </div>
                                <div>
                                    Qty: ${item.quantity} x $
                                    <fmt:formatNumber value="${item.priceAtPurchase}" type="number" minFractionDigits="2" />
                                </div>
                                <div>
                                    <strong>Subtotal: $
                                        <fmt:formatNumber value="${item.quantity * item.priceAtPurchase}" type="number" minFractionDigits="2" />
                                    </strong>
                                </div>
                            </li>
                        </c:forEach>
                    </ul>
                </c:if>
                <c:if test="${empty order.items}">
                    <p class="p-3">No items found for this order.</p>
                </c:if>
            </div>
            <div class="card-footer text-right">
                <h4>Grand Total:
                    <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="$" />
                </h4>
            </div>
        </div>
    </c:if>

    <c:if test="${empty order}">
        <div class="alert alert-danger mt-3">Order details could not be loaded.</div>
    </c:if>
</div>

</body>
</html>
