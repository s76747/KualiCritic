package com.kualicritic.controller;

import com.kualicritic.dao.StallDAO;
import com.kualicritic.dao.MenuDAO;
import com.kualicritic.dao.ReviewDAO;
import com.kualicritic.model.Stall;
import com.kualicritic.model.Menu;
import com.kualicritic.model.Review;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/StallDetailsServlet")
public class StallDetailsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int stallId = Integer.parseInt(request.getParameter("id"));
        
        StallDAO stallDAO = new StallDAO();
        MenuDAO menuDAO = new MenuDAO();
        ReviewDAO reviewDAO = new ReviewDAO();
        
        Stall stall = stallDAO.getStallById(stallId);
        List<Menu> menus = menuDAO.getMenusByStall(stallId);
        List<Review> reviews = reviewDAO.getReviewsByStallId(stallId);
        
        request.setAttribute("stall", stall);
        request.setAttribute("menus", menus);
        request.setAttribute("reviews", reviews);
        
        request.getRequestDispatcher("stallDetails.jsp").forward(request, response);
    }
}