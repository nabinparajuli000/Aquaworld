<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.finandscale.model.User" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.Date" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login");
        return;
    }

    String formattedBirthday = "Not provided";
    if (user.getBirthday() != null) {
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            formattedBirthday = sdf.format(user.getBirthday());
        } catch (Exception e) {
            formattedBirthday = "Invalid date";
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>User Profile</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f5f5f5;
            padding: 40px;
        }
        .profile-container {
            max-width: 600px;
            margin: auto;
            background-color: white;
            padding: 30px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            border-radius: 10px;
        }
        h2 {
            color: #007bff;
            text-align: center;
        }
        p {
            font-size: 16px;
            margin: 10px 0;
        }
        strong {
            display: inline-block;
            width: 120px;
        }
        .actions {
            text-align: center;
            margin-top: 20px;
        }
        .actions a {
            text-decoration: none;
            color: #fff;
            background-color: #007bff;
            padding: 10px 20px;
            border-radius: 6px;
            margin: 0 10px;
            transition: background-color 0.2s;
        }
        .actions a:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="profile-container">
        <h2>User Profile</h2>
        <p><strong>First Name:</strong> <%= user.getFirstname() != null ? user.getFirstname() : "Not provided" %></p>
        <p><strong>Last Name:</strong> <%= user.getLastname() != null ? user.getLastname() : "Not provided" %></p>
        <p><strong>Username:</strong> <%= user.getUsername() %></p>
        <p><strong>Email:</strong> <%= user.getEmail() %></p>
        <p><strong>Birthday:</strong> <%= formattedBirthday %></p>
        <p><strong>Gender:</strong> <%= user.getGender() != null ? user.getGender() : "Not provided" %></p>
        <p><strong>Role:</strong> <%= user.getRole() %></p>

        <div class="actions">
            <a href="edit-profile.jsp">Edit Profile</a>
            <a href="logout">Logout</a>
        </div>
    </div>
</body>
</html>
