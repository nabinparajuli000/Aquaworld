package com.finandscale.controller;


import com.finandscale.util.DatabaseUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(urlPatterns = {"/about", "/contact"}) // Handling multiple paths
public class ContentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        if ("/about".equals(path)) {
            req.getRequestDispatcher("/about.jsp").forward(req, resp);
        } else if ("/contact".equals(path)) {
            req.getRequestDispatcher("/contact.jsp").forward(req, resp);
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        if ("/contact".equals(path)) {
            String name = req.getParameter("name");
            String email = req.getParameter("email");
            String subject = req.getParameter("subject");
            String message = req.getParameter("message");

            if (name == null || name.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                subject == null || subject.trim().isEmpty() ||
                message == null || message.trim().isEmpty()) {

                req.setAttribute("formMessage", "All fields are required.");
                req.setAttribute("formStatus", "error");
                req.getRequestDispatcher("/contact.jsp").forward(req, resp);
                return;
            }

            // Insert into database
            try (Connection conn = DatabaseUtil.getConnection()) {
                String sql = "INSERT INTO contact_messages (name, email, subject, message) VALUES (?, ?, ?, ?)";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, name);
                    stmt.setString(2, email);
                    stmt.setString(3, subject);
                    stmt.setString(4, message);
                    stmt.executeUpdate();
                }
            } catch (SQLException e) {
                e.printStackTrace();
                req.setAttribute("formMessage", "An error occurred while saving your message. Please try again later.");
                req.setAttribute("formStatus", "error");
                req.getRequestDispatcher("/contact.jsp").forward(req, resp);
                return;
            }

            // Success
            req.setAttribute("formMessage", "Thank you for your message! We will get back to you soon.");
            req.setAttribute("formStatus", "success");
            req.getRequestDispatcher("/contact.jsp").forward(req, resp);
        } else {
            resp.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
        }
    }
}
