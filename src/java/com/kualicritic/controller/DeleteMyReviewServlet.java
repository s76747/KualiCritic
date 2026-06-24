package com.kualicritic.controller;

import com.kualicritic.dao.ReviewDAO;
import com.kualicritic.model.Review;
import com.kualicritic.model.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/DeleteMyReviewServlet")
public class DeleteMyReviewServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user != null) {
            int reviewId = Integer.parseInt(request.getParameter("id"));
            Review review = new ReviewDAO().getReviewById(reviewId);
            
            // CORRECTED SECURITY CHECK
            if (review != null && review.getReviewerId().equals(String.valueOf(user.getId()))) {
                new ReviewDAO().deleteReview(reviewId);
            }
        }
        response.sendRedirect("myReviews.jsp");
    }
}