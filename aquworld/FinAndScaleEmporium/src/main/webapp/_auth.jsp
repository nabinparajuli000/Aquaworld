<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:if test="${empty sessionScope.user || sessionScope.user.role != 'admin'}">
    <c:redirect url="${pageContext.request.contextPath}/login.jsp?error=unauthorized"/>
</c:if>
