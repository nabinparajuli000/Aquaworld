package com.finandscale.model;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class Cart {
    private List<CartItem> items;

    public Cart() {
        this.items = new ArrayList<>();
    }

    public List<CartItem> getItems() {
        return items;
    }

    public void addItem(Product product, int quantity) {
        if (product == null || quantity <= 0) {
            return; // Or throw an exception
        }

        // Check if item already exists in cart
        Optional<CartItem> existingItemOpt = items.stream()
                .filter(item -> item.getProduct().getId() == product.getId())
                .findFirst();

        if (existingItemOpt.isPresent()) {
            CartItem existingItem = existingItemOpt.get();
            existingItem.setQuantity(existingItem.getQuantity() + quantity);
        } else {
            items.add(new CartItem(product, quantity));
        }
    }

    public void updateItemQuantity(int productId, int quantity) {
        if (quantity <= 0) {
            removeItem(productId); // Remove if quantity is zero or less
            return;
        }
        items.stream()
             .filter(item -> item.getProduct().getId() == productId)
             .findFirst()
             .ifPresent(item -> item.setQuantity(quantity));
    }

    public void removeItem(int productId) {
        items.removeIf(item -> item.getProduct().getId() == productId);
    }

    public BigDecimal getTotal() {
        return items.stream()
                    .map(CartItem::getSubtotal)
                    .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    public int getItemCount() {
        return items.stream()
                    .mapToInt(CartItem::getQuantity)
                    .sum();
    }

    public void clearCart() {
        items.clear();
    }
}