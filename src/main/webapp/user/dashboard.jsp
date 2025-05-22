<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard | HomeTutor.com </title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #764ba2;
            --secondary-color: #667eea;
        }
        body {
            background-color: #f8f9fa;
        }
        .sidebar {
            background: linear-gradient(135deg, var(--secondary-color) 0%, var(--primary-color) 100%);
            color: white;
            height: 100vh;
            position: fixed;
            width: 250px;
            transition: all 0.3s;
            box-shadow: 5px 0 15px rgba(0, 0, 0, 0.1);
        }
        .sidebar-header {
            padding: 20px;
            background: rgba(0, 0, 0, 0.1);
        }
        .sidebar-menu {
            padding: 0;
            list-style: none;
        }
        .sidebar-menu li {
            padding: 10px 20px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            transition: all 0.3s;
        }
        .sidebar-menu li:hover {
            background: rgba(255, 255, 255, 0.1);
            transform: translateX(5px);
        }
        .sidebar-menu li a {
            color: white;
            text-decoration: none;
            display: block;
        }
        .sidebar-menu li i {
            margin-right: 10px;
        }
        .main-content {
            margin-left: 250px;
            padding: 20px;
            transition: all 0.3s;
        }
        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            transition: all 0.3s;
            margin-bottom: 20px;
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }
        .card-header {
            background: white;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
            font-weight: 600;
        }
        .stat-card {
            background: white;
            border-left: 4px solid var(--primary-color);
        }
        .stat-card i {
            font-size: 2rem;
            color: var(--primary-color);
        }
        .navbar-custom {
            background: white;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }
        .user-profile img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
        }
        .tutor-card {
            border-left: 4px solid var(--secondary-color);
        }
        .upcoming-session {
            border-left: 4px solid #28a745;
        }
    </style>
</head>
<body>
<div class="sidebar">
    <div class="sidebar-header">
        <h4>HomeTutor.com</h4>
        <p class="text-muted">Welcome! ${user.name}</p>
    </div>
    <ul class="sidebar-menu">
        <li class="active">
            <a href="user/dashboard.jsp"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
        </li>
        <c:if test="${user.role == 'tutor'}">
            <li>
                <a href="#"><i class="fas fa-calendar-check"></i> My Sessions</a>
            </li>
            <li>
                <a href="#"><i class="fas fa-wallet"></i> Earnings</a>
            </li>
        </c:if>
        <c:if test="${user.role == 'student'}">
            <li>
                <a href="#"><i class="fas fa-search"></i> Find Tutors</a>
            </li>
            <li>
                <a href="#"><i class="fas fa-calendar-alt"></i> My Bookings</a>
            </li>
        </c:if>
        <li>
            <a href="profile"><i class="fas fa-user"></i> Profile</a>
        </li>
        <li>
            <a href="logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </li>
    </ul>
</div>

