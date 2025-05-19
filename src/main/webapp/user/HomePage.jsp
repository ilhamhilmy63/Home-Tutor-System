<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - HomeTutor.lk</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        :root {
            --primary-color: #2563eb;
            --primary-light: #3b82f6;
            --primary-dark: #1d4ed8;
            --text-color: #1f2937;
            --light-gray: #f3f4f6;
            --medium-gray: #e5e7eb;
            --dark-gray: #6b7280;
            --white: #ffffff;
            --success: #10b981;
            --warning: #f59e0b;
            --danger: #ef4444;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background-color: var(--light-gray);
            color: var(--text-color);
            line-height: 1.6;
        }

        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem 2rem;
            background-color: var(--white);
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .logo {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary-color);
            text-decoration: none;
        }

        .nav-links {
            display: flex;
            gap: 1.5rem;
        }

        .nav-links a {
            color: var(--text-color);
            text-decoration: none;
            font-weight: 500;
            padding: 0.5rem 0;
            position: relative;
            transition: color 0.3s;
        }

        .nav-links a:hover, .nav-links a.active {
            color: var(--primary-color);
        }

        .nav-links a.active:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 3px;
            background-color: var(--primary-color);
            border-radius: 3px 3px 0 0;
        }

        .auth-buttons {
            display: flex;
            gap: 1rem;
        }

        .btn {
            padding: 0.5rem 1rem;
            border-radius: 5px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-block;
        }

        .btn-login {
            background-color: var(--primary-color);
            color: var(--white);
            border: 1px solid var(--primary-color);
        }

        .btn-login:hover {
            background-color: var(--primary-dark);
            border-color: var(--primary-dark);
        }

        .dashboard {
            display: flex;
            min-height: calc(100vh - 80px);
        }

        .sidebar {
            width: 280px;
            background: var(--white);
            box-shadow: 2px 0 10px rgba(0, 0, 0, 0.05);
            padding: 2rem 1.5rem;
            position: sticky;
            top: 80px;
            height: calc(100vh - 80px);
            overflow-y: auto;
        }

        .sidebar-menu {
            list-style: none;
            margin-top: 2rem;
        }

        .sidebar-menu li {
            margin-bottom: 0.75rem;
        }

        .sidebar-menu a {
            display: flex;
            align-items: center;
            gap: 1rem;
            color: var(--text-color);
            text-decoration: none;
            padding: 0.75rem 1rem;
            border-radius: 8px;
            transition: all 0.3s;
            font-size: 0.95rem;
        }

        .sidebar-menu a:hover {
            background-color: var(--light-gray);
            color: var(--primary-color);
        }

        .sidebar-menu a.active {
            background-color: var(--primary-light);
            color: var(--white);
            box-shadow: 0 4px 6px rgba(37, 99, 235, 0.2);
        }

        .sidebar-menu i {
            width: 20px;
            text-align: center;
        }

        .main-content {
            flex: 1;
            padding: 2.5rem;
        }

        .welcome-message {
            background: var(--white);
            padding: 2.5rem;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            margin-bottom: 2.5rem;
            border-left: 4px solid var(--primary-color);
        }

        .welcome-message h2 {
            color: var(--primary-color);
            margin-bottom: 0.5rem;
            font-size: 1.75rem;
        }

        .profile-card {
            display: flex;
            align-items: center;
            gap: 1.5rem;
            margin-bottom: 1.5rem;
        }

        .profile-pic {
            width: 90px;
            height: 90px;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid var(--primary-light);
            box-shadow: 0 4px 10px rgba(37, 99, 235, 0.2);
        }

        .role-badge {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            background-color: var(--primary-light);
            color: white;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 500;
            margin-top: 0.25rem;
        }

        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-top: 2rem;
        }

        .stat-card {
            background: var(--white);
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            display: flex;
            align-items: center;
            gap: 1rem;
            transition: transform 0.3s;
        }

        .stat-card:hover {
            transform: translateY(-5px);
        }

        .stat-icon {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.25rem;
            color: white;
        }

        .icon-blue {
            background-color: var(--primary-color);
        }

        .icon-green {
            background-color: var(--success);
        }

        .icon-orange {
            background-color: var(--warning);
        }

        .stat-info h3 {
            font-size: 1.5rem;
            margin-bottom: 0.25rem;
            color: var(--text-color);
        }

        .stat-info p {
            color: var(--dark-gray);
            font-size: 0.9rem;
        }

        footer {
            background-color: var(--white);
            padding: 1.5rem;
            text-align: center;
            color: var(--dark-gray);
            font-size: 0.9rem;
            box-shadow: 0 -2px 10px rgba(0, 0, 0, 0.05);
        }

        /* Responsive design */
        @media (max-width: 768px) {
            .dashboard {
                flex-direction: column;
            }

            .sidebar {
                width: 100%;
                height: auto;
                position: static;
                padding: 1rem;
            }

            .main-content {
                padding: 1.5rem;
            }

            .navbar {
                flex-direction: column;
                gap: 1rem;
                padding: 1rem;
            }

            .nav-links {
                gap: 1rem;
            }

            .profile-card {
                flex-direction: column;
                text-align: center;
            }
        }
    </style>
