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
import java.util.List;

@WebServlet("/admin/users/*")
public class AdminUserServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null ||
            !"admin".equals(((User)session.getAttribute("user")).getRole())) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
            return;
        }

        String action = req.getPathInfo();

        if (action == null || action.equals("/")) {
            // List all users
            List<User> users = userDAO.getAllUsers();
            req.setAttribute("users", users);
            req.getRequestDispatcher("/admin/manageUsers.jsp").forward(req, resp);
        } else if (action.equals("/view")) {
            try {
                int userId = Integer.parseInt(req.getParameter("id"));
                User userToView = userDAO.getUserById(userId);
                if (userToView != null) {
                    req.setAttribute("userToView", userToView);
                    req.getRequestDispatcher("/admin/viewUser.jsp").forward(req, resp);
                } else {
                    req.setAttribute("adminMessage", "User not found.");
                    req.setAttribute("messageType", "error"); // For styling
                    List<User> users = userDAO.getAllUsers();
                    req.setAttribute("users", users);
                    req.getRequestDispatcher("/admin/manageUsers.jsp").forward(req, resp);
                }
            } catch (NumberFormatException e) {
                req.setAttribute("adminMessage", "Invalid user ID format.");
                 req.setAttribute("messageType", "error");
                List<User> users = userDAO.getAllUsers();
                req.setAttribute("users", users);
                req.getRequestDispatcher("/admin/manageUsers.jsp").forward(req, resp);
            }
        }
        // Add more actions like /editRole if needed
        else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null ||
            !"admin".equals(((User)session.getAttribute("user")).getRole())) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
            return;
        }

        // String action = req.getPathInfo();
        // Handle POST requests for actions like changing role, deactivating user, etc.
        // Example:
        /*
        if (action != null && action.equals("/updateRole")) {
            try {
                int userId = Integer.parseInt(req.getParameter("userId"));
                String newRole = req.getParameter("newRole");
                if (userDAO.updateUserRole(userId, newRole)) {
                    req.getSession().setAttribute("adminMessage", "User role updated successfully!");
                } else {
                    req.getSession().setAttribute("adminMessage", "Failed to update user role.");
                    req.getSession().setAttribute("messageType", "error");
                }
            } catch (NumberFormatException e) {
                req.getSession().setAttribute("adminMessage", "Invalid user ID.");
                req.getSession().setAttribute("messageType", "error");
            }
            resp.sendRedirect(req.getContextPath() + "/admin/users");
        } else {
            resp.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
        }
        */
        // For now, just redirect back if no POST action is defined
        resp.sendRedirect(req.getContextPath() + "/admin/users");
    }
}