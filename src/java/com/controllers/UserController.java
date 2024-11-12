package com.controllers;

import com.models.Admin;
import com.models.User;
import com.service.AdminDAO;
import com.service.UserDAO;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(value = "/")
public class UserController {

    @Autowired
    private AdminDAO adminDAO;

    @Autowired
    private UserDAO userDAO;

    @ModelAttribute("registerForm")
    public User registerAddForm() {
        return new User();
    }

    @RequestMapping(value = "/register.htm", method = RequestMethod.GET)
    public String showRegisterUserForm(ModelMap model) {
        return "user/register";
    }

    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public String addRegister(@ModelAttribute("registerForm") User user, BindingResult br, ModelMap model) {
        if (userDAO.isUsernameTaken(user.getUsername())) {
            br.rejectValue("username", "error.user", "Username already exists");
            return "user/register";
        }
        userDAO.add(user);
        model.addAttribute("result_add", "true");
        return "redirect:/login.htm";
    }

    @ModelAttribute(value = "loginUserForm")
    public User userForm() {
        return new User();
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String showLoginForm() {
        return "user/login";
    }

    @RequestMapping(value = "/login_process", method = RequestMethod.POST)
    public String loginProcess(@ModelAttribute("loginUserForm") User user, ModelMap model, HttpSession session) {
        // Validate captcha
        String sessionCaptcha = (String) session.getAttribute("captcha");
        if (sessionCaptcha == null || !sessionCaptcha.equals(user.getCaptcha())) {
            model.addAttribute("loginError", "Invalid Captcha");
            return "user/login";
        }

        // Check if admin login
        Admin dbAdmin = adminDAO.getAdminByUsernameAndPassword(user.getUsername(), user.getPassword());
        if (dbAdmin != null) {
            session.setAttribute("uname", dbAdmin.getUsername());
            return "redirect:/admin.htm"; // Redirect to admin page
        }

        // Check regular user login
        User dbUser = userDAO.getUserByUsernameAndPassword(user.getUsername(), user.getPassword());
        if (dbUser != null) {
            session.setAttribute("uname", dbUser.getUsername());
            session.setAttribute("userID", dbUser.getUserID()); // Save userID to session
            return "redirect:/index.htm"; // Redirect to index page
        } else {
            model.addAttribute("loginError", "Invalid username, password, or captcha");
            return "user/login";
        }
    }

    @RequestMapping(value = "/index.htm", method = RequestMethod.GET)
    public String homePage(HttpSession session) {
        if (session.getAttribute("userID") == null) {
            return "redirect:/login.htm"; // Redirect to login if not logged in
        }
        return "user/index";
    }

    @RequestMapping(value = "/admin.htm", method = RequestMethod.GET)
    public String adminPage(HttpSession session) {
        if (session.getAttribute("uname") == null) {
            return "redirect:/login.htm"; // Redirect to login if not logged in
        }
        return "admin/admin";
    }

    @RequestMapping(value = "/logout.htm", method = RequestMethod.GET)
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login.htm";
    }

