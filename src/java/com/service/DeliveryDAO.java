/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.service;

import com.models.Delivery;
import java.math.BigDecimal;
import java.util.List;

/**
 *
 * @author Hp
 */
public interface DeliveryDAO {
    
     public List<Delivery> findAll();

    public void add(Delivery delivery);

    public void change(Delivery delivery);

    public Delivery get(int id);

    public void delete(int id);

    public List<Delivery> find(String keyword);

    public Delivery findByName(String deliveryName);

    public BigDecimal getDeliveryCost(int deliveryID) ;

    Delivery findByID(int deliveryID);
     public boolean checkDeliveryHasOrders(int deliveryId);
}
