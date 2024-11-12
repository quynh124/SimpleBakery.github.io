/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.service;

import com.models.CartItem;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;



public class CartDAOImpl implements CartDAO {

    // Sử dụng một HashMap để lưu trữ giỏ hàng. Key là userId và value là danh sách các CartItem.
    private Map<String, List<CartItem>> cartStorage = new HashMap<>();

    @Override
    public void addCartItem(int UserID,CartItem cartItem) {
        List<CartItem> cartItems = cartStorage.getOrDefault(cartItem.getUserID(), new ArrayList<>());
        cartItems.add(cartItem);
       
    }

    

 @Override
public void removeCartItem(String cartItemId) {
    if (cartItemId == null || cartItemId.trim().isEmpty()) {
        System.out.println("Provided cartItemId is null or empty.");
        return;
    }
    boolean removed = false;
    System.out.println("Attempting to remove item with ID: " + cartItemId);
    for (List<CartItem> cartItems : cartStorage.values()) {
        removed = cartItems.removeIf(item -> item.getCartItemId().equals(cartItemId));
        if (removed) {
            System.out.println("Item with ID " + cartItemId + " removed successfully.");
            break;
        }
    }
    if (!removed) {
        System.out.println("Item with ID " + cartItemId + " not found.");
    }
}



    @Override
    public List<CartItem> getCartItems(String userId) {
        return cartStorage.getOrDefault(userId, new ArrayList<>());
    }

    @Override
    public void clearCart(String userId) {
        cartStorage.remove(userId);
    }

    @Override
    public void updateCartItem(CartItem cartItem) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public BigDecimal calculateSubtotal(List<CartItem> list) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}


