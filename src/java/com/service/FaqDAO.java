/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.service;

import com.models.Faq;
import java.util.List;

/**
 *
 * @author Hp
 */
public interface FaqDAO {
    
    public List<Faq> findAll();

    public void add(Faq faq);

    public void change(Faq faq);

    public Faq get(int id);

    public void delete(int id);

    
    public List<Faq> find(String keyword);
    
   
    void update(Faq faq);
    void updateReply(Long faqID, String reply);

    public void updateReply(int faqID, String reply);

    public Faq findById(int faqID);
 List<Faq> findFaqs(int offset, int limit);
    int countFaqs();
   
   
}
