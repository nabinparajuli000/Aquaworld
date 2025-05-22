package com.finandscale.controller;

import com.finandscale.dao.OrderDAO;
import com.finandscale.model.Cart;
import com.finandscale.model.Order;
import com.finandscale.model.OrderItem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        if (cart == null || cart.getItems().isEmpty()) {
            session.setAttribute("cartError", "Your cart is empty.");
            resp.sendRedirect(req.getContextPath() + "/cart.jsp");
            return;
        }

        // Forward to checkout confirmation page
        req.getRequestDispatcher("/checkout.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        if (cart == null || cart.getItems().isEmpty()) {
            session.setAttribute("cartError", "Your cart is empty.");
            resp.sendRedirect(req.getContextPath() + "/cart.jsp");
            return;
        }

        Order order = new Order();
        order.setOrderDate(new Date());
        order.setTotalAmount(cart.getTotal());

        List<OrderItem> orderItems = cart.getItems().stream()
            .map(item -> new OrderItem(item.getProduct(), item.getQuantity(), item.getSubtotal()))
            .toList();

        order.setItems(orderItems);

        try {
            OrderDAO orderDAO = new OrderDAO();
            orderDAO.saveOrder(order);
            session.removeAttribute("cart");
            session.setAttribute("cartMessage", "Thank you! Your order has been placed.");
            resp.sendRedirect(req.getContextPath() + "/cart.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
            session.setAttribute("cartError", "Error processing order.");
            resp.sendRedirect(req.getContextPath() + "/cart.jsp");
        }
    }

}
