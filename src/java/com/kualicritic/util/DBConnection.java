package com.kualicritic.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    // Change these to match your local MySQL setup
    private static final String URL = "jdbc:mysql://localhost:3306/kualicritic_db";
    private static final String USER = "root"; 
    private static final String PASSWORD = "admin"; 

    public static Connection getConnection() {
        Connection connection = null;
        try {
            // Load the MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return connection;
    }
}