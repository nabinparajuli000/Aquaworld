package com.finandscale.model;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

public class Order {
    private int id;
    private Date orderDate;
    private BigDecimal totalAmount;
    private String customerUsername;
    private String customerEmail;
    private String status;
    private List<OrderItem> items;

    public Order() {
    }

    public Order(Date orderDate, BigDecimal totalAmount, String customerUsername, String customerEmail, String status, List<OrderItem> items) {
        this.orderDate = orderDate;
        this.totalAmount = totalAmount;
        this.customerUsername = customerUsername;
        this.customerEmail = customerEmail;
        this.status = status;
        this.items = items;
    }

    // ID
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    // Order Date
    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    // Total Amount
    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    // Customer Username
    public String getCustomerUsername() {
        return customerUsername;
    }

    public void setCustomerUsername(String customerUsername) {
        this.customerUsername = customerUsername;
    }

    // Customer Email
    public String getCustomerEmail() {
        return customerEmail;
    }

    public void setCustomerEmail(String customerEmail) {
        this.customerEmail = customerEmail;
    }

    // Status
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    // Order Items
    public List<OrderItem> getItems() {
        return items;
    }

    public void setItems(List<OrderItem> items) {
        this.items = items;
    }
}
