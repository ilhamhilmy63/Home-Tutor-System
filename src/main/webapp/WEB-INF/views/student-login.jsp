<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Student Login - HomeTutor</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background-color: #f5f9ff;
      min-height: 100vh;
      display: flex;
      flex-direction: column;
    }

    /* Navigation */
    .navbar {
      background: #ffffff;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
      padding: 1rem 0;
      position: sticky;
      top: 0;
      z-index: 100;
    }

    .nav-container {
      max-width: 1200px;
      margin: 0 auto;
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 0 2rem;
    }

    .logo {
      color: #2563eb;
      font-size: 1.8rem;
      font-weight: bold;
      text-decoration: none;
    }

    .nav-links {
      display: flex;
      list-style: none;
      gap: 2rem;
    }

    .nav-links a {
      color: #1e40af;
      text-decoration: none;
      font-weight: 500;
      transition: color 0.3s ease;
    }

    .nav-links a:hover {
      color: #1a365d;
    }

    /* Main Content */
    .main-content {
      flex: 1;
      display: flex;
      justify-content: center;
      align-items: center;
      padding: 2rem;
    }

    .login-container {
      background: #ffffff;
      padding: 3rem;
      border-radius: 10px;
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
      width: 100%;
      max-width: 450px;
      border: 1px solid #e0e7ff;
    }

    .login-header {
      text-align: center;
      margin-bottom: 2rem;
    }

    .login-header h1 {
      color: #1e40af;
      font-size: 2rem;
      margin-bottom: 0.5rem;
    }

    .login-header p {
      color: #4b5563;
      font-size: 1rem;
    }

    .form-group {
      margin-bottom: 1.5rem;
      position: relative;
    }

    .form-group label {
      display: block;
      margin-bottom: 0.5rem;
      color: #1e40af;
      font-weight: 600;
    }

    .form-group input {
      width: 100%;
      padding: 1rem;
      border: 1px solid #d1d5db;
      border-radius: 6px;
      font-size: 1rem;
      transition: all 0.3s ease;
      background: #f9fafb;
    }

    .form-group input:focus {
      outline: none;
      border-color: #2563eb;
      box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
      background: #ffffff;
    }

    .form-group i {
      position: absolute;
      right: 1rem;
      top: 3.2rem;
      color: #6b7280;
    }

    .forgot-password {
      text-align: right;
      margin-bottom: 1.5rem;
    }

    .forgot-password a {
      color: #2563eb;
      text-decoration: none;
      font-size: 0.9rem;
    }

    .forgot-password a:hover {
      text-decoration: underline;
    }

    .btn-login {
      width: 100%;
      padding: 1rem;
      background: #2563eb;
      color: white;
      border: none;
      border-radius: 6px;
      font-size: 1rem;
      font-weight: 600;
      cursor: pointer;
      transition: all 0.3s ease;
    }

    .btn-login:hover {
      background: #1d4ed8;
      box-shadow: 0 4px 6px rgba(37, 99, 235, 0.2);
    }

    .register-link {
      text-align: center;
      margin-top: 1.5rem;
      padding-top: 1.5rem;
      border-top: 1px solid #e5e7eb;
      color: #4b5563;
    }

    .register-link a {
      color: #2563eb;
      text-decoration: none;
      font-weight: 600;
    }

    .register-link a:hover {
      text-decoration: underline;
    }

    .alert {
      padding: 1rem;
      border-radius: 6px;
      margin-bottom: 1.5rem;
      font-weight: 500;
    }

    .alert-error {
      background: #fee2e2;
      color: #b91c1c;
      border: 1px solid #fca5a5;
    }

    .alert-success {
      background: #dcfce7;
      color: #166534;
      border: 1px solid #86efac;
    }

    .alert-info {
      background: #dbeafe;
      color: #1e40af;
      border: 1px solid #93c5fd;
    }

    .password-toggle {
      position: absolute;
      right: 1rem;
      top: 3.2rem;
      cursor: pointer;
      color: #6b7280;
      user-select: none;
    }

    .password-toggle:hover {
      color: #374151;
    }

    .tutor-login-link {
      text-align: center;
      margin-top: 1rem;
      font-size: 0.9rem;
      color: #4b5563;
    }

    .tutor-login-link a {
      color: #2563eb;
      text-decoration: none;
      font-weight: 600;
    }

    .tutor-login-link a:hover {
      text-decoration: underline;
    }

    @media (max-width: 768px) {
      .nav-links {
        display: none;
      }

      .login-container {
        margin: 1rem;
        padding: 2rem;
      }
    }
  </style>
