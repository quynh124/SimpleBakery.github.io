/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.models;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;

/**
 *
 * @author Hp
 */
public class Payment {
    private int paymentID;
    @NotNull
    @NotEmpty(message="Payment Name is not empty")
    private String paymentName;
    @NotNull
    @NotEmpty(message="Desciption is not empty")
    private String description;
    
    public Payment(){
        this.paymentID = 0;
        this.paymentName = null;
        this.description = null;
        
    }
    public Payment( int paymentID, String paymentName, String description){
        this.paymentID = paymentID;
        this.paymentName = paymentName;
        this.description = description;
    }

    public int getPaymentID() {
        return paymentID;
    }

    public void setPaymentID(int paymentID) {
        this.paymentID = paymentID;
    }

    public String getPaymentName() {
        return paymentName;
    }

    public void setPaymentName(String paymentName) {
        this.paymentName = paymentName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
