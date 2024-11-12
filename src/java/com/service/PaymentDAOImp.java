/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.service;
import com.models.Payment;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.sql.DataSource;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

/**
 *
 * @author Hp
 */
public class PaymentDAOImp  implements PaymentDAO {
      private JdbcTemplate jdbcTemplate;

    public PaymentDAOImp() {
    }

    public PaymentDAOImp(DataSource dataSource) {
        jdbcTemplate = new JdbcTemplate(dataSource);
    }
      @Override
    public boolean checkPaymentHasOrders(int paymentId) {
    String sql = "SELECT COUNT(*) FROM Orders WHERE PaymentID = ?";
    int count = jdbcTemplate.queryForObject(sql, new Object[]{paymentId}, Integer.class);
    return count > 0;
}
 @Override
    public List<Payment> findByNameContaining(String name) {
        String sql = "SELECT * FROM Payments WHERE paymentName LIKE ?";
        return jdbcTemplate.query(sql, new Object[]{"%" + name + "%"}, new BeanPropertyRowMapper(Payment.class));
    }
    @Override
    public List<Payment> findAll() {
        String sql = "SELECT * FROM Payments";
        //cach 1
        List<Payment> payment = new ArrayList<>();
        List<Map<String, Object>> rows = jdbcTemplate.queryForList(sql);
        for (Map row : rows) {
            Payment obj = new Payment((int) row.get("PaymentID"), (String) row.get("PaymentName"), (String) row.get("Description"));
            payment.add(obj);
        }
        return payment;

    }

  @Override
public void add(Payment payment) {
    
    String sql = "INSERT INTO Payments (paymentName, description) VALUES (?, ?)";
    jdbcTemplate.update(sql, 
            payment.getPaymentName(),   
            payment.getDescription());  
}

    @Override
    public void change(Payment payment) {
        String sql = "UPDATE Payments SET PaymentName=?, Description = ? WHERE PaymentID =?";
        jdbcTemplate.update(sql, payment.getPaymentName(),payment.getDescription(),
                payment.getPaymentID());
    }

    @Override
    public Payment get(int id) {
        String sql = "SELECT * FROM Payments WHERE PaymentID = ?";
        return (Payment) jdbcTemplate.queryForObject(sql, new Object[]{id}, new BeanPropertyRowMapper(Payment.class));
    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM Payments WHERE PaymentID = ?";
        jdbcTemplate.update(sql, id);
    }

    @Override
    public List<Payment> find(String keyword) {
        return null;
    }

    public JdbcTemplate getJdbcTemplate() {
        return jdbcTemplate;
    }

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }
}
