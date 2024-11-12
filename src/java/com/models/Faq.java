/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.models;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;

/**
 *
 * @author Hp
 */
public class Faq {
    
    private int faqID;
    
    
    @NotEmpty(message="Email User is not empty")
    private String emailUser;
    @NotNull
 
    @NotEmpty(message="Content is not empty")
    private String content;
    @NotEmpty(message="Reply is not empty")
    private String reply;
    @NotEmpty(message="Status is not empty")
    private String status;

    
    public Faq(){
        this.faqID = 0;
       
        this.content = null;
        this.emailUser = null;
        this.reply = null;
        this.status = null;
    }
    public Faq(int faqID, String emailUser, String content, String reply, String status ){
        this.faqID = faqID;
        this.content= content;
        this.emailUser = emailUser;
        this.reply = reply;
        this.status = status ;
    }
    
    
    public int getFaqID() {
        return faqID;
    }

    public void setFaqID(int faqID) {
        this.faqID = faqID;
    }

    public String getEmailUser() {
        return emailUser;
    }

    public void setEmailUser(String emailUser) {
        this.emailUser = emailUser;
    }

  

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getReply() {
        return reply;
    }

    public void setReply(String reply) {
        this.reply = reply;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
            
}
