<style>
    .sidebar { 
        height: 100vh; 
        background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%); /* Sleek modern dark */
        padding-top: 30px; 
        position: fixed; 
        width: 260px; 
        left: 0; 
        top: 0; 
        box-shadow: 4px 0 15px rgba(0,0,0,0.1);
    }
    .sidebar .brand { 
        font-size: 26px; 
        font-weight: 800; 
        text-align: center; 
        margin-bottom: 40px; 
        color: #fff; 
        letter-spacing: 1px; 
    }
    .sidebar .brand i { color: #facc15; } /* Vibrant Yellow */
    .sidebar a { 
        color: #94a3b8; 
        text-decoration: none; 
        padding: 15px 20px; 
        display: block; 
        font-size: 16px; 
        font-weight: 600; 
        transition: all 0.3s ease; 
        margin: 5px 15px; 
        border-radius: 12px; 
    }
    .sidebar a:hover, .sidebar a.active { 
        background-color: rgba(250, 204, 21, 0.1); 
        color: #facc15; 
        transform: translateX(5px); /* Cool slide effect */
    }
    .sidebar a i { width: 25px; }
    
    .logout-container { position: absolute; bottom: 30px; width: 100%; }
    .logout-btn { color: #ef4444 !important; }
    .logout-btn:hover { background-color: rgba(239, 68, 68, 0.1) !important; color: #ef4444 !important; }
</style>

<div class="sidebar">
    <div class="brand"><i class="fas fa-utensils"></i> KualiCritic</div>
    
    <a href="adminDashboard?tab=stalls" class="<%= "stalls".equals(request.getAttribute("currentTab")) ? "active" : "" %>"><i class="fas fa-store"></i> Manage Stalls</a>
    <a href="adminDashboard?tab=menus" class="<%= "menus".equals(request.getAttribute("currentTab")) ? "active" : "" %>"><i class="fas fa-hamburger"></i> Manage Menus</a>
    <a href="adminDashboard?tab=users" class="<%= "users".equals(request.getAttribute("currentTab")) ? "active" : "" %>"><i class="fas fa-users"></i> Manage Users</a>
    <a href="adminDashboard?tab=reviews" class="<%= "reviews".equals(request.getAttribute("currentTab")) ? "active" : "" %>"><i class="fas fa-star"></i> Manage Reviews</a>
    
    <div class="logout-container">
        <a href="LogoutServlet" class="logout-btn"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </div>
</div>