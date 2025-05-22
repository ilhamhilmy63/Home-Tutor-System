<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
    <link href="https://fonts.googleapis.com/css2?family=Lora:wght@600;700&family=Open+Sans:wght@400;600&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Open Sans', sans-serif;
            background-color: #fff;
            color: #333;
            line-height: 1.6;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        main {
            max-width: 400px;
            margin: 2rem auto;
            padding: 2rem;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        h2 {
            font-family: 'Lora', serif;
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .home {
            color: #4A2C2A;
        }

        .tutor {
            color: #6B46C1;
        }

        p.tagline {
            font-size: 0.9rem;
            color: #666;
            margin-bottom: 1.5rem;
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        input[type="email"], input[type="password"] {
            padding: 0.75rem;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 1rem;
            width: 100%;
        }

        input[type="submit"] {
            background: linear-gradient(90deg, #6B46C1, #A78BFA);
            color: #fff;
            padding: 0.75rem;
            border: none;
            border-radius: 6px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: opacity 0.2s;
        }

        input[type="submit"]:hover {
            opacity: 0.9;
        }

        .forgot-password {
            font-size: 0.9rem;
            color: #666;
            margin-top: 0.5rem;
            text-align: right;
        }

        a {
            color: #6B46C1;
            text-decoration: none;
            font-weight: 600;
        }

        a:hover {
            text-decoration: underline;
        }

        .signup-link {
            font-size: 0.9rem;
            color: #666;
            margin-top: 1rem;
        }

        .nav-links {
            margin-top: 1.5rem;
            font-size: 0.9rem;
            color: #666;
        }

        .nav-links a {
            margin: 0 1rem;
            color: #666;
        }

        .nav-links a:hover {
            color: #4A2C2A;
        }

        @media (max-width: 480px) {
            main {
                margin: 1rem;
                padding: 1rem;
            }

            h2 {
                font-size: 1.5rem;
            }
        }
    </style>
</head>
<body>
<main>
    <h2><span class="home">Home</span><span class="tutor">Tutor</span>.lk</h2>
    <p class="tagline">Find the perfect tutor for your needs</p>

    <% if (request.getAttribute("error") != null) { %>
    <p style="color: #D77A61;"><%= request.getAttribute("error") %></p>
    <% } %>
    <% if (request.getAttribute("message") != null) { %>
    <p><%= request.getAttribute("message") %></p>
    <% } %>

    <form action="login" method="post">
        <input type="email" name="email" placeholder="Email" required><br><br>
        <input type="password" name="password" placeholder="Password" required><br><br>
        <input type="submit" value="Login">
    </form>

    <div class="forgot-password"><a href="forgot-password">Forgot Password?</a></div>
    <div class="signup-link">Don't have an account? <a href="register">Sign Up</a></div>
    <div class="nav-links">
        <a href="index.jsp">Home</a>
        <a href="blog">Blog</a>
        <a href="find-tutors">Find Tutors</a>
        <a href="about-us">About Us</a>
    </div>
</main>
</body>
</html>