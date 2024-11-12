/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.controllers;

import com.models.Categories;
import com.models.Products;
import com.service.CategoryDAO;
import com.service.ProductDAO;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author BAOTHI
 */
@Controller
@RequestMapping(value = "/")
public class HomeController {

    @Autowired
    private CategoryDAO categoryDAO;
    @Autowired
    private ProductDAO productDAO;

    @RequestMapping(value = "/index.htm", method = RequestMethod.GET)
    public String showViewIndex(ModelMap model) {
        List<Categories> listCategory = categoryDAO.findAll();
        model.addAttribute("listCategory", listCategory);

        // Lấy tối đa 8 sản phẩm không bị xóa
        List<Products> pagedProducts = productDAO.findActiveProductsPaged(0, 8);

        // Gán dữ liệu vào model để hiển thị trên giao diện
        model.addAttribute("listProduct", pagedProducts);

        return "user/index";
    }

    @RequestMapping(value = "/about.htm", method = RequestMethod.GET)
    public String showAbout(ModelMap model) {
        return "user/about"; // Return the view name for the form to add a faq
    }

   

    @RequestMapping(value = "/blog.htm", method = RequestMethod.GET)
    public String showBlog(ModelMap model) {
        return "user/blog"; // Return the view name for the form to add a faq
    }

    @RequestMapping(value = "/contact.htm", method = RequestMethod.GET)
    public String showContact(ModelMap model) {
        return "user/contact"; // Return the view name for the form to add a faq
    }
}
