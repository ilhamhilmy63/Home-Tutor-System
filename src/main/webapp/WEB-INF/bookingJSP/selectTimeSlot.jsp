<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<html>
<head>
    <title>Select Time Slot</title>
</head>
<body>
<h2>Select Time Slot</h2>
<% if (request.getAttribute("error") != null) { %>
<p style="color:red;"><%= request.getAttribute("error") %></p>
<% } %>
<% List<String> timeSlots = (List<String>) request.getAttribute("timeSlots"); %>
<% if (timeSlots.isEmpty()) { %>
<p>No available time slots for this day.</p>
<a href="book-tutor?step=selectDay&tutorId=<%= request.getAttribute("tutorId") %>&subject=<%= request.getAttribute("subject") %>">Back to Day Selection</a>
<% } else { %>
<form action="book-tutor" method="post">
    <input type="hidden" name="tutorId" value="<%= request.getAttribute("tutorId") %>">
    <input type="hidden" name="subject" value="<%= request.getAttribute("subject") %>">
    <input type="hidden" name="day" value="<%= request.getAttribute("day") %>">
    <label for="timeSlot">Time Slot:</label><br>
    <select id="timeSlot" name="timeSlot" required>
        <% for (String timeSlot : timeSlots) { %>
        <option value="<%= timeSlot %>"><%= timeSlot %></option>
        <% } %>
    </select><br><br>
    <input type="submit" value="Book">
</form>
<% } %>
<a href="book-tutor?step=selectDay&tutorId=<%= request.getAttribute("tutorId") %>&subject=<%= request.getAttribute("subject") %>">Back to Day Selection</a>
</body>
</html>