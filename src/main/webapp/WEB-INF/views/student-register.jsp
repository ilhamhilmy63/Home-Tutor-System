<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Registration - HomeTutor</title>
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

        .register-container {
            background: #ffffff;
            padding: 3rem;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            width: 100%;
            max-width: 600px;
            border: 1px solid #e0e7ff;
        }

        .register-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .register-header h1 {
            color: #1e40af;
            font-size: 2rem;
            margin-bottom: 0.5rem;
        }

        .register-header p {
            color: #4b5563;
            font-size: 1rem;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
            margin-bottom: 1.5rem;
        }

        .form-group {
            position: relative;
        }

        .form-group.full-width {
            grid-column: 1 / -1;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: #1e40af;
            font-weight: 600;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 1rem;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: #f9fafb;
        }

        .form-group input:focus,
        .form-group select:focus {
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

        .btn-register {
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
            margin-top: 1rem;
        }

        .btn-register:hover {
            background: #1d4ed8;
            box-shadow: 0 4px 6px rgba(37, 99, 235, 0.2);
        }

        .login-link {
            text-align: center;
            margin-top: 1.5rem;
            padding-top: 1.5rem;
            border-top: 1px solid #e5e7eb;
            color: #4b5563;
        }

        .login-link a {
            color: #2563eb;
            text-decoration: none;
            font-weight: 600;
        }

        .login-link a:hover {
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

        .tutor-register-link {
            text-align: center;
            margin-top: 1rem;
            font-size: 0.9rem;
            color: #4b5563;
        }

        .tutor-register-link a {
            color: #2563eb;
            text-decoration: none;
            font-weight: 600;
        }

        .tutor-register-link a:hover {
            text-decoration: underline;
        }

        @media (max-width: 768px) {
            .form-grid {
                grid-template-columns: 1fr;
            }

            .nav-links {
                display: none;
            }

            .register-container {
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
            <li><a href="${pageContext.request.contextPath}/"><i class="fas fa-home"></i> Home</a></li>
            <li><a href="${pageContext.request.contextPath}/about"><i class="fas fa-info-circle"></i> About Us</a></li>
            <li><a href="${pageContext.request.contextPath}/contact"><i class="fas fa-envelope"></i> Contact</a></li>
            <li><a href="${pageContext.request.contextPath}/blog"><i class="fas fa-blog"></i> Blog</a></li>
            <li><a href="${pageContext.request.contextPath}/student-login"><i class="fas fa-sign-in-alt"></i> Login</a></li>
        </ul>
    </div>
</nav>

<!-- Main Content -->
<div class="main-content">
    <div class="register-container">
        <div class="register-header">
            <h1><i class="fas fa-user-plus"></i> Student Registration</h1>
            <p>Join our learning community today!</p>
        </div>

        <!-- Error/Success Messages -->
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

        <form method="post" action="${pageContext.request.contextPath}/student-register">
            <div class="form-grid">
                <div class="form-group">
                    <label for="fullName">
                        <i class="fas fa-user"></i> Full Name
                    </label>
                    <input type="text" id="fullName" name="fullName" required
                           placeholder="Enter your full name"
                           value="<%= request.getParameter("fullName") != null ? request.getParameter("fullName") : "" %>">
                </div>

                <div class="form-group">
                    <label for="phoneNumber">
                        <i class="fas fa-phone"></i> Phone Number
                    </label>
                    <input type="tel" id="phoneNumber" name="phoneNumber" required
                           placeholder="Enter phone number" pattern="[0-9]{10,15}"
                           value="<%= request.getParameter("phoneNumber") != null ? request.getParameter("phoneNumber") : "" %>">
                </div>

                <div class="form-group full-width">
                    <label for="email">
                        <i class="fas fa-envelope"></i> Email Address
                    </label>
                    <input type="email" id="email" name="email" required
                           placeholder="Enter your email address"
                           value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>">
                </div>

                <div class="form-group">
                    <label for="password">
                        <i class="fas fa-lock"></i> Password
                    </label>
                    <input type="password" id="password" name="password" required
                           placeholder="Enter password" minlength="6">
                </div>

                <div class="form-group">
                    <label for="confirmPassword">
                        <i class="fas fa-lock"></i> Confirm Password
                    </label>
                    <input type="password" id="confirmPassword" name="confirmPassword" required
                           placeholder="Confirm password" minlength="6">
                </div>

                <div class="form-group">
                    <label for="grade">
                        <i class="fas fa-graduation-cap"></i> Grade Level
                    </label>
                    <select id="grade" name="grade" required>
                        <option value="">Select Grade</option>
                        <option value="Grade 1">Grade 1</option>
                        <option value="Grade 2">Grade 2</option>
                        <option value="Grade 3">Grade 3</option>
                        <option value="Grade 4">Grade 4</option>
                        <option value="Grade 5">Grade 5</option>
                        <option value="Grade 6">Grade 6</option>
                        <option value="Grade 7">Grade 7</option>
                        <option value="Grade 8">Grade 8</option>
                        <option value="Grade 9">Grade 9</option>
                        <option value="Grade 10">Grade 10</option>
                        <option value="Grade 11">Grade 11</option>
                        <option value="Grade 12">Grade 12</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="module">
                        <i class="fas fa-book"></i> Subject Module
                    </label>
                    <select id="module" name="module" required>
                        <option value="">Select Module</option>
                        <option value="Mathematics">Mathematics</option>
                        <option value="Science">Science</option>
                        <option value="English">English</option>
                        <option value="History">History</option>
                        <option value="Geography">Geography</option>
                        <option value="Physics">Physics</option>
                        <option value="Chemistry">Chemistry</option>
                        <option value="Biology">Biology</option>
                        <option value="Computer Science">Computer Science</option>
                        <option value="Art">Art</option>
                    </select>
                </div>
            </div>

            <button type="submit" class="btn-register">
                <i class="fas fa-user-plus"></i> Register Now
            </button>
        </form>

        <div class="tutor-register-link">
            <p>Are you a tutor? <a href="${pageContext.request.contextPath}/tutor-register">Register here</a></p>
        </div>

        <div class="login-link">
            <p>Already have an account?
                <a href="${pageContext.request.contextPath}/student-login">
                    <i class="fas fa-sign-in-alt"></i> Login here
                </a>
            </p>
        </div>
    </div>
</div>

<script>
    // Password confirmation validation
    document.getElementById('confirmPassword').addEventListener('input', function() {
        const password = document.getElementById('password').value;
        const confirmPassword = this.value;

        if (password !== confirmPassword) {
            this.setCustomValidity('Passwords do not match');
        } else {
            this.setCustomValidity('');
        }
    });

    // Phone number validation
    document.getElementById('phoneNumber').addEventListener('input', function() {
        this.value = this.value.replace(/[^0-9]/g, '');
    });

    // Set selected values if they exist
    document.addEventListener('DOMContentLoaded', function() {
        const grade = "<%= request.getParameter("grade") != null ? request.getParameter("grade") : "" %>";
        const module = "<%= request.getParameter("module") != null ? request.getParameter("module") : "" %>";

        if (grade) document.getElementById('grade').value = grade;
        if (module) document.getElementById('module').value = module;
    });
</script>
</body>
</html>