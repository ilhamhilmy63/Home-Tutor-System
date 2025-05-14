<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, TutorSearchAndProfileManagement.Tutor" %>
<!DOCTYPE html>
<html>
<head>
    <title>Tutor Search</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h2 class="mb-4">Search for Tutors</h2>

    <form class="row g-3 mb-4" method="GET" action="">
        <div class="col-md-9">
            <input type="text" class="form-control" name="keyword" placeholder="Enter subject, name, or location" />
        </div>
        <div class="col-md-3">
            <button type="submit" class="btn btn-primary w-100">Search</button>
        </div>
    </form>

    <h4>Search Results</h4>
    <table class="table table-striped table-bordered">
        <thead class="table-dark">
        <tr>
            <th>Name</th>
            <th>Subjects</th>
            <th>Location</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<Tutor> results = (List<Tutor>) request.getAttribute("results");
            if (results != null && !results.isEmpty()) {
                for (Tutor tutor : results) {
        %>
        <tr>
            <td><%= tutor.getName() %></td>
            <td><%= tutor.getSubject() %></td>
            <td><%= tutor.getLocation() %></td>
            <td>
                <a href="profile?id=<%= tutor.getId() %>" class="btn btn-sm btn-info">View Profile</a>
            </td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="4" class="text-center">No tutors found.</td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>
</body>
</html>
