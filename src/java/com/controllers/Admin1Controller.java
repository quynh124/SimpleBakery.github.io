

package com.controllers;

import com.models.Admin;
import com.service.AdminDAO;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/")
public class Admin1Controller {

    private JdbcTemplate jdbcTemplate;
    @Autowired
    private AdminDAO adminDAO;

    // Display the admin list page
    @RequestMapping(value = "/formadmin.htm", method = RequestMethod.GET)
    public String showAdminView(ModelMap model) {
        List<Admin> listAdmin = adminDAO.findAll();
        model.addAttribute("listAdmin", listAdmin);  // Add the list to the model
        return "admin/formadmin";  // JSP page to display
    }

    // Prepare an empty admin form
    // Prepare an empty admin form for display
    @ModelAttribute("adminForm")
    public Admin adminAddForm() {
        return new Admin();  // Create an empty Admin object for the form
    }

    // Display the form to add a new admin
    @RequestMapping(value = "/addadmin.htm", method = RequestMethod.GET)
    public String showAddAdminsForm(Model model) {
        // 'adminForm' is automatically added to the model by the @ModelAttribute method
        return "admin/addadmin";  // Displays the form for adding an admin
    }

    // Process the form and add a new admin to the database
    @RequestMapping(value = "/addadmin", method = RequestMethod.POST)
    public String addAdmin(@ModelAttribute("adminForm") Admin admin, BindingResult br, ModelMap model) {
        if (br.hasErrors()) {
            // If there are validation errors, redisplay the form
            return "admin/addadmin";
        }

        // Add the new admin to the database
        adminDAO.add(admin);

        // Indicate that the addition was successful
        model.addAttribute("result_add", "true");

        // Redirect to the form after successful submission
        return "redirect:/formadmin.htm";
    }

    // Delete an admin by their ID
    @RequestMapping(value = "/admindelete.htm", method = RequestMethod.GET)
    public String deleteAdmin(@RequestParam("id") int id, ModelMap model) {
        adminDAO.delete(id);
        return "redirect:/formadmin.htm";  // Refresh the admin list after deletion
    }

    // Show admin details for updating
    @RequestMapping(value = "/adminupdateshow.htm", method = RequestMethod.GET)
    @ResponseBody
    public String showUpdateAdminForm(@RequestParam("id") int id) {
        try {
            Admin admin = adminDAO.get(id);
            if (admin != null) {
                return "adminID=" + admin.getAdminID()
                        + "&username=" + admin.getUsername()
                        + "&password=" + admin.getPassword();
            } else {
                return "error:Admin not found";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "error:Error fetching admin details";
        }
    }

    // Update the admin information
    @RequestMapping(value = "/updateAdmin.htm", method = RequestMethod.POST)
    public String updateAdmin(@ModelAttribute("adminToUpdate") Admin admin, ModelMap model) {
        adminDAO.change(admin);
        return "redirect:/formadmin.htm";  // Redirect to the admin list view after update
    }
}
