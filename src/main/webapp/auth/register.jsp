<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="container">
    <h2>Register</h2>
    <% if(request.getParameter("error") != null) { %>
    <div class="alert error"><%= request.getParameter("error") %></div>
    <% } %>

    <form action="register" method="post">
        <input type="text" name="name" placeholder="Name" required>
        <input type="email" name="email" placeholder="Email" required>
        <input type="text" name="phone" placeholder="Phone" required>
        <input type="password" name="password" placeholder="Password" required>

        <select name="role" id="role" onchange="showTutorFields()">
            <option value="student">Student</option>
            <option value="tutor">Tutor</option>
        </select>

        <div id="tutor-fields" style="display:none;">
            <input type="text" name="primarySubject" placeholder="Primary Subject">
            <input type="number" step="0.01" name="hourlyRate" placeholder="Hourly Rate">
        </div>

        <button type="submit">Register</button>
    </form>
    <p>Already have an account? <a href="login.jsp">Login here</a></p>
</div>

<script>
    function showTutorFields() {
        const role = document.getElementById('role').value;
        document.getElementById('tutor-fields').style.display =
            role === 'tutor' ? 'block' : 'none';
    }
</script>
</body>
</html>
