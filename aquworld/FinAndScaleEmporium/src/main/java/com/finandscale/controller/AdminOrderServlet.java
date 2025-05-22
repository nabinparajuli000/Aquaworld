package com.finandscale.controller;

import com.finandscale.util.DatabaseUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/admin/order-details") // Consider renaming to /admin/orders if this is a list
public class AdminOrderServlet extends HttpServlet {

    public static class Order {
        private int id;
        private String customerName;
        private Timestamp orderDate;
        private double totalAmount;

        public int getId() { return id; }
        public String getCustomerName() { return customerName; }
        public Timestamp getOrderDate() { return orderDate; }
        public double getTotalAmount() { return totalAmount; }

        public void setId(int id) { this.id = id; }
        public void setCustomerName(String customerName) { this.customerName = customerName; }
        public void setOrderDate(Timestamp orderDate) { this.orderDate = orderDate; }
        public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        List<Order> orders = new ArrayList<>();

        String sql = "SELECT id, customer_name, order_date, total_amount FROM orders ORDER BY order_date DESC";

        try (Connection conn = DatabaseUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("id"));
                order.setCustomerName(rs.getString("customer_name"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                orders.add(order);
            }

        } catch (SQLException e) {
            throw new ServletException("Failed to load orders", e);
        }

        req.setAttribute("orders", orders);
        req.getRequestDispatcher("/admin/orders.jsp").forward(req, resp); // ✅ forward to the correct JSP
    }
}
