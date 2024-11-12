/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.models;

import java.math.BigDecimal;
import javax.validation.constraints.NotNull;

/**
 *
 * @author Hp
 */
public class Delivery {
    
    private int deliveryID;
    @NotNull
    private String deliveryName;
    @NotNull
    private String distance;
    @NotNull
    private BigDecimal price;

    public Delivery(){
        this.deliveryID = 0;
        this.deliveryName = null;
        this.distance = null;
        this.price = null;
        
    }
    public Delivery(int deliveryID, String deliveryName, String distance, BigDecimal price){
        this.deliveryID = deliveryID;
        this.deliveryName = deliveryName;
        this.distance = distance;
        this.price = price;
    }

  

    public int getDeliveryID() {
        return deliveryID;
    }

    public void setDeliveryID(int deliveryID) {
        this.deliveryID = deliveryID;
    }

    public String getDeliveryName() {
        return deliveryName;
    }

    public void setDeliveryName(String deliveryName) {
        this.deliveryName = deliveryName;
    }

    public String getDistance() {
        return distance;
    }

    public void setDistance(String distance) {
        this.distance = distance;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    
}
