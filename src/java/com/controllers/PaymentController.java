
package com.controllers;

import com.models.Payment;

import com.service.PaymentDAO;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(value = "/")
public class PaymentController {
    
    @Autowired
    private PaymentDAO paymentDAO;


    
    @RequestMapping(value = "/formpayment", method = RequestMethod.GET)
    public String showPaymentView(ModelMap model) {
        List<Payment> listPayment = paymentDAO.findAll();
        model.addAttribute("listPayment", listPayment);
        return "admin/formpayment";
    }

    @ModelAttribute(value = "paymentForm")
    public Payment paymentAddForm() {
        return new Payment();
    }

    @RequestMapping(value = "/addpayment.htm", method = RequestMethod.GET)
    public String showAddPaymentsForm(ModelMap model) {
        return "admin/addpayment"; // Return the view name for the form to add a payment
    }
    @RequestMapping(value = "/addpayment", method = RequestMethod.POST)
    public String addPayment(@ModelAttribute("paymentForm") Payment payment, BindingResult br, ModelMap model) {
        model.addAttribute("result_add", "true");
        paymentDAO.add(payment);
        return "redirect:/addpayment.htm";
    }

    @RequestMapping(value = "/paymentdelete.htm", method = RequestMethod.GET)
    public String deletePayment(int id, ModelMap model) {
        boolean hasOrders = paymentDAO.checkPaymentHasOrders(id);
    
    if (hasOrders) {
        // If the user has orders, show an error message
        model.addAttribute("errorMessage", "Cannot delete user. There are orders associated with this user.");
        return showPaymentView(model);
    } else {
        // If no orders exist, delete the user
        paymentDAO.delete(id);
        return showPaymentView(model);
    }
    }
    
     @ModelAttribute("paymentToUpdate")
    public Payment paymentUpdate() {
        return new Payment();
    }

    @RequestMapping(value = "/paymentupdateshow.htm", method = RequestMethod.GET)
    @ResponseBody
    public String showUpdatePaymentForm(@RequestParam("id") int id) {
        try {
            Payment payment = paymentDAO.get(id);
            if (payment != null) {
                return "paymentID=" + payment.getPaymentID() + "&paymentName=" + payment.getPaymentName() + "&description=" + payment.getDescription();
            } else {
                return "error:Payment not found";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "error:Error fetching payment";
        }
    }
//
    @RequestMapping(value = "/updatePayment.htm", method = RequestMethod.POST)
    public String updatePayment(@ModelAttribute("paymentToUpdate") Payment payment, ModelMap model) {
        try {
            paymentDAO.change(payment);
            return "redirect:/formpayment.htm"; // Redirect to the list page after updating
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Error updating Payment");
            return "error"; // Return error page in case of exception
        }
    }
  
}
