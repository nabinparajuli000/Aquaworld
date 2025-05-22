package com.finandscale.dao;

import com.finandscale.model.CartItem;
import com.finandscale.model.Product;
import com.finandscale.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartItemDAO {

    public void addToCart(String sessionId, int productId, int quantity) throws SQLException {
        String sql = "INSERT INTO cart_items (session_id, product_id, quantity) VALUES (?, ?, ?) " +
                     "ON DUPLICATE KEY UPDATE quantity = quantity + ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, sessionId);
            stmt.setInt(2, productId);
            stmt.setInt(3, quantity);
            stmt.setInt(4, quantity);
            stmt.executeUpdate();
        }
    }

    public List<CartItem> getCartItems(String sessionId) throws SQLException {
        String sql = "SELECT ci.id AS cart_item_id, ci.quantity AS cart_quantity, " +
                     "p.id AS product_id, p.name AS product_name, p.price, p.image_url, p.stock_quantity " +
                     "FROM cart_items ci JOIN products p ON ci.product_id = p.id WHERE ci.session_id = ?";
        List<CartItem> items = new ArrayList<>();

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, sessionId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Product product = new Product();
                    product.setId(rs.getInt("product_id"));
                    product.setName(rs.getString("product_name"));
                    product.setPrice(rs.getBigDecimal("price"));
                    product.setImageUrl(rs.getString("image_url"));
                    product.setStockQuantity(rs.getInt("stock_quantity"));

                    CartItem item = new CartItem();
                    item.setId(rs.getInt("cart_item_id"));
                    item.setSessionId(sessionId);
                    item.setProduct(product);
                    item.setQuantity(rs.getInt("cart_quantity"));

                    items.add(item);
                }
            }
        }

        return items;
    }

    public void updateQuantity(int cartItemId, int quantity) throws SQLException {
        String sql = "UPDATE cart_items SET quantity = ? WHERE id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, quantity);
            stmt.setInt(2, cartItemId);
            stmt.executeUpdate();
        }
    }

    public void removeItem(int cartItemId) throws SQLException {
        String sql = "DELETE FROM cart_items WHERE id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, cartItemId);
            stmt.executeUpdate();
        }
    }

    public void clearCart(String sessionId) throws SQLException {
        String sql = "DELETE FROM cart_items WHERE session_id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, sessionId);
            stmt.executeUpdate();
        }
    }
}
