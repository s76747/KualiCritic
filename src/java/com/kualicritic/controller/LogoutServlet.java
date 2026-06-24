package com.kualicritic.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {

    // We use doGet because clicking a standard <a> link in HTML is always a GET request
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Fetch the current session (pass 'false' so it doesn't create a new one if it's missing)
        HttpSession session = request.getSession(false);
        
        // 2. If a session exists, destroy it! This clears the "user" and "userRole" attributes.
        if (session != null) {
            session.invalidate();
        }
        
        // 3. Redirect the user back to the login page with a friendly success message
        response.sendRedirect("login.jsp?success=You have been successfully logged out.");
    }
}