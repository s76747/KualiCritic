package com.kualicritic.controller;

import com.kualicritic.dao.MenuDAO;
import com.kualicritic.model.Menu;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/UpdateMenuServlet")
@MultipartConfig(maxFileSize = 1024 * 1024 * 5)
public class UpdateMenuServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Menu menu = new Menu();
        menu.setId(Integer.parseInt(request.getParameter("id")));
        menu.setStallId(Integer.parseInt(request.getParameter("stallId")));
        menu.setItemName(request.getParameter("itemName"));
        menu.setPrice(Double.parseDouble(request.getParameter("price")));

        Part filePart = request.getPart("menuImage");
        if (filePart != null && filePart.getSize() > 0) {
            // Bug 4 Fix: Server-side file type validation
            String contentType = filePart.getContentType();
            if (contentType == null || !contentType.startsWith("image/")) {
                response.sendRedirect("PrepareEditServlet?type=menu&id=" + menu.getId() + "&error=Only image files are allowed.");
                return;
            }
            String fileName = System.currentTimeMillis() + "_" + Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String uploadPath = request.getServletContext().getRealPath("") + File.separator + "images/menus";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();
            filePart.write(uploadPath + File.separator + fileName);
            menu.setImagePath(fileName);
        } else {
            menu.setImagePath(null); // Triggers DAO to ignore image update
        }

        new MenuDAO().updateMenu(menu);
        response.sendRedirect("adminDashboard?tab=menus"); // Redirects right back to the menus tab!
    }
}