package com.kualicritic.controller;

import com.kualicritic.dao.*;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/adminDashboard")
public class AdminDashboardServlet extends HttpServlet {

    private static final int PAGE_SIZE = 10;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("userRole") == null || !session.getAttribute("userRole").equals("ADMIN")) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Grab the 'tab' from the URL. If it's empty, default to stalls.
        String tab = request.getParameter("tab");
        if (tab == null || tab.isEmpty()) {
            tab = "stalls";
        }

        // Pass the current tab to the JSP so the sidebar knows which link to highlight
        request.setAttribute("currentTab", tab);

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
        int offset = (page - 1) * PAGE_SIZE;

        // Load only the data needed for the active tab to save database memory!
        if ("stalls".equals(tab)) {
            StallDAO stallDAO = new StallDAO();
            int totalStalls = stallDAO.countStalls();
            int totalPages = Math.max(1, (int) Math.ceil(totalStalls / (double) PAGE_SIZE));
            if (page > totalPages) {
                page = totalPages;
                offset = (page - 1) * PAGE_SIZE;
            }

            request.setAttribute("stalls", stallDAO.getStalls(offset, PAGE_SIZE));
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.getRequestDispatcher("adminStalls.jsp").forward(request, response);

        } else if ("menus".equals(tab)) {
            MenuDAO menuDAO = new MenuDAO();
            int totalMenus = menuDAO.countMenus();
            int totalPages = Math.max(1, (int) Math.ceil(totalMenus / (double) PAGE_SIZE));
            if (page > totalPages) {
                page = totalPages;
                offset = (page - 1) * PAGE_SIZE;
            }

            request.setAttribute("menus", menuDAO.getMenus(offset, PAGE_SIZE));
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.getRequestDispatcher("adminMenus.jsp").forward(request, response);

        } else if ("users".equals(tab)) {
            UserDAO userDAO = new UserDAO();
            int totalUsers = userDAO.countUsers();
            int totalPages = Math.max(1, (int) Math.ceil(totalUsers / (double) PAGE_SIZE));
            if (page > totalPages) {
                page = totalPages;
                offset = (page - 1) * PAGE_SIZE;
            }

            request.setAttribute("users", userDAO.getUsers(offset, PAGE_SIZE));
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.getRequestDispatcher("adminUsers.jsp").forward(request, response);

        } else if ("reviews".equals(tab)) {
            ReviewDAO reviewDAO = new ReviewDAO();
            int totalReviews = reviewDAO.countReviews();
            int totalPages = Math.max(1, (int) Math.ceil(totalReviews / (double) PAGE_SIZE));
            if (page > totalPages) {
                page = totalPages;
                offset = (page - 1) * PAGE_SIZE;
            }

            request.setAttribute("reviews", reviewDAO.getReviews(offset, PAGE_SIZE));
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.getRequestDispatcher("adminReviews.jsp").forward(request, response);
        }
    }
}
