/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.models;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import org.hibernate.validator.constraints.NotEmpty;

/**
 *
 * @author Hp
 */
public class Admin {
    
    private int adminID;
    
    @NotNull
    //cho username it nhat 3 , nhiu nhat laf 8 
    @Size(min=3, max=8)
    @NotEmpty(message="User Name is not empty")
    
    private String username;
    @NotNull
    @NotEmpty(message="Password is not empty")
    private String password;

  
     public Admin(){
        this.adminID = 0;
        this.username = null;
        this.password = null;
    }
    
public Admin(int adminID, String username, String password) {
        this.adminID = adminID;
        this.username = username;
        this.password = password;
    }
    public int getAdminID() {
        return adminID;
    }

    public void setAdminID(int adminID) {
        this.adminID = adminID;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
    
}