    @RequestMapping(value = "/userupdateshow.htm", method = RequestMethod.GET)
    @ResponseBody
    public String showUpdateUserForm(@RequestParam("id") int id) {
        try {
            User user = userDAO.get(id);
            if (user != null) {
                return "userID=" + user.getUserID() + "&fullname=" + user.getFullname()
                        + "&username=" + user.getUsername() + "&password=" + user.getPassword()
                        + "&email=" + user.getEmail() + "&phone=" + user.getPhone()
                        + "&address=" + user.getAddress();
            } else {
                return "error:User not found";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "error:Error fetching user";
        }
    }

    @RequestMapping(value = "/updateUser.htm", method = RequestMethod.POST)
    public String updateUser(@ModelAttribute("userToUpdate") User user, ModelMap model) {
        userDAO.change(user);
        return "redirect:/formuser.htm";
    }

    @RequestMapping(value = "/formuser.htm", method = RequestMethod.GET)
    public String showUserView(ModelMap model) {
        List<User> listUser = userDAO.findAll();
        model.addAttribute("listUser", listUser);
        return "admin/formuser";
    }

    @ModelAttribute(value = "userForm")
    public User userAddForm() {
        return new User();
    }

    @RequestMapping(value = "/adduser.htm", method = RequestMethod.GET)
    public String showAddUsersForm(ModelMap model) {
        return "admin/adduser"; // Return the view name for the form to add a user
    }

    @RequestMapping(value = "/adduser.htm", method = RequestMethod.POST)
    public String addUser(@ModelAttribute("userForm") User user, BindingResult br, ModelMap model) {
        model.addAttribute("result_add", "true");
        userDAO.add(user);
        return "redirect:/admin.htm";
    }

    @RequestMapping(value = "/userdelete.htm", method = RequestMethod.GET)
    public String deleteUser(@RequestParam("id") int id, ModelMap model) {
        boolean hasOrders = userDAO.checkUserHasOrders(id);
        if (hasOrders) {
            model.addAttribute("errorMessage", "Cannot delete user. There are orders associated with this user.");
            return showUserView(model);
        } else {
            userDAO.delete(id);
            return showUserView(model);
        }
    }

    @RequestMapping("/forgot.htm")
    public String showForgotPasswordPage(Model model) {
        return "user/forgot";
    }

    @RequestMapping(value = "/forgot.htm", method = RequestMethod.POST)
    public String resetPassword(@RequestParam("email") String email, @RequestParam("newPassword") String newPassword, Model model) {
        User user = userDAO.findUserByEmail(email);
        if (user != null) {
            userDAO.updatePassword(user.getUserID(), newPassword);
            model.addAttribute("message", "Password reset successful! Please log in.");
            return "redirect:/login.htm"; // Chuyển hướng tới trang login khi thành công
        } else {
            model.addAttribute("error", "Email not found!");
            return "user/forgot"; // Hiển thị lại trang quên mật khẩu với thông báo lỗi
        }
    }

    @RequestMapping(value = {"/", "/login"})
    public String login(@RequestParam(required = false) String message, final Model model) {
        if (message != null) {
            model.addAttribute("message", message);
        }
        return "user/login";
    }

    @RequestMapping(value = "/login_checkout", method = RequestMethod.POST)
    public String loginCheckout(@ModelAttribute("loginUserForm") User user, ModelMap model, HttpSession session) {
        Admin dbAdmin = adminDAO.getAdminByUsernameAndPassword(user.getUsername(), user.getPassword());
        if (dbAdmin != null) {
            session.setAttribute("uname", dbAdmin.getUsername());
            return "redirect:/admin.htm"; // Redirect to admin page
        }
        User dbUser = userDAO.getUserByUsernameAndPassword(user.getUsername(), user.getPassword());
        if (dbUser != null) {
            session.setAttribute("uname", dbUser.getUsername());
            session.setAttribute("userID", dbUser.getUserID());
            return "redirect:/checkout.htm";
        } else {
            model.addAttribute("loginError", "Invalid username or password");
            return "user/loginCheckout";
        }
    }

    @RequestMapping(value = "/loginCheckout", method = RequestMethod.GET)
    public String showLoginCheckoutForm() {
        return "user/loginCheckout";
    }

    @RequestMapping(value = "/login_order", method = RequestMethod.POST)
    public String loginOrderTracking(@ModelAttribute("loginUserForm") User user, ModelMap model, HttpSession session) {
        Admin dbAdmin = adminDAO.getAdminByUsernameAndPassword(user.getUsername(), user.getPassword());
        if (dbAdmin != null) {
            session.setAttribute("uname", dbAdmin.getUsername());
            return "redirect:/admin.htm"; // Redirect to admin page
        }
        User dbUser = userDAO.getUserByUsernameAndPassword(user.getUsername(), user.getPassword());
        if (dbUser != null) {
            session.setAttribute("uname", dbUser.getUsername());
            session.setAttribute("userID", dbUser.getUserID());
            return "redirect:/order_tracking.htm";
        } else {
            model.addAttribute("loginError", "Invalid username or password");
            return "user/loginOrderTracking";
        }
    }

    @RequestMapping(value = "/loginOrderTracking", method = RequestMethod.GET)
    public String showLoginOrderForm() {
        return "user/loginOrderTracking";
    }
}
