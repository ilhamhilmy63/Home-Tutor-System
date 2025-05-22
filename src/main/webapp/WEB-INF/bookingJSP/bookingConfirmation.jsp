<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Booking Confirmation</title>
</head>
<body>
<h2>Booking Confirmation</h2>
<% if (request.getAttribute("message") != null) { %>
<p style="color:green;"><%= request.getAttribute("message") %></p>
<% } %>
<p>Your booking has been successfully created!</p>
<a href="home">Back to Dashboard</a>
</body>
</html>