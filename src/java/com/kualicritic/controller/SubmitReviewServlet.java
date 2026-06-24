package com.kualicritic.controller;

import com.kualicritic.dao.ReviewDAO;
import com.kualicritic.model.Review;
import com.kualicritic.model.User;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@WebServlet("/SubmitReviewServlet")
// REQUIRED for handling file uploads! Limits file size to ~5MB
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, maxFileSize = 1024 * 1024 * 5)
public class SubmitReviewServlet extends HttpServlet {

    // Define where to save the uploaded images
    private static final String UPLOAD_DIR = "images/reviews";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("user");

        // Security fallback
        if (loggedInUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 1. Get text data from the form
        int stallId = Integer.parseInt(request.getParameter("stallId"));
        int rating = Integer.parseInt(request.getParameter("rating"));
        String comment = request.getParameter("comment");

        // 2. Handle Image Upload
        Part filePart = request.getPart("reviewImage");
        String fileName = "";
        
        // Check if the user actually uploaded a file
        if (filePart != null && filePart.getSize() > 0) {
            // Bug 4 Fix: Server-side file type validation
            String contentType = filePart.getContentType();
            if (contentType == null || !contentType.startsWith("image/")) {
                response.sendRedirect("writeReview.jsp?stallId=" + stallId + "&stallName=" + request.getParameter("stallName") + "&error=Only image files are allowed.");
                return;
            }

            // Get original file name
            String originalFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            
            // Generate a unique name so files don't overwrite each other (e.g., 16345678_burger.jpg)
            fileName = System.currentTimeMillis() + "_" + originalFileName;
            
            // Find the actual server path to save the image
            String applicationPath = request.getServletContext().getRealPath("");
            String uploadFilePath = applicationPath + File.separator + UPLOAD_DIR;
            
            // Create the directory if it doesn't exist
            File uploadFolder = new File(uploadFilePath);
            if (!uploadFolder.exists()) {
                uploadFolder.mkdirs();
            }
            
            // Save the file to the server folder
            filePart.write(uploadFilePath + File.separator + fileName);
        }

        // 3. Create Review Object
        Review review = new Review();
        review.setUserId(loggedInUser.getId());
        review.setStallId(stallId);
        review.setRating(rating);
        review.setComment(comment);
        review.setImagePath(fileName.isEmpty() ? null : fileName); // Save file name to DB, or null

        // 4. Save to Database
        ReviewDAO reviewDAO = new ReviewDAO();
        reviewDAO.addReview(review);

        // 5. Redirect back to the stall details page to see the new review!
        response.sendRedirect("StallDetailsServlet?id=" + stallId);
    }
}