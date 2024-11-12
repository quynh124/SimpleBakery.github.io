/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.controllers;

import com.models.Categories;
import com.models.OrderDetailDTO;
import com.models.Orders;
import com.models.Products;
import com.models.RevenueDTO;
import com.models.User;
import com.models.Voucher;
import com.service.CategoryDAO;

import com.service.UserDAO;
import com.service.OrderDAO;
import com.service.OrderDetailDAO;
import com.service.ProductDAO;
import com.service.VoucherDAO;

import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 *
 * @author BAOTHI
 */
@Controller
@RequestMapping(value = "/")
public class AdminController {

    @Autowired
    private ProductDAO productDAO;
    @Autowired
    private VoucherDAO voucherDAO;
    @Autowired
    private OrderDAO orderDAO;
    @Autowired
    private OrderDetailDAO orderDetailDAO;
    @Autowired
    private UserDAO userDAO;

    @RequestMapping(value = "/admin.htm", method = RequestMethod.GET)
    public String showAdmin(Model model) {

        List<Products> listProduct = productDAO.findAll();
        List<Orders> listOrder = orderDAO.findAll();
        List<User> listUser = userDAO.findAll();
        List<Voucher> listVoucher = voucherDAO.findAll();

        int totalUser = listUser.size();
        int totalVoucher = listVoucher.size();
        int totalProducts = listProduct.size();
        int totalOrders = listOrder.size();

        System.out.println("Total Products: " + totalProducts);
        System.out.println("Total Orders: " + totalOrders);
        System.out.println("Total Users: " + totalUser);
        System.out.println("Total Vouchers: " + totalVoucher);

        model.addAttribute("totalVoucher", totalVoucher);
        model.addAttribute("totalUser", totalUser);
        model.addAttribute("totalOrders", totalOrders);
        model.addAttribute("totalProducts", totalProducts);
        model.addAttribute("listOrder", listOrder);

        Map<String, Integer> topSelling = productDAO.getTopSellingProducts();

        model.addAttribute("topSelling", topSelling);
        System.out.println("topSelling: " + topSelling);
        Map<String, Integer> topSellingbyMonth = productDAO.getTopSellingProductsByMonth();

        List<RevenueDTO> monthlyRevenue = orderDetailDAO.getRevenueCurrentAndPreviousMonth();
        model.addAttribute("monthlyRevenue", monthlyRevenue);

        model.addAttribute("topSellingbyMonth", topSellingbyMonth);
        System.out.println("topSellingbyMonth: " + topSellingbyMonth);

        List<RevenueDTO> revenueList = orderDetailDAO.getMonthlyRevenue();
        List<RevenueDTO> quarterList = orderDetailDAO.getQuarterlyRevenue();
        System.out.println("Revenue List: " + revenueList);
        model.addAttribute("revenueList", revenueList);
        System.out.println("quarterList : " + quarterList);
        model.addAttribute("quarterList", quarterList);

        java.sql.Date currentDate = new java.sql.Date(System.currentTimeMillis());

        List<Orders> listOrders = orderDAO.findByOrderDate(currentDate);
        model.addAttribute("listOrders", listOrders);

        return "admin/admin";
    }

}
