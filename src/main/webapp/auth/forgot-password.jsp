<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Forgot Password | Home Tutor System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            height: 100vh;
            display: flex;
            align-items: center;
        }
        .forgot-card {
            background: rgba(255, 255, 255, 0.9);
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            overflow: hidden;
            transition: all 0.3s ease;
        }
        .forgot-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.3);
        }
        .forgot-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px;
            text-align: center;
        }
        .form-control:focus {
            border-color: #764ba2;
            box-shadow: 0 0 0 0.25rem rgba(118, 75, 162, 0.25);
        }
        .btn-reset {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            width: 100%;
            padding: 12px;
            font-weight: 600;
            transition: all 0.3s;
        }
        .btn-reset:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }
    </style>
</head>
<body>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-4">
            <div class="forgot-card animate__animated animate__fadeIn">
                <div class="forgot-header">
                    <h3>Forgot Password</h3>
                    <p>Enter your email to reset your password</p>
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
                    <form action="forgot-password" method="post">
                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" class="form-control" id="email" name="email" required>
                        </div>
                        <button type="submit" class="btn btn-reset btn-primary mb-3">Reset Password</button>
                        <div class="text-center">
                            <a href="auth/login.jsp" style="color: #764ba2;">Back to Login</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>