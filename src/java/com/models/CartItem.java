/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.models;

import java.math.BigDecimal;

/**
 *
 * @author BAOTHI
 */
public class CartItem {

    private String cartItemId;
    private String productID;
    private String productName;
    private int size;
    private int quantityCart;
    private BigDecimal unitPrice;
    private BigDecimal total;
    private int userID;
    private String image;  // Thêm trường ảnh

   

    // Getter và Setter cho tất cả các thuộc tính
    public String getProductID() {
        return productID;
    }

    public void setProductID(String productID) {
        this.productID = productID;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public int getSize() {
        return size;
    }

    public void setSize(int size) {
        this.size = size;
    }

    public int getQuantityCart() {
        return quantityCart;
    }

    public void setQuantityCart(int quantityCart) {
        this.quantityCart = quantityCart;
    }

    public BigDecimal getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(BigDecimal unitPrice) {
        this.unitPrice = unitPrice;
    }

   public BigDecimal getTotal() {
        // Tính toán tổng giá của sản phẩm dựa trên số lượng và giá đơn vị
        return unitPrice.multiply(BigDecimal.valueOf(quantityCart));
    }

    public void setTotal(BigDecimal total) {
        this.total = total;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getCartItemId() {
        return cartItemId;
    }

    public void setCartItemId(String cartItemId) {
        this.cartItemId = cartItemId;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

}
