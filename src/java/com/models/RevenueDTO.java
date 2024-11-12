/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.models;

/**
 *
 * @author BAOTHI
 */
public class RevenueDTO {

    private int quarter;
    private int month;
    private double totalRevenue;

    public int getMonth() {
        return month;
    }

    public void setMonth(int month) {
        this.month = month;
    }

    public double getTotalRevenue() {
        return totalRevenue;
    }

    public void setTotalRevenue(double totalRevenue) {
        this.totalRevenue = totalRevenue;
    }

    @Override
    public String toString() {
        if (quarter != 0) {
            return "Quarter: " + quarter + ", Total Revenue: " + totalRevenue;
        } else {
            return "Month: " + month + ", Total Revenue: " + totalRevenue;
        }
    }

    public int getQuarter() {
        return quarter;
    }

    public void setQuarter(int quarter) {
        this.quarter = quarter;
    }

}
