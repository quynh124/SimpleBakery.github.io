/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.service;

import com.models.CartItem;
import java.math.BigDecimal;
import java.util.List;

/**
 *
 * @author BAOTHI
 */
public interface CartDAO {
   
     void addCartItem(int userID, CartItem cartItem);
    // Cập nhật số lượng của một sản phẩm trong giỏ hàng
    void updateCartItem(CartItem cartItem);
    
    // Xóa một sản phẩm khỏi giỏ hàng
    void removeCartItem(String cartItemId);
    
    // Lấy danh sách các sản phẩm trong giỏ hàng của người dùng
    List<CartItem> getCartItems(String userId);
    
    // Xóa tất cả các sản phẩm trong giỏ hàng
    void clearCart(String userId);

    public BigDecimal calculateSubtotal(List<CartItem> cartItems);
}