</head>
<body>
<nav class="navbar">
    <a href="index.jsp" class="logo">HomeTutor.lk</a>
    <div class="nav-links">
        <a href="dashboard" class="active"><i class="fas fa-home"></i> Dashboard</a>
        <a href="TutorSearch.jsp"><i class="fas fa-search"></i> Find Tutors</a>
        <a href="#"><i class="fas fa-envelope"></i> Messages</a>
    </div>
    <div class="auth-buttons">
        <a href="logout" class="btn btn-login"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </div>
</nav>

<div class="dashboard">
    <div class="sidebar">
        <ul class="sidebar-menu">
            <li><a href="dashboard" class="active"><i class="fas fa-home"></i> Dashboard</a></li>
            <li><a href="profile.jsp"><i class="fas fa-user"></i> My Profile</a></li>
            <c:if test="${user.role eq 'tutor'}">
                <li><a href="tutor-schedule.jsp"><i class="fas fa-calendar-alt"></i> My Schedule</a></li>
                <li><a href="tutor-students.jsp"><i class="fas fa-users"></i> My Students</a></li>
            </c:if>
            <c:if test="${user.role eq 'student'}">
                <li><a href="my-tutors.jsp"><i class="fas fa-chalkboard-teacher"></i> My Tutors</a></li>
                <li><a href="book-session.jsp"><i class="fas fa-plus-circle"></i> Book Session</a></li>
            </c:if>
            <li><a href="settings.jsp"><i class="fas fa-cog"></i> Settings</a></li>
        </ul>
    </div>

    <div class="main-content">
        <div class="welcome-message">
            <div class="profile-card">
                <img src="${user.profilePic}" class="profile-pic">
                <div>
                    <h2>Welcome back, ${user.name}!</h2>
                    <span class="role-badge">${user.role}</span>
                </div>
            </div>

            <c:if test="${user.role eq 'tutor'}">
                <p>You have ${upcomingSessions} upcoming sessions this week.</p>
            </c:if>
            <c:if test="${user.role eq 'student'}">
                <p>You're currently learning with ${activeTutors} tutors.</p>
            </c:if>

            <div class="stats-container">
                <c:if test="${user.role eq 'tutor'}">
                    <div class="stat-card">
                        <div class="stat-icon icon-blue">
                            <i class="fas fa-calendar-check"></i>
                        </div>
                        <div class="stat-info">
                            <h3>${upcomingSessions}</h3>
                            <p>Upcoming Sessions</p>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon icon-green">
                            <i class="fas fa-users"></i>
                        </div>
                        <div class="stat-info">
                            <h3>12</h3>
                            <p>Total Students</p>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon icon-orange">
                            <i class="fas fa-star"></i>
                        </div>
                        <div class="stat-info">
                            <h3>4.9</h3>
                            <p>Your Rating</p>
                        </div>
                    </div>
                </c:if>

                <c:if test="${user.role eq 'student'}">
                    <div class="stat-card">
                        <div class="stat-icon icon-blue">
                            <i class="fas fa-chalkboard-teacher"></i>
                        </div>
                        <div class="stat-info">
                            <h3>${activeTutors}</h3>
                            <p>Active Tutors</p>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon icon-green">
                            <i class="fas fa-book-open"></i>
                        </div>
                        <div class="stat-info">
                            <h3>5</h3>
                            <p>Subjects</p>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon icon-orange">
                            <i class="fas fa-clock"></i>
                        </div>
                        <div class="stat-info">
                            <h3>12</h3>
                            <p>Hours This Week</p>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>

        <!-- Additional dashboard content based on user role -->
    </div>
</div>

<footer>
    <p>&copy; 2023 HomeTutor.lk. All rights reserved.</p>
</footer>
</body>
</html>