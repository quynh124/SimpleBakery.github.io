/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.service;

/**
 *
 * @author BAOTHI
 */
import com.models.OrderDetail;
import com.models.OrderDetailDTO;
import com.models.Orders;
import com.models.Payment;
import com.models.RevenueDTO;
import java.math.BigDecimal;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.beans.factory.annotation.Autowired;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import javax.sql.DataSource;
import org.springframework.dao.DataAccessException;
import org.springframework.dao.EmptyResultDataAccessException;

public class OrderDetailDAOImpl implements OrderDetailDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public OrderDetailDAOImpl() {
    }

    public OrderDetailDAOImpl(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    @Override
    public List<OrderDetailDTO> findByOrderID(String orderID) {
        String query = "SELECT od.orderDetailID, od.orderID, od.productID, od.quantity, od.unitPrice, p.productName,p.image "
                + "FROM OrderDetails od "
                + "JOIN Products p ON od.productID = p.productID "
                + "WHERE od.orderID = ?";

        return jdbcTemplate.query(query, new Object[]{orderID}, new RowMapper<OrderDetailDTO>() {
            @Override
            public OrderDetailDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
                OrderDetailDTO dto = new OrderDetailDTO();
                dto.setOrderDetailID(rs.getInt("orderDetailID"));
                dto.setOrderID(rs.getString("orderID"));
                dto.setProductID(rs.getString("productID"));
                dto.setQuantity(rs.getInt("quantity"));
                dto.setUnitPrice(rs.getBigDecimal("unitPrice"));
                dto.setProductName(rs.getString("productName"));
                dto.setImage(rs.getString("image"));// Set productName here

                return dto;
            }
        });
    }

    @Override
    public Payment getPaymentMethod(int paymentID) {
        String sql = "SELECT * FROM Payments WHERE paymentID = ?";

        try {
            // Assuming you are using JdbcTemplate for querying
            return jdbcTemplate.queryForObject(sql, new Object[]{paymentID}, (rs, rowNum) -> {
                Payment payment = new Payment();
                payment.setPaymentID(rs.getInt("paymentID"));
                payment.setPaymentName(rs.getString("paymentName"));
                // Set other fields of the Payment object as needed
                return payment;
            });
        } catch (EmptyResultDataAccessException e) {
            // Handle the case when no result is found
            System.out.println("No payment method found for paymentID: " + paymentID);
            return null; // Or throw a custom exception if needed
        } catch (DataAccessException e) {
            // Handle other data access exceptions
            e.printStackTrace();
            return null; // Handle accordingly
        }
    }

    // RowMapper để ánh xạ dữ liệu từ ResultSet sang đối tượng OrderDetail
    private static final class OrderDetailRowMapper implements RowMapper<OrderDetail> {

        public OrderDetail mapRow(ResultSet rs, int rowNum) throws SQLException {
            OrderDetail orderDetail = new OrderDetail();
            orderDetail.setOrderDetailID(rs.getInt("OrderDetailID"));
            orderDetail.setOrderID(rs.getString("OrderID"));
            orderDetail.setProductID(rs.getString("ProductID"));
            orderDetail.setQuantity(rs.getInt("Quantity"));
            orderDetail.setUnitPrice(rs.getBigDecimal("UnitPrice"));

            return orderDetail;
        }
    }

    @Override
    public void add(OrderDetail orderDetail) {
        String sql = "INSERT INTO OrderDetails ( OrderID, ProductID, Quantity, UnitPrice) VALUES (?, ?, ?, ?)";
        jdbcTemplate.update(sql, orderDetail.getOrderID(), orderDetail.getProductID(), orderDetail.getQuantity(), orderDetail.getUnitPrice());
    }

    @Override
    public List<OrderDetail> findAll() {
        String sql = "SELECT OrderDetailID, OrderID, ProductID, Quantity, UnitPrice FROM OrderDetails";
        List<OrderDetail> orderDetailList = new ArrayList<>();
        List<Map<String, Object>> rows = jdbcTemplate.queryForList(sql);
        for (Map<String, Object> row : rows) {
            OrderDetail obj = new OrderDetail();
            obj.setOrderID((String) row.get("OrderID"));
            obj.setOrderDetailID((int) row.get("OrderDetailID"));
            obj.setUnitPrice((BigDecimal) row.get("UnitPrice"));
            obj.setQuantity((int) row.get("Quantity"));
            obj.setProductID((String) row.get("ProductID"));
            orderDetailList.add(obj);
        }
        return orderDetailList;
    }

    @Override
    public OrderDetail findById(String orderDetailID) {
        String sql = "SELECT * FROM OrderDetail WHERE OrderDetailID = ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{orderDetailID}, new OrderDetailRowMapper());
    }

    @Override
    public void update(OrderDetail orderDetail) {
        String sql = "UPDATE OrderDetails SET Quantity = ?, UnitPrice = ? WHERE OrderDetailID = ?";
        jdbcTemplate.update(sql, orderDetail.getQuantity(), orderDetail.getUnitPrice(), orderDetail.getOrderDetailID());
    }

    @Override
    public void deleteByOrderId(String orderID) {
        String sql = "DELETE FROM OrderDetails WHERE OrderID = ?";
        jdbcTemplate.update(sql, orderID);
    }

    @Override
    public void delete(String orderDetailID) {
        String sql = "DELETE FROM OrderDetails WHERE OrderDetailID = ?";
        jdbcTemplate.update(sql, orderDetailID);
    }

    public JdbcTemplate getJdbcTemplate() {
        return jdbcTemplate;
    }

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public List<RevenueDTO> getMonthlyRevenue() {
        String sql = "SELECT MONTH(O.orderDate) AS month, SUM(OD.quantity * OD.unitPrice) AS totalRevenue "
                + "FROM Orders O JOIN OrderDetails OD ON O.orderID = OD.orderID "
                + "WHERE YEAR(O.orderDate) = YEAR(GETDATE()) "
                + "GROUP BY MONTH(O.orderDate) ORDER BY month";

        // Execute the query and map the results to RevenueDTO objects
        return jdbcTemplate.query(sql, new RowMapper<RevenueDTO>() {
            @Override
            public RevenueDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
                RevenueDTO revenue = new RevenueDTO();
                revenue.setMonth(rs.getInt("month"));
                revenue.setTotalRevenue(rs.getDouble("totalRevenue"));
                return revenue;
            }
        });
    }

    @Override
    public List<RevenueDTO> getQuarterlyRevenue() {
        String sql = "SELECT (DATEPART(MONTH, O.orderDate) + 2) / 3 AS quarter, "
           + "SUM(OD.quantity * OD.unitPrice) AS totalRevenue "
           + "FROM Orders O JOIN OrderDetails OD ON O.orderID = OD.orderID "
           + "WHERE YEAR(O.orderDate) = YEAR(GETDATE()) "
           + "GROUP BY (DATEPART(MONTH, O.orderDate) + 2) / 3 "
           + "ORDER BY quarter";


        // Execute the query and map the results to RevenueDTO objects
        return jdbcTemplate.query(sql, new RowMapper<RevenueDTO>() {
            @Override
            public RevenueDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
                RevenueDTO revenue = new RevenueDTO();
                revenue.setQuarter(rs.getInt("quarter"));
                revenue.setTotalRevenue(rs.getDouble("totalRevenue"));
                return revenue;
            }
        });
    }
    @Override
    public List<RevenueDTO> getRevenueCurrentAndPreviousMonth() {
    String sql = "SELECT MONTH(O.orderDate) AS month, SUM(OD.quantity * OD.unitPrice) AS totalRevenue " +
                 "FROM Orders O JOIN OrderDetails OD ON O.orderID = OD.orderID " +
                 "WHERE (MONTH(O.orderDate) = MONTH(GETDATE()) OR MONTH(O.orderDate) = MONTH(GETDATE()) - 1) " +
                 "AND YEAR(O.orderDate) = YEAR(GETDATE()) " +
                 "GROUP BY MONTH(O.orderDate) " +
                 "ORDER BY month";
    
    return jdbcTemplate.query(sql, new RowMapper<RevenueDTO>() {
        @Override
        public RevenueDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
            RevenueDTO revenue = new RevenueDTO();
            revenue.setMonth(rs.getInt("month"));
            revenue.setTotalRevenue(rs.getDouble("totalRevenue"));
            return revenue;
        }
    });
}


}
