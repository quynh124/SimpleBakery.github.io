/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.service;

import com.models.Products;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

/**
 *
 * @author BAOTHI
 */
public interface ProductDAO {

    public List<Products> findAll();

    public void add(Products products);

    public void change(Products products);

    public Products get(String id);

    public void delete(String id);

    public List<Products> find(String keyword);

    public void update(Products product);

    public String getNextProductID(String categoryID, String productName);

    public List<Products> filterProducts(String category, String search);

    public List<Products> findByCategoryId(String categoryID);

    public Products findById(String productId);

    public Products getProductById(String productId);

    public BigDecimal getProductPrice(String productID);

    public Map<String, Integer> getProductCountsByCategory();

    public String getProductName(String productID);

    public Products findByID(String productID);

    public Map<String, Integer> getTopSellingProducts();

    public List<Products> findActiveProductsPaged(int startIndex, int pageSize);

    public int countActiveProducts();
public Map<String, Integer> getTopSellingProductsByMonth();
    public List<String> findAllProductNames();
}
