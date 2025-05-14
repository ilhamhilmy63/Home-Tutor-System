<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - HomeTutor.lk</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
        }
        .login-container {
            max-width: 500px;
            margin: 50px auto;
            padding: 30px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        }
        .logo-text {
            font-size: 28px;
            font-weight: bold;
            color: #2c3e50;
            margin-bottom: 5px;
        }
        .tagline {
            font-size: 16px;
            color: #7f8c8d;
            margin-bottom: 30px;
        }
        .form-control {
            height: 45px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .btn-login {
            background-color: #3498db;
            color: white;
            border: none;
            height: 45px;
            border-radius: 5px;
            font-weight: 500;
            width: 100%;
        }
        .btn-login:hover {
            background-color: #2980b9;
        }
        .remember-me {
            margin-bottom: 15px;
        }
        .forgot-password {
            text-align: right;
            margin-bottom: 20px;
        }
        .forgot-password a {
            color: #7f8c8d;
            text-decoration: none;
            font-size: 14px;
        }
        .forgot-password a:hover {
            color: #3498db;
        }
        .signup-link {
            text-align: center;
            margin-top: 20px;
            color: #7f8c8d;
        }
        .signup-link a {
            color: #3498db;
            text-decoration: none;
            font-weight: 500;
        }
        .nav-links {
            display: flex;
            justify-content: center;
            margin-top: 30px;
            gap: 20px;
        }
        .nav-links a {
            color: #7f8c8d;
            text-decoration: none;
        }
        .nav-links a:hover {
            color: #3498db;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="login-container">
        <div class="text-center mb-4">
            <div class="logo-text">HomeTutor.lk</div>
            <div class="tagline">Find the perfect tutor for your needs</div>
        </div>

        <c:if test="${not empty param.error}">
            <div class="alert alert-danger">${param.error}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="form-group">
                <input type="text" class="form-control" id="email" name="email" placeholder="Username or Email" required>
            </div>
            <div class="form-group">
                <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
            </div>
            <div class="d-flex justify-content-between align-items-center">
                <div class="form-group form-check remember-me">
                    <input type="checkbox" class="form-check-input" id="remember" name="remember">
                    <label class="form-check-label" for="remember">Remember me</label>
                </div>
                <div class="forgot-password">
                    <a href="${pageContext.request.contextPath}/auth/forgot-password.jsp">Forgot password?</a>
                </div>
            </div>
            <button type="submit" class="btn btn-login">Login</button>
        </form>

        <div class="signup-link">
            Don't have an account? <a href="${pageContext.request.contextPath}/auth/register.jsp">Sign Up</a>
        </div>

        <div class="nav-links">
            <a href="#">Home</a>
            <a href="#">Blog</a>
            <a href="#">Find Tutors</a>
            <a href="#">About Us</a>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>