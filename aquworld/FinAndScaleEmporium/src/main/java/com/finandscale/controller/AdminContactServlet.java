package com.finandscale.controller;

import com.finandscale.util.DatabaseUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/admin/contact_messages") // ✅ Match the JSP link!
public class AdminContactServlet extends HttpServlet {

    public static class ContactMessage {
        private int id;
        private String name;
        private String email;
        private String subject;
        private String message;
        private Timestamp submittedAt;

        // ✅ Add Getters (JSP uses dot notation, so getters are required)
        public int getId() { return id; }
        public String getName() { return name; }
        public String getEmail() { return email; }
        public String getSubject() { return subject; }
        public String getMessage() { return message; }
        public Timestamp getSubmittedAt() { return submittedAt; }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        List<ContactMessage> messages = new ArrayList<>();

        try (Connection conn = DatabaseUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT * FROM contact_messages ORDER BY submitted_at DESC")) {

            while (rs.next()) {
                ContactMessage msg = new ContactMessage();
                msg.id = rs.getInt("id");
                msg.name = rs.getString("name");
                msg.email = rs.getString("email");
                msg.subject = rs.getString("subject");
                msg.message = rs.getString("message");
                msg.submittedAt = rs.getTimestamp("submitted_at");
                messages.add(msg);
            }

        } catch (SQLException e) {
            throw new ServletException("Error loading contact messages", e);
        }

        req.setAttribute("messages", messages);
        req.getRequestDispatcher("/admin/contact_messages.jsp").forward(req, resp);
    }
}
