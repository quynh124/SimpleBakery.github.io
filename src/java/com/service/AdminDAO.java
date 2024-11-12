/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.service;

import com.models.Admin;
import java.util.List;

/**
 *
 * @author Hp
 */
public interface AdminDAO {
     Admin findById(int adminID);
    Admin findByUsername(String username);
    Admin getAdminByUsernameAndPassword(String username, String password);
    public List<Admin> findAll();

    public void add(Admin admin);

    public void change(Admin admin);

    public Admin get(int id);

    public void delete(int id);
}
