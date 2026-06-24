package com.kualicritic.controller;

import com.kualicritic.dao.ReviewDAO;
import com.kualicritic.model.Review;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/UpdateMyReviewServlet")
@MultipartConfig(maxFileSize = 1024 * 1024 * 5)
public class UpdateMyReviewServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Review review = new Review();
        review.setId(Integer.parseInt(request.getParameter("id")));
        review.setRating(Integer.parseInt(request.getParameter("rating")));
        review.setComment(request.getParameter("comment"));

        Part filePart = request.getPart("reviewImage");
        if (filePart != null && filePart.getSize() > 0) {
            // Bug 4 Fix: Server-side file type validation
            String contentType = filePart.getContentType();
            if (contentType == null || !contentType.startsWith("image/")) {
                response.sendRedirect("PrepareEditMyReviewServlet?id=" + review.getId() + "&error=Only image files are allowed.");
                return;
            }
            String fileName = System.currentTimeMillis() + "_" + Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String uploadPath = request.getServletContext().getRealPath("") + File.separator + "images/reviews";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();
            filePart.write(uploadPath + File.separator + fileName);
            review.setImagePath(fileName);
        } else {
            review.setImagePath(null);
        }

        new ReviewDAO().updateReview(review);
        response.sendRedirect("myReviews.jsp");
    }
}