/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.controllers;

import com.models.CartItem;
import com.models.Delivery;
import com.models.OrderDetail;
import com.models.OrderDetailDTO;
import com.models.Orders;

import com.models.Payment;
import com.models.Products;
import com.service.UserDAO;
import com.models.Voucher;
import com.service.CartDAO;
import com.service.DeliveryDAO;
import com.service.OrderDAO;
import com.service.OrderDetailDAO;
import com.service.PaymentDAO;
import com.service.ProductDAO;
import com.service.VoucherDAO;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author BAOTHI
 */
@Controller
@RequestMapping(value = "/")
public class OrderController {

    @Autowired
    private OrderDAO orderDAO;
    @Autowired
    private OrderDetailDAO orderDetailDAO;
    @Autowired
    private CartDAO cartDAO;
    @Autowired
    private ProductDAO productDAO;
    @Autowired
    private VoucherDAO voucherDAO;

    @Autowired
    private DeliveryDAO deliveryDAO;
    @Autowired
    private PaymentDAO paymentDAO;
    @Autowired
    private UserDAO userDAO;

    @RequestMapping(value = "/orders_tb.htm", method = RequestMethod.GET)
    public String showOrderView(ModelMap model) {
        List<Orders> listOrders = orderDAO.findAll();
        model.addAttribute("listOrders", listOrders);
        return "admin/orders_tb";
    }

    @RequestMapping(value = "/viewdetail.htm", method = RequestMethod.GET)
    public String viewOrderDetail(@RequestParam("orderID") String orderID, Model model) {
        Orders order = orderDAO.findByOrderID(orderID);
        List<OrderDetailDTO> orderDetails = orderDetailDAO.findByOrderID(orderID);
        model.addAttribute("order", order);
        model.addAttribute("orderDetails", orderDetails);
        return "admin/viewdetail"; // The name of the JSP file without the .jsp extension
    }

