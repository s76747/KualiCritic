package com.kualicritic.model;

public class Menu {
    private int id;
    private int stallId;
    private String stallName;
    private String itemName;
    private double price;
    private String imagePath;

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getStallId() { return stallId; }
    public void setStallId(int stallId) { this.stallId = stallId; }
    
    public String getStallName() {
    return stallName;
}

public void setStallName(String stallName) {
    this.stallName = stallName;
}

    public String getItemName() { return itemName; }
    public void setItemName(String itemName) { this.itemName = itemName; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public String getImagePath() { return imagePath; }
    public void setImagePath(String imagePath) { this.imagePath = imagePath; }
}