<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Map" %>
<html>
<head>
    <title>Booking Details</title>
</head>
<body>
<h2>Booking Details</h2>
<% if (request.getAttribute("error") != null) { %>
<p style="color:red;"><%= request.getAttribute("error") %></p>
<% } else { %>
<% Map<String, String> details = (Map<String, String>) request.getAttribute("bookingDetails"); %>
<p><strong>Student Name:</strong> <%= details.get("studentName") %></p>
<p><strong>Student Email:</strong> <%= details.get("studentEmail") %></p>
<p><strong>Subject:</strong> <%= details.get("subject") %></p>
<p><strong>Day:</strong> <%= details.get("day") %></p>
<p><strong>Time Slot:</strong> <%= details.get("timeSlot") %></p>
<p><strong>Status:</strong> <%= details.get("status") %></p>
<% } %>
<a href="tutor-home">Back to Dashboard</a>
</body>
</html>