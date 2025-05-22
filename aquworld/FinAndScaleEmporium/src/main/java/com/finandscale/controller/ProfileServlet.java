package com.finandscale.controller;

import com.finandscale.dao.UserDAO;
import com.finandscale.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        User loggedInUser = (User) session.getAttribute("user");

        // Optionally fetch fresh data from DB
        User freshUser = userDAO.getUserByUsername(loggedInUser.getUsername());

        req.setAttribute("user", freshUser);
        req.getRequestDispatcher("profile.jsp").forward(req, resp);
    }
}
