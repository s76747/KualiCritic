package com.kualicritic.controller;

import com.kualicritic.dao.MenuDAO;
import com.kualicritic.model.Menu;
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

@WebServlet("/AddMenuServlet")
@MultipartConfig(maxFileSize = 1024 * 1024 * 5)
public class AddMenuServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int stallId = Integer.parseInt(request.getParameter("stallId"));
        String itemName = request.getParameter("itemName");
        double price = Double.parseDouble(request.getParameter("price"));
        
        Part filePart = request.getPart("menuImage");
        String fileName = "";

        if (filePart != null && filePart.getSize() > 0) {
            // Bug 4 Fix: Server-side file type validation
            String contentType = filePart.getContentType();
            if (contentType == null || !contentType.startsWith("image/")) {
                response.sendRedirect("addMenu.jsp?error=Only image files are allowed.");
                return;
            }

            String originalFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            fileName = System.currentTimeMillis() + "_" + originalFileName;

            String uploadPath = request.getServletContext().getRealPath("") + File.separator + "images/menus";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();
            filePart.write(uploadPath + File.separator + fileName);
        }
        
        Menu menu = new Menu();
        menu.setStallId(stallId);
        menu.setItemName(itemName);
        menu.setPrice(price);
        menu.setImagePath(fileName);
        
        new MenuDAO().insertMenu(menu);
        response.sendRedirect("adminDashboard");
    }
}