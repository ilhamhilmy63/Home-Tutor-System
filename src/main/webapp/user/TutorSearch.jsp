<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Search for Tutors</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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

        h2 {
            color: #2563eb; /* Medium blue for subheadings */
            margin-top: 20px;
            margin-bottom: 15px;
            font-size: 1.6em;
        }

        h3 {
            color: #3b82f6; /* Medium blue for tutor names */
            margin-bottom: 10px;
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

        /* Form and Button Styling */
        form {
            background-color: #ffffff; /* White background for forms */
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            margin: 20px auto;
        }

        .form-control {
            border: 1px solid #93c5fd; /* Light blue border */
            background-color: #f0f9ff; /* Very light blue input background */
        }

        .btn-primary {
            background-color: #2563eb; /* Blue background for buttons */
            border: none;
            border-radius: 4px;
            transition: background-color 0.3s ease;
        }

        .btn-primary:hover {
            background-color: #1e40af; /* Darker blue on hover */
        }

        /* List Styling */
        ul {
            list-style: none;
            padding: 0;
        }

        ul li {
            background-color: #ffffff;
            padding: 15px;
            margin-bottom: 10px;
            border-radius: 8px;
            box-shadow: 0 1px 4px rgba(0, 0, 0, 0.1);
        }

        /* Responsive Design */
        @media (max-width: 600px) {
            form {
                padding: 15px;
            }

            .btn-primary {
                width: 100%;
            }
        }
    </style>
</head>
<body>
<h1>Search for Tutors</h1>

<form action="${pageContext.request.contextPath}/Tutors/TutorList.jsp" method="post" class="card shadow">
    <div class="card-body">
        <div class="mb-3">
            <input type="text" name="keyword" placeholder="Enter subject or name" value="${searchKeyword}" class="form-control">
        </div>
        <div class="mb-3">
            <input type="text" name="location" placeholder="Enter location" value="${searchLocation}" class="form-control">
        </div>
        <div class="mb-3">
            <label for="expertise" class="form-label">Expertise</label>
            <select name="expertise" id="expertise" class="form-control">
                <option value="">Any</option>
                <option value="Basic" ${searchExpertise == 'Basic' ? 'selected' : ''}>Basic</option>
                <option value="Intermediate" ${searchExpertise == 'Intermediate' ? 'selected' : ''}>Intermediate</option>
                <option value="Expert" ${searchExpertise == 'Expert' ? 'selected' : ''}>Expert</option>
            </select>
        </div>
        <div class="d-grid">
            <input type="submit" value="Search" class="btn btn-primary">
        </div>
    </div>
</form>


<a href="${pageContext.request.contextPath}/Tutors/TutorList.jsp">View All Tutors</a>

<script>
    // Sort search results by subject in the frontend
    document.addEventListener('DOMContentLoaded', () => {
        const searchResults = document.getElementById('searchResults');
        if (searchResults) {
            const results = Array.from(searchResults.children);
            results.sort((a, b) => {
                const subjectA = a.querySelector('p:nth-child(2)').textContent.split(': ')[1];
                const subjectB = b.querySelector('p:nth-child(2)').textContent.split(': ')[1];
                return subjectA.localeCompare(subjectB);
            });
            searchResults.innerHTML = '';
            results.forEach(result => searchResults.appendChild(result));
        }
    });
</script>
</body>
</html>