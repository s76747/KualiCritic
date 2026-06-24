<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.kualicritic.model.*, com.kualicritic.dao.*" %>
<!DOCTYPE html>
<html>
    <head>
        <title>My Reviews - KualiCritic</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f8fafc;
                font-family: 'Segoe UI', sans-serif;
            }
            .hero-banner {
                background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%);
                color: white;
                padding: 40px 0;
                border-radius: 15px;
                margin-top: 30px;
                box-shadow: 0 10px 20px rgba(0,0,0,0.1);
            }
            .review-card {
                border: none;
                border-radius: 12px;
                transition: all 0.3s ease;
                box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05);
            }
            .review-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 15px -3px rgba(0,0,0,0.1);
            }
            .review-img {
                width: 100%;
                height: 180px;
                object-fit: cover;
                border-top-left-radius: 12px;
                border-top-right-radius: 12px;
            }
            .stall-badge {
                background-color: #f1f5f9;
                color: #475569;
                font-weight: 600;
                padding: 5px 10px;
                border-radius: 6px;
                font-size: 0.85rem;
            }
        </style>
    </head>
    <body>
        <%@ include file="components/navbar.jsp" %>

        <%
            User user = (User) session.getAttribute("user");
            if (user == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            List<Review> myReviews = new ReviewDAO().getReviewsByUser(user.getId());
            StallDAO stallDAO = new StallDAO();
        %>

        <div class="container mb-5">
            <div class="hero-banner text-center mb-5">
                <h1 class="fw-bold"><i class="fas fa-user-circle text-warning me-2"></i> My Food Diary</h1>
                <p class="text-light opacity-75">Manage your past reviews and ratings.</p>
                <a href="stalls" class="btn btn-warning fw-bold px-4 mt-2">
                    <i class="fas fa-plus me-2"></i>Add New Review
                </a>
            </div>

            <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
                <% if (myReviews.isEmpty()) { %>
                <div class="col-12 text-center py-5">
                    <i class="fas fa-comment-slash fa-4x text-muted opacity-25 mb-3"></i>
                    <h4 class="text-muted fw-bold">You haven't written any reviews yet!</h4>
                    <p class="text-muted">Visit a food stall and share your experience with others.</p>
                    <a href="stalls" class="btn btn-warning mt-2 fw-bold px-4">
                        <i class="fas fa-utensils me-2"></i>Browse Food Stalls to Add Review
                    </a>
                </div>
                <% } else {
                    for (Review r : myReviews) {
                        Stall reviewedStall = stallDAO.getStallById(r.getStallId());
                %>
                <div class="col">
                    <div class="card review-card h-100">
                        <% if (r.getImagePath() != null && !r.getImagePath().isEmpty()) {%>
                        <img src="images/reviews/<%= r.getImagePath()%>" class="review-img">
                        <% } else { %>
                        <div class="review-img d-flex align-items-center justify-content-center bg-light">
                            <i class="fas fa-camera text-muted opacity-25 fa-3x"></i>
                        </div>
                        <% }%>

                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <span class="stall-badge"><i class="fas fa-store me-1"></i> <%= reviewedStall != null ? reviewedStall.getName() : "Stall #" + r.getStallId()%></span>
                                <span class="text-warning fs-6">
                                    <% for (int i = 0; i < r.getRating(); i++) { %><i class="fas fa-star"></i><% }%>
                                </span>
                            </div>
                            <p class="card-text text-secondary mt-3 fst-italic">"<%= r.getComment()%>"</p>
                        </div>

                        <div class="card-footer bg-white border-0 pt-0 pb-3 d-flex gap-2">
                            <a href="PrepareEditMyReviewServlet?id=<%= r.getId()%>" class="btn btn-outline-warning btn-sm flex-grow-1 fw-bold"><i class="fas fa-edit"></i> Edit</a>
                            <a href="DeleteMyReviewServlet?id=<%= r.getId()%>" class="btn btn-outline-danger btn-sm flex-grow-1 fw-bold" onclick="return confirm('Are you sure you want to delete this review?');"><i class="fas fa-trash"></i> Delete</a>
                        </div>
                    </div>
                </div>
                <% }
                }%>
            </div>
        </div>
    </body>
</html>