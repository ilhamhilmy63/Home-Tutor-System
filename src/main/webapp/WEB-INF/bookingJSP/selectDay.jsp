<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.models.Tutor" %>
<%@ page import="com.example.modules.TutorManagement.TutorRepository" %>
<html>
<head>
    <title>Select Day</title>
</head>
<body>
<h2>Select Day</h2>
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
<p>Booking for Tutor: <%= tutor != null ? tutor.getName() : "Unknown" %> (Subject: <%= subject %>)</p>
<% if (request.getAttribute("error") != null) { %>
<p style="color:red;"><%= request.getAttribute("error") %></p>
<% } %>
<% List<String> days = (List<String>) request.getAttribute("days"); %>
<% if (days.isEmpty()) { %>
<p>No available days for this tutor. Please ask the tutor to update their schedule.</p>
<a href="book-tutor?step=selectTutor&subject=<%= request.getAttribute("subject") %>">Back to Tutor Selection</a>
<% } else { %>
<form action="book-tutor" method="get">
    <input type="hidden" name="step" value="selectTimeSlot">
    <input type="hidden" name="tutorId" value="<%= tutorId %>">
    <input type="hidden" name="subject" value="<%= subject %>">
    <label for="day">Day:</label><br>
    <select id="day" name="day" required>
        <% for (String day : days) { %>
        <option value="<%= day %>"><%= day %></option>
        <% } %>
    </select><br><br>
    <input type="submit" value="Next">
</form>
<% } %>
<a href="book-tutor?step=selectTutor&subject=<%= subject %>">Back to Tutor Selection</a>
</body>
</html>