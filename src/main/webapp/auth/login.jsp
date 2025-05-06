<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login | Home Tutor System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            height: 100vh;
            display: flex;
            align-items: center;
        }
        .login-card {
            background: rgba(255, 255, 255, 0.9);
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            overflow: hidden;
            transition: all 0.3s ease;
        }
        .login-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.3);
        }
        .login-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px;
            text-align: center;
        }
        .form-control:focus {
            border-color: #764ba2;
            box-shadow: 0 0 0 0.25rem rgba(118, 75, 162, 0.25);
        }
        .btn-login {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            width: 100%;
            padding: 12px;
            font-weight: 600;
            transition: all 0.3s;
        }
        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }
        .forgot-password {
            color: #764ba2;
            text-decoration: none;
            transition: all 0.3s;
        }
        .forgot-password:hover {
            text-decoration: underline;
        }
        .error-message {
            color: #dc3545;
            font-size: 0.875em;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-4">
            <div class="login-card animate__animated animate__fadeIn">
                <div class="login-header">
                    <h3>Welcome Back</h3>
                    <p>Please login to your account</p>
                </div>
                <div class="card-body p-4">
                    <% if (request.getParameter("error") != null) { %>
                    <div class="alert alert-danger animate__animated animate__shakeX">
                        <%= request.getParameter("error") %>
                    </div>
                    <% } %>
                    <% if (request.getParameter("success") != null) { %>
                    <div class="alert alert-success animate__animated animate__fadeIn">
                        <%= request.getParameter("success") %>
                    </div>
                    <% } %>
                    <form action="${pageContext.request.contextPath}/login" method="post" id="loginForm">
                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" class="form-control" id="email" name="email" required>
                            <div class="error-message" id="emailError"></div>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">Password</label>
                            <input type="password" class="form-control" id="password" name="password" required>
                            <div class="error-message" id="passwordError"></div>
                        </div>
                        <div class="mb-3 form-check">
                            <input type="checkbox" class="form-check-input" id="remember">
                            <label class="form-check-label" for="remember">Remember me</label>
                        </div>
                        <button type="submit" class="btn btn-login btn-primary mb-3">Login</button>
                        <div class="text-center">
                            <a href="${pageContext.request.contextPath}/auth/forgot-password.jsp" class="forgot-password">Forgot Password?</a>
                        </div>
                    </form>
                    <div class="text-center mt-3">
                        <p>Don't have an account? <a href="${pageContext.request.contextPath}/auth/register.jsp" style="color: #764ba2;">Register here</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.getElementById('loginForm').addEventListener('submit', function(e) {
        let isValid = true;

        // Validate email
        const email = document.getElementById('email').value.trim();
        const emailRegex = /^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$/;
        if (!emailRegex.test(email)) {
            document.getElementById('emailError').textContent = 'Invalid email format';
            isValid = false;
        } else {
            document.getElementById('emailError').textContent = '';
        }

        // Validate password
        const password = document.getElementById('password').value;
        if (password.length < 1) {
            document.getElementById('passwordError').textContent = 'Password is required';
            isValid = false;
        } else {
            document.getElementById('passwordError').textContent = '';
        }

        if (!isValid) {
            e.preventDefault();
        }
    });
</script>
</body>
</html>