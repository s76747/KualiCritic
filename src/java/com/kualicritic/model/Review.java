package com.kualicritic.model;

public class Review {
    private int id;
    private int userId;
    private int stallId;
    private int rating;
    private String comment;
    private String imagePath;
    private String reviewerId; // We will store the student_id here to display it on the page

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getStallId() { return stallId; }
    public void setStallId(int stallId) { this.stallId = stallId; }

    public int getRating() { return rating; }
    public void setRating(int rating) { this.rating = rating; }

    public String getComment() { return comment; }
    public void setComment(String comment) { this.comment = comment; }

    public String getImagePath() { return imagePath; }
    public void setImagePath(String imagePath) { this.imagePath = imagePath; }

    public String getReviewerId() { return reviewerId; }
    public void setReviewerId(String reviewerId) { this.reviewerId = reviewerId; }
}