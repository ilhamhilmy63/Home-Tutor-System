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

        /* Main Content */
        main {
            max-width: 800px;
            margin: 2rem auto;
            padding: 2rem;
            background-color: #D9C2A7;
            border-radius: 8px;
        }

        h1 {
            font-family: 'Lora', serif;
            font-size: 1.5rem;
            font-weight: 700;
            color: #4A2C2A;
            margin-bottom: 1rem;
        }

        h3 {
            font-family: 'Lora', serif;
            font-size: 1.25rem;
            font-weight: 600;
            color: #4A2C2A;
            margin: 1.5rem 0 0.5rem;
        }

        p {
            font-size: 1rem;
            color: #4A2C2A;
            margin-bottom: 1rem;
        }

        a {
            color: #4A2C2A;
            text-decoration: none;
            font-weight: 600;
            padding: 0.5rem 1rem;
            border: 1px solid #4A2C2A;
            border-radius: 6px;
            transition: background-color 0.2s, color 0.2s;
        }

        a:hover {
            background-color: #4A2C2A;
            color: #F7C8A5;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 0.5rem;
        }

        table th, table td {
            padding: 0.75rem;
            border: 1px solid #4A2C2A;
            text-align: left;
        }

        table th {
            font-weight: 600;
        }

        /* Responsive */
        @media (max-width: 768px) {
            main {
                margin: 1rem;
                padding: 1rem;
            }

            h1 {
                font-size: 1.25rem;
            }

            h3 {
                font-size: 1rem;
            }

            table {
                font-size: 0.9rem;
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
    <% User user = (User) session.getAttribute("user"); %>
    <% if (user != null) { %>
    <h1>Welcome, <%= user.getName() %>!</h1>
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
    <h1>Please Log In</h1>
    <p><a href="login">Go to Login</a></p>
    <% } %>
</main>
</body>
</html>