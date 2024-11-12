/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.service;

import com.models.OrderDetail;
import com.models.OrderDetailDTO;
import com.models.Orders;
import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import javax.sql.DataSource;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

/**
 *
 * @author BAOTHI
 */
public class OrderDAOImpl implements OrderDAO {

    private JdbcTemplate jdbcTemplate;

    public OrderDAOImpl() {
    }

    public OrderDAOImpl(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    @Override
    public List<Orders> findAll() {
        String sql = "SELECT OrderID, OrderDate, DeliveryDate, TotalPrice, Status, UserID, VoucherID, PaymentID, DeliveryID, YourName, Phone, ShipAddress, Note,isDeleted FROM Orders";
        List<Orders> orderList = new ArrayList<>();
        List<Map<String, Object>> rows = jdbcTemplate.queryForList(sql);
        for (Map<String, Object> row : rows) {
            Orders obj = new Orders();
            obj.setOrderID((String) row.get("OrderID"));
            obj.setOrderDate((Date) row.get("OrderDate"));
            obj.setDeliveryDate((Date) row.get("DeliveryDate"));
            obj.setTotalPrice((BigDecimal) row.get("TotalPrice"));
            obj.setStatus((String) row.get("Status"));
            obj.setUserID((int) row.get("UserID"));
            obj.setVoucherID((int) row.get("VoucherID"));
            obj.setPaymentID((int) row.get("PaymentID"));
            obj.setDeliveryID((int) row.get("DeliveryID"));

            obj.setYourName((String) row.get("YourName"));
            obj.setPhone((String) row.get("Phone")); // Adjust this if phone is a different type
            obj.setShipAddress((String) row.get("ShipAddress"));
            obj.setNote((String) row.get("Note"));
             Boolean isDeletedValue = (Boolean) row.get("isDeleted");
            obj.setIsDeleted(isDeletedValue != null && isDeletedValue); // Gán giá trị boolean
            orderList.add(obj);
        }
        return orderList;
    }

    @Override
    public String generateRandomOrderID() {

        // Use a UUID or a combination of timestamp and a random number
        return "ORD" + System.currentTimeMillis() + (int) (Math.random() * 1000);
    }

    @Override
    public void add(Orders order) {
        String sql = "INSERT INTO Orders (OrderID, OrderDate, DeliveryDate,TotalPrice, Status, UserID, VoucherID, PaymentID, DeliveryID, YourName, Phone, ShipAddress, Note, isDeleted) VALUES (?, ?,?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?)";
        jdbcTemplate.update(sql,
                order.getOrderID(),
                order.getOrderDate(),
                order.getDeliveryDate(),
                order.getTotalPrice(),
                order.getStatus(),
                order.getUserID(),
                order.getVoucherID(),
                order.getPaymentID(),
                order.getDeliveryID(),
                order.getYourName(),
                order.getPhone(),
                order.getShipAddress(),
                order.getNote(),false);
    }

    @Override
    public void change(String orderID, String newStatus) {
        String sql = "UPDATE Orders SET Status = ? WHERE OrderID = ?";
        jdbcTemplate.update(sql, newStatus, orderID);
    }

    @Override
    public Orders get(String id) {
        String sql = "SELECT * FROM Orders WHERE OrderID = ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{id}, BeanPropertyRowMapper.newInstance(Orders.class));
    }

    @Override
    public void delete(String id) {
        String sql = "UPDATE Orders SET isDeleted = ? WHERE OrderID = ?";
        jdbcTemplate.update(sql, true, id);
       
    }

    @Override
    public List<Orders> find(String keyword) {
        String sql = "SELECT * FROM Orders WHERE OrderID LIKE ? OR Decription LIKE ?";
        keyword = "%" + keyword + "%";
        return jdbcTemplate.query(sql, new Object[]{keyword, keyword}, BeanPropertyRowMapper.newInstance(Orders.class));
    }

    public JdbcTemplate getJdbcTemplate() {
        return jdbcTemplate;
    }

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public Orders findByOrderID(String orderID) {
        String sql = "SELECT * FROM Orders WHERE orderID = ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{orderID}, new RowMapper<Orders>() {
            @Override
            public Orders mapRow(ResultSet rs, int rowNum) throws SQLException {
                Orders order = new Orders();
                order.setOrderID(rs.getString("orderID"));
                order.setOrderDate(rs.getDate("orderDate"));
                order.setDeliveryDate(rs.getDate("deliveryDate"));
                order.setTotalPrice(rs.getBigDecimal("totalPrice"));
                order.setStatus(rs.getString("status"));
                order.setUserID(rs.getInt("userID"));
                order.setVoucherID(rs.getInt("voucherID"));
                order.setPaymentID(rs.getInt("paymentID"));
                order.setDeliveryID(rs.getInt("deliveryID"));
                order.setYourName(rs.getString("yourName"));
                order.setPhone(rs.getString("phone"));
                order.setShipAddress(rs.getString("shipAddress"));
                order.setNote(rs.getString("note"));
                return order;
            }
        });
    }

   @Override
public List<Orders> findByUserID(Integer userID) {
    String sql = "SELECT * FROM Orders WHERE userID = ? AND isDeleted = 0"; // Điều kiện isDeleted = false
    return jdbcTemplate.query(sql, new Object[]{userID}, new RowMapper<Orders>() {
        @Override
        public Orders mapRow(ResultSet rs, int rowNum) throws SQLException {
            Orders order = new Orders();
            order.setOrderID(rs.getString("orderID"));
            order.setOrderDate(rs.getDate("orderDate"));
            order.setDeliveryDate(rs.getDate("deliveryDate"));
            order.setStatus(rs.getString("status"));
            order.setUserID(rs.getInt("userID"));
            order.setTotalPrice(rs.getBigDecimal("TotalPrice"));

           
            return order;
        }
    });
}


   @Override
