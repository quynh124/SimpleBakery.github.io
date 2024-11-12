package com.service;

import com.models.Faq;
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
public class FaqDAOImp implements FaqDAO {

    private JdbcTemplate jdbcTemplate;
    private Object id;

    public FaqDAOImp() {
    }

    public FaqDAOImp(DataSource dataSource) {
        jdbcTemplate = new JdbcTemplate(dataSource);
    }

    @Override
    public List<Faq> findAll() {
        String sql = "SELECT * FROM FAQs";
        //cach 1
        List<Faq> faq = new ArrayList<>();
        List<Map<String, Object>> rows = jdbcTemplate.queryForList(sql);
        for (Map row : rows) {
            Faq obj = new Faq((int) row.get("FaqID"),
                    (String) row.get("EmailUser"),
                   
                    (String) row.get("Content"),
                    (String) row.get("Reply"),
                    (String) row.get("Status"));
            faq.add(obj);
        }
        return faq;

    }

    public List<Faq> find(int id) {
        String sql = "SELECT FaqID, EmailUser, Content, Reply,Status FROM FAQs WHERE FaqID = ?";
        List<Faq> faq = new ArrayList<>();
        List<Map<String, Object>> rows = jdbcTemplate.queryForList(sql);
        for (Map row : rows) {
            Faq obj = new Faq((int) row.get("FaqID"),
                    (String) row.get("EmailUser"),
                    
                    (String) row.get("Content"),
                    (String) row.get("Reply"),
                    (String) row.get("Status"));
            faq.add(obj);
        }
        return faq;
    }

    @Override
    public void update(Faq faq) {
        String sql = "UPDATE FAQs SET Reply = ? WHERE FaqID = ?";
        jdbcTemplate.update(sql, faq.getReply(), faq.getFaqID());
    }

    @Override
    public void add(Faq faq) {
        String sql = "INSERT INTO FAQs (emailUser, content, reply, status) VALUES (?,?,?,?)";
        jdbcTemplate.update(sql,
                faq.getEmailUser(), // nvarchar

                faq.getContent(), // text
                faq.getReply(), // text
                faq.getStatus());     // int
    }

    @Override
    public Faq findById(int faqID) {
        String sql = "SELECT * FROM FAQs WHERE FaqID = ?";
        return (Faq) jdbcTemplate.queryForObject(sql, new Object[]{id}, new BeanPropertyRowMapper(Faq.class));
    }

    @Override
    public void updateReply(int faqID, String reply) {
        String sql = "UPDATE FAQs SET Reply = ?, Status = 'Answered' WHERE FaqID = ?";
        jdbcTemplate.update(sql, reply, faqID);
    }

    @Override
    public List<Faq> findFaqs(int offset, int limit) {
        String sql = "SELECT * FROM faq LIMIT ? OFFSET ?";
        return jdbcTemplate.query(sql, new Object[]{id}, new BeanPropertyRowMapper(Faq.class));
    }

    @Override
    public int countFaqs() {
        String sql = "SELECT COUNT(*) FROM faq";
        return jdbcTemplate.queryForObject(sql, Integer.class);
    }

    @Override
    public void change(Faq faq) {
        String sql = "UPDATE FAQs SET EmailUser = ?,Content = ?,Reply = ?,  Status = ? WHERE FaqID = ?";
        jdbcTemplate.update(sql,
                faq.getEmailUser(),
               
                faq.getContent(),
                faq.getReply(),
                faq.getStatus(),
                faq.getFaqID());
    }

    @Override
    public Faq get(int id) {
        String sql = "SELECT * FROM FAQs WHERE FaqID = ?";
        return (Faq) jdbcTemplate.queryForObject(sql, new Object[]{id}, new BeanPropertyRowMapper(Faq.class));
    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM FAQs WHERE FaqID = ?";
        jdbcTemplate.update(sql, id);
    }

    @Override
    public List<Faq> find(String keyword) {
        return null;
    }

    public JdbcTemplate getJdbcTemplate() {
        return jdbcTemplate;
    }

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public void updateReply(Long l, String string) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
