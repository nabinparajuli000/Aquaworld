<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
    .navbar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        background-color: #007bff; /* Blue background */
        padding: 15px 40px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        font-family: 'Segoe UI', sans-serif;
    }

    .navbar-left {
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .navbar-left img {
        height: 24px;
        width: 24px;
    }

    .navbar-left .brand {
        font-weight: bold;
        font-size: 20px;
        color: white;
    }

    .navbar-center a,
    .navbar-right a {
        margin: 0 10px;
        text-decoration: none;
        color: white;
        font-weight: 500;
    }

    .navbar-center a:hover,
    .navbar-right a:hover {
        color: #cce5ff;
    }

    .navbar-center {
        display: flex;
        align-items: center;
    }

    .navbar-right {
        display: flex;
        align-items: center;
        gap: 15px;
    }

    .icon {
        font-size: 20px;
        color: white;
        text-decoration: none;
    }

    .navbar-right span {
        color: white;
    }
</style>

<div class="navbar">
    <div class="navbar-left">
        <img src="${pageContext.request.contextPath}/images/fish-icon.png" alt="Logo" />
        <span class="brand">AquaWorld</span>
    </div>

    <div class="navbar-center">
        <a href="${pageContext.request.contextPath}/index.jsp">Home</a>
        <a href="${pageContext.request.contextPath}/shop">Shop</a>
        <a href="${pageContext.request.contextPath}/about.jsp">About</a>
        <a href="${pageContext.request.contextPath}/contact.jsp">Contact</a>
    </div>

    <div class="navbar-right">
        <c:set var="cart" value="${sessionScope.cart}" />
        <c:set var="cartItemCount" value="0" />
        <c:if test="${not empty cart}">
            <c:set var="cartItemCount" value="${cart.itemCount}" />
        </c:if>

        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <a href="${pageContext.request.contextPath}/profile.jsp" class="icon" title="Profile">👤</a>
                <span>Hi, <c:out value="${sessionScope.user.username}"/></span>
                <c:if test="${sessionScope.user.role == 'admin'}">
                    <a href="${pageContext.request.contextPath}/admin/dashboard.jsp">Admin</a>
                </c:if>
                <a href="${pageContext.request.contextPath}/logout">Logout</a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/login">Login</a>
                <a href="${pageContext.request.contextPath}/register">Register</a>
            </c:otherwise>
        </c:choose>

        <a href="${pageContext.request.contextPath}/cart">
            <span class="icon">🛒</span> (<c:out value="${cartItemCount}"/>)
        </a>
    </div>
</div>
