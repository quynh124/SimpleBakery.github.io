package com.controllers;

import com.models.Categories;

import com.service.CategoryDAO;
import com.service.ProductDAO;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value = "/")
public class CategoryController {

    @Autowired
    private CategoryDAO categoryDAO;
    @Autowired
    private ProductDAO productDAO;

    @RequestMapping(value = "/categories_tb.htm", method = RequestMethod.GET)
    public String showCategoryView(ModelMap model) {
        List<Categories> listCategory = categoryDAO.findAll();
        model.addAttribute("listCategory", listCategory);
        return "admin/categories_tb";
    }

    @ModelAttribute("categoryForm")
    public Categories categoryAddForm() {
        return new Categories();
    }

    @RequestMapping(value = "/categories_add.htm", method = RequestMethod.GET)
    public String showAddCategoryForm(ModelMap model) {
        return "admin/categories_add"; // Return the view name for the form to add a category
    }

    @RequestMapping(value = "/categories_add.htm", method = RequestMethod.POST)
    public String addCategory(@ModelAttribute("categoryForm") Categories categories, BindingResult br, ModelMap model) {
        if (br.hasErrors()) {
            System.out.println("Validation errors: " + br.getAllErrors());
            return "admin/categories_add"; // Return to the form view if there are errors
        }
        try {
            String categoryID = generateCategoryID(categories.getCategoryName());
            categories.setCategoryID(categoryID);
            categoryDAO.add(categories);
            model.addAttribute("result_add", "true");
            return "redirect:/categories_tb.htm"; // Redirect to the category list after adding
        } catch (DataIntegrityViolationException e) {
            // Catch exception for duplicate key
            model.addAttribute("error_message", "Category ID already exists. Please enter a different ID.");
            return "admin/categories_add"; // Return to the form view with error message
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error_message", "An error occurred while adding the category.");
            return "admin/categories_add"; // Return to the form view with generic error message
        }
    }

    private String generateCategoryID(String categoryName) {
        if (categoryName == null || categoryName.trim().isEmpty()) {
            return null;
        }

        String[] words = categoryName.split("\\s+");
        if (words.length < 2) {
            return null; // Không đủ từ để tạo ID
        }

        // Tạo prefix từ hai ký tự đầu tiên của các từ
        String prefix = (words[0].substring(0, 1) + words[1].substring(0, 1)).toUpperCase();

        // Lấy số ID tiếp theo cho prefix cụ thể
        int nextId = categoryDAO.getNextCategoryId(prefix) + 1;

        // Tạo categoryID mới
        return prefix + nextId;
    }

    @RequestMapping(value = "/categoryupdateshow.htm", method = RequestMethod.GET)
    @ResponseBody
    public String showUpdateCategoryForm(@RequestParam("id") String id) {
        try {
            Categories category = categoryDAO.get(id);
            if (category != null) {

                return "categoryID=" + category.getCategoryID() + "&categoryName=" + category.getCategoryName() + "&decription=" + category.getDecription();
            } else {

                return "error:Category not found";
            }
        } catch (Exception e) {
            e.printStackTrace();

            return "error:Error fetching category";
        }
    }

    @RequestMapping(value = "/updateCategory.htm", method = RequestMethod.POST)
    public String updateCategory(@ModelAttribute("categoryToUpdate") Categories categories, ModelMap model) {
        categoryDAO.change(categories);
        return "redirect:/categories_tb.htm"; // Redirect to the list page after updating
    }

 @RequestMapping(value = "/categorydelete.htm", method = RequestMethod.GET)
public String deleteCategory(String id, ModelMap model) {
    boolean isCategoryLinked = categoryDAO.isCategoryUsedInProducts(id);
    
    if (isCategoryLinked) {
        model.addAttribute("errorMessage", "Cannot delete this category because it is linked to one or more products.");
    } else {
        categoryDAO.delete(id);
        model.addAttribute("successMessage", "Category deleted successfully.");
    }
    
    return showCategoryView(model);
}



}
