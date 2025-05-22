<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Tutor Search Results</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Same styling as TutorSearch.jsp */
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
        .tutor-card {
            background-color: white;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 15px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .tutor-name {
            color: #2563eb;
            font-size: 1.4em;
            margin-bottom: 10px;
        }
        .search-info {
            margin-bottom: 20px;
            text-align: center;
            font-style: italic;
        }
    </style>
</head>
<body>
<h1>Tutor Search Results</h1>

<div class="search-info">
    <c:if test="${not empty searchKeyword}">
        Searching for: "${searchKeyword}"
    </c:if>
    <c:if test="${not empty searchLocation}">
        in ${searchLocation}
    </c:if>
    <c:if test="${not empty searchExpertise}">
        with ${searchExpertise} expertise
    </c:if>
</div>

<c:choose>
    <c:when test="${not empty tutorList && !tutorList.isEmpty()}">
        <div id="searchResults">
            <c:forEach var="tutor" items="${tutorList}">
                <div class="tutor-card">
                    <h3 class="tutor-name">${tutor.name}</h3>
                    <p><strong>Subject:</strong> ${tutor.subject}</p>
                    <p><strong>Location:</strong> ${tutor.location}</p>
                    <p><strong>Expertise:</strong> ${tutor.expertise}</p>
                    <p><strong>Bio:</strong> ${tutor.bio}</p>
                    <a href="${pageContext.request.contextPath}/TutorProfile?id=${tutor.id}" class="btn btn-primary">
                        View Profile
                    </a>
                </div>
            </c:forEach>
        </div>
    </c:when>
    <c:otherwise>
        <div class="alert alert-info">
            No tutors found matching your search criteria.
        </div>
    </c:otherwise>
</c:choose>

<a href="${pageContext.request.contextPath}/TutorSearch.jsp" class="btn btn-secondary">
    Back to Search
</a>
</body>
</html>