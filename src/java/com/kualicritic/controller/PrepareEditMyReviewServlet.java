package com.kualicritic.controller;

import com.kualicritic.dao.ReviewDAO;
import com.kualicritic.model.Review;
import com.kualicritic.model.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/PrepareEditMyReviewServlet")
public class PrepareEditMyReviewServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) { response.sendRedirect("login.jsp"); return; }

        int reviewId = Integer.parseInt(request.getParameter("id"));
        Review review = new ReviewDAO().getReviewById(reviewId);

        // SECURITY CHECK: Ensure this review actually belongs to the logged-in student!
        if (review != null && review.getReviewerId().equals(String.valueOf(user.getId()))) {
            request.setAttribute("review", review);
            request.getRequestDispatcher("editMyReview.jsp").forward(request, response);
        } else {
            response.sendRedirect("myReviews.jsp"); 
        }
    }
}