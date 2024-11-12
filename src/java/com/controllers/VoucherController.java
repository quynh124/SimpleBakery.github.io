package com.controllers;

import com.models.Voucher;
import com.service.VoucherDAO;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author Hp
 */
@Controller
@RequestMapping(value = "/")
public class VoucherController {

    @Autowired
    private VoucherDAO voucherDAO;

    @RequestMapping(value = "/formvoucher", method = RequestMethod.GET)
    public String showVoucherView(ModelMap model) {
        List<Voucher> listVoucher = voucherDAO.findAll();
        model.addAttribute("listVoucher", listVoucher);
        return "admin/formvoucher";
    }

    @RequestMapping(value = "/vouchers", method = RequestMethod.GET)
    public String showVoucher(ModelMap model) {
        List<Voucher> listVoucher = voucherDAO.findAll();
        model.addAttribute("listVoucher", listVoucher);
        return "user/vouchers";
    }

    @GetMapping("/apply-voucher")
    public String applyVoucher(@RequestParam("voucherCode") String code, Model model) {
        Voucher voucher = voucherDAO.findByCode(code);
        if (voucher != null && voucher.isValid()) {

            model.addAttribute("discountAmount", voucher.getDiscountAmount());
            return "success";
        } else {
            model.addAttribute("error", "Mã giảm giá không hợp lệ hoặc đã hết hạn");
            return "error";
        }
    }

    @ModelAttribute(value = "voucherForm")
    public Voucher voucherAddForm() {
        return new Voucher();
    }

    @RequestMapping(value = "/addvoucher.htm", method = RequestMethod.GET)
    public String showAddVouchersForm(ModelMap model) {
        return "admin/addvoucher"; // Return the view name for the form to add a voucher
    }

    @RequestMapping(value = "/addvoucher", method = RequestMethod.POST)
    public String addVoucher(@ModelAttribute("voucherForm") Voucher voucher, BindingResult br, ModelMap model) {
        model.addAttribute("result_add", "true");
        voucherDAO.add(voucher);
        return "redirect:/formvoucher.htm";
    }

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }

    @RequestMapping(value = "/voucherdelete.htm", method = RequestMethod.GET)
    public String deleteVoucher(int id, ModelMap model) {
        boolean hasOrders = voucherDAO.checkVoucherHasOrders(id);

        if (hasOrders) {
            // If the user has orders, show an error message
            model.addAttribute("errorMessage", "Cannot delete user. There are orders associated with this user.");
            return showVoucherView(model);
        } else {
            // If no orders exist, delete the user
            voucherDAO.delete(id);
            return showVoucherView(model);
        }
    }

    @ModelAttribute("voucherToUpdate")
    public Voucher voucherUpdate() {
        return new Voucher();
    }

    @RequestMapping(value = "/voucherupdateshow.htm", method = RequestMethod.GET)
    @ResponseBody
    public String showUpdateVoucherForm(@RequestParam("id") int id) {
        try {
            Voucher voucher = voucherDAO.get(id);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            if (voucher != null) {
                return "voucherID=" + voucher.getVoucherID()
                        + "&voucherCode=" + voucher.getVoucherCode()
                        + "&discountAmount=" + voucher.getDiscountAmount()
                        + "&startDate=" + voucher.getStartDate()
                        + "&endDate=" + voucher.getEndDate()
                        + "&eventName=" + voucher.getEventName()
                        + "&imagesUrl=" + voucher.getImagesUrl()
                        + "&userID=" + voucher.getUserID();
            } else {
                return "error:Voucher not found";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "error:Error fetching voucher";
        }
    }
//

    @RequestMapping(value = "/updateVoucher.htm", method = RequestMethod.POST)
    public String updateVoucher(@ModelAttribute("voucherToUpdate") Voucher voucher, ModelMap model) {
        try {
            voucherDAO.change(voucher);
            return "redirect:/formvoucher.htm"; // Redirect to the list page after updating
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Error updating Voucher");
            return "error"; // Return error page in case of exception
        }
    }

}
