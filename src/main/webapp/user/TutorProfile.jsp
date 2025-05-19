<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, TutorSearchAndProfileManagement.Tutor, TutorSearchAndProfileManagement.TutorAvailability" %>
<!DOCTYPE html>
<html>
<head>
    <title>Tutor Profile</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h2 class="mb-4">Tutor Profile</h2>
    <%
        Tutor tutor = (Tutor) request.getAttribute("tutor");
        List<TutorAvailability> availabilityList = (List<TutorAvailability>) request.getAttribute("availabilityList");
        if (tutor == null) {
    %>
    <div class="alert alert-danger">Tutor not found.</div>
    <%
    } else {
    %>
    <table class="table table-bordered">
        <tr>
            <th>Name</th>
            <td><%= tutor.getName() %></td>
        </tr>
        <tr>
            <th>Subjects</th>
            <td><%= tutor.getSubject() %></td>
        </tr>
        <tr>
            <th>Location</th>
            <td><%= tutor.getLocation() %></td>
        </tr>
        <tr>
            <th>Bio</th>
            <td><%= tutor.getBio() %></td>
        </tr>
        <tr>
            <th>Availability</th>
            <td>
                <table class="table table-sm table-striped mb-0">
                    <thead>
                    <tr>
                        <th>Day</th>
                        <th>Start Time</th>
                        <th>End Time</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        if (availabilityList != null && !availabilityList.isEmpty()) {
                            for (TutorAvailability avail : availabilityList) {
                    %>
                    <tr>
                        <td><%= avail.getDay() %></td>
                        <td><%= avail.getStartTime() %></td>
                        <td><%= avail.getEndTime() %></td>
                    </tr>
                    <%
                        }
                    } else {
                    %>
                    <tr>
                        <td colspan="3">No availability listed.</td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </td>
        </tr>
    </table>
    <a href="contact?id=<%= tutor.getId() %>" class="btn btn-success">Contact Tutor</a>
    <%
        }
    %>
</div>
</body>
</html>
