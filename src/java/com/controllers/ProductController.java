/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.controllers;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.models.Categories;
import com.models.Products;
import com.service.CategoryDAO;
import com.service.ProductDAO;
import java.io.IOException;
import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

/**
 *
 * @author BAOTHI
 */
@Controller
@RequestMapping(value = "/")
public class ProductController {

    @Autowired
    private ProductDAO productDAO;
    @Autowired
    private CategoryDAO categoryDAO;

    @RequestMapping(value = "/products_tb.htm", method = RequestMethod.GET)
    public String showProductView(ModelMap model) {
        List<Products> listProduct = productDAO.findAll();
        List<Categories> categories = categoryDAO.findAll();
        int totalProducts = listProduct.size();
        model.addAttribute("totalProducts", totalProducts);
        model.addAttribute("categories", categories);
        model.addAttribute("listProduct", listProduct);
        return "admin/products_tb";
    }

    @ModelAttribute("productForm")
    public Products productAddForm() {
        return new Products();
    }

    @RequestMapping(value = "/products_add.htm", method = RequestMethod.GET)
    public String showAddProductForm(ModelMap model) {
        List<Categories> categories = categoryDAO.findAll();
        model.addAttribute("categories", categories);
        return "admin/products_add";
    }

    @RequestMapping(value = "/products_add.htm", method = RequestMethod.POST)
    public String addProduct(@RequestParam(value = "image", required = false) MultipartFile image,
            @ModelAttribute("productForm") @Valid Products products,
            BindingResult br, ModelMap model) {

        try {
            // Tạo ID sản phẩm mới
            String nextProductID = productDAO.getNextProductID(products.getCategoryID(), products.getProductName());
            products.setProductID(nextProductID);
            products.setCreateDate(new java.util.Date());
            // Xử lý upload file với Cloudinary
            if (image != null && !image.isEmpty()) {
                // Initialize Cloudinary
                Map<String, String> cloudinaryConfig = new HashMap<>();
                cloudinaryConfig.put("cloud_name", "dyetbks6g");
                cloudinaryConfig.put("api_key", "271339192833531");
                cloudinaryConfig.put("api_secret", "zkdgWWLb0LG1iPDYn8NMSIH8Q24");
                Cloudinary cloudinary = new Cloudinary(cloudinaryConfig);

                // Upload image to Cloudinary
                Map<String, Object> uploadResult = cloudinary.uploader().upload(image.getBytes(), ObjectUtils.emptyMap());
                String imageUrl = (String) uploadResult.get("secure_url");
                products.setImage(imageUrl);
            }

            // Thêm sản phẩm vào cơ sở dữ liệu
            productDAO.add(products);
            model.addAttribute("result_add", "true");

        } catch (IOException e) {
            e.printStackTrace();
            model.addAttribute("result_add", "false");
            model.addAttribute("error_message", "Error while uploading image or saving product. Please try again.");
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("result_add", "false");
            model.addAttribute("error_message", "An unexpected error occurred. Please try again.");
        }

        return "redirect:/products_tb.htm"; // Redirect đến trang danh sách sau khi thêm
    }

    @ModelAttribute("productToUpdate")
    public Products productUpdate() {
        return new Products();
    }

    @RequestMapping(value = "/productupdateshow.htm", method = RequestMethod.GET)
    @ResponseBody
    public String showUpdateProductForm(@RequestParam("id") String id, ModelMap model) {
        try {
            Products products = productDAO.get(id);
            List<Categories> categories = categoryDAO.findAll();
            model.addAttribute("categories", categories);
            if (products != null) {
                model.addAttribute("productToUpdate", products);

                return "productID=" + products.getProductID() + "&productName=" + products.getProductName() + "&unitPrice=" + products.getUnitPrice() + "&size=" + products.getSize() + "&image=" + products.getImage() + "&quantity=" + products.getQuantity() + "&decription=" + products.getDecription() + "&categoryID=" + products.getCategoryID();
            } else {

                return "error:Product not found";
            }
        } catch (Exception e) {
            e.printStackTrace();

            return "error:Error fetching product";
        }
    }

    @RequestMapping(value = "/updateProduct.htm", method = RequestMethod.POST)
    public String updateProduct(
            @RequestParam(value = "image", required = false) MultipartFile image,
            @ModelAttribute("productToUpdate") @Valid Products products,
            BindingResult br, ModelMap model) {

        try {
            Products existingProduct = productDAO.get(products.getProductID());

            if (image != null && !image.isEmpty()) {
                // Initialize Cloudinary
                Map<String, String> cloudinaryConfig = new HashMap<>();
                cloudinaryConfig.put("cloud_name", "dyetbks6g");
                cloudinaryConfig.put("api_key", "271339192833531");
                cloudinaryConfig.put("api_secret", "zkdgWWLb0LG1iPDYn8NMSIH8Q24");
                Cloudinary cloudinary = new Cloudinary(cloudinaryConfig);

                // Upload image to Cloudinary
                Map<String, Object> uploadResult = cloudinary.uploader().upload(image.getBytes(), ObjectUtils.emptyMap());
                String imageUrl = (String) uploadResult.get("secure_url");
                products.setImage(imageUrl); // Cập nhật URL hình ảnh
            } else {
                // Nếu không có hình ảnh mới, giữ nguyên hình ảnh hiện tại
                products.setImage(existingProduct.getImage());
            }

            // Cập nhật sản phẩm vào cơ sở dữ liệu
            productDAO.change(products);
            List<Categories> categories = categoryDAO.findAll();
            model.addAttribute("categories", categories);

        } catch (IOException e) {
            e.printStackTrace();
            model.addAttribute("result_update", "false");
            model.addAttribute("error_message", "Error while uploading image or saving product. Please try again.");
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("result_update", "false");
            model.addAttribute("error_message", "An unexpected error occurred. Please try again.");
        }

        return "redirect:/products_tb.htm"; // Redirect đến trang danh sách sau khi cập nhật
    }

    @RequestMapping(value = "/productdelete.htm", method = RequestMethod.GET)
    public String deleteOrder(@RequestParam("id") String id, ModelMap model) {
        try {
            // First, delete related records in OrderDetails
            productDAO.delete(id);

            model.addAttribute("result_delete", "true");
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("result_delete", "false");
            model.addAttribute("error_message", "Error while deleting product. Please try again.");
        }
        return "redirect:/products_tb.htm"; // Redirect to the orders list page after deletion
    }
}
