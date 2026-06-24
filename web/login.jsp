<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Login - KualiCritic</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            .form-container {
                max-width: 400px;
                margin: 50px auto;
                padding: 25px;
                border: 1px solid #ddd;
                border-radius: 8px;
                font-family: Arial, sans-serif;
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            }
            .form-group {
                margin-bottom: 15px;
            }
            .form-group label {
                display: block;
                font-weight: bold;
                margin-bottom: 5px;
                color: #2c3e50;
            }
            .form-group input {
                width: 100%;
                padding: 10px;
                box-sizing: border-box;
                border: 1px solid #ccc;
                border-radius: 4px;
            }
            .btn-submit {
                background-color: #2c3e50;
                color: white;
                padding: 12px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                width: 100%;
                font-size: 16px;
                font-weight: bold;
            }
            .btn-submit:hover {
                background-color: #34495e;
            }
            .error-msg {
                color: #e74c3c;
                background: #fadbd8;
                padding: 10px;
                border-radius: 4px;
                margin-bottom: 15px;
                text-align: center;
                font-weight: bold;
            }
            .success-msg {
                color: #27ae60;
                background: #d5f5e3;
                padding: 10px;
                border-radius: 4px;
                margin-bottom: 15px;
                text-align: center;
                font-weight: bold;
            }
            .links {
                text-align: center;
                margin-top: 15px;
                font-size: 14px;
            }
            .links a {
                color: #2980b9;
                text-decoration: none;
                margin: 0 10px;
            }
            .links a:hover {
                text-decoration: underline;
            }
            .input-group-password {
                position: relative;
            }
            .input-group-password input {
                padding-right: 40px;
            }
            .toggle-password {
                position: absolute;
                right: 10px;
                top: 50%;
                transform: translateY(-50%);
                cursor: pointer;
                color: #7f8c8d;
                border: none;
                background: none;
            }
        </style>
    </head>
    <body>
        <%@ include file="components/navbar.jsp" %>

        <div class="form-container">
            <h2 style="text-align: center; color: #2c3e50;">Welcome Back</h2>

            <% if (request.getParameter("success") != null) {%>
            <div class="success-msg"><%= request.getParameter("success")%></div>
            <% } %>

            <% if (request.getAttribute("error") != null) {%>
            <div class="error-msg"><%= request.getAttribute("error")%></div>
            <% }%>

            <form action="LoginServlet" method="post">

                <div class="form-group">
                    <label>Student ID:</label>
                    <input type="text" name="studentId" required placeholder="e.g., S12345">
                </div>

                <div class="form-group">
                    <label>Password:</label>
                    <div class="input-group-password">
                        <input type="password" name="password" id="login-password" required>
                        <button type="button" class="toggle-password" onclick="togglePassword()"><i class="fas fa-eye" id="eye-icon"></i></button>
                    </div>
                </div>

                <button type="submit" class="btn-submit">Login</button>

            </form>

            <div class="links">
                <a href="forgotPassword.jsp">Forgot Password?</a> | 
                <a href="register.jsp">Create an Account</a>
            </div>
        </div>
        <script>
            function togglePassword() {
                var field = document.getElementById('login-password');
                var icon = document.getElementById('eye-icon');
                if (field.type === 'password') {
                    field.type = 'text';
                    icon.classList.replace('fa-eye', 'fa-eye-slash');
                } else {
                    field.type = 'password';
                    icon.classList.replace('fa-eye-slash', 'fa-eye');
                }
            }
        </script>
    </body>
</html>