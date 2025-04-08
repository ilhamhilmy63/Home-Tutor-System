<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="HomeTutorSearchingSystem.Tutor, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Tutor List</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<jsp:include page="../includes/header.jsp"/>

<div class="container">
    <h2>Available Tutors</h2>

    <div class="search-box">
        <form action="tutor/list.jsp" method="get">
            <input type="text" name="subject" placeholder="Search by subject">
            <button type="submit" class="btn">Search</button>
        </form>
    </div>

    <%
        String subjectFilter = request.getParameter("subject");
        List<Tutor> tutors = UserManagement.getAllTutorsSortedBySubject();
    %>

    <table class="tutor-table">
        <thead>
        <tr>
            <th>Name</th>
            <th>Primary Subject</th>
            <th>Hourly Rate</th>
            <th>Qualifications</th>
        </tr>
        </thead>
        <tbody>
        <% for(Tutor tutor : tutors) {
            if(subjectFilter == null ||
                    tutor.getPrimarySubject().equalsIgnoreCase(subjectFilter)) { %>
        <tr>
            <td><%= tutor.getName() %></td>
            <td><%= tutor.getPrimarySubject() %></td>
            <td>$<%= String.format("%.2f", tutor.getHourlyRate()) %></td>
            <td><%= tutor.getQualification() %></td>
        </tr>
        <% }
        } %>
        </tbody>
    </table>
</div>
</body>
</html>