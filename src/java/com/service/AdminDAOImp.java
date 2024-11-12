package com.service;


import com.models.Admin;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
;

public class AdminDAOImp implements AdminDAO {
    
    
    @Override
    public Admin findById(int adminID) {
        String sql = "SELECT * FROM Admin WHERE adminID=?";
        return jdbcTemplate.queryForObject(sql, new Object[]{adminID}, new AdminRowMapper());
    }
    private static class AdminRowMapper implements RowMapper<Admin> {
        @Override
        public Admin mapRow(ResultSet rs, int rowNum) throws SQLException {
            Admin admin = new Admin();
            admin.setAdminID(rs.getInt("adminID"));
            admin.setUsername(rs.getString("username"));
            admin.setPassword(rs.getString("password"));
            return admin;
        }
    }
    @Autowired
    private AdminDAO adminDAO;
    private List<Admin> admin = new ArrayList<>();

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    // Getter for jdbcTemplate
    public JdbcTemplate getJdbcTemplate() {
        return jdbcTemplate;
    }

    public AdminDAOImp() {
    }
    private JdbcTemplate jdbcTemplate;

    
    public AdminDAOImp(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    @Override
    public Admin getAdminByUsernameAndPassword(String username, String password) {
        String sql = "SELECT * FROM Admin WHERE UserName = ? AND Password = ?";

        try {
            return jdbcTemplate.queryForObject(sql, new Object[]{username, password}, new BeanPropertyRowMapper<>(Admin.class));
        } catch (EmptyResultDataAccessException e) {
            // Log for debugging
            System.out.println("No admin found with provided username and password");
            return null;
        }
    }


    @Override
    public List<Admin> findAll() {
        String sql = "SELECT * FROM Admin";
        List<Admin> adminList = new ArrayList<>();
        List<Map<String, Object>> rows = jdbcTemplate.queryForList(sql);

        for (Map<String, Object> row : rows) {
            Admin admin = new Admin(
                    (int) row.get("AdminID"),
                    (String) row.get("UserName"),
                    (String) row.get("Password")
            );
            adminList.add(admin);
        }
        return adminList;
    }

    @Override
    public void add(Admin admin) {
        String sql = "INSERT INTO Admin (UserName, Password) VALUES (?, ?)";
        jdbcTemplate.update(sql, admin.getUsername(), admin.getPassword());
    }

    @Override
    public void change(Admin admin) {
        String sql = "UPDATE Admin SET UserName = ?, Password = ? WHERE AdminID = ?";
        jdbcTemplate.update(sql, admin.getUsername(), admin.getPassword(), admin.getAdminID());
    }

    @Override
    public Admin get(int id) {
        String sql = "SELECT * FROM Admin WHERE AdminID = ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{id}, new BeanPropertyRowMapper<>(Admin.class));
    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM Admin WHERE AdminID = ?";
        jdbcTemplate.update(sql, id);
    }

    @Override
    public Admin findByUsername(String string) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}


