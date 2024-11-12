/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.controllers;

import com.models.CartItem;
import com.models.Products;
import com.service.CartDAO;
import com.service.CategoryDAO;
import com.service.ProductDAO;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpSession;
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
public class CartController {

    @Autowired
    private CategoryDAO categoryDAO;
    @Autowired
    private ProductDAO productDAO;

    @Autowired
    private CartDAO cartDAO;

    @RequestMapping(value = "/add-to-cart.htm", method = RequestMethod.POST)
    public String addToCart(
            @RequestParam("productID") String productID,
            @RequestParam("productName") String productName,
            @RequestParam("size") int size,
            @RequestParam("quantityCart") int quantityCart,
            @RequestParam("unitPrice") BigDecimal unitPrice,
            @RequestParam("image") String image,
            HttpSession session,
            ModelMap model) {

        // Fetch the product from the database (optional)
        Products product = productDAO.findById(productID);

        // Create CartItem object
        CartItem cartItem = new CartItem();
        cartItem.setProductID(productID);
        cartItem.setProductName(productName);
        cartItem.setSize(size);
        cartItem.setQuantityCart(quantityCart);
        cartItem.setUnitPrice(unitPrice);
        cartItem.setTotal(unitPrice.multiply(BigDecimal.valueOf(quantityCart))); // Calculate total price for this item
        cartItem.setImage(image);

        // Retrieve the cart from the session
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }

        // Check if the item already exists in the cart
        boolean itemExists = false;
        for (CartItem item : cart) {
            if (item.getProductID().equals(productID) && item.getSize() == size) {
                // Update quantity and total if item exists
                item.setQuantityCart(item.getQuantityCart() + quantityCart);
                item.setTotal(item.getUnitPrice().multiply(BigDecimal.valueOf(item.getQuantityCart())));
                itemExists = true;
                break;
            }
        }

        if (!itemExists) {
            // Add new item to the cart if it does not exist
            cart.add(cartItem);
        }

        // Save updated cart to session
        session.setAttribute("cart", cart);

        // Update total count and total price in the session
        int totalCount = cart.stream().mapToInt(CartItem::getQuantityCart).sum();
        BigDecimal totalPrice = cart.stream()
                .map(CartItem::getTotal)
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        model.addAttribute("cartItems", cart);
        session.setAttribute("totalCount", totalCount);
        session.setAttribute("totalPrice", totalPrice);

        // Redirect to cart page
        return "redirect:/cart.htm";
    }

    // Phương thức hiển thị giỏ hàng
    @RequestMapping(value = "/cart.htm", method = RequestMethod.GET)
    public String viewCart(HttpSession session, Model model) {
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }
        model.addAttribute("cart", cart);
        return "user/cart"; // Đây là tên của view (JSP hoặc Thymeleaf) để hiển thị giỏ hàng
    }

   @RequestMapping(value = "/remove.htm", method = RequestMethod.POST)
public String removeFromCart(@RequestParam("productID") String productID, 
                              @RequestParam("size") int size,
                              HttpSession session) {
    
    // Lấy giỏ hàng từ session
    List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cart");

    if (cartItems != null) {
        // Tìm và xóa sản phẩm khỏi giỏ hàng
        cartItems.removeIf(item -> item.getProductID().equals(productID) && item.getSize() == size);

        // Cập nhật lại tổng số lượng sản phẩm và tổng giá
        int totalCount = cartItems.stream().mapToInt(CartItem::getQuantityCart).sum();
        BigDecimal totalPrice = cartItems.stream().map(CartItem::getTotal).reduce(BigDecimal.ZERO, BigDecimal::add);

        // Cập nhật lại session
        session.setAttribute("cart", cartItems);
        session.setAttribute("totalCount", totalCount);
        session.setAttribute("totalPrice", totalPrice);
    }

    return "redirect:/cart.htm"; // Chuyển hướng về trang giỏ hàng
}

    @RequestMapping(value = "/clear-cart.htm", method = RequestMethod.POST)
    public String clearCart(HttpSession session) {
        // Xóa giỏ hàng khỏi session
        session.removeAttribute("cart");

        // Cập nhật số lượng và tổng giá trị về 0
        session.setAttribute("totalCount", 0);
        session.setAttribute("totalPrice", 0.00);

        return "redirect:/cart.htm"; // Chuyển hướng về trang giỏ hàng
    }

}
