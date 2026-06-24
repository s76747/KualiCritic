<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.kualicritic.model.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit User - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <%@ include file="components/navbar.jsp" %>
    <% User u = (User) request.getAttribute("editUser"); %>
    
    <div class="container mt-5" style="max-width: 500px;">
        <div class="card shadow-sm p-4">
            <h3 class="mb-4">Edit User Account</h3>
            <form action="UpdateUserServlet" method="post">
                <input type="hidden" name="id" value="<%= u.getId() %>">
                
                <div class="mb-3">
                    <label class="form-label fw-bold">Student ID</label>
                    <input type="text" name="studentId" class="form-control" value="<%= u.getStudentId() %>" required>
                </div>
                
                <div class="mb-3">
                    <label class="form-label fw-bold">Email</label>
                    <input type="email" name="email" class="form-control" value="<%= u.getEmail() %>" required>
                </div>
                
                <div class="mb-4">
                    <label class="form-label fw-bold">Role</label>
                    <select name="role" class="form-select">
                        <option value="STUDENT" <%= u.getRole().equals("STUDENT") ? "selected" : "" %>>STUDENT</option>
                        <option value="ADMIN" <%= u.getRole().equals("ADMIN") ? "selected" : "" %>>ADMIN</option>
                    </select>
                </div>
                
                <button type="submit" class="btn btn-warning w-100 fw-bold">Update User</button>
                <a href="adminDashboard" class="btn btn-link w-100 text-decoration-none mt-2">Cancel</a>
            </form>
        </div>
    </div>
</body>
</html>