<div class="main-content">
    <nav class="navbar navbar-expand navbar-custom">
        <div class="container-fluid">
            <h5 class="mb-0">Dashboard</h5>
            <ul class="navbar-nav ms-auto">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown">
                        <div class="user-profile d-flex align-items-center">
                            <img src="https://via.placeholder.com/40" alt="User" class="me-2">
                            <span>${user.name}</span>
                        </div>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li><a class="dropdown-item" href="profile"><i class="fas fa-user me-2"></i> Profile</a></li>
                        <li><a class="dropdown-item" href="#"><i class="fas fa-cog me-2"></i> Settings</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="logout"><i class="fas fa-sign-out-alt me-2"></i> Logout</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </nav>

    <div class="container-fluid mt-4">
        <c:if test="${user.role == 'tutor'}">
            <div class="row">
                <div class="col-md-4">
                    <div class="card stat-card animate__animated animate__fadeIn">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="text-muted mb-2">Total Sessions</h6>
                                    <h3 class="mb-0">124</h3>
                                </div>
                                <i class="fas fa-calendar-check"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card stat-card animate__animated animate__fadeIn animate__delay-1s">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="text-muted mb-2">Upcoming Sessions</h6>
                                    <h3 class="mb-0">5</h3>
                                </div>
                                <i class="fas fa-clock"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card stat-card animate__animated animate__fadeIn animate__delay-2s">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="text-muted mb-2">Total Earnings</h6>
                                    <h3 class="mb-0">$2,450</h3>
                                </div>
                                <i class="fas fa-dollar-sign"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>

        <c:if test="${user.role == 'student'}">
            <div class="row">
                <div class="col-md-4">
                    <div class="card stat-card animate__animated animate__fadeIn">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="text-muted mb-2">Active Tutors</h6>
                                    <h3 class="mb-0">12</h3>
                                </div>
                                <i class="fas fa-chalkboard-teacher"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card stat-card animate__animated animate__fadeIn animate__delay-1s">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="text-muted mb-2">Upcoming Sessions</h6>
                                    <h3 class="mb-0">3</h3>
                                </div>
                                <i class="fas fa-clock"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card stat-card animate__animated animate__fadeIn animate__delay-2s">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="text-muted mb-2">Completed Sessions</h6>
                                    <h3 class="mb-0">28</h3>
                                </div>
                                <i class="fas fa-check-circle"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>

        <div class="row mt-4">
            <div class="col-md-8">
                <c:if test="${user.role == 'tutor'}">
                    <div class="card animate__animated animate__fadeIn">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h6 class="mb-0">Upcoming Sessions</h6>
                            <a href="#" class="btn btn-sm btn-primary">View All</a>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead>
                                    <tr>
                                        <th>Student</th>
                                        <th>Subject</th>
                                        <th>Date & Time</th>
                                        <th>Duration</th>
                                        <th>Action</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr class="upcoming-session">
                                        <td>Emily Johnson</td>
                                        <td>Mathematics</td>
                                        <td>Today, 3:00 PM</td>
                                        <td>1 hour</td>
                                        <td><a href="#" class="btn btn-sm btn-success">Start</a></td>
                                    </tr>
                                    <tr class="upcoming-session">
                                        <td>Michael Brown</td>
                                        <td>Physics</td>
                                        <td>Tomorrow, 10:00 AM</td>
                                        <td>1.5 hours</td>
                                        <td><a href="#" class="btn btn-sm btn-outline-primary">Details</a></td>
                                    </tr>
                                    <tr>
                                        <td>Sarah Wilson</td>
                                        <td>Chemistry</td>
                                        <td>June 15, 2:00 PM</td>
                                        <td>2 hours</td>
                                        <td><a href="#" class="btn btn-sm btn-outline-primary">Details</a></td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </c:if>

                <c:if test="${user.role == 'student'}">
                    <div class="card animate__animated animate__fadeIn">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h6 class="mb-0">Recommended Tutors</h6>
                            <a href="#" class="btn btn-sm btn-primary">View All</a>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <div class="card tutor-card h-100">
                                        <div class="card-body">
                                            <div class="d-flex align-items-center mb-3">
                                                <img src="https://via.placeholder.com/60" class="rounded-circle me-3" alt="Tutor">
                                                <div>
                                                    <h5 class="mb-0">Dr. Robert Smith</h5>
                                                    <p class="text-muted mb-0">Mathematics</p>
                                                </div>
                                            </div>
                                            <div class="d-flex justify-content-between mb-2">
                                                <small class="text-muted">Experience:</small>
                                                <small>8 years</small>
                                            </div>
                                            <div class="d-flex justify-content-between mb-2">
                                                <small class="text-muted">Rating:</small>
                                                <small><i class="fas fa-star text-warning"></i> 4.9/5.0</small>
                                            </div>
                                            <div class="d-flex justify-content-between mb-3">
                                                <small class="text-muted">Rate:</small>
                                                <small>$40/hour</small>
                                            </div>
                                            <button class="btn btn-primary w-100">Book Session</button>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <div class="card tutor-card h-100">
                                        <div class="card-body">
                                            <div class="d-flex align-items-center mb-3">
                                                <img src="https://via.placeholder.com/60" class="rounded-circle me-3" alt="Tutor">
                                                <div>
                                                    <h5 class="mb-0">Prof. Jane Doe</h5>
                                                    <p class="text-muted mb-0">Physics</p>
                                                </div>
                                            </div>
                                            <div class="d-flex justify-content-between mb-2">
                                                <small class="text-muted">Experience:</small>
                                                <small>6 years</small>
                                            </div>
                                            <div class="d-flex justify-content-between mb-2">
                                                <small class="text-muted">Rating:</small>
                                                <small><i class="fas fa-star text-warning"></i> 4.8/5.0</small>
                                            </div>
                                            <div class="d-flex justify-content-between mb-3">
                                                <small class="text-muted">Rate:</small>
                                                <small>$35/hour</small>
                                            </div>
                                            <button class="btn btn-primary w-100">Book Session</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>
            </div>
            <div class="col-md-4">
                <div class="card animate__animated animate__fadeIn">
                    <div class="card-header">
                        <h6 class="mb-0">Recent Notifications</h6>
                    </div>
                    <div class="card-body">
                        <div class="list-group">
                            <a href="#" class="list-group-item list-group-item-action">
                                <div class="d-flex w-100 justify-content-between">
                                    <h6 class="mb-1">New Message</h6>
                                    <small>10 min ago</small>
                                </div>
                                <p class="mb-1">You have a new message from your tutor.</p>
                            </a>
                            <a href="#" class="list-group-item list-group-item-action">
                                <div class="d-flex w-100 justify-content-between">
                                    <h6 class="mb-1">Session Reminder</h6>
                                    <small>1 hour ago</small>
                                </div>
                                <p class="mb-1">Your session starts in 2 hours.</p>
                            </a>
                            <a href="#" class="list-group-item list-group-item-action">
                                <div class="d-flex w-100 justify-content-between">
                                    <h6 class="mb-1">Payment Received</h6>
                                    <small>3 hours ago</small>
                                </div>
                                <p class="mb-1">Your payment of $50 has been processed.</p>
                            </a>
                        </div>
                    </div>
                </div>

                <div class="card mt-4 animate__animated animate__fadeIn animate__delay-1s">
                    <div class="card-header">
                        <h6 class="mb-0">Quick Actions</h6>
                    </div>
                    <div class="card-body">
                        <c:if test="${user.role == 'tutor'}">
                            <button class="btn btn-primary w-100 mb-2">
                                <i class="fas fa-calendar-plus me-2"></i> Set Availability
                            </button>
                            <button class="btn btn-success w-100 mb-2">
                                <i class="fas fa-book me-2"></i> Update Subjects
                            </button>
                        </c:if>
                        <c:if test="${user.role == 'student'}">
                            <button class="btn btn-primary w-100 mb-2">
                                <i class="fas fa-search me-2"></i> Find Tutors
                            </button>
                            <button class="btn btn-success w-100 mb-2">
                                <i class="fas fa-calendar me-2"></i> Book Session
                            </button>
                        </c:if>
                        <button class="btn btn-info w-100 mb-2">
                            <i class="fas fa-question-circle me-2"></i> Get Help
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>