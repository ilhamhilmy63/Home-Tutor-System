<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="UserManage.User, UserManage.Tutor" %>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<jsp:include page="../includes/header.jsp"/>

<div class="container">
    <h2>Welcome, ${user.name}</h2>

    <% if(user instanceof Tutor) { %>
    <div class="alert info">
        Your Subjects: ${tutor.primarySubject} <br>
        Hourly Rate: $${tutor.hourlyRate}
    </div>
    <% } %>

    <div class="actions">
        <a href="profile.jsp" class="btn">Update Profile</a>
        <a href="delete.jsp" class="btn danger">Delete Account</a>
        <% if(user instanceof Tutor) { %>
        <a href="../tutor/list.jsp" class="btn">View All Tutors</a>
        <% } %>
    </div>
</div>
</body>
</html>
