<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.kualicritic.model.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Menu - KualiCritic</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8fafc; font-family: 'Segoe UI', sans-serif; }
        .form-card { 
            background: white; border-radius: 16px; padding: 30px; 
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05); 
            max-width: 600px; margin: 40px auto; 
        }
    </style>
</head>
<body>
    <%-- Use the standard navbar instead of the sidebar --%>
    <%@ include file="components/navbar.jsp" %>
    
    <% Menu m = (Menu) request.getAttribute("menu"); %>
    <% List<Stall> stalls = (List<Stall>) request.getAttribute("stalls"); %>
    
    <div class="container">
        <div class="form-card">
            <h2 class="fw-bold mb-4" style="color: #1e293b;">Edit Menu Item</h2>
            
            <form action="UpdateMenuServlet" method="post" enctype="multipart/form-data">
                <input type="hidden" name="id" value="<%= m.getId() %>">
                
                <div class="mb-3">
                    <label class="form-label fw-bold">Assign to Stall</label>
                    <select name="stallId" class="form-select" required>
                        <% for(Stall s : stalls) { %>
                            <option value="<%= s.getId() %>" <%= (s.getId() == m.getStallId()) ? "selected" : "" %>><%= s.getName() %></option>
                        <% } %>
                    </select>
                </div>
                
                <div class="mb-3">
                    <label class="form-label fw-bold">Item Name</label>
                    <input type="text" name="itemName" class="form-control" value="<%= m.getItemName() %>" required>
                </div>
                
                <div class="mb-3">
                    <label class="form-label fw-bold">Price (RM)</label>
                    <input type="number" step="0.01" name="price" class="form-control" value="<%= m.getPrice() %>" required>
                </div>
                
                <div class="mb-4">
                    <label class="form-label fw-bold">Update Food Picture (Leave blank to keep current image)</label>
                    <input type="file" name="menuImage" class="form-control" accept="image/*">
                </div>
                
                <button type="submit" class="btn btn-warning w-100 fw-bold py-2">Save Changes</button>
                <a href="adminDashboard?tab=menus" class="btn btn-light w-100 mt-2 fw-bold">Cancel</a>
            </form>
        </div>
    </div>
</body>
</html>