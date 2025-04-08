<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="UserManage.User" %>
<%@ page import="UserManage.UserManagement" %>
<% User user = (User) session.getAttribute("user"); %>

<header>
    <nav>
        <div class="logo">
            <a href="${pageContext.request.contextPath}/">HomeTutor</a>
        </div>
        <div class="nav-links">
            <% if(user != null) { %>
            <span>Welcome, <%= user.getName() %></span>
            <a href="user/dashboard.jsp">Dashboard</a>
            <% if(user instanceof UserManage.Tutor) { %>
            <a href="tutor/list.jsp">Browse Tutors</a>
            <% } %>
            <a href="user/profile.jsp">Profile</a>
            <a href="logout">Logout</a>
            <% } else { %>
            <a href="auth/login.jsp">Login</a>
            <a href="auth/register.jsp">Register</a>
            <% } %>
        </div>
    </nav>
</header>