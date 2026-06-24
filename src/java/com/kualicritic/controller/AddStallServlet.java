package com.kualicritic.controller;

import com.kualicritic.dao.StallDAO;
import com.kualicritic.model.Stall;

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

@WebServlet("/AddStallServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, maxFileSize = 1024 * 1024 * 5)
public class AddStallServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "images/stalls";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Security Check
        HttpSession session = request.getSession();
        if (session.getAttribute("userRole") == null || !session.getAttribute("userRole").equals("ADMIN")) {
            response.sendRedirect("index.jsp");
            return;
        }

        // 2. Get text parameters
        String name = request.getParameter("stallName");
        String description = request.getParameter("description");

        // 3. Handle File Upload
        Part filePart = request.getPart("stallImage");
        String fileName = "";
        
        if (filePart != null && filePart.getSize() > 0) {
            // Bug 4 Fix: Server-side file type validation
            String contentType = filePart.getContentType();
            if (contentType == null || !contentType.startsWith("image/")) {
                response.sendRedirect("addStall.jsp?error=Only image files are allowed.");
                return;
            }

            String originalFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            fileName = System.currentTimeMillis() + "_" + originalFileName; // Make name unique
            
            String applicationPath = request.getServletContext().getRealPath("");
            String uploadFilePath = applicationPath + File.separator + UPLOAD_DIR;
            
            File uploadFolder = new File(uploadFilePath);
            if (!uploadFolder.exists()) {
                uploadFolder.mkdirs();
            }
            
            filePart.write(uploadFilePath + File.separator + fileName);
        }

        // 4. Save to Database via DAO
        Stall stall = new Stall();
        stall.setName(name);
        stall.setDescription(description);
        stall.setImagePath(fileName);
        
        StallDAO stallDAO = new StallDAO();
        stallDAO.insertStall(stall);

        // 5. Redirect back to the admin dashboard to see the new stall!
        response.sendRedirect("adminDashboard");
    }
}