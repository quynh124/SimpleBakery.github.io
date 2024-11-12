package com.controllers;

import com.models.Faq;
import com.service.FaqDAO;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(value = "/", method = RequestMethod.GET)
public class FaqController {

    @Autowired
    private FaqDAO faqDAO;

    @GetMapping("/faqs")
    public String showFaqs(Model model) {
        model.addAttribute("faqs", faqDAO.findAll());
        return "user/faqs"; // Tên của JSP hoặc view hiển thị danh sách FAQs
    }

    @RequestMapping(value = "/viewfaq.htm", method = RequestMethod.GET)
    public String showFaq(@RequestParam(value = "page", defaultValue = "1") int page, ModelMap model) {
        int pageSize = 10;  // Number of FAQs per page
        List<Faq> allFaqs = faqDAO.findAll();  // Retrieve all FAQs from the database
        int totalFaqs = allFaqs.size();
        int totalPages = (int) Math.ceil((double) totalFaqs / pageSize);

        // Calculate start and end index for the current page
        int startIndex = (page - 1) * pageSize;
        int endIndex = Math.min(startIndex + pageSize, totalFaqs);

        List<Faq> pagedFaqs = allFaqs.subList(startIndex, endIndex);

        model.addAttribute("listFaq", pagedFaqs);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);

        return "user/viewfaq";
    }

    @RequestMapping(value = "/updateReply.htm", method = RequestMethod.POST)
    @ResponseBody
    public String updateReply(@RequestParam("faqID") int faqID, @RequestParam("reply") String reply) {
        faqDAO.updateReply(faqID, reply);
        return "Reply updated successfully!";
    }

    @RequestMapping(value = "/faqs.htm", method = RequestMethod.GET)
    public String showAddFaqForm(ModelMap model) {
        return "user/viewfaq"; // Return the view name for the form to add a faq
    }

    @RequestMapping(value = "/faqs.htm", method = RequestMethod.POST)
    public String addFaqs(@ModelAttribute("faqForm") Faq faq, BindingResult br, ModelMap model) {
        model.addAttribute("result_add", "true");
        faqDAO.add(faq);
        return "redirect:/viewfaq.htm";
    }

    @ModelAttribute(value = "faqForm")
    public Faq faqAddForm() {
        return new Faq();
    }

    @RequestMapping(value = "/addfaqs.htm", method = RequestMethod.GET)
    public String showAddFaqsForm(ModelMap model) {
        return "admin/addfaqs"; // Return the view name for the form to add a faq
    }

    @RequestMapping(value = "/addfaqs.htm", method = RequestMethod.POST)
    public String addFaq(@ModelAttribute("faqForm") Faq faq, BindingResult br, ModelMap model) {
        model.addAttribute("result_add", "true");
        faqDAO.add(faq);
        return "redirect:/addfaqs.htm";
    }

    @RequestMapping(value = "/faqdelete.htm", method = RequestMethod.GET)
    public String deleteFaq(int id, ModelMap model) {
        faqDAO.delete(id);
        return showFaqView(model);
    }

    @RequestMapping(value = "/formfaqs.htm", method = RequestMethod.GET)
    public String showFaqView(ModelMap model) {
        List<Faq> listFaq = faqDAO.findAll();
        model.addAttribute("listFaq", listFaq);
        return "admin/formfaqs";
    }

    @ModelAttribute("faqToUpdate")
    public Faq faqUpdate() {
        return new Faq();
    }

    @RequestMapping(value = "/faqupdateshow.htm", method = RequestMethod.GET)
    @ResponseBody
    public String showUpdateFaqForm(@RequestParam("id") int id) {
        try {
            Faq faq = faqDAO.get(id);
            if (faq != null) {
                return "faqID=" + faq.getFaqID() + "&emailUser=" + faq.getEmailUser() +  "&content=" + faq.getContent() + "&reply=" + faq.getReply() + "&status=" + faq.getStatus();
            } else {
                return "error:Faq not found";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "error:Error fetching faq";
        }
    }
//

    @RequestMapping(value = "/updateFaq.htm", method = RequestMethod.POST)
    public String updateFaq(@ModelAttribute("faqToUpdate") Faq faq, ModelMap model) {
        try {
            faqDAO.change(faq);
            return "redirect:/formfaqs.htm"; // Redirect to the list page after updating
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Error updating FAQ");
            return "error"; // Return error page in case of exception
        }
    }
//ket

    @GetMapping("/faqsearch")
    public String showFaqSearchForm(Model model) {
        model.addAttribute("faqFormsearch", new Faq()); // Khởi tạo đối tượng FAQ
        return "admin/formfaqs"; // Trả về trang JSP chứa form
    }

    @PostMapping("/faqsearch")
    public String searchFaq(@ModelAttribute("faqFormsearch") Faq faq, BindingResult br, ModelMap model) {
        String name = faq.getEmailUser();
        List<Faq> faqs = faqDAO.find(name);
        if (faqs != null && !faqs.isEmpty()) {
            model.addAttribute("listFaq", faqs); // Đảm bảo sử dụng đúng danh sách FAQs
        } else {
            model.addAttribute("listFaq", null);
            model.addAttribute("searchError", "Faq not found");
        }
        return "admin/formfaqs"; // Trả về trang hiển thị kết quả tìm kiếm mà không chuyển hướng
    }

  
}
