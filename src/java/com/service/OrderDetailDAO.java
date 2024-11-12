/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.service;

import com.models.OrderDetail;
import com.models.RevenueDTO;
import com.models.OrderDetailDTO;
import com.models.Payment;
import java.util.List;

/**
 *
 * @author BAOTHI
 */
public interface OrderDetailDAO {

    void add(OrderDetail orderDetail);  
  public List<OrderDetail> findAll();
    OrderDetail findById(String orderDetailID);  


    void update(OrderDetail orderDetail); 

    void delete(String orderDetailID);  

    public List<OrderDetailDTO> findByOrderID(String orderID);

    public  void deleteByOrderId(String orderID);

  public List<RevenueDTO> getMonthlyRevenue();

   public Payment getPaymentMethod(int paymentID) ;
 public List<RevenueDTO> getQuarterlyRevenue();
 public List<RevenueDTO> getRevenueCurrentAndPreviousMonth();
}
