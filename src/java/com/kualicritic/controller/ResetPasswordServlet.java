package com.kualicritic.controller;

import com.kualicritic.util.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ResetPasswordServlet")
public class ResetPasswordServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String studentId = request.getParameter("studentId");
        String pin = request.getParameter("pin");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match.");
            request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            String fetchSql = "SELECT password FROM users WHERE student_id = ? AND recovery_pin = ?";
            String currentPassword = null;
            try (PreparedStatement fetchStmt = conn.prepareStatement(fetchSql)) {
                fetchStmt.setString(1, studentId);
                fetchStmt.setString(2, pin);
                ResultSet rs = fetchStmt.executeQuery();
                if (rs.next()) {
                    currentPassword = rs.getString("password");
                }
            }

            if (currentPassword == null) {
                request.setAttribute("error", "Invalid Student ID or Recovery PIN.");
                request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
                return;
            }

            if (currentPassword.equals(newPassword)) {
                request.setAttribute("error", "New password must be different from your current password.");
                request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
                return;
            }

            String updateSql = "UPDATE users SET password = ? WHERE student_id = ? AND recovery_pin = ?";
            try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                updateStmt.setString(1, newPassword);
                updateStmt.setString(2, studentId);
                updateStmt.setString(3, pin);
                updateStmt.executeUpdate();
            }

            response.sendRedirect("login.jsp?success=Password reset successfully. Please login.");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
