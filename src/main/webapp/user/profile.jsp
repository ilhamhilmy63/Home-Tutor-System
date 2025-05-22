<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.model.*" %>
<%
    Student user = (Student) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<html>
<head>
    <title>Profile - hometutor.lk</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
            color: #333;
        }
        .header {
            background-color: #1a73e8;
            color: white;
            padding: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .logo {
            font-size: 24px;
            font-weight: bold;
        }
        .logout-btn {
            background-color: white;
            color: #1a73e8;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
        }
        .container {
            max-width: 800px;
            margin: 30px auto;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 30px;
        }
        h1 {
            color: #1a73e8;
            margin-bottom: 24px;
        }
        .profile-info {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }
        .info-item {
            margin-bottom: 16px;
        }
        .info-label {
            font-weight: 500;
            color: #666;
            margin-bottom: 4px;
        }
        .info-value {
            font-size: 18px;
        }
        .edit-btn {
            background-color: #1a73e8;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 20px;
        }
        .edit-btn:hover {
            background-color: #0d62c9;
        }
    </style>
</head>
<body>
<div class="header">
    <div class="logo">hometutor.lk</div>
    <form action="logout" method="post">
        <button type="submit" class="logout-btn">Logout</button>
    </form>
</div>

<div class="container">
    <h1>Student Profile</h1>

    <div class="profile-info">
        <div class="info-item">
            <div class="info-label">Full Name</div>
            <div class="info-value"><%= user.getFullName() %></div>
        </div>

        <div class="info-item">
            <div class="info-label">Email</div>
            <div class="info-value"><%= user.getEmail() %></div>
        </div>

        <div class="info-item">
            <div class="info-label">Phone Number</div>
            <div class="info-value"><%= user.getPhoneNumber() %></div>
        </div>

        <div class="info-item">
            <div class="info-label">Grade</div>
            <div class="info-value"><%= user.getGrade() %></div>
        </div>

        <div class="info-item">
            <div class="info-label">Module Needed</div>
            <div class="info-value"><%= user.getModule() %></div>
        </div>
    </div>

    <button class="edit-btn" onclick="window.location.href='edit-profile.jsp'">Edit Profile</button>
</div>
</body>
</html>