<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="UserManage.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>Profile Management</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<jsp:include page="../includes/header.jsp"/>

<div class="container">
    <h2>Profile Settings</h2>

    <% if(request.getParameter("error") != null) { %>
    <div class="alert error"><%= request.getParameter("error") %></div>
    <% } %>
    <% if(request.getParameter("success") != null) { %>
    <div class="alert success"><%= request.getParameter("success") %></div>
    <% } %>

    <div class="profile-info">
        <p><strong>Name:</strong> ${user.name}</p>
        <p><strong>Email:</strong> ${user.email}</p>
        <p><strong>Phone:</strong> ${user.phone}</p>
        <% if(user instanceof UserManage.Tutor) { %>
        <p><strong>Primary Subject:</strong> ${tutor.primarySubject}</p>
        <p><strong>Hourly Rate:</strong> $${tutor.hourlyRate}</p>
        <% } %>
    </div>

    <form action="profile" method="post">
        <h3>Change Password</h3>
        <input type="password" name="newPassword" placeholder="New Password" required>
        <button type="submit" class="btn">Update Password</button>
    </form>
</div>
</body>
</html>