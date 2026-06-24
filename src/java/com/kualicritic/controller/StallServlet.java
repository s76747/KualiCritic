package com.kualicritic.controller;

import com.kualicritic.dao.StallDAO;
import com.kualicritic.model.Stall;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// This maps the URL so when you go to /stalls, this code runs
@WebServlet("/stalls")
public class StallServlet extends HttpServlet {

    private static final int PAGE_SIZE = 12;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        StallDAO stallDAO = new StallDAO();

        // Parse the 'page' parameter (defaults to page 1 if missing/invalid)
        int page = 1;
        try {
            page = Integer.parseInt(request.getParameter("page"));
            if (page < 1) {
                page = 1;
            }
        } catch (NumberFormatException e) {
            page = 1;
        }

        int totalStalls = stallDAO.countStalls();
        int totalPages = Math.max(1, (int) Math.ceil(totalStalls / (double) PAGE_SIZE));
        if (page > totalPages) {
            page = totalPages;
        }
        int offset = (page - 1) * PAGE_SIZE;

        List<Stall> stallList = stallDAO.getStalls(offset, PAGE_SIZE);

        // Attach the list and pagination info to the request so the JSP can read it
        request.setAttribute("stalls", stallList);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        // Forward the user to the view
        request.getRequestDispatcher("stalls.jsp").forward(request, response);
    }
}
