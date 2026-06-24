package com.kualicritic.controller;

import com.kualicritic.dao.MenuDAO;
import com.kualicritic.dao.UserDAO;
import com.kualicritic.dao.StallDAO;
import com.kualicritic.dao.ReviewDAO;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/AdminDeleteServlet")
public class AdminDeleteServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        if (session.getAttribute("userRole") == null || !session.getAttribute("userRole").equals("ADMIN")) {
            response.sendRedirect("index.jsp");
            return;
        }

        String type = request.getParameter("type");
        int id = Integer.parseInt(request.getParameter("id"));

        // Route the deletion based on the 'type'
        if ("user".equals(type)) {
            new UserDAO().deleteUser(id);
        } else if ("stall".equals(type)) {
            new StallDAO().deleteStall(id);
        } else if ("review".equals(type)) {
            new ReviewDAO().deleteReview(id);
        } else if ("menu".equals(type)) {
            new MenuDAO().deleteMenu(id); // ADD THIS LINE
        }

        // Refresh the dashboard
        response.sendRedirect("adminDashboard");
    }
}