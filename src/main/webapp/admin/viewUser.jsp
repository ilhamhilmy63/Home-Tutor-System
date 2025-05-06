<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../common.jsp" %>
<%@page import="UserManage.User, java.util.List" %>

<%
    User currentUser = (User) session.getAttribute("user");
    if(currentUser == null || !currentUser.getRole().equalsIgnoreCase("admin")) {
        response.sendRedirect(request.getContextPath() + "/auth/login.jsp");
        return;
    }

    List<User> users = (List<User>) request.getAttribute("users");
%>

<c:set var="content" value="admin/viewUsers-content.jsp" />
<c:set var="title" value="View Users" />

<jsp:include page="../template.jsp" />
<div class="admin-container">
    <h1>User Management</h1>

    <table class="user-table">
        <thead>
        <tr>
            <th>Name</th>
            <th>Email</th>
            <th>Role</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <% for(User user : users) { %>
        <tr>
            <td><%= user.getName() %></td>
            <td><%= user.getEmail() %></td>
            <td><span class="role-badge <%= user.getRole().toLowerCase() %>">
                        <%= user.getRole() %>
                    </span></td>
            <td>
                <a href="#" class="btn-action edit">Edit</a>
                <% if(!user.getEmail().equals(currentUser.getEmail())) { %>
                <a href="${pageContext.request.contextPath}/admin/deleteUser?email=<%= user.getEmail() %>"
                   class="btn-action delete">Delete</a>
                <% } %>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>