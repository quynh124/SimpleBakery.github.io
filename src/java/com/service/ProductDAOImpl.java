/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.service;

import com.models.Products;
import java.math.BigDecimal;
import java.sql.Connection;
import java.util.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.sql.DataSource;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.web.multipart.MultipartFile;

public class ProductDAOImpl implements ProductDAO {

    private JdbcTemplate jdbcTemplate;

    public ProductDAOImpl() {
    }

    public ProductDAOImpl(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    @Override
    public List<Products> findAll() {
        String sql = "SELECT ProductID, ProductName, UnitPrice, Size, Image, Quantity, Decription, CategoryID, isDeleted, createDate FROM Products";
        List<Products> productList = new ArrayList<>();
        List<Map<String, Object>> rows = jdbcTemplate.queryForList(sql);
        for (Map<String, Object> row : rows) {
            Products obj = new Products();
            obj.setProductID((String) row.get("ProductID"));
            obj.setProductName((String) row.get("ProductName"));
            obj.setUnitPrice((BigDecimal) row.get("UnitPrice"));
            obj.setSize((int) row.get("Size"));
            obj.setImage((String) row.get("Image"));
            obj.setQuantity((int) row.get("Quantity"));
            obj.setDecription((String) row.get("Decription"));
            obj.setCategoryID((String) row.get("CategoryID"));

            // Lấy giá trị isDeleted trực tiếp
            Boolean isDeletedValue = (Boolean) row.get("isDeleted");
            obj.setIsDeleted(isDeletedValue != null && isDeletedValue); // Gán giá trị boolean

            // Thêm dòng này để lấy giá trị createDate
            obj.setCreateDate((Date) row.get("createDate"));

            productList.add(obj);
        }
        return productList;
    }

    @Override
    public List<Products> findByCategoryId(String categoryId) {
        List<Products> products = new ArrayList<>();
        String sql = "SELECT * FROM Products WHERE categoryID = ?";

        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, categoryId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Products product = new Products();
                    // Lấy dữ liệu từ ResultSet và gán vào đối tượng Products
                    product.setProductID(rs.getString("productID"));
                    product.setProductName(rs.getString("productName"));
                    product.setUnitPrice(rs.getBigDecimal("unitPrice"));
                    product.setSize(rs.getInt("Size"));
                    product.setImage(rs.getString("Image"));
                    product.setQuantity(rs.getInt("Quantity"));
                    product.setDecription(rs.getString("Decription"));
                    product.setCategoryID(rs.getString("categoryID"));

                    // Lấy giá trị createDate
                    product.setCreateDate(rs.getDate("createDate")); // Giả sử `createDate` có kiểu DATE hoặc DATETIME trong DB

                    // Thêm sản phẩm vào danh sách
                    products.add(product);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    @Override
    public void add(Products product) {
        String sql = "INSERT INTO Products (ProductID, ProductName, UnitPrice, Size, Image, Quantity, Decription, CategoryID, createDate) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        jdbcTemplate.update(sql, product.getProductID(), product.getProductName(), product.getUnitPrice(), product.getSize(), product.getImage(), product.getQuantity(), product.getDecription(), product.getCategoryID(), new java.sql.Timestamp(product.getCreateDate().getTime()));
    }

    @Override
    public void change(Products product) {
        String sql = "UPDATE Products SET ProductName = ?, UnitPrice = ?, Size = ?, Image = ?, Quantity = ?, Decription = ?, CategoryID = ? WHERE ProductID = ?";
        jdbcTemplate.update(sql,
                product.getProductName(),
                product.getUnitPrice(),
                product.getSize(),
                product.getImage(),
                product.getQuantity(),
                product.getDecription(),
                product.getCategoryID(),
                // Gán createDate ở đây nếu cần
                product.getProductID()
        );
    }

    @Override
    public String getNextProductID(String categoryID, String productName) {
        String prefix = getProductPrefix(productName);
        String query = "SELECT MAX(productID) FROM Products WHERE productID LIKE ?";

        String maxProductID = jdbcTemplate.queryForObject(query, new Object[]{categoryID + prefix + "%"}, String.class);

        int nextNumber = 1; // Default value if no existing ID is found

        if (maxProductID != null) {
            // Extract the numeric part from the existing maxProductID
            String numberPart = maxProductID.substring(categoryID.length() + prefix.length());
            nextNumber = Integer.parseInt(numberPart) + 1;
        }

        return categoryID + prefix + String.format("%02d", nextNumber);
    }

    // Method to get the product prefix from the product name
    private String getProductPrefix(String productName) {
        String[] parts = productName.split(" ");
        if (parts.length >= 2) {
            return parts[0].substring(0, 1) + parts[1].substring(0, 1);
        } else if (parts.length == 1) {
            return parts[0].substring(0, 2);
        } else {
            return "XX"; // Default prefix if productName is empty
        }
    }

    @Override
    public Products get(String id) {
        String sql = "SELECT * FROM Products WHERE ProductID = ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{id}, BeanPropertyRowMapper.newInstance(Products.class));
    }

    @Override
    public void delete(String id) {

        String sql = "UPDATE Products SET isDeleted = ? WHERE ProductID = ?";
        jdbcTemplate.update(sql, true, id);

    }

    @Override
    public List<Products> find(String keyword) {
        String sql = "SELECT p.* FROM Products p "
                + "JOIN Categories c ON p.categoryID = c.categoryID "
                + "WHERE p.productName LIKE ? OR c.categoryName LIKE ?";
        keyword = "%" + keyword + "%";
        return jdbcTemplate.query(sql, new Object[]{keyword, keyword}, BeanPropertyRowMapper.newInstance(Products.class));
    }

    public JdbcTemplate getJdbcTemplate() {
        return jdbcTemplate;
    }

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public List<Products> filterProducts(String category, String search) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    private Connection getConnection() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public Products findById(String productId) {
        String sql = "SELECT * FROM Products WHERE productID = ?";
        Products product = jdbcTemplate.query(sql, new Object[]{productId}, new ResultSetExtractor<Products>() {
            @Override
            public Products extractData(ResultSet rs) throws SQLException {
                if (rs.next()) {
                    Products product = new Products();
                    product.setProductID(rs.getString("productID"));
                    product.setProductName(rs.getString("productName"));
                    product.setUnitPrice(rs.getBigDecimal("unitPrice"));
                    product.setSize(rs.getInt("Size"));
                    product.setImage(rs.getString("Image"));
                    product.setQuantity(rs.getInt("Quantity"));
                    product.setDecription(rs.getString("Decription"));
                    product.setCategoryID(rs.getString("categoryID"));

                    // Lấy categoryName dựa trên categoryID
                    String categoryName = findCategoryNameById(product.getCategoryID());
                    product.setCategoryName(categoryName);

                    return product;
                }
                return null; // hoặc throw an exception nếu không tìm thấy
            }
        });

        return product;
    }

    public String findCategoryNameById(String categoryID) {
        String sql = "SELECT categoryName FROM Categories WHERE categoryID = ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{categoryID}, String.class);
    }

    public void update(Products product) {
        String sql = "UPDATE Products SET Quantity = ? WHERE productID = ?";
        jdbcTemplate.update(sql, product.getQuantity(), product.getProductID());
    }

    @Override
    public Products getProductById(String productId) {
        String sql = "SELECT * FROM Products WHERE productID = ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{productId}, new BeanPropertyRowMapper<>(Products.class));
    }

    @Override
    public BigDecimal getProductPrice(String productID) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public Map<String, Integer> getProductCountsByCategory() {
        String sql = "SELECT c.categoryName, COUNT(p.productID) AS productCount "
                + "FROM Products p "
                + "JOIN Categories c ON p.categoryID = c.categoryID "
                + "GROUP BY c.categoryName";

        Map<String, Integer> categoryCounts = jdbcTemplate.query(sql, new ResultSetExtractor<Map<String, Integer>>() {
            @Override
            public Map<String, Integer> extractData(ResultSet rs) throws SQLException, DataAccessException {
                Map<String, Integer> categoryCounts = new HashMap<>();
                while (rs.next()) {
                    categoryCounts.put(rs.getString("categoryName"), rs.getInt("productCount"));
                }
                return categoryCounts;
            }
        });

        // Log the retrieved counts
        System.out.println("Retrieved Category Counts: " + categoryCounts);
        return categoryCounts;
    }

    @Override
    public String getProductName(String productID) {
        // Logic to retrieve product name from the database using productID
        String productName = ""; // Replace with your logic to fetch product name
        return productName;
    }

    @Override
    public Map<String, Integer> getTopSellingProducts() {
        String sql = "SELECT TOP 5 p.ProductName, SUM(od.Quantity) AS total_quantity_sold "
                + "FROM OrderDetails od "
                + "JOIN Orders o ON od.OrderID = o.OrderID "
                + "JOIN Products p ON od.ProductID = p.ProductID "
                + "WHERE YEAR(o.OrderDate) = YEAR(GETDATE()) "
                + "GROUP BY p.ProductName "
                + "ORDER BY total_quantity_sold DESC";

        return jdbcTemplate.query(sql, new ResultSetExtractor<Map<String, Integer>>() {
            @Override
            public Map<String, Integer> extractData(ResultSet rs) throws SQLException, DataAccessException {
                Map<String, Integer> productSales = new HashMap<>();
                while (rs.next()) {
                    productSales.put(rs.getString("ProductName"), rs.getInt("total_quantity_sold"));
                }
                return productSales;
            }
        });
    }

    @Override
    public Map<String, Integer> getTopSellingProductsByMonth() {
        // SQL query để lấy top 5 sản phẩm bán chạy nhất trong tháng hiện tại
        String sql = "SELECT TOP 5 p.ProductName, SUM(od.Quantity) AS total_quantity_sold "
                + "FROM OrderDetails od "
                + "JOIN Orders o ON od.OrderID = o.OrderID "
                + "JOIN Products p ON od.ProductID = p.ProductID "
                + "WHERE YEAR(o.OrderDate) = YEAR(GETDATE()) " // Lọc theo năm hiện tại
                + "AND MONTH(o.OrderDate) = MONTH(GETDATE()) " // Lọc theo tháng hiện tại
                + "GROUP BY p.ProductName "
                + "ORDER BY total_quantity_sold DESC"; // Sắp xếp theo số lượng bán được (từ cao xuống thấp)

        return jdbcTemplate.query(sql, new ResultSetExtractor<Map<String, Integer>>() {
            @Override
            public Map<String, Integer> extractData(ResultSet rs) throws SQLException, DataAccessException {
                Map<String, Integer> productSales = new HashMap<>();
                while (rs.next()) {
                    productSales.put(rs.getString("ProductName"), rs.getInt("total_quantity_sold"));
                }
                return productSales;
            }
        });
    }

    @Override
    public Products findByID(String productID) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public List<Products> findActiveProductsPaged(int startIndex, int pageSize) {
        String sql = "SELECT * FROM Products WHERE isDeleted = 0 ORDER BY productID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        return jdbcTemplate.query(sql, new Object[]{startIndex, pageSize}, new RowMapper<Products>() {
            @Override
            public Products mapRow(ResultSet rs, int rowNum) throws SQLException {
                Products product = new Products();

                product.setProductID(rs.getString("productID"));
                product.setProductName(rs.getString("productName"));
                product.setUnitPrice(rs.getBigDecimal("unitPrice"));
                product.setSize(rs.getInt("Size"));
                product.setImage(rs.getString("Image"));
                product.setQuantity(rs.getInt("Quantity"));
                product.setDecription(rs.getString("Decription"));
                product.setCategoryID(rs.getString("categoryID"));

                // Thêm dòng này để lấy giá trị createDate
                product.setCreateDate(rs.getDate("createDate"));
                return product;
            }
        });
    }

    @Override
    public int countActiveProducts() {
        String sql = "SELECT COUNT(*) FROM Products WHERE isDeleted = 0";
        return jdbcTemplate.queryForObject(sql, Integer.class);
    }

    @Override
    public List<String> findAllProductNames() {
        String query = "SELECT productName FROM Products WHERE isDeleted = 0"; // Thêm điều kiện nếu cần
        return jdbcTemplate.queryForList(query, String.class);
    }

}
