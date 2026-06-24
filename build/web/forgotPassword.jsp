<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head><title>Reset Password - KualiCritic</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            .input-group-password {
                position: relative;
            }
            .input-group-password input {
                padding-right: 40px;
                width: 100%;
                padding: 8px 40px 8px 8px;
                margin-bottom: 10px;
                box-sizing: border-box;
            }
            .toggle-password {
                position: absolute;
                right: 10px;
                top: 35%;
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
        <div style="max-width: 400px; margin: 50px auto; padding: 20px; border: 1px solid #ccc; border-radius: 8px;">
            <h2>Reset Password</h2>
            <p>Enter your Student ID and your 4-digit Secret Recovery PIN.</p>

            <% if (request.getAttribute("error") != null) {%>
            <p style="color: red;"><%= request.getAttribute("error")%></p>
            <% }%>

            <form action="ResetPasswordServlet" method="post" onsubmit="return validateForm()">
                <label>Student ID:</label><br>
                <input type="text" name="studentId" required style="width: 100%; padding: 8px; margin-bottom: 10px;"><br>

                <label>Recovery PIN:</label><br>
                <input type="text" name="pin" required maxlength="4" style="width: 100%; padding: 8px; margin-bottom: 10px;"><br>

                <label>New Password:</label><br>
                <div class="input-group-password">
                    <input type="password" name="newPassword" id="newPassword" required minlength="6">
                    <button type="button" class="toggle-password" onclick="togglePassword('newPassword', 'eye1')"><i class="fas fa-eye" id="eye1"></i></button>
                </div>

                <label>Confirm New Password:</label><br>
                <div class="input-group-password">
                    <input type="password" name="confirmPassword" id="confirmPassword" required minlength="6">
                    <button type="button" class="toggle-password" onclick="togglePassword('confirmPassword', 'eye2')"><i class="fas fa-eye" id="eye2"></i></button>
                </div>
                <div id="pw-error" style="color:red; margin-bottom:10px; display:none;"></div>

                <button type="submit" style="width: 100%; padding: 10px; background: #2c3e50; color: white; border: none; cursor: pointer; margin-top:5px;">Reset Password</button>
            </form>
        </div>
        <script>
            function togglePassword(fieldId, iconId) {
                var field = document.getElementById(fieldId);
                var icon = document.getElementById(iconId);
                if (field.type === 'password') {
                    field.type = 'text';
                    icon.classList.replace('fa-eye', 'fa-eye-slash');
                } else {
                    field.type = 'password';
                    icon.classList.replace('fa-eye-slash', 'fa-eye');
                }
            }
            function validateForm() {
                var newPw = document.getElementById('newPassword').value;
                var confirmPw = document.getElementById('confirmPassword').value;
                var errDiv = document.getElementById('pw-error');
                if (newPw !== confirmPw) {
                    errDiv.textContent = 'Passwords do not match.';
                    errDiv.style.display = 'block';
                    return false;
                }
                errDiv.style.display = 'none';
                return true;
            }
        </script>
    </body>
</html>