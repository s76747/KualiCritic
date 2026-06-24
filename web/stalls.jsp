<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.kualicritic.model.Stall" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Food Stalls - KualiCritic</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f8f9fa;
            }
            .stall-img {
                height: 220px;
                object-fit: cover;
                border-top-left-radius: 8px;
                border-top-right-radius: 8px;
            }
            .card {
                transition: transform 0.2s;
                border: none;
                border-radius: 8px;
            }
            .card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 20px rgba(0,0,0,0.1) !important;
            }
        </style>
    </head>
    <body>
        <%@ include file="components/navbar.jsp" %>

        <div class="container my-5">
            <div class="text-center mb-5">
                <h1 class="fw-bold">Explore Campus Food</h1>
                <p class="text-muted">Discover menus and read honest reviews from UMT students.</p>
            </div>

            <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
                <%
                    List<Stall> stalls = (List<Stall>) request.getAttribute("stalls");
                    if (stalls != null && !stalls.isEmpty()) {
                        for (Stall stall : stalls) {
                %>
                <div class="col">
                    <div class="card h-100 shadow-sm">
                        <img src="images/stalls/<%= stall.getImagePath()%>" class="card-img-top stall-img" onerror="this.src='https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=600&q=80'">

                        <div class="card-body">
                            <h4 class="card-title fw-bold"><%= stall.getName()%></h4>
                            <p class="card-text text-muted"><%= stall.getDescription()%></p>
                        </div>

                        <div class="card-footer bg-white border-0 pb-3 text-center">
                            <a href="StallDetailsServlet?id=<%= stall.getId()%>" class="btn btn-warning w-100 fw-bold">
                                <i class="fas fa-book-open"></i> View Menu & Reviews
                            </a>
                        </div>
                    </div>
                </div>
                <%
                        }
                    } else {
                        out.print("<div class='col-12 text-center text-muted'><h4>No stalls available right now.</h4></div>");
                    }
                %>
            </div>

            <%
                Integer currentPage = (Integer) request.getAttribute("currentPage");
                Integer totalPages = (Integer) request.getAttribute("totalPages");
                if (currentPage != null && totalPages != null && totalPages > 1) {
            %>
            <nav class="d-flex justify-content-center mt-5">
                <ul class="pagination">
                    <li class="page-item <%= currentPage <= 1 ? "disabled" : ""%>">
                        <a class="page-link" href="stalls?page=<%= currentPage - 1%>">&laquo; Prev</a>
                    </li>
                    <% for (int p = 1; p <= totalPages; p++) {%>
                    <li class="page-item <%= p == currentPage ? "active" : ""%>">
                        <a class="page-link" href="stalls?page=<%= p%>"><%= p%></a>
                    </li>
                    <% }%>
                    <li class="page-item <%= currentPage >= totalPages ? "disabled" : ""%>">
                        <a class="page-link" href="stalls?page=<%= currentPage + 1%>">Next &raquo;</a>
                    </li>
                </ul>
            </nav>
            <% }%>
        </div>
    </body>
</html>