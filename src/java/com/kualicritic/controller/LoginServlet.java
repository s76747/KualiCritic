package com.kualicritic.controller;

import com.kualicritic.dao.UserDAO;
import com.kualicritic.model.User;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String studentId = request.getParameter("studentId");
        String password = request.getParameter("password");
        
        UserDAO userDAO = new UserDAO();
        User loggedInUser = userDAO.validateLogin(studentId, password);
        
        if (loggedInUser != null) {
            // Create a session to keep the user logged in
            HttpSession session = request.getSession();
            session.setAttribute("user", loggedInUser);
            session.setAttribute("userRole", loggedInUser.getRole());
            
            // Redirect based on role
            if (loggedInUser.getRole().equals("ADMIN")) {
                response.sendRedirect("adminDashboard");
            } else {
                response.sendRedirect("index.jsp");
            }
        } else {
            // Login failed
            request.setAttribute("error", "Invalid Student ID or Password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}