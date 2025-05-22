<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.models.Tutor" %>
<%@ page import="com.example.modules.TutorManagement.TutorRepository" %>
<html>
<head>
    <title>Select Day</title>
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

        .booking-info {
            font-size: 1rem;
            color: #666;
            margin-bottom: 1.5rem;
            text-align: left;
            padding: 0.5rem;
            background-color: #f8f9fa;
            border-radius: 4px;
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 1rem;
            text-align: left;
        }

        label {
            font-size: 1rem;
            color: #666;
        }

        select {
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

        a {
            color: #6B46C1;
            text-decoration: none;
            font-weight: 600;
        }

        a:hover {
            text-decoration: underline;
        }

        .back-link {
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

        .error-message {
            color: #D77A61;
            margin-bottom: 1rem;
        }

        .no-days {
            color: #666;
            margin-bottom: 1rem;
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

    <h3>Select Day</h3>
    <%
        String tutorId = request.getParameter("tutorId");
        String subject = request.getParameter("subject");
        TutorRepository tutorRepository = new TutorRepository();
        Tutor tutor = null;
        try {
            tutor = tutorRepository.getAllTutors().stream()
                    .filter(t -> t.getId().equals(tutorId))
                    .findFirst()
                    .orElse(null);
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
    <div class="booking-info">
        Booking for Tutor: <%= tutor != null ? tutor.getName() : "Unknown" %><br>
        Subject: <%= subject %>
    </div>

    <% if (request.getAttribute("error") != null) { %>
    <p class="error-message"><%= request.getAttribute("error") %></p>
    <% } %>

    <% List<String> days = (List<String>) request.getAttribute("days"); %>
    <% if (days.isEmpty()) { %>
    <p class="no-days">No available days for this tutor. Please ask the tutor to update their schedule.</p>
    <div class="back-link">
        <a href="book-tutor?step=selectTutor&subject=<%= subject %>">Back to Tutor Selection</a>
    </div>
    <% } else { %>
    <form action="book-tutor" method="get">
        <input type="hidden" name="step" value="selectTimeSlot">
        <input type="hidden" name="tutorId" value="<%= tutorId %>">
        <input type="hidden" name="subject" value="<%= subject %>">
        <label for="day">Day:</label>
        <select id="day" name="day" required>
            <% for (String day : days) { %>
            <option value="<%= day %>"><%= day %></option>
            <% } %>
        </select>
        <input type="submit" value="Next">
    </form>
    <div class="back-link">
        <a href="book-tutor?step=selectTutor&subject=<%= subject %>">Back to Tutor Selection</a>
    </div>
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