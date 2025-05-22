package com.finandscale.model;

import java.math.BigDecimal;

public class CartItem {
    private int id;
    private String sessionId;
    private Product product;
    private int quantity;

    // Constructors
    public CartItem() {}

    public CartItem(Product product, int quantity) {
        this.product = product;
        this.quantity = quantity;
    }

    // Getters and setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getSessionId() {
        return sessionId;
    }

    public void setSessionId(String sessionId) {
        this.sessionId = sessionId;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    // Calculate subtotal (price * quantity)
    public BigDecimal getSubtotal() {
        if (product != null && product.getPrice() != null) {
            return product.getPrice().multiply(BigDecimal.valueOf(quantity));
        }
        return BigDecimal.ZERO;
    }

    // Optional: Equals & hashCode based on product id
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof CartItem)) return false;

        CartItem that = (CartItem) o;
        return product != null && that.product != null && product.getId() == that.product.getId();
    }

    @Override
    public int hashCode() {
        return product != null ? Integer.hashCode(product.getId()) : 0;
    }
}
