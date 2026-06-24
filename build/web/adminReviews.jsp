<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.kualicritic.model.Review" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Manage Reviews - Admin</title>
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

            .thumbnail {
                width: 65px;
                height: 65px;
                object-fit: cover;
                border-radius: 12px;
                border: 2px solid #f1f5f9;
                transition: 0.3s;
            }
            .thumbnail:hover {
                transform: scale(1.5);
                cursor: pointer;
            } /* Cool zoom effect for review images */
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
            <h2 class="fw-bold mb-4" style="color: #1e293b;"><i class="fas fa-star text-warning me-2"></i> Manage Reviews</h2>

            <table class="modern-table">
                <thead>
                    <tr>
                        <th>Review ID</th>
                        <th>Student</th>
                        <th>Photo Attached</th>
                        <th>Rating</th>
                        <th>Comment</th>
                        <th class="text-end">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% List<Review> reviews = (List<Review>) request.getAttribute("reviews");
                    if (reviews != null) {
                        for (Review r : reviews) {%>
                    <tr>
                        <td class="text-muted fw-bold">#<%= r.getId()%></td>
                        <td><span class="badge" style="background-color: #e2e8f0; color: #475569;"><i class="fas fa-user-circle me-1"></i> <%= r.getReviewerId()%></span></td>
                        <td>
                            <% if (r.getImagePath() != null && !r.getImagePath().isEmpty()) {%>
                            <a href="images/reviews/<%= r.getImagePath()%>" target="_blank" title="View Full Image">
                                <img src="images/reviews/<%= r.getImagePath()%>" class="thumbnail shadow-sm">
                            </a>
                            <% } else { %>
                            <span class="badge bg-light text-muted border px-3 py-2">No Photo</span>
                            <% } %>
                        </td>
                        <td class="text-warning fs-5">
                            <% for (int i = 0; i < r.getRating(); i++) { %><i class="fas fa-star"></i><% }%>
                        </td>
                        <td class="fst-italic" style="color: #64748b; max-width: 300px;">"<%= r.getComment()%>"</td>
                        <td class="text-end">
                            <a href="AdminDeleteServlet?type=review&id=<%= r.getId()%>" class="btn btn-sm btn-outline-danger btn-action" onclick="return confirm('Delete review?');"><i class="fas fa-trash"></i> Remove</a>
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
                        <a class="page-link" href="adminDashboard?tab=reviews&page=<%= currentPage - 1%>">&laquo; Prev</a>
                    </li>
                    <% for (int p = 1; p <= totalPages; p++) {%>
                    <li class="page-item <%= p == currentPage ? "active" : ""%>">
                        <a class="page-link" href="adminDashboard?tab=reviews&page=<%= p%>"><%= p%></a>
                    </li>
                    <% }%>
                    <li class="page-item <%= currentPage >= totalPages ? "disabled" : ""%>">
                        <a class="page-link" href="adminDashboard?tab=reviews&page=<%= currentPage + 1%>">Next &raquo;</a>
                    </li>
                </ul>
            </nav>
            <% }%>
        </div>
    </body>
</html>