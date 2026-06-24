<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.kualicritic.model.User" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Manage Users - Admin</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f8fafc;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }
            .main-content {
                margin-left: 260px;
                padding: 40px 50px;
            }

            .modern-table {
                border-collapse: separate;
                border-spacing: 0 15px;
                width: 100%;
            }
            .modern-table thead th {
                border: none;
                color: #64748b;
                text-transform: uppercase;
                font-size: 0.85rem;
                letter-spacing: 1px;
                padding: 0 20px;
            }
            .modern-table tbody tr {
                background-color: #fff;
                box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
                transition: all 0.2s ease;
            }
            .modern-table tbody tr:hover {
                transform: translateY(-4px);
                box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
            }
            .modern-table td {
                padding: 15px 20px;
                border: none;
                vertical-align: middle;
            }
            .modern-table td:first-child {
                border-top-left-radius: 12px;
                border-bottom-left-radius: 12px;
            }
            .modern-table td:last-child {
                border-top-right-radius: 12px;
                border-bottom-right-radius: 12px;
            }

            .btn-action {
                border-radius: 8px;
                font-weight: 600;
                font-size: 0.85rem;
            }
        </style>
    </head>
    <body>
        <%@ include file="components/adminSidebar.jsp" %>

        <div class="main-content">
            <h2 class="fw-bold mb-4" style="color: #1e293b;"><i class="fas fa-users text-info me-2"></i> Registered Users</h2>

            <table class="modern-table">
                <thead>
                    <tr>
                        <th>User ID</th>
                        <th>Student ID</th>
                        <th>Email Address</th>
                        <th>Role</th>
                        <th class="text-end">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% List<User> users = (List<User>) request.getAttribute("users");
                    if (users != null) {
                        for (User u : users) {%>
                    <tr>
                        <td class="text-muted fw-bold">#<%= u.getId()%></td>
                        <td><span class="badge" style="background-color: #e2e8f0; color: #475569; font-size: 0.9rem; padding: 8px 12px;"><i class="fas fa-id-card me-1"></i> <%= u.getStudentId()%></span></td>
                        <td class="fw-bold" style="color: #334155;"><%= u.getEmail()%></td>
                        <td>
                            <% if (u.getRole().equals("ADMIN")) { %> 
                            <span class="badge bg-danger shadow-sm py-2 px-3">ADMIN</span> 
                            <% } else { %> 
                            <span class="badge bg-primary shadow-sm py-2 px-3">STUDENT</span> 
                            <% }%>
                        </td>
                        <td class="text-end">
                            <a href="PrepareEditServlet?type=user&id=<%= u.getId()%>" class="btn btn-sm btn-outline-warning btn-action me-1"><i class="fas fa-edit"></i> Edit</a>
                            <% if (!u.getRole().equals("ADMIN")) {%>
                            <a href="AdminDeleteServlet?type=user&id=<%= u.getId()%>" class="btn btn-sm btn-outline-danger btn-action" onclick="return confirm('Remove user?');"><i class="fas fa-trash"></i> Remove</a>
                            <% } %>
                        </td>
                    </tr>
                    <% }
                    } %>
                </tbody>
            </table>

            <%
                Integer currentPage = (Integer) request.getAttribute("currentPage");
                Integer totalPages = (Integer) request.getAttribute("totalPages");
                if (currentPage != null && totalPages != null && totalPages > 1) {
            %>
            <nav class="d-flex justify-content-center mt-4">
                <ul class="pagination">
                    <li class="page-item <%= currentPage <= 1 ? "disabled" : ""%>">
                        <a class="page-link" href="adminDashboard?tab=users&page=<%= currentPage - 1%>">&laquo; Prev</a>
                    </li>
                    <% for (int p = 1; p <= totalPages; p++) {%>
                    <li class="page-item <%= p == currentPage ? "active" : ""%>">
                        <a class="page-link" href="adminDashboard?tab=users&page=<%= p%>"><%= p%></a>
                    </li>
                    <% }%>
                    <li class="page-item <%= currentPage >= totalPages ? "disabled" : ""%>">
                        <a class="page-link" href="adminDashboard?tab=users&page=<%= currentPage + 1%>">Next &raquo;</a>
                    </li>
                </ul>
            </nav>
            <% }%>
        </div>
    </body>
</html>