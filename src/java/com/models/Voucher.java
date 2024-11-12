package com.models;

import java.math.BigDecimal;
import java.util.Date;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.format.annotation.DateTimeFormat;

public class Voucher {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int voucherID;

    @NotEmpty(message = "Voucher Code is not empty")
    private String voucherCode;

    @NotNull(message = "Discount Amount is not null")
    private BigDecimal discountAmount;

    @NotNull(message = "Start Date is not null")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date startDate;

   

    @NotNull(message = "End Date is not null")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date endDate;

    @NotEmpty(message = "Event Name is not empty")
    private String eventName;

    @NotEmpty(message = "Image is not empty")
    private String imagesUrl;
     private int userID;

    public Voucher() {
        this.voucherID = 0;
        this.voucherCode = null;
        this.discountAmount = null;
        this.startDate = null;
        this.endDate = null;
        this.eventName = null;
        this.imagesUrl = null;
        this.userID = 0;
    }

    public Voucher(int userID, String voucherCode, BigDecimal discountAmount, Date startDate, Date endDate, String eventName, String imagesUrl) {
        this.voucherCode = voucherCode;
        this.discountAmount = discountAmount;
        this.startDate = startDate;
        this.endDate = endDate;
        this.eventName = eventName;
        this.imagesUrl = imagesUrl;
        this.userID = userID;
    }

    public int getVoucherID() {
        return voucherID;
    }

    public void setVoucherID(int voucherID) {
        this.voucherID = voucherID;
    }

    public String getVoucherCode() {
        return voucherCode;
    }

    public void setVoucherCode(String voucherCode) {
        this.voucherCode = voucherCode;
    }

    public BigDecimal getDiscountAmount() {
        return discountAmount;
    }

    public void setDiscountAmount(BigDecimal discountAmount) {
        this.discountAmount = discountAmount;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public String getEventName() {
        return eventName;
    }

    public void setEventName(String eventName) {
        this.eventName = eventName;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getImagesUrl() {
        return imagesUrl;
    }

    public void setImagesUrl(String imagesUrl) {
        this.imagesUrl = imagesUrl;
    }

    public boolean isValid() {
        // Implement your validation logic here
        return voucherCode != null && discountAmount != null && startDate != null && endDate != null && eventName != null && imagesUrl != null;
    }

    @Override
    public String toString() {
        return "Voucher{" +
                "voucherID=" + voucherID +
                ", voucherCode='" + voucherCode + '\'' +
                ", discountAmount=" + discountAmount +
                ", startDate=" + startDate +
                ", endDate=" + endDate +
                ", eventName='" + eventName + '\'' +
                ", userID=" + userID +
                ", imagesUrl='" + imagesUrl + '\'' +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Voucher)) return false;
        Voucher voucher = (Voucher) o;
        return voucherID == voucher.voucherID;
    }

    @Override
    public int hashCode() {
        return Integer.hashCode(voucherID);
    }
}
