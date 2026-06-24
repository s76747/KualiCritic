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
import javax.servlet.http.Part;

@WebServlet("/UpdateStallServlet")
@MultipartConfig(maxFileSize = 1024 * 1024 * 5)
public class UpdateStallServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Stall stall = new Stall();
        stall.setId(Integer.parseInt(request.getParameter("id")));
        stall.setName(request.getParameter("name"));
        stall.setDescription(request.getParameter("description"));
        
        // Handle optional file upload
        Part filePart = request.getPart("stallImage");
        if (filePart != null && filePart.getSize() > 0) {
            // Bug 4 Fix: Server-side file type validation
            String contentType = filePart.getContentType();
            if (contentType == null || !contentType.startsWith("image/")) {
                response.sendRedirect("PrepareEditServlet?type=stall&id=" + stall.getId() + "&error=Only image files are allowed.");
                return;
            }
            String fileName = System.currentTimeMillis() + "_" + Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String uploadPath = request.getServletContext().getRealPath("") + File.separator + "images/stalls";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();
            filePart.write(uploadPath + File.separator + fileName);
            stall.setImagePath(fileName);
        } else {
            stall.setImagePath(null); // Triggers DAO to ignore image update
        }
        
        new StallDAO().updateStall(stall);
        response.sendRedirect("adminDashboard");
    }
}