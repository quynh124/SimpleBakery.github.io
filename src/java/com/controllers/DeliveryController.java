/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.controllers;

import com.service.DeliveryDAO;
import com.models.Delivery;
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
@RequestMapping(value = "/",method = RequestMethod.GET)
public class DeliveryController {
    
    @Autowired
    private DeliveryDAO deliveryDAO;

    @RequestMapping(value = "/formdelivery.htm", method = RequestMethod.GET)
    public String showDeliveryView(ModelMap model) {
        List<Delivery> listDelivery = deliveryDAO.findAll();
        model.addAttribute("listDelivery", listDelivery);
        return "admin/formdelivery";
    }

    @ModelAttribute(value = "deliveryForm")
    public Delivery deliveryAddForm() {
       return new Delivery();
    }
    
    @RequestMapping(value = "/adddelivery.htm", method = RequestMethod.GET)
    public String showAddDeliverysForm(ModelMap model) {
        return "admin/adddelivery"; // Return the view name for the form to add a delivery
    }
    @RequestMapping(value = "/adddelivery.htm", method = RequestMethod.POST)
    public String addDelivery(@ModelAttribute("deliveryForm") Delivery delivery, BindingResult br, ModelMap model) {
        model.addAttribute("result_add", "true");
        deliveryDAO.add(delivery);
        return "redirect:/formdelivery.htm";
    }
        @RequestMapping(value = "/deliverydelete.htm", method = RequestMethod.GET)
    public String deleteDelivery(int id, ModelMap model) {
        boolean hasOrders = deliveryDAO.checkDeliveryHasOrders(id);
    
    if (hasOrders) {
        // If the user has orders, show an error message
        model.addAttribute("errorMessage", "Cannot delete user. There are orders associated with this user.");
        return showDeliveryView(model);
    } else {
        // If no orders exist, delete the user
        deliveryDAO.delete(id);
        return showDeliveryView(model);
    }
    }
    @ModelAttribute("deliveryToUpdate")
    public Delivery deliveryUpdate() {
        return new Delivery();
    }

    @RequestMapping(value = "/deliveryupdateshow.htm", method = RequestMethod.GET)
    @ResponseBody
    public String showUpdateDeliveryForm(@RequestParam("id") int id) {
        try {
            Delivery delivery = deliveryDAO.get(id);
            if (delivery != null) {
                return "deliveryID=" + delivery.getDeliveryID()+ "&deliveryName=" + delivery.getDeliveryName()  + "&distance=" + delivery.getDistance() +"&price=" + delivery.getPrice() ;
            } else {
                return "error:Delivery not found";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "error:Error fetching delivery";
        }
    }
//
    @RequestMapping(value = "/updateDelivery.htm", method = RequestMethod.POST)
    public String updateDelivery(@ModelAttribute("deliveryToUpdate") Delivery delivery, ModelMap model) {
        try {
            deliveryDAO.change(delivery);
            return "redirect:/formdelivery.htm"; // Redirect to the list page after updating
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Error updating FAQ");
            return "error"; // Return error page in case of exception
        }
    }
}
