package com.service;

import com.models.User;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.Query;
import javax.sql.DataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

/**
 *
 * @author Hp
 */
public class UserDAOImp implements UserDAO {

    private JdbcTemplate jdbcTemplate;

    public UserDAOImp() {
    }

    public UserDAOImp(DataSource dataSource) {
        jdbcTemplate = new JdbcTemplate(dataSource);
    }

    @Autowired
    private UserDAO userDAO;

    private List<User> user = new ArrayList<>();

    @Autowired
    private EntityManager entityManager;

//    @Override
//    public User findByUsernameAndPassword(String username, String password) {
//        String hql = "FROM Users WHERE username = :UserName AND password = :Password";
//        TypedQuery<User> query = entityManager.createQuery(hql, User.class);
//        query.setParameter("username", username);
//        query.setParameter("password", password);
//
//        try {
//            return query.getSingleResult();
//        } catch (NoResultException e) {
//            return null;  // Return null if no user is found
//        }
//    }
    @Override
    public boolean checkUserHasOrders(int userId) {
        String sql = "SELECT COUNT(*) FROM Orders WHERE UserID = ?";
        int count = jdbcTemplate.queryForObject(sql, new Object[]{userId}, Integer.class);
        return count > 0;
    }

    @Override
    public User findByUsernameAndPassword(String username, String password) {
        String sql = "SELECT * FROM Users WHERE UserName = ?1 AND Password = ?2";
        Query query = entityManager.createNativeQuery(sql, User.class);
        query.setParameter(1, username);
        query.setParameter(2, password);

        try {
            return (User) query.getSingleResult();
        } catch (NoResultException e) {
            return null;  // Trả về null nếu không tìm thấy người dùng
        }
    }

    @Override
    public String loginUser(User user) {

        String sql = "SELECT UserName FROM Users WHERE UserName=? AND Password=?";

        try {

            String username = jdbcTemplate.queryForObject(sql, new Object[]{
                user.getUsername(), user.getPassword()}, String.class);

            return username;

        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public User getUserByUsernameAndPassword(String username, String password) {
        String sql = "SELECT * FROM Users WHERE UserName = ? AND Password = ?";

        try {
            return jdbcTemplate.queryForObject(sql, new Object[]{username, password}, new BeanPropertyRowMapper<>(User.class));
        } catch (EmptyResultDataAccessException e) {
            // Log for debugging
            System.out.println("No user found with provided username and password");
            return null;
        }
    }

    @Override
    public void updatePassword(int userID, String newPassword) {
        String sql = "UPDATE Users SET Password = ? WHERE UserID = ?";
        jdbcTemplate.update(sql, newPassword, userID);
    }

    @Override
    public List<User> findAll() {
        String sql = "SELECT * FROM Users";
        //cach 1
        List<User> user = new ArrayList<>();
        List<Map<String, Object>> rows = jdbcTemplate.queryForList(sql);
        for (Map row : rows) {
            User obj = new User((int) row.get("UserID"),
                    (String) row.get("FullName"),
                    (String) row.get("UserName"),
                    (String) row.get("Password"),
                    (String) row.get("Email"),
                    (String) row.get("Phone"),
                    (String) row.get("Address"));

            user.add(obj);
        }
        return user;

    }

    @Override
    public void add(User user) {
        String sql = "INSERT INTO Users (fullname, username, password, email, phone, address) VALUES (?,?,?,?,?,?)";
        jdbcTemplate.update(sql,
                user.getFullname(),
                user.getUsername(),
                user.getPassword(),
                user.getEmail(),
                user.getPhone(),
                user.getAddress());
    }

    @Override
    public void change(User user) {
        String sql = "UPDATE Users SET FullName = ?, UserName = ?,Password = ? , Email = ?, Phone = ?, Address = ? WHERE UserID = ?";
        jdbcTemplate.update(sql, user.getFullname(),
                user.getUsername(), user.getPassword(),
                user.getEmail(),
                user.getPhone(), user.getAddress(),
                user.getUserID());
    }

    @Override
    public User get(int id) {
        String sql = "SELECT * FROM Users WHERE UserID = ?";
        return (User) jdbcTemplate.queryForObject(sql, new Object[]{id}, new BeanPropertyRowMapper(User.class));
    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM Users WHERE UserID = ?";
        jdbcTemplate.update(sql, id);
    }

    @Override
    public List<User> find(String keyword) {
        return null;
    }

    public JdbcTemplate getJdbcTemplate() {
        return jdbcTemplate;
    }

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public boolean find(String username, String password) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean validateUser(String username, String password) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public Object getCurrentSession() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public User login(String uname, String passwd) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean isUsernameTaken(String username) {
        String sql = "SELECT COUNT(*) FROM Users WHERE UserName = ?";
        int count = jdbcTemplate.queryForObject(sql, new Object[]{username}, Integer.class);
        return count > 0;
    }

    @Override
    public User findByUserName(String username, String password) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    private static final class UserMapper implements RowMapper<User> {

        public User mapRow(ResultSet rs, int rowNum) throws SQLException {
            User user = new User();
            user.setUsername(rs.getString("username"));
            user.setFullname(rs.getString("fullname"));
            user.setEmail(rs.getString("email"));
            // Thiết lập các trường khác nếu có
            return user;
        }
    }

    @Override
    public User findByUsername(String username) {
        String sql = "SELECT * FROM users WHERE username = ?";
        List<User> users = jdbcTemplate.query(sql, new Object[]{username}, (ResultSet rs, int rowNum) -> {
            return mapRowToUser(rs);
        });

        if (users.isEmpty()) {
            return null;
        }

        return users.get(0);
    }

    private User mapRowToUser(ResultSet rs) throws SQLException {
        User user = new User();
        user.setUserID(rs.getInt("id"));
        user.setUsername(rs.getString("username"));
        user.setPassword(rs.getString("password"));
        return user;
    }

    @Override
    public void saveOrUpdateGoogleUser(User googleUser) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    private User mapUser(ResultSet rs) throws SQLException {
        User user = new User();
        user.setUserID(rs.getInt("UserID"));
        user.setUsername(rs.getString("UserName"));
        user.setEmail(rs.getString("Email"));
        user.setPassword(rs.getString("Password"));
        return user;
    }

    private static class HibernateUtil {

        public HibernateUtil() {
        }
    }

    @Override
    public User findUserByEmail(String email) {
        String sql = "SELECT * FROM Users WHERE Email = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new Object[]{email}, (rs, rowNum) -> mapUser(rs));
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }
}
