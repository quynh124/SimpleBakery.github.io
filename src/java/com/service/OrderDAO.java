/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.service;

import com.models.OrderDetail;
import com.models.OrderDetailDTO;
import com.models.Orders;
import java.time.LocalDate;
import java.util.List;

/**
 *
 * @author BAOTHI
 */
public interface OrderDAO {

    public List<Orders> findAll();

    public void add(Orders orders);

    public void change(String orderID, String newStatus);

    public Orders get(String id);

    public void delete(String id);

    public List<Orders> find(String keyword);

 
   

   public  String generateRandomOrderID();

  

     Orders findByOrderID(String orderID);

    public List<Orders> findByUserID(Integer userID);

     boolean existsByOrderID(String orderID);

    public List<OrderDetailDTO> findOrderDetailsByUserID(Integer userID);

    public List<OrderDetailDTO> findOrderDetailsByOrderID(String orderID);

    public Object findByID(String orderID);

   public List<Orders> findByOrderDate(java.sql.Date orderDate);
}
