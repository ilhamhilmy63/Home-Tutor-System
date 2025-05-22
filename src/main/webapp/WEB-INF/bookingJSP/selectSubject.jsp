<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<html>
<head>
  <title>Select Subject</title>
</head>
<body>
<h2>Select Subject</h2>
<% if (request.getAttribute("error") != null) { %>
<p style="color:red;"><%= request.getAttribute("error") %></p>
<% } %>
<form action="book-tutor" method="get">
  <input type="hidden" name="step" value="selectTutor">
  <label for="subject">Subject:</label><br>
  <select id="subject" name="subject" required>
    <% List<String> subjects = (List<String>) request.getAttribute("subjects"); %>
    <% for (String subject : subjects) { %>
    <option value="<%= subject %>"><%= subject %></option>
    <% } %>
  </select><br><br>
  <input type="submit" value="Next">
</form>
<a href="home">Back to Dashboard</a>
</body>
</html>