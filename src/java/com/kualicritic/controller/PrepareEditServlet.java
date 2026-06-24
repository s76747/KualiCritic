package com.kualicritic.controller;

import com.kualicritic.dao.MenuDAO;
import com.kualicritic.dao.StallDAO;
import com.kualicritic.dao.UserDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/PrepareEditServlet")
public class PrepareEditServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        if (session.getAttribute("userRole") == null || !session.getAttribute("userRole").equals("ADMIN")) {
            response.sendRedirect("login.jsp"); return;
        }

        String type = request.getParameter("type");
        int id = Integer.parseInt(request.getParameter("id"));

        if ("stall".equals(type)) {
            request.setAttribute("stall", new StallDAO().getStallById(id));
            request.getRequestDispatcher("editStall.jsp").forward(request, response);
        } else if ("user".equals(type)) {
            request.setAttribute("editUser", new UserDAO().getUserById(id));
            request.getRequestDispatcher("editUser.jsp").forward(request, response);
        } else if ("menu".equals(type)) { // ADD THIS BLOCK
            request.setAttribute("menu", new MenuDAO().getMenuById(id));
            // Also grab stalls so the Admin can re-assign the menu to a different stall if needed
            request.setAttribute("stalls", new StallDAO().getAllStalls()); 
            request.getRequestDispatcher("editMenu.jsp").forward(request, response);
        }
    }
}