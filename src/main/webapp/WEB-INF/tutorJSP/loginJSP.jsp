<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Tutor Login</title>
    <link href="https://fonts.googleapis.com/css2?family=Lora:wght@600;700&family=Open+Sans:wght@400;600&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Open Sans', sans-serif;
            background-color: #f5f7fa;
            color: #333;
            line-height: 1.6;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 450px;
            width: 100%;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .header {
            background: linear-gradient(135deg, #6B46C1, #A78BFA);
            color: white;
            padding: 25px;
            text-align: center;
        }

        .header h2 {
            font-family: 'Lora', serif;
            margin: 0;
            font-size: 1.8rem;
        }

        .content {
            padding: 30px;
        }

        .error-message {
            color: #e53e3e;
            background-color: #fed7d7;
            padding: 12px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
            font-size: 0.9rem;
        }

        form {
            margin-top: 15px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #4a5568;
            font-size: 0.95rem;
        }

        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #e2e8f0;
            border-radius: 6px;
            font-size: 16px;
            transition: all 0.3s;
        }

        input[type="email"]:focus,
        input[type="password"]:focus {
            outline: none;
            border-color: #6B46C1;
            box-shadow: 0 0 0 2px rgba(107, 70, 193, 0.2);
        }

        .btn {
            display: inline-block;
            padding: 12px 24px;
            border-radius: 6px;
            font-weight: 600;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s;
            border: none;
            width: 100%;
            font-size: 16px;
            margin-top: 10px;
        }

        .btn-primary {
            background: linear-gradient(135deg, #6B46C1, #A78BFA);
            color: white;
        }

        .btn-primary:hover {
            opacity: 0.9;
            transform: translateY(-1px);
        }

        .register-link {
            text-align: center;
            margin-top: 25px;
            color: #4a5568;
            font-size: 0.95rem;
        }

        .register-link a {
            color: #6B46C1;
            font-weight: 600;
            text-decoration: none;
        }

        .register-link a:hover {
            text-decoration: underline;
        }

        .footer-links {
            display: flex;
            justify-content: center;
            margin-top: 25px;
            padding-top: 20px;
            border-top: 1px solid #e2e8f0;
        }

        .footer-links a {
            color: #6B46C1;
            text-decoration: none;
            margin: 0 10px;
            font-weight: 600;
            font-size: 0.9rem;
        }

        .footer-links a:hover {
            text-decoration: underline;
        }

        @media (max-width: 480px) {
            .container {
                border-radius: 0;
            }

            .header {
                padding: 20px;
            }

            .header h2 {
                font-size: 1.5rem;
            }

            .content {
                padding: 20px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h2>Tutor Login</h2>
    </div>

    <div class="content">
        <% if (request.getAttribute("error") != null) { %>
        <div class="error-message">
            <%= request.getAttribute("error") %>
        </div>
        <% } %>

        <form action="tutor-login" method="post">
            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" required placeholder="Enter your email">
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required placeholder="Enter your password">
            </div>

            <button type="submit" class="btn btn-primary">Login</button>
        </form>

        <div class="register-link">
            <p>Don't have an account? <a href="tutor-register">Register here</a></p>
        </div>

        <div class="footer-links">
            <a href="forgot-password">Forgot Password?</a>
            <a href="home">Back to Home</a>
        </div>
    </div>
</div>
</body>
</html>