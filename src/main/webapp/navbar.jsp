<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="UserManage.User" %>
<%@taglib prefix="c" uri="jakarta.tags.core" %>

<nav class="navbar">
    <div class="navbar-brand">
        <a href="${pageContext.request.contextPath}">
            <i class="fas fa-chalkboard-teacher"></i>
            <span>Home Tutor</span>
        </a>
    </div>

    <div class="navbar-links">
        <c:choose>
            <c:when test="${empty sessionScope.user}">
                <a href="${pageContext.request.contextPath}/auth/login.jsp" class="nav-link">Login</a>
                <a href="${pageContext.request.contextPath}/auth/register.jsp" class="nav-link">Register</a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/user/dashboard.jsp" class="nav-link">Dashboard</a>
                <a href="${pageContext.request.contextPath}/profile" class="nav-link">Profile</a>

                <c:if test="${sessionScope.user.role eq 'admin'}">
                    <a href="${pageContext.request.contextPath}/admin/viewUsers" class="nav-link">View Users</a>
                </c:if>

                <div class="dropdown">
                    <button class="dropdown-btn">
                        <i class="fas fa-user-circle"></i>
                            ${sessionScope.user.name}
                        <i class="fas fa-caret-down"></i>
                    </button>
                    <div class="dropdown-content">
                        <a href="${pageContext.request.contextPath}/user/profile.jsp">Settings</a>
                        <a href="${pageContext.request.contextPath}/user/delete.jsp">Delete Account</a>
                        <a href="${pageContext.request.contextPath}/logout">Logout</a>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <button class="navbar-toggle">
        <i class="fas fa-bars"></i>
    </button>
</nav>

<script>
    // Mobile menu toggle
    document.querySelector('.navbar-toggle').addEventListener('click', function() {
        document.querySelector('.navbar-links').classList.toggle('active');
    });

    // Dropdown functionality
    document.querySelectorAll('.dropdown-btn').forEach(btn => {
        btn.addEventListener('click', function() {
            this.nextElementSibling.classList.toggle('show');
        });
    });
</script>