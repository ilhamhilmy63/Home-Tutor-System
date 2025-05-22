<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.models.Tutor" %>
<%@ page import="java.util.List" %>
<html>
<head>
  <title>Select Tutor</title>
</head>
<body>
<h2>Select Tutor for <%= request.getAttribute("subject") %></h2>
<% if (request.getAttribute("error") != null) { %>
<p style="color:red;"><%= request.getAttribute("error") %></p>
<% } %>
<% List<Tutor> tutors = (List<Tutor>) request.getAttribute("tutors"); %>
<% if (tutors.isEmpty()) { %>
<p>No tutors available for this subject.</p>
<a href="book-tutor?step=selectSubject">Back to Subject Selection</a>
<% } else { %>
<form action="book-tutor" method="get">
  <input type="hidden" name="step" value="selectDay">
  <input type="hidden" name="subject" value="<%= request.getAttribute("subject") %>">
  <label for="tutorId">Tutor:</label><br>
  <select id="tutorId" name="tutorId" required>
    <% for (Tutor tutor : tutors) { %>
    <option value="<%= tutor.getId() %>"><%= tutor.getName() %> (<%= tutor.getEmail() %>)</option>
    <% } %>
  </select><br><br>
  <input type="submit" value="Next">
</form>
<% } %>
<a href="book-tutor?step=selectSubject">Back to Subject Selection</a>
</body>
</html>