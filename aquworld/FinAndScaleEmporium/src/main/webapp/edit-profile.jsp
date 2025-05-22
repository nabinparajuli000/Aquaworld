<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.finandscale.model.User" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login");
        return;
    }

    String formattedBirthday = "";
    if (user.getBirthday() != null) {
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            formattedBirthday = sdf.format(user.getBirthday());
        } catch (Exception e) {
            formattedBirthday = "";
        }
    }

    String message = (String) request.getAttribute("message");
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Profile</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f0f2f5;
            padding: 40px;
        }
        .form-container {
            max-width: 600px;
            margin: auto;
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            color: #007bff;
        }
        form {
            margin-top: 20px;
        }
        label {
            display: block;
            margin-top: 15px;
            font-weight: bold;
        }
        input, select {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        .btn {
            display: block;
            width: 100%;
            margin-top: 20px;
            padding: 10px;
            background-color: #007bff;
            color: white;
            font-weight: bold;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.2s;
        }
        .btn:hover {
            background-color: #0056b3;
        }
        .message {
            margin-top: 15px;
            text-align: center;
            color: green;
        }
        .error {
            margin-top: 15px;
            text-align: center;
            color: red;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Edit Profile</h2>

        <% if (message != null) { %>
            <p class="message"><%= message %></p>
        <% } %>
        <% if (error != null) { %>
            <p class="error"><%= error %></p>
        <% } %>

        <form method="post" action="update-profile">
            <label for="firstname">First Name</label>
            <input type="text" name="firstname" id="firstname" value="<%= user.getFirstname() %>" required>

            <label for="lastname">Last Name</label>
            <input type="text" name="lastname" id="lastname" value="<%= user.getLastname() %>" required>

            <label for="email">Email</label>
            <input type="email" name="email" id="email" value="<%= user.getEmail() %>" required>

            <label for="birthday">Birthday</label>
            <input type="date" name="birthday" id="birthday" value="<%= formattedBirthday %>" required>

            <label for="gender">Gender</label>
            <select name="gender" id="gender" required>
                <option value="">Select Gender</option>
                <option value="Male" <%= "Male".equals(user.getGender()) ? "selected" : "" %>>Male</option>
                <option value="Female" <%= "Female".equals(user.getGender()) ? "selected" : "" %>>Female</option>
                <option value="Other" <%= "Other".equals(user.getGender()) ? "selected" : "" %>>Other</option>
            </select>

            <button class="btn" type="submit">Update Profile</button>
        </form>
    </div>
</body>
</html>
