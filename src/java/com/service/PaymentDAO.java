/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.service;

import com.models.Payment;
import java.util.List;



/**
 *
 * @author Hp
 */
public interface PaymentDAO {
    
    public List<Payment> findAll();

    public void add(Payment payment);

    public void change(Payment payment);

    public Payment get(int id);

    public void delete(int id);

    public List<Payment> find(String keyword);
     List<Payment> findByNameContaining(String name);

    public boolean checkPaymentHasOrders(int id);
}


