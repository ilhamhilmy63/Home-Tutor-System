<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.modules.BookingManagement.BookingService" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.example.models.User" %>
<html>
<head>
    <title>Welcome</title>
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
            max-width: 800px;
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

        h3 {
            font-family: 'Lora', serif;
            font-size: 1.5rem;
            font-weight: 600;
            color: #4A2C2A;
            margin: 1.5rem 0 0.5rem;
        }

        p {
            font-size: 1rem;
            color: #666;
            margin-bottom: 1rem;
        }

        a {
            display: inline-block;
            background: linear-gradient(90deg, #6B46C1, #A78BFA);
            color: #fff;
            padding: 0.75rem 1.5rem;
            border-radius: 6px;
            font-size: 1rem;
            font-weight: 600;
            text-decoration: none;
            transition: opacity 0.2s;
            margin: 0.5rem;
        }

        a:hover {
            opacity: 0.9;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 0.5rem;
            font-size: 0.9rem;
        }

        table th, table td {
            padding: 0.75rem;
            border: 1px solid #ccc;
            text-align: left;
        }

        table th {
            background-color: #f5f5f5;
            font-weight: 600;
            color: #4A2C2A;
        }

        table td {
            color: #666;
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

        @media (max-width: 768px) {
            main {
                margin: 1rem;
                padding: 1rem;
            }

            h1 {
                font-size: 1.5rem;
            }

            h3 {
                font-size: 1.25rem;
            }

            table {
                font-size: 0.8rem;
            }

            table th, table td {
                padding: 0.5rem;
            }
        }

        @media (max-width: 480px) {
            a {
                display: block;
                margin: 0.5rem auto;
                width: fit-content;
            }
        }
    </style>
</head>
<body>
<main>
    <h1><span class="home">Home</span><span class="tutor">Tutor</span>.lk</h1>
    <p class="tagline">Find the perfect tutor for your needs</p>

    <% User user = (User) session.getAttribute("user"); %>
    <% if (user != null) { %>
    <h3>Welcome, <%= user.getName() %>!</h3>
    <p>You are logged in as: <%= user.getRole() %></p>
    <p>Email: <%= user.getEmail() %></p>

    <% if ("student".equals(user.getRole())) { %>
    <p><a href="book-tutor?step=selectSubject">Book a Tutor</a></p>
    <h3>Your Bookings</h3>
    <%
        BookingService bookingService = new BookingService();
        List<Map<String, String>> bookings = bookingService.getStudentBookingsWithTutorName(user.getId());
        if (bookings.isEmpty()) { %>
    <p>No bookings found.</p>
    <% } else { %>
    <table>
        <tr>
            <th>Tutor</th>
            <th>Subject</th>
            <th>Day</th>
            <th>Time Slot</th>
            <th>Status</th>
        </tr>
        <% for (Map<String, String> booking : bookings) { %>
        <tr>
            <td><%= booking.get("tutorName") %></td>
            <td><%= booking.get("subject") %></td>
            <td><%= booking.get("day") %></td>
            <td><%= booking.get("timeSlot") %></td>
            <td><%= booking.get("status") %></td>
        </tr>
        <% } %>
    </table>
    <% } %>
    <% } %>
    <p><a href="logout">Logout</a></p>
    <% } else { %>
    <h3>Please Log In</h3>
    <p><a href="login">Go to Login</a></p>
    <% } %>

    <div class="nav-links">
        <a href="index.jsp">Home</a>
        <a href="blog">Blog</a>
        <a href="find-tutors">Find Tutors</a>
        <a href="about-us">About Us</a>
    </div>
</main>
</body>
</html>