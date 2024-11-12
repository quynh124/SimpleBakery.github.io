/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.service;

import com.models.Voucher;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 *
 * @author Hp
 */
public interface VoucherDAO  {
    
    public List<Voucher> findAll();

    public void add(Voucher voucher);
    void saveOrUpdate(Voucher voucher);

    public void change(Voucher voucher);

    public Voucher get(int id);

    public void delete(int id);

    public List<Voucher> find(String keyword);
    
    void updateVoucher(Voucher voucher);
    
    List<Voucher> getAllVouchers();
    Voucher getVoucherByCode(String voucherCode);
    boolean isValidVoucher(String voucherCode, Date currentDate);
    
     Voucher findByCode(String code);
public BigDecimal getVoucherDiscount(int VoucherID);
    public boolean checkVoucherHasOrders(int id);
     public Voucher findById(int voucherID);
}