</head>
<body>
<!-- Navigation -->
<nav class="navbar">
  <div class="nav-container">
    <a href="${pageContext.request.contextPath}/" class="logo">
      <i class="fas fa-graduation-cap"></i> HomeTutor
    </a>
    <ul class="nav-links">
      <li><a href="${pageContext.request.contextPath}/user/HomePage.jsp"><i class="fas fa-home"></i> Home</a></li>
      <li><a href="${pageContext.request.contextPath}/user/AboutUs.jsp"><i class="fas fa-info-circle"></i> About Us</a></li>
      <li><a href="${pageContext.request.contextPath}/user/Contact.jsp"><i class="fas fa-envelope"></i> Contact</a></li>
      <li><a href="${pageContext.request.contextPath}/user/blog.jsp"><i class="fas fa-blog"></i> Blog</a></li>
      <li><a href="${pageContext.request.contextPath}/student-register"><i class="fas fa-user-plus"></i> Register</a></li>
    </ul>
  </div>
</nav>

<!-- Main Content -->
<div class="main-content">
  <div class="login-container">
    <div class="login-header">
      <h1><i class="fas fa-sign-in-alt"></i> Student Login</h1>
      <p>Welcome back! Please sign in to your account.</p>
    </div>

    <!-- Messages -->
    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-error">
      <i class="fas fa-exclamation-triangle"></i>
      <%= request.getAttribute("error") %>
    </div>
    <% } %>

    <% if (request.getAttribute("success") != null) { %>
    <div class="alert alert-success">
      <i class="fas fa-check-circle"></i>
      <%= request.getAttribute("success") %>
    </div>
    <% } %>

    <% if (request.getParameter("message") != null && "logout".equals(request.getParameter("message"))) { %>
    <div class="alert alert-info">
      <i class="fas fa-info-circle"></i>
      You have been successfully logged out.
    </div>
    <% } %>

    <form method="post" action="${pageContext.request.contextPath}/student-login">
      <div class="form-group">
        <label for="email">
          <i class="fas fa-envelope"></i> Email Address
        </label>
        <input type="email" id="email" name="email" required
               placeholder="Enter your email address"
               value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>">
      </div>

      <div class="form-group">
        <label for="password">
          <i class="fas fa-lock"></i> Password
        </label>
        <input type="password" id="password" name="password" required
               placeholder="Enter your password">
        <span class="password-toggle" onclick="togglePassword()">
          <i class="fas fa-eye" id="toggleIcon"></i>
        </span>
      </div>

      <div class="forgot-password">
        <a href="${pageContext.request.contextPath}/forgot-password">
          <i class="fas fa-question-circle"></i> Forgot Password?
        </a>
      </div>

      <button type="submit" class="btn-login">
        <i class="fas fa-sign-in-alt"></i> Login Now
      </button>
    </form>

    <div class="tutor-login-link">
      <p>Are you a tutor? <a href="${pageContext.request.contextPath}/tutor-login">Login here</a></p>
    </div>

    <div class="register-link">
      <p>Don't have an account?
        <a href="${pageContext.request.contextPath}/student-register">
          <i class="fas fa-user-plus"></i> Register here
        </a>
      </p>
    </div>
  </div>
</div>

<script>
  function togglePassword() {
    const passwordField = document.getElementById('password');
    const toggleIcon = document.getElementById('toggleIcon');

    if (passwordField.type === 'password') {
      passwordField.type = 'text';
      toggleIcon.classList.remove('fa-eye');
      toggleIcon.classList.add('fa-eye-slash');
    } else {
      passwordField.type = 'password';
      toggleIcon.classList.remove('fa-eye-slash');
      toggleIcon.classList.add('fa-eye');
    }
  }

  // Auto-focus on email field
  document.addEventListener('DOMContentLoaded', function() {
    const emailField = document.getElementById('email');
    if (emailField && !emailField.value) {
      emailField.focus();
    }
  });
</script>
</body>
</html>