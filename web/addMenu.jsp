<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.kualicritic.dao.StallDAO, com.kualicritic.model.Stall" %>
<!DOCTYPE html>
<html>
<head><title>Add Menu - KualiCritic</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <%@ include file="components/navbar.jsp" %>
    <% 
        if (session.getAttribute("userRole") == null || !session.getAttribute("userRole").equals("ADMIN")) {
            response.sendRedirect("index.jsp"); return;
        }
    %>
    <div style="max-width: 500px; margin: 40px auto; padding: 20px; border: 1px solid #ddd;">
        <h2>Add a Menu Item</h2>
        <form action="AddMenuServlet" method="post" enctype="multipart/form-data">
            <label>Select Stall:</label><br>
            <select name="stallId" required style="width:100%; padding:8px; margin-bottom:15px;">
                <% 
                    List<Stall> stalls = new StallDAO().getAllStalls();
                    for(Stall s : stalls) { 
                %>
                    <option value="<%= s.getId() %>"><%= s.getName() %></option>
                <% } %>
            </select><br>

            <label>Item Name:</label><br>
            <input type="text" name="itemName" required style="width:100%; padding:8px; margin-bottom:15px;"><br>

            <label>Price (RM):</label><br>
            <input type="number" step="0.01" name="price" required style="width:100%; padding:8px; margin-bottom:15px;"><br>

            <label>Food Image:</label><br>
            <input type="file" name="menuImage" accept="image/*" required style="margin-bottom:15px;"><br>

            <button type="submit" style="background:#27ae60; color:white; padding:10px; width:100%; border:none;">Save Menu</button>
        </form>
    </div>
</body>
</html>