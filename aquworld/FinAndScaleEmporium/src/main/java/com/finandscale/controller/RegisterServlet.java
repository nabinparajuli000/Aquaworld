package com.finandscale.controller;

import com.finandscale.dao.UserDAO;
import com.finandscale.model.User;
import com.finandscale.util.PasswordUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String firstname = req.getParameter("firstname");
        String lastname = req.getParameter("lastname");
        String username = req.getParameter("username");
        String birthdayStr = req.getParameter("birthday");
        String gender = req.getParameter("gender");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");

        String errorMsg = null;

        // Validation
        if (firstname == null || firstname.trim().isEmpty() ||
            lastname == null || lastname.trim().isEmpty() ||
            username == null || username.trim().isEmpty() ||
            birthdayStr == null || birthdayStr.trim().isEmpty() ||
            gender == null || gender.trim().isEmpty() || gender.equals("Select Gender") ||
            email == null || email.trim().isEmpty() ||
            password == null || password.isEmpty()) {
            errorMsg = "All fields are required.";
        } else if (!password.equals(confirmPassword)) {
            errorMsg = "Passwords do not match.";
        } else if (userDAO.userExists(username, email)) {
            errorMsg = "Username or Email already exists.";
        }

        if (errorMsg != null) {
            req.setAttribute("error", errorMsg);
            req.getRequestDispatcher("register.jsp").forward(req, resp);
            return;
        }

        // Parse birthday
        Date birthday = null;
        try {
            birthday = Date.valueOf(birthdayStr); // expects yyyy-MM-dd
        } catch (IllegalArgumentException e) {
            req.setAttribute("error", "Invalid birthday format.");
            req.getRequestDispatcher("register.jsp").forward(req, resp);
            return;
        }

        // Hash password
        byte[] saltBytes = PasswordUtil.generateSalt();
        String salt = PasswordUtil.encodeSalt(saltBytes);
        String hashedPassword = PasswordUtil.hashPassword(password, saltBytes);

        // Create user object
        User newUser = new User();
        newUser.setFirstname(firstname);
        newUser.setLastname(lastname);
        newUser.setUsername(username);
        newUser.setBirthday(birthday);
        newUser.setGender(gender);
        newUser.setEmail(email);
        newUser.setPassword(hashedPassword);
        newUser.setSalt(salt);
        newUser.setRole("user");

        // Save user
        if (userDAO.addUser(newUser)) {
            req.setAttribute("success_reg", "Registration successful! Please login.");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
        } else {
            req.setAttribute("error", "Registration failed. Please try again.");
            req.getRequestDispatcher("register.jsp").forward(req, resp);
        }
    }
}
