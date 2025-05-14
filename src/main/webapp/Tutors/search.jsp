<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Find Tutors - HomeTutor.lk</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}src/main/webapp/Tutors/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}src/main/webapp/Tutors/Tutor.css">
</head>
<body>
<header class="header">
    <div class="container">
        <div class="nav">
            <div class="logo">HomeTutor.lk</div>
            <a href="${pageContext.request.contextPath}/tutors/profile" class="btn">My Profile</a>
        </div>
    </div>
</header>

<main class="container">
    <div class="card">
        <h1>Find Your Perfect Tutor</h1>

        <div class="search-filters">
            <div class="filter-group">
                <label for="subject">Subject</label>
                <select id="subject" class="form-control">
                    <option value="">All Subjects</option>
                    <!-- Subjects will be populated from the Subject class -->
                    <option value="math">Mathematics</option>
                    <option value="science">Science</option>
                    <option value="english">English</option>
                </select>
            </div>

            <div class="filter-group">
                <label for="location">Location</label>
                <input type="text" id="location" class="form-control" placeholder="Enter location">
            </div>

            <div class="filter-group">
                <label for="availability">Availability</label>
                <select id="availability" class="form-control">
                    <option value="">Any Time</option>
                    <option value="morning">Morning</option>
                    <option value="afternoon">Afternoon</option>
                    <option value="evening">Evening</option>
                </select>
            </div>

            <div class="filter-group">
                <label for="rating">Minimum Rating</label>
                <select id="rating" class="form-control">
                    <option value="0">Any Rating</option>
                    <option value="3">3+ Stars</option>
                    <option value="4">4+ Stars</option>
                    <option value="5">5 Stars</option>
                </select>
            </div>
        </div>

        <button id="search-btn" class="btn">Search Tutors</button>
    </div>

    <div class="card" id="results-container">
        <h2>Available Tutors</h2>

        <!-- Tutor list will be populated by SearchService -->
        <div class="tutor-card">
            <img src="${pageContext.request.contextPath}/images/tutor1.jpg" alt="Tutor" class="tutor-avatar">
            <div class="tutor-info">
                <h3 class="tutor-name">John Smith</h3>
                <div class="tutor-subjects">Mathematics, Physics</div>
                <div class="tutor-rating">★★★★☆ (4.2)</div>
                <div class="tutor-location">Colombo</div>
                <div class="tutor-bio">Experienced math tutor with 5 years of teaching high school students...</div>
                <a href="${pageContext.request.contextPath}/tutors/profile?id=1" class="btn">View Profile</a>
            </div>
        </div>

        <div class="tutor-card">
            <img src="${pageContext.request.contextPath}/images/tutor2.jpg" alt="Tutor" class="tutor-avatar">
            <div class="tutor-info">
                <h3 class="tutor-name">Sarah Johnson</h3>
                <div class="tutor-subjects">English, Literature</div>
                <div class="tutor-rating">★★★★★ (4.9)</div>
                <div class="tutor-location">Kandy</div>
                <div class="tutor-bio">English literature specialist with a passion for helping students improve their writing skills...</div>
                <a href="${pageContext.request.contextPath}/tutors/profile?id=2" class="btn">View Profile</a>
            </div>
        </div>
    </div>
</main>

<script src="${pageContext.request.contextPath}/js/tutor.js"></script>
</body>
</html>