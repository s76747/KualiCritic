<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>KualiCritic - Campus Food Reviews</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8fafc; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        
        /* Stunning Dark Hero Section */
        .hero-section {
            background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%);
            color: white;
            padding: 80px 20px;
            border-bottom-left-radius: 30px;
            border-bottom-right-radius: 30px;
            text-align: center;
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
            margin-bottom: 50px;
        }
        .hero-section h1 { font-size: 3.5rem; font-weight: 800; letter-spacing: -1px; margin-bottom: 20px; }
        .hero-section p { font-size: 1.25rem; color: #94a3b8; max-width: 600px; margin: 0 auto 30px auto; }
        
        /* Modern Buttons with Flexbox Alignment */
        .btn-brand-primary {
            background: linear-gradient(135deg, #facc15 0%, #eab308 100%);
            color: #1e293b !important; font-weight: 700; border: none; border-radius: 12px;
            padding: 15px 35px; font-size: 1.1rem; transition: 0.3s; box-shadow: 0 4px 15px rgba(250, 204, 21, 0.3);
        }
        .btn-brand-primary:hover { transform: translateY(-3px); box-shadow: 0 8px 25px rgba(250, 204, 21, 0.4); }
        
        .btn-brand-secondary {
            background: rgba(255,255,255,0.1); border: 2px solid rgba(255,255,255,0.2);
            color: white; font-weight: 700; border-radius: 12px; padding: 15px 35px;
            font-size: 1.1rem; transition: 0.3s; backdrop-filter: blur(10px);
        }
        .btn-brand-secondary:hover { background: rgba(255,255,255,0.2); color: white; transform: translateY(-3px); }

        /* Floating Feature Cards */
        .feature-card {
            background: white; border: none; border-radius: 16px; padding: 30px;
            text-align: center; transition: all 0.3s ease; box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
            height: 100%;
        }
        .feature-card:hover { transform: translateY(-10px); box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1); }
        .feature-icon { font-size: 2.5rem; color: #facc15; margin-bottom: 20px; }
        .feature-card h4 { color: #1e293b; font-weight: 700; }
        .feature-card p { color: #64748b; }
    </style>
</head>
<body>
    <%@ include file="components/navbar.jsp" %>
    
    <div class="hero-section">
        <div class="container">
            <h1>Discover Campus Food. <br><span style="color: #facc15;">Share Your Voice.</span></h1>
            <p>The ultimate food review platform built specifically for students. Explore menus, read honest feedback, and find your next favorite meal between classes.</p>
            
            <div class="d-flex justify-content-center gap-3 mt-4 flex-wrap">
                <!-- Buttons use d-flex for perfect icon/text alignment -->
                <a href="stalls" class="btn btn-brand-primary d-flex align-items-center justify-content-center">
                    <i class="fas fa-search me-2"></i> Browse Food Stalls
                </a>
                
                <% if (session.getAttribute("user") != null) { %>
                    <a href="myReviews.jsp" class="btn btn-brand-secondary d-flex align-items-center justify-content-center">
                        <i class="fas fa-star me-2"></i> View My Reviews
                    </a>
                <% } else { %>
                    <a href="login.jsp" class="btn btn-brand-secondary d-flex align-items-center justify-content-center">
                        <i class="fas fa-sign-in-alt me-2"></i> Login to Review
                    </a>
                <% } %>
            </div>
        </div>
    </div>

    <div class="container mb-5">
        <div class="row g-4">
            <div class="col-md-4">
                <div class="feature-card">
                    <i class="fas fa-hamburger feature-icon"></i>
                    <h4>Explore Menus</h4>
                    <p>Check out what each stall is serving today and compare prices before you even leave your room.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-card">
                    <i class="fas fa-comments feature-icon"></i>
                    <h4>Honest Reviews</h4>
                    <p>Read real experiences from other students. Find out if the Nasi Lemak is actually spicy!</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-card">
                    <i class="fas fa-camera-retro feature-icon"></i>
                    <h4>Share Photos</h4>
                    <p>Upload pictures of your meals to help the community discover the best-looking dishes on campus.</p>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>