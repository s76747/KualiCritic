package com.kualicritic.model;

public class User {
    private int id;
    private String studentId;
    private String email;
    private String role;

    // Empty Constructor
    public User() {}

    // Parameterized Constructor
    public User(int id, String studentId, String email, String role) {
        this.id = id;
        this.studentId = studentId;
        this.email = email;
        this.role = role;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getStudentId() { return studentId; }
    public void setStudentId(String studentId) { this.studentId = studentId; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
}