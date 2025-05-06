<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../common.jsp" %>
<%@page import="UserManage.User" %>

<%
    User user = (User) session.getAttribute("user");
    if(user == null) {
        response.sendRedirect(request.getContextPath() + "/auth/login.jsp");
        return;
    }
%>

<c:set var="content" value="user/delete-content.jsp" />
<c:set var="title" value="Delete Account" />

<jsp:include page="../template.jsp" />
<div class="delete-container">
    <div class="delete-card">
        <div class="delete-header">
            <h2>Delete Account</h2>
            <p>This action cannot be undone</p>
        </div>

        <form action="${pageContext.request.contextPath}/delete-account" method="POST">
            <div class="form-group">
                <label for="password">Enter your password to confirm</label>
                <input type="password" id="password" name="password" required>
            </div>

            <div class="form-actions">
                <a href="dashboard.jsp" class="btn btn-secondary">Cancel</a>
                <button type="submit" class="btn btn-danger">Delete Account</button>
            </div>
        </form>
    </div>
</div>