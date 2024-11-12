package com.service;

import com.models.Voucher;
import java.math.BigDecimal;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.UUID;
import javax.sql.DataSource;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;

public class VoucherDAOImp implements VoucherDAO {

    private JdbcTemplate jdbcTemplate;

    public VoucherDAOImp() {
    }

    public VoucherDAOImp(DataSource dataSource) {
        jdbcTemplate = new JdbcTemplate(dataSource);
    }

    @Override
    public boolean checkVoucherHasOrders(int voucherId) {
        String sql = "SELECT COUNT(*) FROM Orders WHERE VoucherID = ?";
        int count = jdbcTemplate.queryForObject(sql, new Object[]{voucherId}, Integer.class);
        return count > 0;
    }

    @Override
    public Voucher getVoucherByCode(String voucherCode) {
        String sql = "SELECT * FROM Voucher WHERE VoucherCode = ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{voucherCode}, Voucher.class);
    }

    public boolean isValidVoucher(String voucherCode, Date currentDate) {
        String sql = "SELECT * FROM Voucher WHERE VoucherCode = ? AND StartDate <= ? AND EndDate >= ?";
        Voucher voucher = jdbcTemplate.queryForObject(sql, new Object[]{voucherCode, currentDate, currentDate}, Voucher.class);
        return voucher != null;
    }

    public String generateVoucherCode(Double discountAmount) {
        int discount = discountAmount.intValue();
        String randomString = UUID.randomUUID().toString().substring(0, 6).toUpperCase();
        return "DISCOUNT" + discount + "-" + randomString;
    }

    // Lưu voucher vào cơ sở dữ liệu
    @Override
    public List<Voucher> findAll() {
        String sql = "SELECT * FROM Voucher";
        return jdbcTemplate.query(sql, new RowMapper<Voucher>() {
            @Override
            public Voucher mapRow(ResultSet rs, int rowNum) throws SQLException {
                Voucher voucher = new Voucher();
                voucher.setVoucherID(rs.getInt("voucherID"));
                voucher.setVoucherCode(rs.getString("voucherCode"));
                voucher.setDiscountAmount(rs.getBigDecimal("discountAmount"));
                voucher.setStartDate(rs.getDate("startDate"));
                voucher.setEndDate(rs.getDate("endDate"));
                voucher.setEventName(rs.getString("eventName"));
                voucher.setImagesUrl(rs.getString("imagesUrl"));
                voucher.setUserID(rs.getInt("userID"));
                return voucher;
            }
        });
    }

    @Override
    public void add(Voucher voucher) {
        String sql = "INSERT INTO Voucher (VoucherCode, DiscountAmount, StartDate, EndDate, EventName, ImagesUrl, UserID) VALUES (?,?,?,?,?,?,?)";

        jdbcTemplate.update(sql,
                voucher.getVoucherCode(),
                voucher.getDiscountAmount(),
                voucher.getStartDate(),
                voucher.getEndDate(),
                voucher.getEventName(),
                voucher.getImagesUrl(),
                voucher.getVoucherID());
    }

    @Override
    public void change(Voucher voucher) {
        String sql = "UPDATE Voucher SET  VoucherCode = ?, DiscountAmount = ?, StartDate = ?, EndDate = ?,EventName = ?, ImagesUrl = ?, UserID = ? WHERE VoucherID = ?";
        jdbcTemplate.update(sql,
                voucher.getVoucherCode(),
                voucher.getDiscountAmount(),
                voucher.getStartDate(),
                voucher.getEndDate(),
                voucher.getEventName(),
                voucher.getImagesUrl(),
                voucher.getUserID(),
                voucher.getVoucherID());
    }

    @Override
    public Voucher get(int id) {
        String sql = "SELECT * FROM Voucher WHERE VoucherID = ?";
        return (Voucher) jdbcTemplate.queryForObject(sql, new Object[]{id}, new BeanPropertyRowMapper(Voucher.class));
    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM Voucher WHERE VoucherID = ?";
        jdbcTemplate.update(sql, id);
    }

    @Override
    public List<Voucher> find(String keyword) {
        return null;
    }

    public JdbcTemplate getJdbcTemplate() {
        return jdbcTemplate;
    }

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public void updateVoucher(Voucher voucher) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void saveOrUpdate(Voucher vchr) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public List<Voucher> getAllVouchers() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean isValidVoucher(String string, java.util.Date date) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public Voucher findByCode(String string) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public BigDecimal getVoucherDiscount(int VoucherID) {
        String sql = "SELECT DiscountAmount FROM Voucher WHERE VoucherID = ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{VoucherID}, BigDecimal.class);
    }

    public Voucher findById(int voucherID) {
        String sql = "SELECT * FROM Voucher WHERE voucherID = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new Object[]{voucherID}, new RowMapper<Voucher>() {
                @Override
                public Voucher mapRow(ResultSet rs, int rowNum) throws SQLException {
                    Voucher voucher = new Voucher();
                    voucher.setVoucherID(rs.getInt("voucherID"));
                    voucher.setVoucherCode(rs.getString("voucherCode"));
                    voucher.setDiscountAmount(rs.getBigDecimal("discountAmount"));
                    voucher.setStartDate(rs.getDate("startDate"));
                    voucher.setEndDate(rs.getDate("endDate"));
                    voucher.setEventName(rs.getString("eventName"));
                    voucher.setImagesUrl(rs.getString("imagesUrl"));
                    return voucher;
                }
            });
        } catch (EmptyResultDataAccessException e) {
            return null; // Trả về null nếu không tìm thấy voucher
        }
    }
@InitBinder
public void initBinder(WebDataBinder binder) {
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    dateFormat.setLenient(false);
    binder.registerCustomEditor(Date.class, "startDate", new CustomDateEditor(dateFormat, true));
    binder.registerCustomEditor(Date.class, "endDate", new CustomDateEditor(dateFormat, true));
}

}
