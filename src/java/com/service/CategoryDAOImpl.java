/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.service;

import com.models.Categories;
import com.service.CategoryDAO;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.sql.DataSource;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

public class CategoryDAOImpl implements CategoryDAO {

    private JdbcTemplate jdbcTemplate;

    public CategoryDAOImpl() {
    }

    public CategoryDAOImpl(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    @Override
    public List<Categories> findAll() {
        String sql = "SELECT CategoryID, CategoryName, Decription ,isDeleted FROM Categories";
        List<Categories> categoryList = new ArrayList<>();
        List<Map<String, Object>> rows = jdbcTemplate.queryForList(sql);
        for (Map<String, Object> row : rows) {
            Categories obj = new Categories();
            obj.setCategoryID((String) row.get("CategoryID"));
            obj.setCategoryName((String) row.get("CategoryName"));
            obj.setDecription((String) row.get("Decription"));
            Boolean isDeletedValue = (Boolean) row.get("isDeleted");
            obj.setIsDeleted(isDeletedValue != null && isDeletedValue); // Gán giá trị boolean
            categoryList.add(obj);
        }
        return categoryList;
    }

    @Override
    public void add(Categories categories) {
        String sql = "INSERT INTO Categories (CategoryID, CategoryName, Decription, isDeleted) VALUES (?, ?, ?, ?)";
        jdbcTemplate.update(sql, categories.getCategoryID(), categories.getCategoryName(), categories.getDecription(), false); // Thiết lập isDeleted mặc định là false
    }

    @Override
    public void change(Categories categories) {
        String sql = "UPDATE Categories SET CategoryName = ?, Decription = ? WHERE CategoryID = ?";
        jdbcTemplate.update(sql, categories.getCategoryName(), categories.getDecription(), categories.getCategoryID());
    }

    @Override
    public int getNextCategoryId(String prefix) {
        // Truy vấn SQL để lấy số tự động tăng lớn nhất hiện có với prefix cụ thể
        String sql = "SELECT COALESCE(MAX(CAST(SUBSTRING(categoryID, LEN(?) + 1, LEN(categoryID) - LEN(?)) AS INT)), 0) "
                + "FROM Categories WHERE categoryID LIKE ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{prefix, prefix, prefix + "%"}, Integer.class);
    }

    @Override
    public Categories get(String id) {
        String sql = "SELECT * FROM Categories WHERE CategoryID = ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{id}, BeanPropertyRowMapper.newInstance(Categories.class));
    }

    @Override
    public void delete(String id) {
        String sql = "UPDATE Categories SET isDeleted = ? WHERE CategoryID = ?";
        jdbcTemplate.update(sql, true, id);
    }

    @Override
    public List<Categories> find(String keyword) {
        String sql = "SELECT * FROM Categories WHERE CategoryID LIKE ? OR Decription LIKE ?";
        keyword = "%" + keyword + "%";
        return jdbcTemplate.query(sql, new Object[]{keyword, keyword}, BeanPropertyRowMapper.newInstance(Categories.class));
    }

    public JdbcTemplate getJdbcTemplate() {
        return jdbcTemplate;
    }

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public List<Categories> getAllCategories() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean isCategoryUsedInProducts(String categoryID) {
        String sql = "SELECT COUNT(*) FROM Products WHERE categoryID = ?";
        int count = jdbcTemplate.queryForObject(sql, new Object[]{categoryID}, Integer.class);
        return count > 0;
    }

}
