<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
    /* 
       Match the Admin Sidebar Style! 
       Dark gradient background with smooth slate-to-gold text transitions.
    */
    .modern-navbar {
        background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%);
        padding: 12px 0;
        box-shadow: 0 4px 15px rgba(0,0,0,0.15);
    }
    
    .modern-navbar .navbar-brand {
        font-size: 24px;
        font-weight: 800;
        color: #ffffff !important;
        letter-spacing: 1px;
    }
    
    .modern-navbar .nav-link {
        color: #94a3b8 !important; /* Slate color */
        font-weight: 600;
        margin: 0 5px;
        padding: 10px 16px !important;
        border-radius: 12px;
        transition: all 0.3s ease;
    }
    
    .modern-navbar .nav-link:hover, .modern-navbar .nav-link.active {
        background-color: rgba(250, 204, 21, 0.1); /* Faint gold background */
        color: #facc15 !important; /* Solid gold text */
        transform: translateY(-2px);
    }
    
    /* Styling the Navbar Buttons */
    .btn-brand-primary {
        background: linear-gradient(135deg, #facc15 0%, #eab308 100%);
        color: #1e293b !important;
        font-weight: 700;
        border: none;
        border-radius: 8px;
        padding: 8px 20px;
        transition: 0.3s;
    }
    .btn-brand-primary:hover {
        transform: scale(1.05);
        box-shadow: 0 4px 10px rgba(250, 204, 21, 0.3);
    }
    
    .btn-brand-outline {
        border: 2px solid #64748b;
        color: #f8fafc !important;
        font-weight: 600;
        border-radius: 8px;
        padding: 6px 18px;
        transition: 0.3s;
    }
    .btn-brand-outline:hover {
        border-color: #facc15;
        color: #facc15 !important;
        background: transparent;
    }
    
    .btn-brand-danger {
        background: rgba(239, 68, 68, 0.15);
        color: #ef4444 !important;
        font-weight: 600;
        border-radius: 8px;
        transition: 0.3s;
        border: 1px solid transparent;
    }
    .btn-brand-danger:hover {
        background: rgba(239, 68, 68, 0.25);
        border-color: #ef4444;
    }
    
    /* Mobile Menu Hamburger Icon Fix */
    .navbar-toggler { border-color: rgba(255,255,255,0.1); }
    .navbar-toggler-icon { filter: invert(1); opacity: 0.7; }
</style>

<nav class="navbar navbar-expand-lg modern-navbar sticky-top">
    <div class="container">
        <!-- Brand Logo -->
        <a class="navbar-brand" href="index.jsp">
            <i class="fas fa-utensils text-warning me-2"></i>KualiCritic
        </a>
        
        <!-- Mobile Toggle Button -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto align-items-center">
                <li class="nav-item"><a class="nav-link" href="index.jsp"><i class="fas fa-home me-1"></i> Home</a></li>
                <li class="nav-item"><a class="nav-link" href="stalls"><i class="fas fa-store me-1"></i> Food Stalls</a></li>
                
                <% if (session.getAttribute("user") != null) { 
                    String role = (String) session.getAttribute("userRole");
                %>
                    <li class="nav-item"><a class="nav-link" href="myReviews.jsp"><i class="fas fa-star me-1"></i> My Reviews</a></li>
                    
                    <% if ("ADMIN".equals(role)) { %>
                        <li class="nav-item ms-lg-3 mt-3 mt-lg-0">
                            <a class="btn btn-brand-outline btn-sm" href="adminDashboard"><i class="fas fa-cogs me-1"></i> Admin Panel</a>
                        </li>
                    <% } %>
                    
                    <li class="nav-item ms-lg-2 mt-2 mt-lg-0">
                        <a class="btn btn-brand-danger btn-sm px-3 py-2" href="LogoutServlet"><i class="fas fa-sign-out-alt me-1"></i> Logout</a>
                    </li>
                <% } else { %>
                    <li class="nav-item ms-lg-3 mt-3 mt-lg-0">
                        <a class="btn btn-brand-outline btn-sm" href="login.jsp">Login</a>
                    </li>
                    <li class="nav-item ms-lg-2 mt-2 mt-lg-0">
                        <a class="btn btn-brand-primary btn-sm" href="register.jsp">Sign Up</a>
                    </li>
                <% } %>
            </ul>
        </div>
    </div>
</nav>