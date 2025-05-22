<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Home Tutor System</title>
    <link href="https://fonts.googleapis.com/css2?family=Lora:wght@600;700&family=Open+Sans:wght@400;600&display=swap" rel="stylesheet">
    <style>
        /* General Reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* Body */
        body {
            font-family: 'Open Sans', sans-serif;
            background-color: #ECE2D0;
            color: #4A2C2A;
            line-height: 1.6;
        }

        /* Header */
        header {
            background-color: #4A2C2A;
            padding: 1rem 2rem;
            text-align: center;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        header h1 {
            font-family: 'Lora', serif;
            font-size: 2rem;
            font-weight: 700;
            color: #F7C8A5;
        }

        /* Main Content */
        main {
            max-width: 800px;
            margin: 2rem auto;
            padding: 2rem;
            text-align: center;
            background-color: #D9C2A7;
            border-radius: 8px;
        }

        main h1 {
            font-family: 'Lora', serif;
            font-size: 2rem;
            font-weight: 700;
            color: #4A2C2A;
            margin-bottom: 1rem;
        }

        main p {
            font-size: 1rem;
            color: #4A2C2A;
            margin-bottom: 1.5rem;
        }

        /* Links */
        .links {
            margin-bottom: 1.5rem;
        }

        .links a {
            color: #4A2C2A;
            text-decoration: none;
            font-size: 1rem;
            font-weight: 600;
            padding: 0.5rem 1rem;
            margin: 0 0.5rem;
            border: 1px solid #4A2C2A;
            border-radius: 6px;
            transition: background-color 0.2s, color 0.2s;
        }

        .links a:hover {
            background-color: #4A2C2A;
            color: #F7C8A5;
        }

        /* Responsive */
        @media (max-width: 768px) {
            header {
                padding: 1rem;
            }

            header h1 {
                font-size: 1.5rem;
            }

            main {
                margin: 1rem;
                padding: 1rem;
            }

            main h1 {
                font-size: 1.5rem;
            }

            .links a {
                display: inline-block;
                margin: 0.5rem;
            }
        }

        @media (max-width: 480px) {
            .links a {
                display: block;
                margin: 0.5rem auto;
                width: fit-content;
            }
        }
    </style>
</head>
<body>
<header>
    <h1>HomeTutor</h1>
</header>
<main>
    <h1>Welcome to Home Tutor System</h1>
    <div class="links">
        <a href="login">User Login</a> |
        <a href="register">User Register</a> |
        <a href="tutor-login">Tutor Login</a> |
        <a href="tutor-register">Tutor Register</a>
        <a href="tutor-booking-details">Booking Details</a>
        <a href="tutor-update-profile">Update Profile</a>
    </div>
    <p>Find the best tutors for your learning needs!</p>
</main>
</body>
</html>