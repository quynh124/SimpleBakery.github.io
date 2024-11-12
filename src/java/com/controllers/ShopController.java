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
public class ShopController {

    @Autowired
    private CategoryDAO categoryDAO;
    @Autowired
    private ProductDAO productDAO;

    @RequestMapping(value = "/shop.htm", method = RequestMethod.GET)
    public String showViewIndex(@RequestParam(value = "page", defaultValue = "1") int page, ModelMap model) {
        int pageSize = 8;       
        List<Categories> listCategory = categoryDAO.findAll();
        model.addAttribute("listCategory", listCategory);   
        int totalProducts = productDAO.countActiveProducts(); 
        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);       
        int startIndex = (page - 1) * pageSize;      
        List<Products> pagedProducts = productDAO.findActiveProductsPaged(startIndex, pageSize);     
        model.addAttribute("listProduct", pagedProducts);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);

        return "user/shop"; 
    }

    @RequestMapping(value = "/search.htm", method = RequestMethod.GET)
    public String showSearchIndex(@RequestParam(value = "search", required = false) String searchQuery,
            ModelMap model) {
        List<Products> listProduct;
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            listProduct = productDAO.find(searchQuery);
        } else {
            listProduct = productDAO.findAll(); 
        }
        model.addAttribute("listProduct", listProduct);

        return "user/shop";
    }


    @RequestMapping(value = "/shop-details.htm", method = RequestMethod.GET)
    public String showProductDetail(@RequestParam("id") String productId, ModelMap model) {
        List<Products> listProduct = productDAO.findAll();
        model.addAttribute("listProduct", listProduct);
        Products product = productDAO.findById(productId);
        if (product != null) {
            List<Categories> listCategory = categoryDAO.findAll(); 
            model.addAttribute("product", product);
            model.addAttribute("listCategory", listCategory);
            return "user/shop-details"; 
        } else {
            return "error"; 
        }
    }

}
