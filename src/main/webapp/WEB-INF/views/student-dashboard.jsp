<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.model.Student" %>
<%
    Student student = (Student) session.getAttribute("student");
    if (student == null) {
        response.sendRedirect("student-login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard - Home Tutor System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-blue: #1a73e8;
            --light-blue: #e8f0fe;
            --dark-blue: #0d47a1;
            --white: #ffffff;
            --light-gray: #f8f9fa;
            --medium-gray: #e9ecef;
            --dark-gray: #495057;
        }

        body {
            background-color: var(--light-gray);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .dashboard-container {
            background: var(--white);
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            overflow: hidden;
            margin: 2rem 0;
            border: 1px solid var(--medium-gray);
        }

        .dashboard-header {
            background: var(--primary-blue);
            color: var(--white);
            padding: 2rem;
            position: relative;
        }

        .profile-avatar {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.2);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            margin-bottom: 1rem;
            color: var(--white);
            font-weight: bold;
        }

        .info-card {
            background: var(--white);
            border-radius: 8px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            border: 1px solid var(--medium-gray);
            transition: all 0.3s ease;
            height: 100%;
        }

        .info-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.08);
            border-color: var(--primary-blue);
        }

        .info-label {
            font-weight: 600;
            color: var(--primary-blue);
            font-size: 0.85rem;
            margin-bottom: 0.5rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .info-value {
            font-size: 1.1rem;
            color: var(--dark-gray);
            font-weight: 500;
        }

        .btn-primary {
            background-color: var(--primary-blue);
            border: none;
            padding: 10px 24px;
            font-weight: 500;
            border-radius: 8px;
        }

        .btn-primary:hover {
            background-color: var(--dark-blue);
            transform: translateY(-2px);
        }

        .nav-pills .nav-link {
            border-radius: 8px;
            margin: 0 5px;
            font-weight: 500;
            color: var(--dark-gray);
            padding: 10px 20px;
        }

        .nav-pills .nav-link.active {
            background-color: var(--primary-blue);
            color: var(--white);
        }

        .badge-blue {
            background-color: var(--primary-blue);
            color: var(--white);
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 500;
        }

        .quick-actions {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 1rem;
            margin: 2rem 0;
        }

        .quick-action-card {
            background: var(--white);
            border-radius: 8px;
            padding: 1.5rem;
            text-align: center;
            border: 1px solid var(--medium-gray);
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .quick-action-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
            border-color: var(--primary-blue);
        }

        .quick-action-icon {
            font-size: 2rem;
            color: var(--primary-blue);
            margin-bottom: 1rem;
        }

        .quick-action-title {
            font-weight: 600;
            color: var(--dark-gray);
            margin-bottom: 0.5rem;
        }

        .quick-action-desc {
            font-size: 0.85rem;
            color: var(--dark-gray);
            opacity: 0.8;
        }

        .section-title {
            color: var(--primary-blue);
            font-weight: 600;
            margin-bottom: 1.5rem;
            position: relative;
            padding-bottom: 0.5rem;
        }

        .section-title:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 50px;
            height: 3px;
            background: var(--primary-blue);
            border-radius: 3px;
        }

        .modal-header {
            background: var(--primary-blue);
            color: var(--white);
        }

        .modal-title {
            font-weight: 500;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="dashboard-container">
        <!-- Header -->
        <div class="dashboard-header">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <div class="profile-avatar">
                        <%= student.getFullName().substring(0, 1).toUpperCase() %>
                    </div>
                    <h2 class="mb-2">Welcome, <%= student.getFullName() %>!</h2>
                    <p class="mb-0 opacity-85">
                        <i class="fas fa-graduation-cap me-2"></i>Student Dashboard
                    </p>
                </div>
                <div class="col-md-4 text-md-end">
                    <div class="mb-2">
                        <span class="badge badge-blue">
                            <i class="fas fa-layer-group me-1"></i>Grade: <%= student.getGrade() %>
                        </span>
                    </div>
                    <div>
                        <span class="badge badge-blue">
                            <i class="fas fa-book me-1"></i>Module: <%= student.getModule() %>
                        </span>
                    </div>
                </div>
            </div>
        </div>

        <div class="p-4">
            <!-- Alerts -->
            <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger alert-dismissible fade show">
                <i class="fas fa-exclamation-circle me-2"></i>
                <%= request.getAttribute("error") %>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <% } %>

            <% if (request.getAttribute("success") != null) { %>
            <div class="alert alert-success alert-dismissible fade show">
                <i class="fas fa-check-circle me-2"></i>
                <%= request.getAttribute("success") %>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <% } %>

            <!-- Quick Actions -->
            <div class="quick-actions">
                <a href="booking.jsp" class="quick-action-card text-decoration-none">
                    <div class="quick-action-icon">
                        <i class="fas fa-calendar-check"></i>
                    </div>
                    <h5 class="quick-action-title">Book a Session</h5>
                    <p class="quick-action-desc">Schedule a tutoring session with your preferred tutor</p>
                </a>

                <a href="tutor-search" class="quick-action-card text-decoration-none">
                    <div class="quick-action-icon">
                        <i class="fas fa-chalkboard-teacher"></i>
                    </div>
                    <h5 class="quick-action-title">Find Tutors</h5>
                    <p class="quick-action-desc">Browse and connect with available tutors</p>
                </a>

                <div class="quick-action-card" data-bs-toggle="modal" data-bs-target="#editProfileModal">
                    <div class="quick-action-icon">
                        <i class="fas fa-user-edit"></i>
                    </div>
                    <h5 class="quick-action-title">Update Profile</h5>
                    <p class="quick-action-desc">Edit your personal information</p>
                </div>

                <a href="${pageContext.request.contextPath}/user/MyCourse.jsp" class="quick-action-card text-decoration-none">
                    <div class="quick-action-icon">
                        <i class="fas fa-book-open"></i>
                    </div>
                    <h5 class="quick-action-title">My Courses</h5>
                    <p class="quick-action-desc">View your enrolled courses and materials</p>
                </a>
            </div>

            <!-- Navigation Tabs -->
            <ul class="nav nav-pills justify-content-center mb-4" id="dashboardTabs" role="tablist">
                <li class="nav-item" role="presentation">
                    <button class="nav-link active" id="profile-tab" data-bs-toggle="pill" data-bs-target="#profile"
                            type="button" role="tab">
                        <i class="fas fa-user me-2"></i>My Profile
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="courses-tab" data-bs-toggle="pill" data-bs-target="#courses"
                            type="button" role="tab">
                        <i class="fas fa-book-open me-2"></i>My Courses
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="tutors-tab" data-bs-toggle="pill" data-bs-target="#tutors"
                            type="button" role="tab">
                        <i class="fas fa-chalkboard-teacher me-2"></i>My Tutors
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="settings-tab" data-bs-toggle="pill" data-bs-target="#settings"
                            type="button" role="tab">
                        <i class="fas fa-cog me-2"></i>Settings
                    </button>
                </li>
            </ul>

            <!-- Tab Content -->
            <div class="tab-content" id="dashboardTabsContent">
                <!-- Profile Tab -->
                <div class="tab-pane fade show active" id="profile" role="tabpanel">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="info-card">
                                <div class="info-label">
                                    <i class="fas fa-id-card me-2"></i>Student ID
                                </div>
                                <div class="info-value">
                                    <code><%= student.getId() %></code>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="info-card">
                                <div class="info-label">
                                    <i class="fas fa-user me-2"></i>Full Name
                                </div>
                                <div class="info-value"><%= student.getFullName() %></div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="info-card">
                                <div class="info-label">
                                    <i class="fas fa-envelope me-2"></i>Email Address
                                </div>
                                <div class="info-value"><%= student.getEmail() %></div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="info-card">
                                <div class="info-label">
                                    <i class="fas fa-phone me-2"></i>Phone Number
                                </div>
                                <div class="info-value"><%= student.getPhoneNumber() %></div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="info-card">
                                <div class="info-label">
                                    <i class="fas fa-layer-group me-2"></i>Grade Level
                                </div>
                                <div class="info-value">
                                    <span class="badge badge-blue"><%= student.getGrade() %></span>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="info-card">
                                <div class="info-label">
                                    <i class="fas fa-book me-2"></i>Current Module
                                </div>
                                <div class="info-value">
                                    <span class="badge badge-blue"><%= student.getModule() %></span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="text-center mt-4">
                        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#editProfileModal">
                            <i class="fas fa-edit me-2"></i>Edit Profile
                        </button>
                    </div>
                </div>

                <!-- Courses Tab -->
                <div class="tab-pane fade" id="courses" role="tabpanel">
                    <h4 class="section-title">
                        <i class="fas fa-book-open me-2"></i>My Courses
                    </h4>

                    <div class="alert alert-info">
                        <i class="fas fa-info-circle me-2"></i>
                        You are currently enrolled in <strong><%= student.getModule() %></strong> for <strong><%= student.getGrade() %></strong>.
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="info-card">
                                <div class="info-label">Upcoming Sessions</div>
                                <div class="info-value">
                                    <p><i class="fas fa-calendar-day text-primary me-2"></i> Monday, 3:00 PM - Math</p>
                                    <p><i class="fas fa-calendar-day text-primary me-2"></i> Wednesday, 4:30 PM - Science</p>
                                </div>
                                <div class="mt-3">
                                    <a href="booking.jsp" class="btn btn-sm btn-outline-primary">
                                        <i class="fas fa-plus me-1"></i> Schedule More
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="info-card">
                                <div class="info-label">Course Materials</div>
                                <div class="info-value">
                                    <p><i class="fas fa-file-pdf text-danger me-2"></i> Math_Chapter3.pdf</p>
                                    <p><i class="fas fa-file-video text-info me-2"></i> Science_Lesson5.mp4</p>
                                </div>
                                <div class="mt-3">
                                    <button class="btn btn-sm btn-outline-primary">
                                        <i class="fas fa-download me-1"></i> Download All
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Tutors Tab -->
                <div class="tab-pane fade" id="tutors" role="tabpanel">
                    <h4 class="section-title">
                        <i class="fas fa-chalkboard-teacher me-2"></i>My Tutors
                    </h4>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="info-card">
                                <div class="d-flex align-items-center mb-3">
                                    <div class="profile-avatar me-3" style="width: 50px; height: 50px; font-size: 1.2rem;">
                                        JD
                                    </div>
                                    <div>
                                        <h5 class="mb-0">John Doe</h5>
                                        <small class="text-muted">Mathematics Tutor</small>
                                    </div>
                                </div>
                                <div class="mb-2">
                                    <span class="badge bg-light text-dark me-2">
                                        <i class="fas fa-star text-warning me-1"></i>4.8
                                    </span>
                                    <span class="badge bg-light text-dark">
                                        <i class="fas fa-user-graduate text-primary me-1"></i>5 years exp
                                    </span>
                                </div>
                                <p class="small text-muted mb-3">Specializes in Algebra and Calculus for high school students.</p>
                                <div>
                                    <a href="messaging.jsp?tutorId=1" class="btn btn-sm btn-outline-primary me-2">
                                        <i class="fas fa-envelope me-1"></i> Message
                                    </a>
                                    <a href="booking.jsp?tutorId=1" class="btn btn-sm btn-primary">
                                        <i class="fas fa-calendar-plus me-1"></i> Book Session
                                    </a>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="info-card">
                                <div class="d-flex align-items-center mb-3">
                                    <div class="profile-avatar me-3" style="width: 50px; height: 50px; font-size: 1.2rem;">
                                        SJ
                                    </div>
                                    <div>
                                        <h5 class="mb-0">Sarah Johnson</h5>
                                        <small class="text-muted">Science Tutor</small>
                                    </div>
                                </div>
                                <div class="mb-2">
                                    <span class="badge bg-light text-dark me-2">
                                        <i class="fas fa-star text-warning me-1"></i>4.9
                                    </span>
                                    <span class="badge bg-light text-dark">
                                        <i class="fas fa-user-graduate text-primary me-1"></i>7 years exp
                                    </span>
                                </div>
                                <p class="small text-muted mb-3">Expert in Physics and Chemistry with PhD in Science Education.</p>
                                <div>
                                    <a href="messaging.jsp?tutorId=2" class="btn btn-sm btn-outline-primary me-2">
                                        <i class="fas fa-envelope me-1"></i> Message
                                    </a>
                                    <a href="booking.jsp?tutorId=2" class="btn btn-sm btn-primary">
                                        <i class="fas fa-calendar-plus me-1"></i> Book Session
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="text-center mt-3">
                        <a href="tutor.jsp" class="btn btn-primary">
                            <i class="fas fa-search me-2"></i> Find More Tutors
                        </a>
                    </div>
                </div>

                <!-- Settings Tab -->
                <div class="tab-pane fade" id="settings" role="tabpanel">
                    <div class="row justify-content-center">
                        <div class="col-md-8">
                            <div class="info-card">
                                <h5 class="mb-4">
                                    <i class="fas fa-key me-2"></i>Change Password
                                </h5>
                                <button class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#changePasswordModal">
                                    <i class="fas fa-lock me-2"></i>Change Password
                                </button>
                            </div>

                            <div class="info-card">
                                <h5 class="mb-4">
                                    <i class="fas fa-sign-out-alt me-2"></i>Account Actions
                                </h5>
                                <a href="logout" class="btn btn-outline-danger">
                                    <i class="fas fa-sign-out-alt me-2"></i>Logout
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Edit Profile Modal -->
<div class="modal fade" id="editProfileModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title text-white">
                    <i class="fas fa-edit me-2"></i>Edit Profile
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form method="post" action="student-dashboard">
                <div class="modal-body">
                    <input type="hidden" name="action" value="updateProfile">

                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-floating mb-3">
                                <input type="text" class="form-control" id="editFullName" name="fullName"
                                       value="<%= student.getFullName() %>" required>
                                <label for="editFullName">Full Name</label>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-floating mb-3">
                                <input type="tel" class="form-control" id="editPhoneNumber" name="phoneNumber"
                                       value="<%= student.getPhoneNumber() %>" required>
                                <label for="editPhoneNumber">Phone Number</label>
                            </div>
                        </div>
                    </div>

                    <div class="form-floating mb-3">
                        <input type="email" class="form-control" id="editEmail" name="email"
                               value="<%= student.getEmail() %>" required>
                        <label for="editEmail">Email Address</label>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-floating mb-3">
                                <input type="text" class="form-control" id="editGrade" name="grade"
                                       value="<%= student.getGrade() %>" required>
                                <label for="editGrade">Grade Level</label>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-floating mb-3">
                                <input type="text" class="form-control" id="editModule" name="module"
                                       value="<%= student.getModule() %>" required>
                                <label for="editModule">Module</label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save me-2"></i>Save Changes
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Change Password Modal -->
<div class="modal fade" id="changePasswordModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title text-white">
                    <i class="fas fa-key me-2"></i>Change Password
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form method="post" action="student-dashboard">
                <div class="modal-body">
                    <input type="hidden" name="action" value="changePassword">

                    <div class="form-floating mb-3">
                        <input type="password" class="form-control" id="currentPassword" name="currentPassword" required>
                        <label for="currentPassword">Current Password</label>
                    </div>

                    <div class="form-floating mb-3">
                        <input type="password" class="form-control" id="newPassword" name="newPassword"
                               required minlength="6">
                        <label for="newPassword">New Password</label>
                    </div>

                    <div class="form-floating mb-3">
                        <input type="password" class="form-control" id="confirmNewPassword" name="confirmPassword"
                               required minlength="6">
                        <label for="confirmNewPassword">Confirm New Password</label>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save me-2"></i>Change Password
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Password confirmation validation
    document.getElementById('confirmNewPassword').addEventListener('input', function() {
        const newPassword = document.getElementById('newPassword').value;
        const confirmPassword = this.value;

        if (newPassword !== confirmPassword) {
            this.setCustomValidity('Passwords do not match');
        } else {
            this.setCustomValidity('');
        }
    });

    // Auto-dismiss alerts after 5 seconds
    setTimeout(function() {
        const alerts = document.querySelectorAll('.alert');
        alerts.forEach(function(alert) {
            const bsAlert = new bootstrap.Alert(alert);
            bsAlert.close();
        });
    }, 5000);
</script>
</body>
</html>