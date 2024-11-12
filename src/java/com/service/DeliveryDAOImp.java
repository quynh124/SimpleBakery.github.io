
package com.service;


import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.sql.DataSource;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import com.models.Delivery;
import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.sql.DataSource;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;


public class DeliveryDAOImp implements DeliveryDAO {
    
    private JdbcTemplate jdbcTemplate;

    public DeliveryDAOImp() {
    }

    public DeliveryDAOImp(DataSource dataSource) {
        jdbcTemplate = new JdbcTemplate(dataSource);
    }
    @Override
    public boolean checkDeliveryHasOrders(int deliveryId) {
    String sql = "SELECT COUNT(*) FROM Orders WHERE DeliveryID = ?";
    int count = jdbcTemplate.queryForObject(sql, new Object[]{deliveryId}, Integer.class);
    return count > 0;
}
     @Override
    public List<Delivery> findAll() {
        String sql = "SELECT * FROM Deliveries";
        //cach 1
        List<Delivery> delivery = new ArrayList<>();
        List<Map<String, Object>> rows = jdbcTemplate.queryForList(sql);
        for (Map row : rows) {
            Delivery obj = new Delivery((int) row.get("DeliveryID"),
                    (String) row.get("DeliveryName"),
                    (String) row.get("Distance"), 
                    (BigDecimal) row.get("Price"));
            delivery.add(obj);
        }
        return delivery;

    }
@Override
    public void add(Delivery delivery) {
        String sql = "INSERT INTO Deliveries (deliveryname, distance, price) VALUES (?,?,?)";
        jdbcTemplate.update(sql,
                delivery.getDeliveryName(),
                delivery.getDistance(),
                delivery.getPrice());}

    @Override
    public void change(Delivery delivery) {
        String sql = "UPDATE Deliveries SET DeliveryName = ?,Distance = ?,Price = ? WHERE DeliveryID =?";
        jdbcTemplate.update(sql,
                delivery.getDeliveryName(),
                delivery.getDistance(),
                delivery.getPrice(),
                delivery.getDeliveryID());
    }

    @Override
    public Delivery get(int id) {
        String sql = "SELECT * FROM Deliveries WHERE DeliveryID = ?";
        return (Delivery) jdbcTemplate.queryForObject(sql, new Object[]{id}, new BeanPropertyRowMapper(Delivery.class));
    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM Deliveries WHERE DeliveryID = ?";
        jdbcTemplate.update(sql, id);
    }

    @Override
    public List<Delivery> find(String keyword) {
        return null;
    }
    public JdbcTemplate getJdbcTemplate() {
        return jdbcTemplate;
    }

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }




    @Override
    public Delivery findByID(int deliveryID) {
        String sql = "SELECT * FROM Deliveries WHERE DeliveryID = ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{deliveryID}, new RowMapper<Delivery>() {
            @Override
            public Delivery mapRow(ResultSet rs, int rowNum) throws SQLException {
                Delivery delivery = new Delivery();
                delivery.setDeliveryID(rs.getInt("deliveryID"));
                delivery.setDeliveryName(rs.getString("deliveryName"));
                delivery.setPrice(rs.getBigDecimal("price")); // Adjust according to your schema
                // Set other properties if needed...
                return delivery;
            }
        });
    }

    @Override
    public BigDecimal getDeliveryCost(int deliveryID) {
        String sql = "SELECT price FROM Deliveries WHERE DeliveryID = ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{deliveryID}, BigDecimal.class);
    }

    @Override
    public Delivery findByName(String deliveryName) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
