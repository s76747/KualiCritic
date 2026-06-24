package com.kualicritic.controller;

import com.kualicritic.dao.UserDAO;
import com.kualicritic.model.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UpdateUserServlet")
public class UpdateUserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = new User();
        user.setId(Integer.parseInt(request.getParameter("id")));
        user.setStudentId(request.getParameter("studentId"));
        user.setEmail(request.getParameter("email"));
        user.setRole(request.getParameter("role"));
        
        new UserDAO().updateUser(user);
        response.sendRedirect("adminDashboard");
    }
}