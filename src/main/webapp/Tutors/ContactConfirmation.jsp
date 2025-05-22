<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Contact Confirmation</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Arial, sans-serif;
        }
        body {
            background-color: #e8f0fe;
            color: #1e3a8a;
            line-height: 1.6;
            padding: 20px;
        }
        h1 {
            color: #1e40af;
            text-align: center;
            margin-bottom: 20px;
        }
        p {
            font-size: 1.1em;
            text-align: center;
            margin-bottom: 20px;
        }
        a {
            color: #1d4ed8;
            text-decoration: none;
        }
        a:hover {
            color: #60a5fa;
        }
        .error {
            background-color: #fee2e2;
            color: #dc3545;
            padding: 10px;
            border-radius: 4px;
            text-align: center;
        }
        .confirmation {
            background-color: #dcfce7;
            color: #166534;
            padding: 10px;
            border-radius: 4px;
            text-align: center;
        }
    </style>
</head>
<body>
<h1>Contact Confirmation</h1>

<c:if test="${not empty error}">
    <p class="error">${error}</p>
</c:if>
<c:if test="${not empty confirmation}">
    <p class="confirmation">${confirmation}</p>
</c:if>

<p><a href="${pageContext.request.contextPath}/tutorController?action=list">Back to Tutor List</a></p>
</body>
</html>