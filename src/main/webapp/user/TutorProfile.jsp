<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Tutor Profile</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #4361ee;
            --secondary-color: #3f37c9;
            --light-color: #f8f9fa;
            --dark-color: #212529;
            --success-color: #4bb543;
            --error-color: #ff3333;
            --border-radius: 8px;
            --box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background-color: #f5f7ff;
            color: var(--dark-color);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 1.5rem 0;
            text-align: center;
            margin-bottom: 2rem;
            box-shadow: var(--box-shadow);
        }

        .container {
            max-width: 800px;
            margin: 0 auto 3rem;
            padding: 0 1rem;
            flex: 1;
        }

        .profile-card {
            background-color: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            padding: 2rem;
            margin-bottom: 2rem;
        }

        .profile-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .profile-header h1 {
            color: var(--primary-color);
            font-size: 2rem;
            margin-bottom: 0.5rem;
        }

        .profile-header p {
            color: #666;
        }

        .profile-section {
            margin-bottom: 1.5rem;
        }

        .profile-section h2 {
            color: var(--primary-color);
            font-size: 1.3rem;
            margin-bottom: 1rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid #eee;
        }

        .profile-details {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1.5rem;
        }

        .detail-item {
            margin-bottom: 1rem;
        }

        .detail-item strong {
            display: block;
            color: #555;
            margin-bottom: 0.3rem;
            font-weight: 500;
        }

        .detail-item p {
            color: var(--dark-color);
        }

        .availability-list {
            list-style: none;
        }

        .availability-list li {
            padding: 0.5rem 0;
            border-bottom: 1px solid #eee;
            display: flex;
            justify-content: space-between;
        }

        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 1rem;
            margin-top: 2rem;
        }

        .btn {
            background-color: var(--primary-color);
            color: white;
            border: none;
            padding: 0.8rem 1.5rem;
            border-radius: var(--border-radius);
            font-size: 1rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .btn:hover {
            background-color: var(--secondary-color);
            transform: translateY(-2px);
        }

        .btn-outline {
            background-color: transparent;
            border: 2px solid var(--primary-color);
            color: var(--primary-color);
        }

        .btn-outline:hover {
            background-color: var(--primary-color);
            color: white;
        }

        .message {
            padding: 1rem;
            border-radius: var(--border-radius);
            margin-bottom: 1.5rem;
            text-align: center;
        }

        .error {
            background-color: #ffebee;
            color: var(--error-color);
            border: 1px solid #ffcdd2;
        }

        @media (max-width: 768px) {
            .profile-details {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<div class="header">
    <h1>Tutor Profile</h1>
</div>

<div class="container">
    <c:choose>
        <c:when test="${not empty sessionScope.tutor}">
            <div class="profile-card">
                <div class="profile-header">
                    <h1>${sessionScope.tutor.name}</h1>
                    <p>${sessionScope.tutor.subject} Tutor</p>
                </div>

                <div class="profile-section">
                    <h2>Personal Information</h2>
                    <div class="profile-details">
                        <div class="detail-item">
                            <strong>Tutor ID</strong>
                            <p>${sessionScope.tutor.id}</p>
                        </div>
                        <div class="detail-item">
                            <strong>Email</strong>
                            <p>${sessionScope.tutor.email}</p>
                        </div>
                        <div class="detail-item">
                            <strong>Phone</strong>
                            <p>${sessionScope.tutor.phone}</p>
                        </div>
                        <div class="detail-item">
                            <strong>Location</strong>
                            <p>${sessionScope.tutor.location}</p>
                        </div>
                        <div class="detail-item">
                            <strong>Expertise Level</strong>
                            <p>${sessionScope.tutor.expertise}</p>
                        </div>
                    </div>
                </div>

                <div class="profile-section">
                    <h2>About Me</h2>
                    <p>${sessionScope.tutor.bio}</p>
                </div>

                <div class="profile-section">
                    <h2>Availability</h2>
                    <ul class="availability-list">
                        <c:forEach var="slot" items="${availabilityList}">
                            <li>
                                <span>${slot.day}</span>
                                <span>${slot.start} - ${slot.end}</span>
                            </li>
                        </c:forEach>
                    </ul>
                </div>

                <div class="action-buttons">
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline">Logout</a>
                    <c:if test="${not empty sessionScope.tutor && sessionScope.tutor.id == tutor.id}">
                        <a href="${pageContext.request.contextPath}/TutorProfile?id=${tutor.id}&edit=true" class="btn">Edit Profile</a>
                    </c:if>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="message error">
                Error: Tutor information not available. Please <a href="${pageContext.request.contextPath}/Tutors/TutorLogin.jsp">log in</a> again.
            </div>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>