<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Add New Stall - KualiCritic Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .form-container { max-width: 500px; margin: 40px auto; padding: 20px; border: 1px solid #ddd; border-radius: 8px; font-family: Arial, sans-serif; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; font-weight: bold; margin-bottom: 5px; }
        .form-group input, .form-group textarea { width: 100%; padding: 8px; box-sizing: border-box; }
        .btn-submit { background-color: #27ae60; color: white; padding: 10px 15px; border: none; border-radius: 5px; cursor: pointer; width: 100%; font-size: 16px; }
        .btn-submit:hover { background-color: #2ecc71; }
        .back-link { display: block; margin-top: 15px; text-align: center; text-decoration: none; color: #2c3e50; }
    </style>
</head>
<body>
    <%@ include file="components/navbar.jsp" %>
    
    <% 
        // Security check: Only Admins can view this page
        if (session.getAttribute("userRole") == null || !session.getAttribute("userRole").equals("ADMIN")) {
            response.sendRedirect("index.jsp");
            return;
        }
    %>

    <div class="form-container">
        <h2>Add a New Food Stall</h2>
        
        <form action="AddStallServlet" method="post" enctype="multipart/form-data">
            
            <div class="form-group">
                <label>Stall Name:</label>
                <input type="text" name="stallName" required placeholder="e.g., Kafe Komputer UMT">
            </div>
            
            <div class="form-group">
                <label>Description:</label>
                <textarea name="description" rows="4" required placeholder="What kind of food do they sell?"></textarea>
            </div>
            
            <div class="form-group">
                <label>Upload Stall Cover Picture:</label>
                <input type="file" name="stallImage" accept="image/png, image/jpeg, image/jpg" required>
            </div>
            
            <button type="submit" class="btn-submit">Save Stall</button>
        </form>
        
        <a href="adminDashboard" class="back-link">&larr; Back to Dashboard</a>
    </div>
</body>
</html>