package com.finandscale.controller;

import com.finandscale.dao.UserDAO;
import com.finandscale.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Date;

@WebServlet("/update-profile") // <-- Ensure this path matches your form action
public class UpdateProfileServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect("login");
            return;
        }

        User currentUser = (User) session.getAttribute("user");

        // Get form data
        String firstname = req.getParameter("firstname");
        String lastname = req.getParameter("lastname");
        String email = req.getParameter("email");
        String birthdayStr = req.getParameter("birthday");
        String gender = req.getParameter("gender");

        // Basic validation
        if (firstname == null || firstname.isEmpty() ||
            lastname == null || lastname.isEmpty() ||
            email == null || email.isEmpty() ||
            birthdayStr == null || birthdayStr.isEmpty() ||
            gender == null || gender.isEmpty()) {

            req.setAttribute("error", "All fields are required.");
            req.getRequestDispatcher("edit-profile.jsp").forward(req, resp);
            return;
        }

        // Parse birthday
        Date birthday;
        try {
            birthday = Date.valueOf(birthdayStr); // yyyy-MM-dd format
        } catch (IllegalArgumentException e) {
            req.setAttribute("error", "Invalid date format.");
            req.getRequestDispatcher("edit-profile.jsp").forward(req, resp);
            return;
        }

        // Update user fields
        currentUser.setFirstname(firstname);
        currentUser.setLastname(lastname);
        currentUser.setEmail(email);
        currentUser.setBirthday(birthday);
        currentUser.setGender(gender);

        // Update DB
        boolean success = userDAO.updateUser(currentUser);

        if (success) {
            session.setAttribute("user", currentUser); // Update session
            req.setAttribute("message", "Profile updated successfully.");
        } else {
            req.setAttribute("error", "Profile update failed. Please try again.");
        }

        req.getRequestDispatcher("edit-profile.jsp").forward(req, resp);
    }
}
