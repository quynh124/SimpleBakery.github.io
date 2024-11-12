/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.service;

import com.models.Categories;
import java.util.List;

/**
 *
 * @author BAOTHI
 */
public interface CategoryDAO {
      public List<Categories> findAll();
    public void add(Categories categories);
    public void change(Categories categories);
    public Categories get(String id);
    public void delete(String id);
    public List<Categories> find(String keyword);
    int getNextCategoryId(String prefix);

    public List<Categories> getAllCategories();

   

    public boolean isCategoryUsedInProducts(String id);

}
