<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="/_auth.jsp" />
<jsp:include page="/_navbar.jsp" />

<html>
<head>
    <title>Edit Product</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f4f4;
            padding: 40px;
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #333;
        }

        form {
            background-color: #fff;
            max-width: 500px;
            margin: 0 auto;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }

        label {
            font-weight: bold;
            display: block;
            margin-top: 15px;
            margin-bottom: 5px;
            color: #333;
        }

        input[type="text"],
        input[type="number"],
        textarea,
        select {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 4px;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }

        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 12px 20px;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 15px;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }

        .cancel-link {
            display: inline-block;
            margin-left: 10px;
            color: #555;
            text-decoration: none;
            padding: 10px 15px;
        }

        .cancel-link:hover {
            text-decoration: underline;
        }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: #555;
        }

        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<h2>Edit Product</h2>

<form action="${pageContext.request.contextPath}/admin/products/edit" method="post" enctype="multipart/form-data">
    <input type="hidden" name="id" value="${product.id}" />

    <label for="name">Product Name:</label>
    <input type="text" id="name" name="name" value="<c:out value='${product.name}'/>" required>

    <label for="description">Description:</label>
    <textarea id="description" name="description" rows="4" cols="50"><c:out value='${product.description}'/></textarea>

    <label for="price">Price:</label>
    <input type="number" step="0.01" id="price" name="price" value="${product.price}" required>

    <label for="quantity">Quantity:</label>
    <input type="number" id="quantity" name="quantity" value="${product.quantity}" required>

    <label for="category">Category:</label>
    <select id="category" name="category" required>
        <option value="">-- Select Category --</option>
        <option value="fish" <c:if test="${product.category == 'fish'}">selected</c:if>>Fish</option>
        <option value="plant" <c:if test="${product.category == 'plant'}">selected</c:if>>Plant</option>
        <option value="equipment" <c:if test="${product.category == 'equipment'}">selected</c:if>>Equipment</option>
        <option value="decoration" <c:if test="${product.category == 'decoration'}">selected</c:if>>Decoration</option>
    </select>

    <label for="imageFile">Upload New Image (optional):</label>
    <input type="file" id="imageFile" name="imageFile" accept="image/png, image/jpeg, image/gif">

    <input type="submit" value="Update Product">
    <a class="cancel-link" href="${pageContext.request.contextPath}/admin/products">Cancel</a>
</form>

<a class="back-link" href="${pageContext.request.contextPath}/admin/products">Back to Product List</a>

</body>
</html>
