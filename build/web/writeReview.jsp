<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Write Review - KualiCritic</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    
    <style>
        body { background-color: #f8f9fa; }
        
        /* Magic CSS for Star Rating (No JavaScript needed!) */
        .star-rating {
            display: flex;
            flex-direction: row-reverse; /* Reverses the order so the CSS sibling selector works */
            justify-content: flex-end;
        }
        
        .star-rating input[type="radio"] {
            display: none; /* Hide the ugly default radio buttons */
        }
        
        .star-rating label {
            color: #ddd; /* Gray empty star color */
            font-size: 2.5rem;
            cursor: pointer;
            transition: color 0.2s;
            margin-right: 5px;
        }
        
        /* When a radio button is checked, or hovered, turn gold. 
           Also turn all sibling labels AFTER it gold. */
        .star-rating input[type="radio"]:checked ~ label,
        .star-rating label:hover,
        .star-rating label:hover ~ label {
            color: #f1c40f; 
        }
    </style>
</head>
<body>
    <%@ include file="components/navbar.jsp" %>
    
    <% 
        // Security check: If they are not logged in, kick them back to login page
        if (session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String stallId = request.getParameter("stallId");
        String stallName = request.getParameter("stallName");
    %>

    <div class="container mt-5" style="max-width: 600px;">
        <div class="card shadow-sm border-0">
            <div class="card-header bg-white border-bottom-0 pt-4 pb-0 text-center">
                <h3 class="fw-bold">Reviewing: <span class="text-warning"><%= stallName %></span></h3>
            </div>
            
            <div class="card-body p-4">
                <form action="SubmitReviewServlet" method="post" enctype="multipart/form-data">
                    
                    <input type="hidden" name="stallId" value="<%= stallId %>">
                    
                    <div class="mb-4">
                        <label class="form-label fw-bold fs-5">Your Rating:</label>
                        <div class="star-rating">
                            <input type="radio" id="star5" name="rating" value="5" required /><label for="star5" class="fas fa-star"></label>
                            <input type="radio" id="star4" name="rating" value="4" /><label for="star4" class="fas fa-star"></label>
                            <input type="radio" id="star3" name="rating" value="3" /><label for="star3" class="fas fa-star"></label>
                            <input type="radio" id="star2" name="rating" value="2" /><label for="star2" class="fas fa-star"></label>
                            <input type="radio" id="star1" name="rating" value="1" /><label for="star1" class="fas fa-star"></label>
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label fw-bold">Your Review:</label>
                        <textarea name="comment" class="form-control" rows="5" placeholder="How was the food, service, and portion size?" required></textarea>
                    </div>
                    
                    <div class="mb-4">
                        <label class="form-label fw-bold">Upload a Picture (Optional):</label>
                        <input type="file" name="reviewImage" class="form-control" accept="image/png, image/jpeg, image/jpg">
                    </div>
                    
                    <button type="submit" class="btn btn-warning w-100 fw-bold fs-5 py-2">Post Review</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>