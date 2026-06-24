<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Register - KualiCritic</title>
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
            .form-group input.is-invalid,
            .input-group-email.is-invalid {
                border-color: #e74c3c !important;
                box-shadow: 0 0 0 1px #e74c3c;
            }
            .field-error {
                color: #e74c3c;
                font-size: 13px;
                margin-top: 4px;
                display: block;
            }
        </style>
    </head>
    <body>
        <%@ include file="components/navbar.jsp" %>

        <div class="form-container">
            <h2 style="text-align: center; color: #2c3e50;">Student Registration</h2>

            <% if (request.getAttribute("error") != null) {%>
            <div class="error-msg"><%= request.getAttribute("error")%></div>
            <% }%>

            <form action="RegisterServlet" method="post">

                <div class="form-group">
                    <label>Student ID (e.g., S12345):</label>
                    <input type="text" name="studentId"
                           class="<%= request.getAttribute("studentIdError") != null ? "is-invalid" : ""%>"
                           value="<%= request.getAttribute("studentId") != null ? request.getAttribute("studentId") : ""%>"
                           required placeholder="SXXXXX">
                    <% if (request.getAttribute("studentIdError") != null) {%>
                    <span class="field-error"><%= request.getAttribute("studentIdError")%></span>
                    <% }%>
                </div>

                <div class="form-group">
                    <label>Email Address:</label>
                    <div class="input-group-email <%= request.getAttribute("emailError") != null ? "is-invalid" : ""%>"
                         style="display:flex; align-items:center; border:1px solid #ccc; border-radius:4px; overflow:hidden;">
                        <input type="text" name="studentIdEmail" id="studentIdEmail" required placeholder="SXXXXX"
                               style="flex:1; padding:10px; border:none; outline:none; box-sizing:border-box;"
                               oninput="syncEmail()" pattern="[Ss]\d+" title="Enter your Student ID (e.g. S12345)">
                        <span style="padding:10px; background:#f0f0f0; color:#555; white-space:nowrap; border-left:1px solid #ccc;">@ocean.umt.edu.my</span>
                    </div>
                    <% if (request.getAttribute("emailError") != null) {%>
                    <span class="field-error"><%= request.getAttribute("emailError")%></span>
                    <% }%>
                    <input type="hidden" name="email" id="hiddenEmail">
                    <small style="color:#7f8c8d;">Enter your Student ID only (e.g. S12345)</small>
                </div>

                <div class="form-group">
                    <label>Password (Min 6 chars):</label>
                    <div class="input-group-password">
                        <input type="password" name="password" id="reg-password" required minlength="6">
                        <button type="button" class="toggle-password" onclick="togglePassword('reg-password', this)"><i class="fas fa-eye"></i></button>
                    </div>
                </div>

                <div class="form-group">
                    <label>Confirm Password:</label>
                    <div class="input-group-password">
                        <input type="password" name="confirmPassword" id="reg-confirm" required minlength="6">
                        <button type="button" class="toggle-password" onclick="togglePassword('reg-confirm', this)"><i class="fas fa-eye"></i></button>
                    </div>
                </div>

                <div class="form-group">
                    <label>Secret Recovery PIN (4 Digits):</label>
                    <input type="text" name="recoveryPin" required maxlength="4" pattern="\d{4}" title="Please enter exactly 4 numbers" placeholder="e.g. 1234">
                    <small style="color: #7f8c8d;">Remember this! You need it to reset your password.</small>
                </div>

                <button type="submit" class="btn-submit" onclick="syncEmail()">Create Account</button>

            </form>

            <p style="text-align: center; margin-top: 15px;">
                Already have an account? <a href="login.jsp" style="color: #2980b9;">Login here</a>
            </p>
        </div>
        <script>
            function syncEmail() {
                var sid = document.getElementById('studentIdEmail').value.trim();
                document.getElementById('hiddenEmail').value = sid + '@ocean.umt.edu.my';
            }
            function togglePassword(fieldId, btn) {
                var field = document.getElementById(fieldId);
                var icon = btn.querySelector('i');
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