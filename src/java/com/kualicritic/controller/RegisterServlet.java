package com.kualicritic.controller;

import com.kualicritic.dao.UserDAO;
import java.io.IOException;
import java.util.regex.Pattern;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Get data from the form
        String studentId = request.getParameter("studentId").toUpperCase(); // Force uppercase 'S'
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String pin = request.getParameter("recoveryPin");

        // 2. Validations
        // Validate Student ID (Must be 'S' followed by exactly 5 digits)
        if (!Pattern.matches("^S\\d{5}$", studentId)) {
            request.setAttribute("error", "Student ID must be 'S' followed by 5 digits (e.g., S12345).");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Validate Email format
        if (!Pattern.matches("^[A-Za-z0-9+_.-]+@(.+)$", email)) {
            request.setAttribute("error", "Invalid email format.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Validate Password length
        if (password.length() < 6) {
            request.setAttribute("error", "Password must be at least 6 characters long.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Check if passwords match
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Validate PIN (Must be exactly 4 digits)
        if (!Pattern.matches("^\\d{4}$", pin)) {
            request.setAttribute("error", "Recovery PIN must be exactly 4 digits.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // 3. Check the database for existing Student ID / Email before inserting
        UserDAO userDAO = new UserDAO();
        boolean studentIdTaken = userDAO.isStudentIdTaken(studentId);
        boolean emailTaken = userDAO.isEmailTaken(email);

        if (studentIdTaken || emailTaken) {
            // Keep what the user typed so the form isn't cleared
            request.setAttribute("studentId", studentId);

            if (studentIdTaken) {
                request.setAttribute("studentIdError", "This Student ID is already registered.");
            }
            if (emailTaken) {
                request.setAttribute("emailError", "This Email is already registered.");
            }
            request.setAttribute("error", "Registration failed. Student ID or Email already exists.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // 4. Save to Database
        boolean isRegistered = userDAO.registerUser(studentId, email, password, pin);

        if (isRegistered) {
            // Success! Send them to login page
            response.sendRedirect("login.jsp?success=Account created successfully! Please login.");
        } else {
            // Fail! Fallback in case of a race condition or other DB error
            request.setAttribute("studentId", studentId);
            request.setAttribute("error", "Registration failed. Student ID or Email may already exist.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}
