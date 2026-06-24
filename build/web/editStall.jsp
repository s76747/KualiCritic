<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.kualicritic.model.Stall" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Stall - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <%@ include file="components/navbar.jsp" %>
    <% Stall s = (Stall) request.getAttribute("stall"); %>
    
    <div class="container mt-5" style="max-width: 600px;">
        <div class="card shadow-sm p-4">
            <h3 class="mb-4">Edit Food Stall</h3>
            <form action="UpdateStallServlet" method="post" enctype="multipart/form-data">
                <input type="hidden" name="id" value="<%= s.getId() %>">
                
                <div class="mb-3">
                    <label class="form-label fw-bold">Stall Name</label>
                    <input type="text" name="name" class="form-control" value="<%= s.getName() %>" required>
                </div>
                
                <div class="mb-3">
                    <label class="form-label fw-bold">Description</label>
                    <textarea name="description" class="form-control" rows="4" required><%= s.getDescription() %></textarea>
                </div>
                
                <div class="mb-4">
                    <label class="form-label fw-bold">Update Cover Picture (Leave blank to keep current image)</label>
                    <input type="file" name="stallImage" class="form-control" accept="image/*">
                </div>
                
                <button type="submit" class="btn btn-warning w-100 fw-bold">Save Changes</button>
                <a href="adminDashboard" class="btn btn-link w-100 text-decoration-none mt-2">Cancel</a>
            </form>
        </div>
    </div>
</body>
</html>