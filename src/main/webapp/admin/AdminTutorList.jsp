<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
  <title>Admin - Manage Tutors</title>
  <style>
    /* General Reset and Font */
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Segoe UI', Arial, sans-serif;
    }

    /* Body Styling with Blue Theme */
    body {
      background-color: #e8f0fe; /* Light blue background */
      color: #1e3a8a; /* Dark blue text */
      line-height: 1.6;
      padding: 20px;
    }

    /* Headings */
    h1 {
      color: #1e40af; /* Darker blue for headings */
      text-align: center;
      margin-bottom: 20px;
      font-size: 2.2em;
    }

    /* Paragraphs and Links */
    p {
      margin-bottom: 10px;
      font-size: 1.1em;
    }

    a {
      color: #1d4ed8; /* Blue for links */
      text-decoration: none;
      transition: color 0.3s ease;
    }

    a:hover {
      color: #60a5fa; /* Lighter blue on hover */
    }

    /* Table Styling */
    table {
      width: 100%;
      max-width: 800px;
      margin: 20px auto;
      border-collapse: collapse;
      background-color: #ffffff;
      box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    }

    th, td {
      padding: 12px;
      text-align: left;
      border-bottom: 1px solid #bfdbfe; /* Light blue border */
    }

    th {
      background-color: #3b82f6; /* Medium blue header */
      color: white;
    }

    tr:nth-child(even) {
      background-color: #f0f9ff; /* Light blue for alternate rows */
    }

    tr:hover {
      background-color: #dbeafe; /* Slightly darker blue on hover */
    }

    /* Error and Confirmation Messages */
    p[style*="color: red"] {
      background-color: #fee2e2; /* Light red background */
      padding: 10px;
      border-radius: 4px;
      text-align: center;
    }

    p[style*="color: green"] {
      background-color: #dcfce7; /* Light green background */
      padding: 10px;
      border-radius: 4px;
      text-align: center;
    }

    /* Responsive Design */
    @media (max-width: 600px) {
      table {
        font-size: 0.9em;
      }
    }
  </style>
</head>
<body>
<h1>Manage Tutors</h1>

<c:if test="${not empty error}">
  <p style="color: red;">${error}</p>
</c:if>
<c:if test="${not empty message}">
  <p style="color: green;">${message}</p>
</c:if>

<c:choose>
  <c:when test="${empty tutorList}">
    <p>No tutor profiles available.</p>
  </c:when>
  <c:otherwise>
    <table border="1">
      <tr>
        <th>Name</th>
        <th>Subject</th>
        <th>Location</th>
        <th>Actions</th>
      </tr>
      <c:forEach var="tutor" items="${tutorList}">
        <tr>
          <td>${tutor.name}</td>
          <td>${tutor.subject}</td>
          <td>${tutor.location}</td>
          <td>
            <a href="tutorController?action=editForm&id=${tutor.id}">Edit</a> |
            <a href="tutorController?action=delete&id=${tutor.id}"
               onclick="return confirm('Are you sure you want to delete this tutor?');">Delete</a>
          </td>
        </tr>
      </c:forEach>
    </table>
  </c:otherwise>
</c:choose>

<a href="tutorController?action=list">Back to Tutor List</a>
</body>
</html>