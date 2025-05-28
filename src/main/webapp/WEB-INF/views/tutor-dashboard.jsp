<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.model.Tutor" %>
<%
    Tutor tutor = (Tutor) request.getAttribute("tutor");
    if (tutor == null) {
        response.sendRedirect(request.getContextPath() + "/tutor-login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tutor Dashboard - Home Tutor System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .dashboard-container {
            padding: 20px;
        }
        .dashboard-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            padding: 30px;
            margin-bottom: 20px;
            backdrop-filter: blur(10px);
        }
        .navbar-custom {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            margin-bottom: 20px;
        }
        .profile-img {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 2rem;
            margin-bottom: 15px;
        }
        .btn-custom {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 15px;
            color: white;
            font-weight: 600;
            transition: all 0.3s ease;
            padding: 10px 20px;
        }
        .btn-custom:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
            color: white;
        }
        .form-control, .form-select {
            border-radius: 15px;
            border: 2px solid #e9ecef;
        }
        .form-control:focus, .form-select:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
        .alert {
            border-radius: 15px;
            border: none;
        }
        .stat-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 15px;
            padding: 20px;
            text-align: center;
            margin-bottom: 20px;
        }
        .section-title {
            color: #667eea;
            font-weight: 700;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<!-- Navigation -->
<div class="container-fluid dashboard-container">
    <nav class="navbar navbar-expand-lg navbar-custom">
        <div class="container-fluid">
            <a class="navbar-brand fw-bold" href="#" style="color: #667eea;">
                <i class="fas fa-chalkboard-teacher me-2"></i>Tutor Dashboard
            </a>
            <div class="navbar-nav ms-auto">
                    <span class="navbar-text me-3">
                        Welcome, <strong><%= tutor.getFullName() %></strong>
                    </span>
                <form method="post" action="${pageContext.request.contextPath}/tutor-dashboard" style="display: inline;">
                    <input type="hidden" name="action" value="logout">
                    <button type="submit" class="btn btn-outline-danger btn-sm">
                        <i class="fas fa-sign-out-alt me-1"></i>Logout
                    </button>
                </form>
            </div>
        </div>
    </nav>

    <!-- Messages -->
    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <i class="fas fa-exclamation-triangle me-2"></i>
        <%= request.getAttribute("error") %>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <% } %>

    <% if (request.getAttribute("success") != null) { %>
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <i class="fas fa-check-circle me-2"></i>
        <%= request.getAttribute("success") %>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <% } %>

    <div class="row">
        <!-- Profile Section -->
        <div class="col-md-4">
            <div class="dashboard-card">
                <div class="text-center">
                    <div class="profile-img mx-auto">
                        <i class="fas fa-user"></i>
                    </div>
                    <h4 class="fw-bold"><%= tutor.getFullName() %></h4>
                    <p class="text-muted"><%= tutor.getSpecialization() %> Tutor</p>
                    <p class="text-muted"><i class="fas fa-envelope me-2"></i><%= tutor.getEmail() %></p>
                    <p class="text-muted"><i class="fas fa-phone me-2"></i><%= tutor.getPhoneNumber() %></p>
                </div>
            </div>

            <!-- Quick Stats -->
            <div class="stat-card">
                <i class="fas fa-dollar-sign fa-2x mb-2"></i>
                <h4>$<%= tutor.getHourlyRate() %>/hour</h4>
                <p class="mb-0">Hourly Rate</p>
            </div>

            <div class="stat-card">
                <i class="fas fa-clock fa-2x mb-2"></i>
                <h4><%= tutor.getExperience() %></h4>
                <p class="mb-0">Experience</p>
            </div>
        </div>

        <!-- Main Content -->
        <div class="col-md-8">
            <!-- Profile Update Form -->
            <div class="dashboard-card">
                <h3 class="section-title">
                    <i class="fas fa-user-edit me-2"></i>Update Profile
                </h3>

                <form method="post" action="${pageContext.request.contextPath}/tutor-dashboard">
                    <input type="hidden" name="action" value="updateProfile">

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="fullName" class="form-label">Full Name</label>
                            <input type="text" class="form-control" id="fullName" name="fullName"
                                   value="<%= tutor.getFullName() %>" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="phoneNumber" class="form-label">Phone Number</label>
                            <input type="tel" class="form-control" id="phoneNumber" name="phoneNumber"
                                   value="<%= tutor.getPhoneNumber() %>" required>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12 mb-3">
                            <label for="qualification" class="form-label">Qualification</label>
                            <input type="text" class="form-control" id="qualification" name="qualification"
                                   value="<%= tutor.getQualification() %>" required>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="specialization" class="form-label">Specialization</label>
                            <select class="form-select" id="specialization" name="specialization" required>
                                <option value="Mathematics" <%= tutor.getSpecialization().equals("Mathematics") ? "selected" : "" %>>Mathematics</option>
                                <option value="Science" <%= tutor.getSpecialization().equals("Science") ? "selected" : "" %>>Science</option>
                                <option value="English" <%= tutor.getSpecialization().equals("English") ? "selected" : "" %>>English</option>
                                <option value="Computer Science" <%= tutor.getSpecialization().equals("Computer Science") ? "selected" : "" %>>Computer Science</option>
                                <option value="Physics" <%= tutor.getSpecialization().equals("Physics") ? "selected" : "" %>>Physics</option>
                                <option value="Chemistry" <%= tutor.getSpecialization().equals("Chemistry") ? "selected" : "" %>>Chemistry</option>
                                <option value="Biology" <%= tutor.getSpecialization().equals("Biology") ? "selected" : "" %>>Biology</option>
                                <option value="History" <%= tutor.getSpecialization().equals("History") ? "selected" : "" %>>History</option>
                                <option value="Geography" <%= tutor.getSpecialization().equals("Geography") ? "selected" : "" %>>Geography</option>
                                <option value="Languages" <%= tutor.getSpecialization().equals("Languages") ? "selected" : "" %>>Languages</option>
                                <option value="Arts" <%= tutor.getSpecialization().equals("Arts") ? "selected" : "" %>>Arts</option>
                                <option value="Music" <%= tutor.getSpecialization().equals("Music") ? "selected" : "" %>>Music</option>
                                <option value="Other" <%= tutor.getSpecialization().equals("Other") ? "selected" : "" %>>Other</option>
                            </select>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="experience" class="form-label">Experience</label>
                            <select class="form-select" id="experience" name="experience" required>
                                <option value="Less than 1 year" <%= tutor.getExperience().equals("Less than 1 year") ? "selected" : "" %>>Less than 1 year</option>
                                <option value="1-2 years" <%= tutor.getExperience().equals("1-2 years") ? "selected" : "" %>>1-2 years</option>
                                <option value="3-5 years" <%= tutor.getExperience().equals("3-5 years") ? "selected" : "" %>>3-5 years</option>
                                <option value="5-10 years" <%= tutor.getExperience().equals("5-10 years") ? "selected" : "" %>>5-10 years</option>
                                <option value="More than 10 years" <%= tutor.getExperience().equals("More than 10 years") ? "selected" : "" %>>More than 10 years</option>
                            </select>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="hourlyRate" class="form-label">Hourly Rate ($)</label>
                            <input type="number" class="form-control" id="hourlyRate" name="hourlyRate"
                                   value="<%= tutor.getHourlyRate() %>" min="1" step="0.01" required>
                        </div>
                    </div>

                    <div class="text-end">
                        <button type="submit" class="btn btn-custom">
                            <i class="fas fa-save me-2"></i>Update Profile
                        </button>
                    </div>
                </form>
            </div>

            <!-- Quick Actions -->
            <div class="dashboard-card">
                <h3 class="section-title">
                    <i class="fas fa-tasks me-2"></i>Quick Actions
                </h3>

                <div class="row">
                    <div class="col-md-4 mb-3">
                        <div class="d-grid">
                            <button class="btn btn-custom" onclick="viewBookings()">
                                <i class="fas fa-calendar-alt me-2"></i>View Bookings
                            </button>
                        </div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <div class="d-grid">
                            <button class="btn btn-custom" onclick="manageSchedule()">
                                <i class="fas fa-clock me-2"></i>Manage Schedule
                            </button>
                        </div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <div class="d-grid">
                            <button class="btn btn-custom" onclick="viewProfile()">
                                <i class="fas fa-user me-2"></i>View Public Profile
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Quick action functions (placeholder for future implementation)
    function viewBookings() {
        alert('Booking management feature coming soon!');
    }

    function manageSchedule() {
        alert('Schedule management feature coming soon!');
    }

    function viewProfile() {
        alert('Public profile view feature coming soon!');
    }

    // Phone number validation
    document.getElementById('phoneNumber').addEventListener('input', function(e) {
        this.value = this.value.replace(/[^0-9]/g, '');
        if (this.value.length > 15) {
            this.value = this.value.slice(0, 15);
        }
    });

    // Hourly rate validation
    document.getElementById('hourlyRate').addEventListener('input', function(e) {
        if (this.value < 0) {
            this.value = 0;
        }
    });

    // Auto-dismiss alerts
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