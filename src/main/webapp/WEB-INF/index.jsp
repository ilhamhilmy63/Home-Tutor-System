<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HomeTutor.lk - Find Your Perfect Tutor</title>
    <style>
        :root {
            --primary-color: #4a6bff;
            --secondary-color: #f8f9fa;
            --accent-color: #ff6b6b;
            --text-color: #333;
            --light-text: #6c757d;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #f5f7ff;
            color: var(--text-color);
            line-height: 1.6;
        }

        .navbar {
            background-color: white;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--primary-color);
            text-decoration: none;
        }

        .nav-links {
            display: flex;
            gap: 2rem;
        }

        .nav-links a {
            color: var(--text-color);
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s;
        }

        .nav-links a:hover {
            color: var(--primary-color);
        }

        .auth-buttons .btn {
            margin-left: 1rem;
            padding: 0.5rem 1.5rem;
            border-radius: 5px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s;
        }

        .btn-login {
            border: 1px solid var(--primary-color);
            color: var(--primary-color);
        }

        .btn-login:hover {
            background-color: var(--primary-color);
            color: white;
        }

        .btn-signup {
            background-color: var(--primary-color);
            color: white;
        }

        .btn-signup:hover {
            background-color: #3a56d4;
        }

        .hero {
            padding: 5rem 2rem;
            text-align: center;
            background: linear-gradient(135deg, #f5f7ff 0%, #e8ecff 100%);
        }

        .hero h1 {
            font-size: 3rem;
            margin-bottom: 1rem;
            color: var(--primary-color);
        }

        .hero p {
            font-size: 1.2rem;
            color: var(--light-text);
            max-width: 700px;
            margin: 0 auto 2rem;
        }

        .search-box {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            max-width: 800px;
            margin: 0 auto;
        }

        .search-input {
            width: 100%;
            padding: 1rem;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1rem;
            margin-bottom: 1rem;
        }

        .search-btn {
            background-color: var(--accent-color);
            color: white;
            border: none;
            padding: 1rem 2rem;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .search-btn:hover {
            background-color: #e05555;
        }

        .features {
            padding: 4rem 2rem;
            text-align: center;
        }

        .features h2 {
            font-size: 2rem;
            margin-bottom: 3rem;
            color: var(--primary-color);
        }

        .feature-cards {
            display: flex;
            justify-content: center;
            gap: 2rem;
            flex-wrap: wrap;
        }

        .feature-card {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            width: 300px;
            transition: transform 0.3s;
        }

        .feature-card:hover {
            transform: translateY(-10px);
        }

        .feature-icon {
            font-size: 2.5rem;
            color: var(--primary-color);
            margin-bottom: 1rem;
        }

        .feature-card h3 {
            margin-bottom: 1rem;
        }

        footer {
            background-color: var(--primary-color);
            color: white;
            text-align: center;
            padding: 2rem;
            margin-top: 3rem;
        }
    </style>
</head>
<body>
<nav class="navbar">
    <a href="index.jsp" class="logo">HomeTutor.lk</a>
    <div class="nav-links">
        <a href="#">Home</a>
        <a href="#">Find Tutors</a>
        <a href="#">How It Works</a>
        <a href="#">About Us</a>
    </div>
    <div class="auth-buttons">
        <a href="auth/login.jsp" class="btn btn-login">Login</a>
        <a href="auth/register.jsp" class="btn btn-signup">Sign Up</a>
    </div>
</nav>

<section class="hero">
    <h1>Find the Perfect Tutor for Your Needs</h1>
    <p>Connect with qualified tutors in your area for personalized learning experiences</p>

    <div class="search-box">
        <input type="text" class="search-input" placeholder="Search for subjects (e.g., Math, Science)">
        <button class="search-btn">Find Tutors</button>
    </div>
</section>

<section class="features">
    <h2>Why Choose HomeTutor.lk</h2>
    <div class="feature-cards">
        <div class="feature-card">
            <div class="feature-icon">👨‍🏫</div>
            <h3>Qualified Tutors</h3>
            <p>All our tutors are verified and have excellent teaching credentials</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon">🏠</div>
            <h3>Learn at Home</h3>
            <p>Get personalized attention in the comfort of your home</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon">💰</div>
            <h3>Affordable Rates</h3>
            <p>Find tutors that fit your budget with transparent pricing</p>
        </div>
    </div>
</section>

<footer>
    <p>&copy; 2023 HomeTutor.lk. All rights reserved.</p>
</footer>
</body>
</html>