    @RequestMapping(value = "/orderupdateshow.htm", method = RequestMethod.GET)
    @ResponseBody
    public String showUpdateOrderForm(@RequestParam("id") String id) {
        try {
            Orders order = orderDAO.get(id);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            if (order != null) {
                return "orderID=" + order.getOrderID() + "&orderDate=" + order.getOrderDate()
                        + "&deliveryDate=" + order.getDeliveryDate()
                        + "&totalPrice=" + order.getTotalPrice()
                        + "&status=" + order.getStatus()
                        + "&userID=" + order.getUserID()
                        + "&voucherID=" + order.getVoucherID()
                        + "&paymentID=" + order.getPaymentID()
                        + "&deliveryID=" + order.getDeliveryID();
            } else {
                return "error:Order not found";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "error:Error fetching order";
        }
    }

    @RequestMapping(value = "/updateOrder.htm", method = RequestMethod.POST)
    public String updateOrderStatus(@RequestParam("orderID") String orderID, @RequestParam("status") String newStatus) {
        try {
            orderDAO.change(orderID, newStatus);
            return "redirect:/orders_tb.htm"; // Hoặc trang nào đó để xác nhận cập nhật
        } catch (Exception e) {
            e.printStackTrace();
            return "error"; // Hoặc trang lỗi
        }
    }

    @RequestMapping(value = "/orderdelete.htm", method = RequestMethod.GET)
    public String deleteOrder(@RequestParam("id") String id, ModelMap model) {
        try {
            // First, delete related records in OrderDetails
            orderDetailDAO.deleteByOrderId(id);
            // Then, delete the order itself
            orderDAO.delete(id);
            model.addAttribute("result_delete", "true");
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("result_delete", "false");
            model.addAttribute("error_message", "Error while deleting order. Please try again.");
        }
        return "redirect:/orders_tb.htm"; // Redirect to the orders list page after deletion
    }

    @RequestMapping(value = "/checkout.htm", method = RequestMethod.GET)
    public String showCheckout(HttpSession session, Model model) {
        // Check if user is logged in
//        User user = (User) session.getAttribute("loggedInUser");
        List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cart");
        if (cartItems == null) {
            cartItems = new ArrayList<>();
        }
        BigDecimal subtotal = BigDecimal.ZERO;
        for (CartItem item : cartItems) {
            subtotal = subtotal.add(item.getTotal()); // Ensure item.getTotal() returns the total for that item
        }

        BigDecimal deliveryCost = getDeliveryCost(session); // Assuming this method retrieves the correct delivery cost
        BigDecimal voucherDiscount = getVoucherDiscount(session); // Fetch the voucher discount amount

        // Calculate total price
        BigDecimal totalPrice = subtotal.add(deliveryCost).subtract(voucherDiscount); // Apply voucher discount

        // Add attributes to the model
        model.addAttribute("cart", cartItems);
        model.addAttribute("subtotal", subtotal);
        model.addAttribute("deliveryCost", deliveryCost);
        model.addAttribute("voucherDiscount", voucherDiscount); // Add voucher discount to the model
        model.addAttribute("totalPrice", totalPrice); // Ensure you are adding totalPrice to the model

        List<Delivery> deliveries = deliveryDAO.findAll();
        model.addAttribute("deliveries", deliveries);
        List<Payment> payments = paymentDAO.findAll();
        model.addAttribute("payments", payments);
        List<Voucher> vouchers = voucherDAO.findAll();
        model.addAttribute("vouchers", vouchers);

        return "user/checkout"; // Return view name for checkout page
    }
public BigDecimal getVoucherDiscount(HttpSession session) {
    Integer voucherID = (Integer) session.getAttribute("selectedVoucherID");
    if (voucherID == null) {
        return BigDecimal.ZERO; // Không có voucher được chọn
    }

    Voucher voucher = voucherDAO.findById(voucherID); // Sử dụng phương thức findById
    if (voucher == null || voucher.getStartDate() == null || voucher.getEndDate() == null) {
        return BigDecimal.ZERO; // Trả về 0 nếu voucher không hợp lệ
    }

    Date currentDate = new Date();
    // Kiểm tra xem voucher có còn hiệu lực không
    if (currentDate.before(voucher.getStartDate()) || currentDate.after(voucher.getEndDate())) {
        return BigDecimal.ZERO; // Trả về 0 nếu voucher không còn hiệu lực
    }

    return voucher.getDiscountAmount(); // Trả về discountAmount của voucher
}



    public BigDecimal getDeliveryCost(HttpSession session) {
        Integer deliveryID = (Integer) session.getAttribute("selectedDeliveryID");
        if (deliveryID == null) {
            return BigDecimal.ZERO;
        }
        return deliveryDAO.getDeliveryCost(deliveryID);
    }

    @RequestMapping(value = "/submitOrder.htm", method = RequestMethod.POST)
    public String checkout(
            @RequestParam("delivery") int deliveryID,
            @RequestParam("paymentMethod") int paymentID,
            @RequestParam("phone") String phone,
            @RequestParam("shipAddress") String shipAddress,
            @RequestParam("yourName") String yourName,
            @RequestParam("note") String note,
            @RequestParam(value = "voucher", required = false, defaultValue = "0") int voucherID, // Optional voucherID
            HttpSession session, Model model) {

        Integer userID = (Integer) session.getAttribute("userID");
        if (userID == null) {
            return "redirect:/loginCheckout.htm";
        }

        // Ensure the order ID generation logic is retained
        String orderID = generateRandomOrderID();
        while (orderDAO.findByID(orderID) != null) {
            orderID = generateRandomOrderID();
        }

        Date currentDate = new Date();
        List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cart");
        if (cartItems == null || cartItems.isEmpty()) {
            model.addAttribute("error", "Cart is empty. Cannot proceed with order.");
            return "user/checkout"; // Redirect back to checkout with error
        }

        BigDecimal subtotal = BigDecimal.ZERO;
        for (CartItem item : cartItems) {
            subtotal = subtotal.add(item.getTotal());
        }

        BigDecimal deliveryCost = deliveryDAO.getDeliveryCost(deliveryID);
        BigDecimal voucherDiscount = voucherDAO.getVoucherDiscount(voucherID);
        BigDecimal totalPrice = subtotal.add(deliveryCost).subtract(voucherDiscount);

        Orders order = new Orders();
        order.setOrderID(orderID);
        order.setOrderDate(currentDate);
        order.setDeliveryDate(new Date(currentDate.getTime() + 24 * 60 * 60 * 1000)); // +1 day
        order.setStatus("Ordered");
        order.setDeliveryID(deliveryID);
        order.setPaymentID(paymentID);
        order.setUserID(userID);
        order.setVoucherID(voucherID);
        order.setTotalPrice(totalPrice);
        order.setPhone(phone);
        order.setYourName(yourName);
        order.setShipAddress(shipAddress);
        order.setNote(note);

        try {
            orderDAO.add(order); // Save order to the database
            for (CartItem cartItem : cartItems) {
                OrderDetail orderDetail = new OrderDetail();
                orderDetail.setOrderID(orderID);
                orderDetail.setProductID(cartItem.getProductID());
                orderDetail.setQuantity(cartItem.getQuantityCart());
                orderDetail.setUnitPrice(cartItem.getUnitPrice());
                orderDetailDAO.add(orderDetail);
                Products product = productDAO.findById(cartItem.getProductID());
                if (product != null) {
                    int newQuantity = product.getQuantity() - cartItem.getQuantityCart();
                    if (newQuantity < 0) {
                        throw new IllegalArgumentException("Not enough stock for product: " + product.getProductID());
                    }
                    product.setQuantity(newQuantity);
                    productDAO.update(product); // Save updated product
                }// Add order detail to the database
            }
            session.setAttribute("cart", new ArrayList<>()); // Clear cart
        } catch (Exception e) {
            System.out.println("Error while submitting order: " + e.getMessage());
            model.addAttribute("error", "An error occurred while processing your order. Please try again.");
            return "user/checkout"; // Redirect back to checkout on error
        }

        return "redirect:/order_tracking.htm"; // Redirect to order tracking page on success
    }

    private String generateRandomOrderID() {
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ123456789";
        StringBuilder orderID = new StringBuilder();
        Random rnd = new Random();
        while (orderID.length() < 5) {
            int index = (int) (rnd.nextFloat() * characters.length());
            orderID.append(characters.charAt(index));
        }
        return orderID.toString();
    }

    @RequestMapping(value = "/order_tracking", method = RequestMethod.GET)
    public String showOrderTrackingForm() {
        return "user/order_tracking";
    }

    @RequestMapping(value = "/order_tracking.htm", method = RequestMethod.GET)
    public String trackOrder(HttpSession session, Model model) {
        // Retrieve userID from session
        Integer userID = (Integer) session.getAttribute("userID");
        if (userID == null) {
            return "redirect:/loginOrderTracking.htm";
        }

        // Retrieve the list of orders for the user
        List<Orders> ordersList = orderDAO.findByUserID(userID);
        if (ordersList.isEmpty()) {
            model.addAttribute("message", "No orders found for this user.");
            return "user/order_tracking"; // Return to the same page with a message
        }

        // Add all orders to the model
        model.addAttribute("orders", ordersList);

        Map<String, List<OrderDetailDTO>> allOrderDetails = new HashMap<>();
        for (Orders order : ordersList) {
            List<OrderDetailDTO> orderDetails = orderDAO.findOrderDetailsByOrderID(order.getOrderID());
            System.out.println("Order ID: " + order.getOrderID() + " - Order Details: " + orderDetails); // Kiểm tra dữ liệu
            allOrderDetails.put(order.getOrderID(), orderDetails);
        }

        model.addAttribute("orderDetailsList", allOrderDetails); // Add map of order details for each order

        return "user/order_tracking"; // Return to the JSP page
    }

}
