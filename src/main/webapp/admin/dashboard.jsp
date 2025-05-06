<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard | Home Tutor System</title>
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
    </style>
</head>
<body>
<div class="sidebar">
    <div class="sidebar-header">
        <h4>Home Tutor System</h4>
        <p class="text-muted">Admin Panel</p>
    </div>
    <ul class="sidebar-menu">
        <li class="active">
            <a href="admin/dashboard.jsp"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
        </li>
        <li>
            <a href="admin/viewUsers"><i class="fas fa-users"></i> Manage Users</a>
        </li>
        <li>
            <a href="#"><i class="fas fa-chalkboard-teacher"></i> Manage Tutors</a>
        </li>
        <li>
            <a href="#"><i class="fas fa-user-graduate"></i> Manage Students</a>
        </li>
        <li>
            <a href="#"><i class="fas fa-book"></i> Subjects</a>
        </li>
        <li>
            <a href="#"><i class="fas fa-cog"></i> Settings</a>
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
                        <li><a class="dropdown-item" href="user/profile.jsp"><i class="fas fa-user me-2"></i> Profile</a></li>
                        <li><a class="dropdown-item" href="#"><i class="fas fa-cog me-2"></i> Settings</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="logout"><i class="fas fa-sign-out-alt me-2"></i> Logout</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </nav>

    <div class="container-fluid mt-4">
        <div class="row">
            <div class="col