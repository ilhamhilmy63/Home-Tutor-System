<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Home Tutor System</title>
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

        h1 {
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

        .links {
            display: flex;
            flex-direction: column;
            gap: 1rem;
            margin: 1rem 0;
        }

        a {
            display: inline-block;
            background: linear-gradient(90deg, #6B46C1, #A78BFA);
            color: #fff;
            padding: 0.75rem;
            border-radius: 6px;
            font-size: 1rem;
            font-weight: 600;
            text-decoration: none;
            transition: opacity 0.2s;
        }

        a:hover {
            opacity: 0.9;
        }

        .description {
            font-size: 1rem;
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
            background: none;
            color: #666;
            padding: 0;
        }

        .nav-links a:hover {
            color: #4A2C2A;
            opacity: 1;
        }

        @media (max-width: 480px) {
            main {
                margin: 1rem;
                padding: 1rem;
            }

            h1 {
                font-size: 1.5rem;
            }
        }
    </style>
</head>
<body>
<main>
    <h1><span class="home">Home</span><span class="tutor">Tutor</span>.lk</h1>
    <p class="tagline">Find the perfect tutor for your needs</p>

    <div class="links">
        <a href="login">User Login</a>
        <a href="register">User Register</a>
        <a href="tutor-login">Tutor Login</a>
        <a href="tutor-register">Tutor Register</a>
    </div>

    <p class="description">Find the best tutors for your learning needs!</p>

    <div class="nav-links">
        <a href="index.jsp">Home</a>
        <a href="blog">Blog</a>
        <a href="find-tutors">Find Tutors</a>
        <a href="about-us">About Us</a>
    </div>
</main>
</body>
</html>