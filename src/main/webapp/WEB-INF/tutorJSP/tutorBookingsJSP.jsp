<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, java.util.Map, com.example.models.Booking" %>
<html>
<head>
  <title>Tutor Bookings</title>
</head>
<body>
<h2>Your Bookings</h2>
<!-- Debug Section -->
<div style="border: 1px solid #ccc; padding: 10px; margin-bottom: 20px;">
  <h3>Debug Info</h3>
  <p>Number of bookings: <%= ((List<Booking>) request.getAttribute("tutorBookings")) != null ? ((List<Booking>) request.getAttribute("tutorBookings")).size() : 0 %></p>
  <p>Error attribute: <%= request.getAttribute("error") != null ? request.getAttribute("error") : "None" %></p>
  <p>Student ID to Name map size: <%= ((Map<String, String>) request.getAttribute("studentIdToName")) != null ? ((Map<String, String>) request.getAttribute("studentIdToName")).size() : 0 %></p>
</div>
<% if (request.getAttribute("error") != null) { %>
<p style="color:red;"><%= request.getAttribute("error") %></p>
<% } else { %>
<% List<com.example.models.Booking> bookings = (List<com.example.models.Booking>) request.getAttribute("tutorBookings"); %>
<% Map<String, String> studentIdToName = (Map<String, String>) request.getAttribute("studentIdToName"); %>
<% if (bookings == null || bookings.isEmpty()) { %>
<p>No bookings found.</p>
<% } else { %>
<table border="1">
  <tr>
    <th>Student Name</th>
    <th>Subject</th>
    <th>Day</th>
    <th>Time Slot</th>
    <th>Status</th>
    <th>Details</th>
  </tr>
  <% for (com.example.models.Booking booking : bookings) { %>
  <tr>
    <td><%= studentIdToName.getOrDefault(booking.getStudentId(), "Unknown") %></td>
    <td><%= booking.getSubject() %></td>
    <td><%= booking.getDay() %></td>
    <td><%= booking.getTimeSlot() %></td>
    <td><%= booking.getStatus() %></td>
    <td><a href="tutor-booking-details?bookingId=<%= booking.getId() %>">View Details</a></td>
  </tr>
  <% } %>
</table>
<% } %>
<% } %>
<a href="index.jsp">Back to Dashboard</a>
<a href="tutor-update-profile">Update Details</a>
</body>
</html>