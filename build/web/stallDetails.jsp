<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.kualicritic.model.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Stall Details - KualiCritic</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8fafc; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        
        /* Hero Header */
        .stall-header {
            background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%);
            color: white; padding: 50px 20px; border-radius: 16px; margin-top: 30px; text-align: center;
            box-shadow: 0 10px 20px rgba(0,0,0,0.1); position: relative; overflow: hidden;
        }
        
        /* Modern Tabs */
        .nav-pills .nav-link {
            color: #64748b; font-weight: 600; padding: 12px 25px; border-radius: 50px; margin: 0 5px; transition: 0.3s;
        }
        .nav-pills .nav-link:hover { background-color: #e2e8f0; }
        .nav-pills .nav-link.active { background-color: #facc15; color: #1e293b; box-shadow: 0 4px 10px rgba(250, 204, 21, 0.3); }
        
        /* Content Cards */
        .content-card { background: white; border-radius: 16px; padding: 30px; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05); }
        
        .menu-item { display: flex; justify-content: space-between; align-items: center; padding: 15px 0; border-bottom: 1px solid #f1f5f9; }
        .menu-item:last-child { border-bottom: none; }
        
        .review-bubble { background-color: #f8fafc; border-radius: 12px; padding: 20px; margin-bottom: 20px; border-left: 4px solid #facc15; }
        
        /* Photo Gallery Grid */
        .gallery-img { width: 100%; height: 200px; object-fit: cover; border-radius: 12px; transition: 0.3s; cursor: pointer; }
        .gallery-img:hover { transform: scale(1.03); box-shadow: 0 10px 15px rgba(0,0,0,0.1); }
    </style>
</head>
<body>
    <%@ include file="components/navbar.jsp" %>
    
    <% 
        Stall stall = (Stall) request.getAttribute("stall"); 
        List<Menu> menus = (List<Menu>) request.getAttribute("menus");
        List<Review> reviews = (List<Review>) request.getAttribute("reviews");
    %>
    
    <div class="container mb-5">
        
        <div class="stall-header mb-4">
            <% if (stall.getImagePath() != null && !stall.getImagePath().isEmpty()) { %>
                <img src="images/stalls/<%= stall.getImagePath() %>"
                     style="max-height: 250px; width: 100%; object-fit: cover; border-radius: 12px; margin-bottom: 20px;"
                     onerror="this.style.display='none'">
            <% } %>
            <h1 class="fw-bold"><i class="fas fa-store text-warning me-2"></i> <%= stall.getName() %></h1>
            <p class="lead opacity-75 mx-auto" style="max-width: 600px;"><%= stall.getDescription() %></p>
            
            <% if (session.getAttribute("user") != null) { %>
                <a href="writeReview.jsp?stallId=<%= stall.getId() %>&stallName=<%= stall.getName() %>" class="btn btn-warning fw-bold mt-3 px-4 py-2" style="border-radius: 8px;">
                    <i class="fas fa-pen me-2"></i> Write a Review
                </a>
            <% } %>
        </div>

        <ul class="nav nav-pills justify-content-center mb-4" id="stallTabs" role="tablist">
            <li class="nav-item" role="presentation">
                <button class="nav-link active" id="menu-tab" data-bs-toggle="pill" data-bs-target="#menu" type="button" role="tab"><i class="fas fa-utensils me-1"></i> Menu Items</button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="reviews-tab" data-bs-toggle="pill" data-bs-target="#reviews" type="button" role="tab"><i class="fas fa-comments me-1"></i> Student Reviews</button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="photos-tab" data-bs-toggle="pill" data-bs-target="#photos" type="button" role="tab"><i class="fas fa-camera me-1"></i> Photo Gallery</button>
            </li>
        </ul>

        <div class="tab-content" id="stallTabsContent">
            
            <div class="tab-pane fade show active" id="menu" role="tabpanel">
                <div class="content-card mx-auto" style="max-width: 800px;">
                    <h3 class="fw-bold mb-4 text-center" style="color: #1e293b;">Available Menu</h3>
                    <% if (menus != null && !menus.isEmpty()) {
                        for (Menu m : menus) { %>
                            <div class="menu-item">
                                <div class="d-flex align-items-center">
                                    <% if(m.getImagePath() != null) { %>
                                        <img src="images/menus/<%= m.getImagePath() %>" class="rounded me-3 shadow-sm" style="width: 50px; height: 50px; object-fit: cover;">
                                    <% } %>
                                    <span class="fs-5 fw-bold" style="color: #334155;"><%= m.getItemName() %></span>
                                </div>
                                <strong class="fs-5 text-success">RM <%= String.format("%.2f", m.getPrice()) %></strong>
                            </div>
                    <% } } else { %>
                        <p class="text-center text-muted">No menu items uploaded yet.</p>
                    <% } %>
                </div>
            </div>

            <div class="tab-pane fade" id="reviews" role="tabpanel">
                <div class="content-card mx-auto" style="max-width: 800px;">
                    <h3 class="fw-bold mb-4 text-center" style="color: #1e293b;">What Students Are Saying</h3>
                    <% if (reviews != null && !reviews.isEmpty()) {
                        for (Review r : reviews) { %>
                           <div class="review-bubble">

    <div class="d-flex justify-content-between mb-3">
    <span class="badge bg-secondary px-3 py-2">
        <i class="fas fa-user me-1"></i>
        Anonymous
    </span>

    <span class="text-warning">
        <% for(int i=0; i<r.getRating(); i++) { %>
            <i class="fas fa-star"></i>
        <% } %>
    </span>
</div>

   <div class="d-flex justify-content-between align-items-start">

    <div class="flex-grow-1">
        <p class="fst-italic text-secondary mb-0">
            "<%= r.getComment() %>"
        </p>
    </div>

    <% if(r.getImagePath() != null && !r.getImagePath().isEmpty()) { %>
        <a href="images/reviews/<%= r.getImagePath() %>" target="_blank">
            <img src="images/reviews/<%= r.getImagePath() %>"
                 class="rounded shadow-sm ms-3"
                 style="width:120px; height:120px; object-fit:cover; cursor:pointer;">
        </a>
    <% } %>

</div>

   

</div>
                    <% } } else { %>
                        <p class="text-center text-muted">No reviews yet. Be the first!</p>
                    <% } %>
                </div>
            </div>

            <div class="tab-pane fade" id="photos" role="tabpanel">
                <div class="content-card">
                    <h3 class="fw-bold mb-4 text-center" style="color: #1e293b;">Community Photos</h3>
                    <div class="row g-3">
                        <% 
                            boolean hasPhotos = false;
                            if (reviews != null) {
                                for (Review r : reviews) {
                                    if (r.getImagePath() != null && !r.getImagePath().isEmpty()) {
                                        hasPhotos = true;
                        %>
                                        <div class="col-6 col-md-4 col-lg-3">
                                            <a href="images/reviews/<%= r.getImagePath() %>" target="_blank">
                                                <img src="images/reviews/<%= r.getImagePath() %>" class="gallery-img shadow-sm">
                                            </a>
                                        </div>
                        <%          }
                                }
                            }
                            if (!hasPhotos) { 
                        %>
                            <div class="col-12 text-center py-5">
                                <i class="fas fa-image fa-3x text-muted opacity-25 mb-3"></i>
                                <p class="text-muted">No photos have been uploaded by students yet.</p>
                            </div>
                        <% } %>
                    </div>
                </div>
            </div>
            
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>