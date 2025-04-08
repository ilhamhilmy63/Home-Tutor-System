<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="container">
    <h2>Login</h2>
    <% if(request.getParameter("error") != null) { %>
    <div class="alert error"><%= request.getParameter("error") %></div>
    <% } %>
    <% if(request.getParameter("success") != null) { %>
    <div class="alert success"><%= request.getParameter("success") %></div>
    <% } %>

    <form action="login" method="post">
        <input type="email" name="email" placeholder="Email" required>
        <input type="password" name="password" placeholder="Password" required>
        <button type="submit">Login</button>
    </form>
    <p>Don't have an account? <a href="register.jsp">Register here</a></p>
</div>
</body>
</html>