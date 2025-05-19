<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Tutor List (Admin View)</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h2 class="mb-4">All Tutors</h2>
    <table class="table table-striped table-bordered">
        <thead class="table-light">
        <tr>
            <th>Name</th>
            <th>Subjects</th>
            <th>Location</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<Map<String, String>> tutorList = (List<Map<String, String>>) request.getAttribute("tutorList");
            if (tutorList != null && !tutorList.isEmpty()) {
                for (Map<String, String> tutor : tutorList) {
                    String id = tutor.get("id"); // assumes "id" key exists
                    String name = tutor.get("name");
                    String subjects = tutor.get("subjects");
                    String location = tutor.get("location");
        %>
        <tr>
            <td><%= name %></td>
            <td><%= subjects %></td>
            <td><%= location %></td>
            <td>
                <a href="/view?id=<%= id %>" class="btn btn-sm btn-info">View</a>
                <a href="/edit?id=<%= id %>" class="btn btn-sm btn-warning">Edit</a>
                <a href="/delete?id=<%= id %>" class="btn btn-sm btn-danger">Delete</a>
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
