<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.kualicritic.model.Review" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Review - KualiCritic</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8fafc; font-family: 'Segoe UI', sans-serif; }
        .star-rating { display: flex; flex-direction: row-reverse; justify-content: flex-end; }
        .star-rating input[type="radio"] { display: none; }
        .star-rating label { color: #cbd5e1; font-size: 2.5rem; cursor: pointer; transition: color 0.2s; margin-right: 5px; }
        .star-rating input[type="radio"]:checked ~ label, .star-rating label:hover, .star-rating label:hover ~ label { color: #facc15; }
    </style>
</head>
<body>
    <%@ include file="components/navbar.jsp" %>
    <% Review r = (Review) request.getAttribute("review"); %>

    <div class="container mt-5" style="max-width: 600px;">
        <div class="card shadow-sm border-0 rounded-4 p-4">
            <h3 class="fw-bold mb-4" style="color: #1e293b;"><i class="fas fa-edit text-warning"></i> Edit Your Review</h3>
            <form action="UpdateMyReviewServlet" method="post" enctype="multipart/form-data">
                <input type="hidden" name="id" value="<%= r.getId() %>">
                
                <div class="mb-4">
                    <label class="form-label fw-bold text-muted">Update Rating:</label>
                    <div class="star-rating">
                        <input type="radio" id="star5" name="rating" value="5" <%= r.getRating() == 5 ? "checked" : "" %> /><label for="star5" class="fas fa-star"></label>
                        <input type="radio" id="star4" name="rating" value="4" <%= r.getRating() == 4 ? "checked" : "" %> /><label for="star4" class="fas fa-star"></label>
                        <input type="radio" id="star3" name="rating" value="3" <%= r.getRating() == 3 ? "checked" : "" %> /><label for="star3" class="fas fa-star"></label>
                        <input type="radio" id="star2" name="rating" value="2" <%= r.getRating() == 2 ? "checked" : "" %> /><label for="star2" class="fas fa-star"></label>
                        <input type="radio" id="star1" name="rating" value="1" <%= r.getRating() == 1 ? "checked" : "" %> /><label for="star1" class="fas fa-star"></label>
                    </div>
                </div>
                
                <div class="mb-3">
                    <label class="form-label fw-bold text-muted">Your Comment:</label>
                    <textarea name="comment" class="form-control" rows="4" required><%= r.getComment() %></textarea>
                </div>
                
                <div class="mb-4">
                    <label class="form-label fw-bold text-muted">Update Picture (Optional):</label>
                    <input type="file" name="reviewImage" class="form-control" accept="image/*">
                    <small class="text-muted">Leave blank to keep your current picture.</small>
                </div>
                
                <button type="submit" class="btn btn-warning w-100 fw-bold py-2 rounded-3">Save Changes</button>
                <a href="myReviews.jsp" class="btn btn-light w-100 mt-2 fw-bold rounded-3">Cancel</a>
            </form>
        </div>
    </div>
</body>
</html>