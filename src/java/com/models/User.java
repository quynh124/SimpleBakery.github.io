package com.models;

import javax.persistence.Column;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;

public class User {
    @NotNull
    @Size(min=3, max=8)
    @NotEmpty(message="User Name is not empty")
    private String username;

    @NotNull
    @NotEmpty(message="Password is not empty")
    private String password;

    @NotNull
    @NotEmpty(message="Full Name is not empty")
    private String fullname;

    @NotEmpty(message="Address is not empty")
    @NotNull
    private String address;

    @Email(message = "Email should be valid")
    @NotNull
    @NotEmpty(message="Email is not empty")
    private String email;

    @NotNull
    @NotEmpty(message="Phone is not empty")
    private String phone;

    @NotNull(message = "User ID is not null")
    private int userID;

    private String captcha;

    @Column(name = "reset_password_token")
    private String resetPasswordToken;

    public User() {
    }

    public User(int userID, String fullname, String username, String password, String email, String phone, String address) {
        this.userID = userID;
        this.fullname = fullname;
        this.username = username;
        this.password = password;
        this.email = email;
        this.phone = phone;
        this.address = address;
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

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getResetPasswordToken() {
        return resetPasswordToken;
    }

    public void setResetPasswordToken(String resetPasswordToken) {
        this.resetPasswordToken = resetPasswordToken;
    }

    public String getCaptcha() {
        return captcha;
    }

    public void setCaptcha(String captcha) {
        this.captcha = captcha;
    }
}
