<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.kualicritic.model.Menu" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Manage Menus - Admin</title>
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

            /* Modern Floating Table UI */
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
                transform: translateY(-4px); /* Floats up on hover! */
                box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
            }
            .modern-table td {
                padding: 15px 20px;
                border: none;
                vertical-align: middle;
            }
            /* Round the corners of the table rows */
            .modern-table td:first-child {
                border-top-left-radius: 12px;
                border-bottom-left-radius: 12px;
            }
            .modern-table td:last-child {
                border-top-right-radius: 12px;
                border-bottom-right-radius: 12px;
            }

            .food-thumbnail {
                width: 65px;
                height: 65px;
                object-fit: cover;
                border-radius: 12px;
                border: 2px solid #f1f5f9;
            }
            .btn-add {
                background: linear-gradient(135deg, #10b981 0%, #059669 100%);
                color: white;
                border: none;
                border-radius: 8px;
                font-weight: 600;
                padding: 10px 20px;
            }
            .btn-add:hover {
                background: #059669;
                color: white;
                transform: scale(1.05);
                transition: 0.2s;
            }

            /* Softer buttons for actions */
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
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="fw-bold" style="color: #1e293b;"><i class="fas fa-hamburger text-warning me-2"></i> Manage Menus</h2>
                <a href="addMenu.jsp" class="btn btn-add shadow-sm"><i class="fas fa-plus me-1"></i> Add New Menu</a>
            </div>

            <table class="modern-table">
                <thead>
                    <tr>
                        <th>Item ID</th>
                        <th>Image</th>
                        <th>Stall</th>
                        <th>Item Name</th>
                        <th>Price</th>
                        <th class="text-end">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% List<Menu> menus = (List<Menu>) request.getAttribute("menus");
                    if (menus != null) {
                        for (Menu m : menus) {%>
                    <tr>
                        <td class="text-muted fw-bold">#<%= m.getId()%></td>
                        <td>
                            <img src="images/menus/<%= m.getImagePath()%>" class="food-thumbnail shadow-sm" onerror="this.src='https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=100&q=80'">
                        </td>
                        <td>
                            <span class="badge" style="background-color: #e2e8f0; color: #475569;">
                                <%= m.getStallName()%>
                            </span>
                        </td>
                        <td class="fw-bold fs-5" style="color: #334155;"><%= m.getItemName()%></td>
                        <td class="text-success fw-bold fs-5">RM <%= String.format("%.2f", m.getPrice())%></td>
                        <td class="text-end">
                            <a href="PrepareEditServlet?type=menu&id=<%= m.getId()%>" class="btn btn-sm btn-warning btn-action me-1"><i class="fas fa-edit"></i> Edit</a>
                            <a href="AdminDeleteServlet?type=menu&id=<%= m.getId()%>" class="btn btn-sm btn-danger btn-action" onclick="return confirm('Delete item?');"><i class="fas fa-trash"></i></a>
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
                        <a class="page-link" href="adminDashboard?tab=menus&page=<%= currentPage - 1%>">&laquo; Prev</a>
                    </li>
                    <% for (int p = 1; p <= totalPages; p++) {%>
                    <li class="page-item <%= p == currentPage ? "active" : ""%>">
                        <a class="page-link" href="adminDashboard?tab=menus&page=<%= p%>"><%= p%></a>
                    </li>
                    <% }%>
                    <li class="page-item <%= currentPage >= totalPages ? "disabled" : ""%>">
                        <a class="page-link" href="adminDashboard?tab=menus&page=<%= currentPage + 1%>">Next &raquo;</a>
                    </li>
                </ul>
            </nav>
            <% }%>
        </div>
    </body>
</html>