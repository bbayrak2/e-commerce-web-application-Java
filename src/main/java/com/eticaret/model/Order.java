package com.eticaret.model;

import java.sql.Timestamp;

public class Order {
    private int id;
    private int userId;
    private String address;
    private double totalPrice;
    private String status;
    private Timestamp orderDate; 
    public Order() {}

 
    public Order(int id, int userId, String address, double totalPrice, String status, Timestamp orderDate) {
        this.id = id;
        this.userId = userId;
        this.address = address;
        this.totalPrice = totalPrice;
        this.status = status;
        this.orderDate = orderDate;
    }

   
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public double getTotalPrice() { return totalPrice; }
    public void setTotalPrice(double totalPrice) { this.totalPrice = totalPrice; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Timestamp getOrderDate() { return orderDate; }
    public void setOrderDate(Timestamp orderDate) { this.orderDate = orderDate; }
}