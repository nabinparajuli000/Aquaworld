package com.finandscale.controller;

import com.finandscale.dao.UserDAO;
import com.finandscale.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        User user = userDAO.getUserByUsername(username);

        // Check user credentials (in production use hashed password comparison)
        if (user != null && user.getPassword().equals(password)) {
            // Invalidate old session and create new one (prevents session fixation)
            HttpSession oldSession = req.getSession(false);
            if (oldSession != null) {
                oldSession.invalidate();
            }

            HttpSession newSession = req.getSession(true);
            newSession.setAttribute("user", user); // Store full user object

            // Optional: Flash message (can be shown in header or toast)
            newSession.setAttribute("flashMessage", "Login successful! Welcome, " + user.getUsername() + ".");
            newSession.setAttribute("flashMessageType", "success");

            // Redirect based on role
            if ("admin".equals(user.getRole())) {
                resp.sendRedirect(req.getContextPath() + "/admin/dashboard.jsp");
            } else {
                resp.sendRedirect(req.getContextPath() + "/home.jsp");
            }
        } else {
            // Handle login failure with request-scoped error
            req.setAttribute("error", "Invalid username or password.");
            req.setAttribute("toastMessage", "Login failed: Invalid credentials.");
            req.setAttribute("toastMessageType", "error");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
        }
    }
}
