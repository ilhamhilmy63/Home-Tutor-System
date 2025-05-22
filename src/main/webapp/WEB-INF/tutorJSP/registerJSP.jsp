<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Tutor Registration</title>
</head>
<body>
<h2>Tutor Registration</h2>
<% if (request.getAttribute("error") != null) { %>
<p style="color:red;"><%= request.getAttribute("error") %></p>
<% } %>
<form action="tutor-register" method="post">
    <label for="name">Name:</label><br>
    <input type="text" id="name" name="name" required><br>
    <label for="email">Email:</label><br>
    <input type="email" id="email" name="email" required><br>
    <label for="password">Password:</label><br>
    <input type="password" id="password" name="password" required><br>
    <label for="subject">Subject:</label><br>
    <select id="subject" name="subject" required>
        <option value="Physics">Physics</option>
        <option value="Chemistry">Chemistry</option>
        <option value="Maths">Maths</option>
        <option value="IT">IT</option>
        <option value="Biology">Biology</option>
    </select><br><br>
    <label>Available Days:</label><br>
    <input type="checkbox" id="monday" name="days" value="Monday">
    <label for="monday">Monday</label>
    <input type="checkbox" id="tuesday" name="days" value="Tuesday">
    <label for="tuesday">Tuesday</label>
    <input type="checkbox" id="wednesday" name="days" value="Wednesday">
    <label for="wednesday">Wednesday</label>
    <input type="checkbox" id="thursday" name="days" value="Thursday">
    <label for="thursday">Thursday</label>
    <input type="checkbox" id="friday" name="days" value="Friday">
    <label for="friday">Friday</label>
    <input type="checkbox" id="saturday" name="days" value="Saturday">
    <label for="saturday">Saturday</label><br><br>
    <label>Available Time Slots:</label><br>
    <input type="checkbox" id="slot1" name="timeSlots" value="8:00am-10:00am">
    <label for="slot1">8:00am-10:00am</label>
    <input type="checkbox" id="slot2" name="timeSlots" value="10:00am-12:00pm">
    <label for="slot2">10:00am-12:00pm</label>
    <input type="checkbox" id="slot3" name="timeSlots" value="2:00pm-4:00pm">
    <label for="slot3">2:00pm-4:00pm</label>
    <input type="checkbox" id="slot4" name="timeSlots" value="4:00pm-6:00pm">
    <label for="slot4">4:00pm-6:00pm</label><br><br>
    <input type="submit" value="Register">
</form>
<p>Already have an account? <a href="tutor-login">Login here</a></p>
</body>
</html>