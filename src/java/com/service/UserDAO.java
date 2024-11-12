/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.service;

import com.models.User;
import java.util.List;
import javax.jms.Session;
import javax.transaction.Transaction;
import org.springframework.beans.factory.annotation.Autowired;


/**
 *
 * @author Hp
 */
public interface UserDAO {
 
    User findByUsername(String username);
     
    public List<User> findAll();

    public void add(User user);

    public void change(User user);

    public User get(int id);

    public void delete(int id);
    
     User findUserByEmail(String email);
    void updatePassword(int userID, String newPassword);

    public List<User> find(String keyword);
   public User login(String uname, String passwd);

    public boolean find(String username, String password);
    
    public User findByUserName(String username, String password) ;
    boolean validateUser(String username, String password);
   User findByUsernameAndPassword(String username, String password);

   public Object getCurrentSession();
   public String loginUser(User user);
    
    boolean isUsernameTaken(String username);
     void saveOrUpdateGoogleUser(User googleUser);
    User getUserByUsernameAndPassword(String username, String password);
      public boolean checkUserHasOrders(int id);
}

