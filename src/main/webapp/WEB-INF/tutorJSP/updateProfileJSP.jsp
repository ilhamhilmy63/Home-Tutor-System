<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.models.Tutor" %>
<%@ page import="com.example.models.Schedule" %>
<%@ page import="com.example.modules.TutorManagement.ScheduleService" %>
<%@ page import="java.util.List" %>
<html>
<head>
    <title>Update Tutor Profile</title>
</head>
<body>
<h2>Update Profile</h2>
<% if (request.getAttribute("message") != null) { %>
<p style="color:green;"><%= request.getAttribute("message") %></p>
<% } %>
<% if (request.getAttribute("error") != null) { %>
<p style="color:red;"><%= request.getAttribute("error") %></p>
<% } %>
<%
    Tutor tutor = (Tutor) session.getAttribute("tutor");
    ScheduleService scheduleService = new ScheduleService();
    List<Schedule> schedules = scheduleService.getTutorSchedules(tutor.getId());
    String[] days = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};
    String[] timeSlots = {"8:00am-10:00am", "10:00am-12:00pm", "2:00pm-4:00pm", "4:00pm-6:00pm"};
%>
<form action="tutor-update-profile" method="post">
    <label for="name">Name:</label><br>
    <input type="text" id="name" name="name" value="<%= tutor.getName() %>" required><br>
    <label for="email">Email:</label><br>
    <input type="email" id="email" name="email" value="<%= tutor.getEmail() %>" required><br>
    <label for="subject">Subject:</label><br>
    <select id="subject" name="subject" required>
        <option value="Physics" <%= "Physics".equals(tutor.getSubject()) ? "selected" : "" %>>Physics</option>
        <option value="Chemistry" <%= "Chemistry".equals(tutor.getSubject()) ? "selected" : "" %>>Chemistry</option>
        <option value="Maths" <%= "Maths".equals(tutor.getSubject()) ? "selected" : "" %>>Maths</option>
        <option value="IT" <%= "IT".equals(tutor.getSubject()) ? "selected" : "" %>>IT</option>
        <option value="Biology" <%= "Biology".equals(tutor.getSubject()) ? "selected" : "" %>>Biology</option>
    </select><br><br>
    <label>Available Days:</label><br>
    <% for (String day : days) { %>
    <input type="checkbox" id="<%= day.toLowerCase() %>" name="days" value="<%= day %>"
        <%= schedules.stream().anyMatch(s -> s.getDay().equals(day)) ? "checked" : "" %>>
    <label for="<%= day.toLowerCase() %>"><%= day %></label>
    <% } %><br><br>
    <label>Available Time Slots:</label><br>
    <% for (String slot : timeSlots) { %>
    <input type="checkbox" id="<%= slot.replaceAll("[: -]", "") %>" name="timeSlots" value="<%= slot %>"
        <%= schedules.stream().anyMatch(s -> s.getTimeSlot().equals(slot)) ? "checked" : "" %>>
    <label for="<%= slot.replaceAll("[: -]", "") %>"><%= slot %></label>
    <% } %><br><br>
    <input type="submit" value="Update Profile">
</form>
<a href="index.jsp">Back to Dashboard</a>
</body>
</html>