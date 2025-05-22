package com.finandscale.dao;

import com.finandscale.model.Order;
import com.finandscale.model.OrderItem;
import com.finandscale.util.DatabaseUtil;

import java.sql.*;
import java.util.List;

public class OrderDAO {

    public int saveOrder(Order order) throws SQLException {
        String insertOrderSql = "INSERT INTO orders (order_date, total_amount) VALUES (?, ?)";
        String insertItemSql = "INSERT INTO order_items (order_id, product_id, quantity, subtotal) VALUES (?, ?, ?, ?)";

        Connection conn = null;
        PreparedStatement orderStmt = null;
        PreparedStatement itemStmt = null;
        ResultSet generatedKeys = null;

        try {
            conn = DatabaseUtil.getConnection();
            conn.setAutoCommit(false);

            orderStmt = conn.prepareStatement(insertOrderSql, Statement.RETURN_GENERATED_KEYS);
            orderStmt.setTimestamp(1, new Timestamp(order.getOrderDate().getTime()));
            orderStmt.setBigDecimal(2, order.getTotalAmount());
            orderStmt.executeUpdate();

            generatedKeys = orderStmt.getGeneratedKeys();
            if (generatedKeys.next()) {
                int orderId = generatedKeys.getInt(1);
                order.setId(orderId);

                itemStmt = conn.prepareStatement(insertItemSql);
                for (OrderItem item : order.getItems()) {
                    itemStmt.setInt(1, orderId);
                    itemStmt.setInt(2, item.getProduct().getId());
                    itemStmt.setInt(3, item.getQuantity());
                    itemStmt.setBigDecimal(4, item.getSubtotal());
                    itemStmt.addBatch();
                }

                itemStmt.executeBatch();
                conn.commit();
                return orderId;
            } else {
                throw new SQLException("Creating order failed, no ID obtained.");
            }

        } catch (SQLException e) {
            if (conn != null) conn.rollback();
            throw e;
        } finally {
            if (generatedKeys != null) generatedKeys.close();
            if (orderStmt != null) orderStmt.close();
            if (itemStmt != null) itemStmt.close();
            if (conn != null) conn.close();
        }
    }
}
