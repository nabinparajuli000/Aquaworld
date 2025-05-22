<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="/_auth.jsp" />
<jsp:include page="/_navbar.jsp" />

<html>
<head>
    <title>Add New Product - Admin</title>
    <style>
        /* Your existing styles preserved */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f7f9fc;
            margin: 0;
            padding: 0;
        }

        .form-container {
            max-width: 600px;
            margin: 50px auto;
            padding: 30px;
            background-color: #ffffff;
            border-radius: 12px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.05);
        }

        h1 {
            text-align: center;
            color: #005f73;
            margin-bottom: 25px;
        }

        .form-container div {
            margin-bottom: 15px;
        }

        label {
            display: block;
            font-weight: bold;
            margin-bottom: 6px;
            color: #333;
        }

        input[type="text"],
        input[type="number"],
        textarea,
        select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
            box-sizing: border-box;
            transition: border-color 0.3s;
        }

        input[type="text"]:focus,
        input[type="number"]:focus,
        textarea:focus,
        select:focus {
            border-color: #0a9396;
            outline: none;
        }

        textarea {
            resize: vertical;
        }

        .error {
            color: #d00000;
            background: #ffe5e5;
            padding: 10px;
            border-radius: 6px;
            margin-bottom: 20px;
        }

        button[type="submit"] {
            background-color: #0a9396;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button[type="submit"]:hover {
            background-color: #007f80;
        }

        a.cancel-link {
            margin-left: 15px;
            color: #555;
            text-decoration: none;
            font-size: 15px;
        }

        a.cancel-link:hover {
            text-decoration: underline;
        }

        @media (max-width: 600px) {
            .form-container {
                margin: 20px;
                padding: 20px;
            }

            button[type="submit"],
            a.cancel-link {
                display: block;
                margin-top: 10px;
            }
        }
    </style>
</head>
<body>

<div class="form-container">
    <h1>Add New Product</h1>

    <c:if test="${not empty error}">
        <p class="error"><c:out value="${error}"/></p>
    </c:if>

    <form action="${pageContext.request.contextPath}/admin/products/add" method="post" enctype="multipart/form-data">
        <div>
            <label for="name">Product Name:</label>
            <input type="text" id="name" name="name" value="${param.name}" required>
        </div>
        <div>
            <label for="description">Description:</label>
            <textarea id="description" name="description" rows="4" required>${param.description}</textarea>
        </div>
        <div>
            <label for="price">Price (e.g., 19.99):</label>
            <input type="number" id="price" name="price" step="0.01" min="0" value="${param.price}" required>
        </div>
        <div>
            <label for="category">Category:</label>
            <select id="category" name="category" required>
                <option value="">-- Select Category --</option>
                <option value="fish" <c:if test="${param.category == 'fish'}">selected</c:if>>Fish</option>
                <option value="plant" <c:if test="${param.category == 'plant'}">selected</c:if>>Plant</option>
                <option value="equipment" <c:if test="${param.category == 'equipment'}">selected</c:if>>Equipment</option>
                <option value="decoration" <c:if test="${param.category == 'decoration'}">selected</c:if>>Decoration</option>
            </select>
        </div>
        <div>
            <label for="quantity">Stock Quantity:</label>
            <input type="number" id="quantity" name="quantity" min="0" value="${param.quantity}" required>
        </div>
        <div>
            <label for="imageFile">Product Image (Optional):</label>
            <input type="file" id="imageFile" name="imageFile" accept="image/png, image/jpeg, image/gif">
        </div>
        <div>
            <button type="submit">Add Product</button>
            <a class="cancel-link" href="${pageContext.request.contextPath}/admin/products">Cancel</a>
        </div>
    </form>
</div>

</body>
</html>