public List<OrderDetailDTO> findOrderDetailsByUserID(Integer userID) {
    String sql = "SELECT o.orderID, o.orderDate, o.deliveryDate, d.deliveryName, d.price AS deliveryPrice, "
            + "o.status, o.isDeleted "
            + "FROM Orders o "
            + "JOIN Deliveries d ON o.deliveryID = d.deliveryID "
            + "WHERE o.userID = ? AND o.isDeleted = false";  // Thêm điều kiện isDeleted = false

    List<OrderDetailDTO> orders = jdbcTemplate.query(sql, new Object[]{userID}, (rs, rowNum) -> {
        OrderDetailDTO order = new OrderDetailDTO();
        order.setOrderID(rs.getString("orderID"));
        order.setOrderDate(rs.getDate("orderDate"));
        order.setDeliveryDate(rs.getDate("deliveryDate"));
        order.setDeliveryName(rs.getString("deliveryName"));
        order.setPrice(rs.getBigDecimal("deliveryPrice"));  // Lấy đúng alias
        order.setStatus(rs.getString("status"));
        order.setIsDeleted(rs.getBoolean("isDeleted"));  // Lấy cột isDeleted nếu cần
        return order;
    });

    return orders;
}


    @Override
    public List<OrderDetailDTO> findOrderDetailsByOrderID(String orderID) {
        String sql = "SELECT od.orderDetailID, od.productID, p.productName,p.image, od.unitPrice, od.quantity, o.status "
                + "FROM OrderDetails od "
                + "JOIN Products p ON od.productID = p.productID "
                + "JOIN Orders o ON od.orderID = o.orderID "
                + "WHERE od.orderID = ?";

        return jdbcTemplate.query(sql, new Object[]{orderID}, (rs, rowNum) -> {
            OrderDetailDTO orderDetail = new OrderDetailDTO();
            orderDetail.setOrderDetailID(rs.getInt("orderDetailID"));
            orderDetail.setOrderID(orderID); // Gán orderID từ tham số
            orderDetail.setProductID(rs.getString("productID"));
            orderDetail.setProductName(rs.getString("productName")); // Gán productName
            orderDetail.setUnitPrice(rs.getBigDecimal("unitPrice"));
            orderDetail.setQuantity(rs.getInt("quantity"));
            orderDetail.setStatus(rs.getString("status"));
             orderDetail.setImage(rs.getString("image"));

            return orderDetail;
        });
    }

    @Override
    public boolean existsByOrderID(String orderID) {
        String sql = "SELECT COUNT(*) FROM Orders WHERE OrderID = ?";
        Integer count = jdbcTemplate.queryForObject(sql, new Object[]{orderID}, Integer.class);
        return count != null && count > 0;
    }

    @Override
    public Orders findByID(String orderID) {
        String sql = "SELECT * FROM Orders WHERE orderID = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new Object[]{orderID}, new OrderRowMapper());
        } catch (EmptyResultDataAccessException e) {
            return null; // Return null if no order found
        }
    }

    private static class OrderRowMapper implements RowMapper<Orders> {

        @Override
        public Orders mapRow(ResultSet rs, int rowNum) throws SQLException {
            Orders order = new Orders();
            order.setOrderID(rs.getString("orderID"));
            order.setOrderDate(rs.getDate("orderDate"));
            order.setDeliveryDate(rs.getDate("deliveryDate"));
            order.setStatus(rs.getString("status"));
            order.setUserID(rs.getInt("userID"));
            order.setDeliveryID(rs.getInt("deliveryID"));
            order.setPaymentID(rs.getInt("paymentID"));
//            order.setProductID(rs.getString("productID"));
//            order.setProductName(rs.getString("productName"));
//            order.setQuantity(rs.getInt("quantity"));
            order.setTotalPrice(rs.getBigDecimal("totalPrice"));
            order.setPhone(rs.getString("phone"));
            order.setYourName(rs.getString("yourName"));
            order.setShipAddress(rs.getString("shipAddress"));
            order.setNote(rs.getString("note"));
            // Add other fields as necessary...
            return order;
        }
    }

    public class OrderDetailRowMapper implements RowMapper<OrderDetailDTO> {

        @Override
        public OrderDetailDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
            OrderDetailDTO dto = new OrderDetailDTO();
            dto.setOrderID(rs.getString("orderID"));
            dto.setTotalPrice(rs.getBigDecimal("totalPrice"));
            dto.setOrderDate(rs.getDate("orderDate"));
            dto.setDeliveryDate(rs.getDate("deliveryDate"));
            dto.setProductID(rs.getString("productID"));
            dto.setProductName(rs.getString("productName"));
            dto.setUnitPrice(rs.getBigDecimal("unitPrice"));
            dto.setQuantity(rs.getInt("quantity"));
            dto.setDeliveryName(rs.getString("deliveryName"));
            dto.setPrice(rs.getBigDecimal("price"));
             dto.setImage(rs.getString("image"));
            return dto;
        }
    }

    @Override
public List<Orders> findByOrderDate(java.sql.Date orderDate) {
    String sql = "SELECT * FROM Orders WHERE CAST(orderDate AS DATE) = ?";
    return jdbcTemplate.query(sql, new Object[]{orderDate}, new OrderRowMapper());
}


}
