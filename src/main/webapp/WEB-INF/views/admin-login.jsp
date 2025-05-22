<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login - HomeTutor.lk</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-blue: #2563eb;
            --light-blue: #e0e7ff;
            --dark-blue: #1e40af;
            --accent-blue: #3b82f6;
            --white: #ffffff;
            --light-gray: #f8fafc;
            --dark-gray: #64748b;
            --success-green: #10b981;
            --error-red: #ef4444;
        }

        body {
            background-color: var(--light-blue);
            min-height: 100vh;
            display: flex;
            align-items: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .login-container {
            background: var(--white);
            border-radius: 16px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.08);
            overflow: hidden;
            margin: 2rem auto;
        }

        .login-header {
            background: linear-gradient(135deg, var(--primary-blue) 0%, var(--dark-blue) 100%);
            color: var(--white);
            padding: 2.5rem 2rem;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .login-header::before {
            content: "";
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, rgba(255,255,255,0) 70%);
            transform: rotate(30deg);
        }

        .login-icon {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            margin: 0 auto 1.5rem;
            background: rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(5px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .form-section {
            padding: 2.5rem;
        }

        .form-floating > label {
            color: var(--dark-gray);
            padding-left: 2.5rem;
        }

        .form-control {
            padding-left: 2.5rem;
            border-radius: 8px;
            border: 1px solid #e2e8f0;
            height: calc(3.5rem + 2px);
        }

        .form-control:focus {
            border-color: var(--accent-blue);
            box-shadow: 0 0 0 0.25rem rgba(59, 130, 246, 0.25);
        }

        .input-icon {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--dark-gray);
            z-index: 5;
        }

        .btn-admin {
            background: linear-gradient(135deg, var(--primary-blue) 0%, var(--dark-blue) 100%);
            border: none;
            padding: 14px 28px;
            font-weight: 600;
            letter-spacing: 0.5px;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .btn-admin:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 15px rgba(37, 99, 235, 0.3);
        }

        .alert {
            border-radius: 8px;
            border-left: 4px solid transparent;
            padding: 1rem 1.5rem;
        }

        .alert-danger {
            background-color: rgba(239, 68, 68, 0.1);
            border-left-color: var(--error-red);
            color: var(--error-red);
        }

        .alert-success {
            background-color: rgba(16, 185, 129, 0.1);
            border-left-color: var(--success-green);
            color: var(--success-green);
        }

        .divider {
            display: flex;
            align-items: center;
            margin: 1.5rem 0;
            color: var(--dark-gray);
        }

        .divider::before, .divider::after {
            content: "";
            flex: 1;
            border-bottom: 1px solid #e2e8f0;
        }

        .divider::before {
            margin-right: 1rem;
        }

        .divider::after {
            margin-left: 1rem;
        }

        .btn-outline-secondary {
            border-radius: 8px;
            padding: 10px 20px;
            transition: all 0.3s ease;
        }

        .btn-outline-secondary:hover {
            background-color: #f1f5f9;
        }

        .text-link {
            color: var(--primary-blue);
            text-decoration: none;
            font-weight: 500;
            transition: all 0.2s ease;
        }

        .text-link:hover {
            color: var(--dark-blue);
            text-decoration: underline;
        }

        .remember-me {
            display: flex;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .remember-me input {
            margin-right: 0.5rem;
        }

        .forgot-password {
            text-align: right;
            margin-bottom: 1.5rem;
        }

        @media (max-width: 768px) {
            .login-header {
                padding: 2rem 1rem;
            }

            .form-section {
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6">
            <div class="login-container">
                <div class="login-header">
                    <div class="login-icon">
                        <i class="fas fa-user-shield"></i>
                    </div>
                    <h2 class="mb-2">Admin Login</h2>
                    <p class="mb-0 opacity-90">HomeTutor.lk - Sri Lanka's Premier Tutoring Platform</p>
                </div>

                <div class="form-section">
                    <% if (request.getAttribute("error") != null) { %>
                    <div class="alert alert-danger mb-4">
                        <i class="fas fa-exclamation-circle me-2"></i>
                        <%= request.getAttribute("error") %>
                    </div>
                    <% } %>

                    <% if (request.getAttribute("success") != null) { %>
                    <div class="alert alert-success mb-4">
                        <i class="fas fa-check-circle me-2"></i>
                        <%= request.getAttribute("success") %>
                    </div>
                    <% } %>

                    <form method="post" action="admin-login">
                        <div class="mb-3">
                            <div class="form-floating position-relative">
                                <i class="fas fa-user input-icon"></i>
                                <input type="text" class="form-control ps-4" id="usernameOrEmail" name="usernameOrEmail"
                                       placeholder="Username or Email" required
                                       value="<%= request.getAttribute("usernameOrEmail") != null ? request.getAttribute("usernameOrEmail") : "" %>">
                                <label for="usernameOrEmail">Username or Email</label>
                            </div>
                        </div>

                        <div class="mb-3">
                            <div class="form-floating position-relative">
                                <i class="fas fa-lock input-icon"></i>
                                <input type="password" class="form-control ps-4" id="password" name="password"
                                       placeholder="Password" required>
                                <label for="password">Password</label>
                            </div>
                        </div>

                        <div class="row mb-4">
                            <div class="col-md-6">
                                <div class="remember-me">
                                    <input type="checkbox" id="remember" name="remember">
                                    <label for="remember">Remember me</label>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="forgot-password">
                                    <a href="forgot-password" class="text-link">Forgot password?</a>
                                </div>
                            </div>
                        </div>

                        <div class="d-grid mb-4">
                            <button type="submit" class="btn btn-admin">
                                <i class="fas fa-sign-in-alt me-2"></i>Login to Dashboard
                            </button>
                        </div>
                    </form>

                    <div class="divider">OR</div>

                    <div class="text-center mb-4">
                        <p class="mb-2">Don't have an admin account?</p>
                        <a href="admin-register" class="text-link">
                            <i class="fas fa-user-plus me-1"></i>Request Admin Access
                        </a>
                    </div>

                    <div class="text-center">
                        <p class="text-muted mb-2">Looking for other access?</p>
                        <a href="student-login" class="btn btn-outline-secondary me-2">
                            <i class="fas fa-graduation-cap me-2"></i>Student Login
                        </a>
                        <a href="tutor-login" class="btn btn-outline-secondary">
                            <i class="fas fa-chalkboard-teacher me-2"></i>Tutor Login
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Form validation styling
    document.querySelector('form').addEventListener('submit', function(e) {
        const inputs = this.querySelectorAll('input[required]');
        let isValid = true;

        inputs.forEach(input => {
            if (!input.checkValidity()) {
                input.classList.add('is-invalid');
                isValid = false;
            } else {
                input.classList.remove('is-invalid');
            }
        });

        if (!isValid) {
            e.preventDefault();
        }
    });
</script>
</body>
</html>