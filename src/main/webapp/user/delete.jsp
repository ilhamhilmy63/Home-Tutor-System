<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Delete Account</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<jsp:include page="../includes/header.jsp"/>

<div class="container">
    <h2>Account Deletion</h2>

    <% if(request.getParameter("error") != null) { %>
    <div class="alert error"><%= request.getParameter("error") %></div>
    <% } %>

    <div class="warning-box">
        <h3>⚠️ Warning!</h3>
        <p>This action will permanently delete your account and all associated data.</p>
        <p>Are you sure you want to proceed?</p>

        <form action="delete-account" method="post">
            <button type="submit" class="btn danger">Confirm Deletion</button>
            <a href="dashboard.jsp" class="btn">Cancel</a>
        </form>
    </div>
</div>
</body>
</html>
