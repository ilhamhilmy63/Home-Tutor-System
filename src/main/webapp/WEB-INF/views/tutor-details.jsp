<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.model.Tutor" %>
<%
  Tutor tutor = (Tutor) request.getAttribute("tutor");
  String contactSuccess = (String) request.getAttribute("contactSuccess");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title><%= tutor.getFullName() %> - Tutor Profile</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <style>
    .profile-header {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      color: white;
      padding: 3rem 0;
    }
    .profile-card {
      margin-top: -2rem;
      border: none;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
      border-radius: 15px;
    }
    .profile-avatar {
      width: 120px;
      height: 120px;
      background: linear-gradient(45deg, #667eea, #764ba2);
      border: 4px solid white;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 3rem;
      color: white;
      margin: -60px auto 0;
      border-radius: 50%;
    }
    .info-item {
      background: #f8f9fa;
      border-radius: 10px;
      padding: 1rem;
      margin-bottom: 1rem;
      border-left: 4px solid #667eea;
    }
    .specialization-badge {
      background: linear-gradient(45deg, #667eea, #764ba2);
      color: white;
      font-size: 1.1rem;
      padding: 0.5rem 1rem;
    }
    .rate-highlight {
      background: linear-gradient(45deg, #f093fb, #f5576c);
      color: white;
      font-size: 1.5rem;
      padding: 1rem;
      border-radius: 10px;
      text-align: center;
    }
    .experience-badge {
      background: linear-gradient(45deg, #4facfe, #00f2fe);
      color: white;
      padding: 0.5rem 1rem;
    }
    .contact-form {
      background: #f8f9fa;
      border-radius: 15px;
      padding: 2rem;
    }
    .btn-contact {
      background: linear-gradient(45deg, #667eea, #764ba2);
      border: none;
      color: white;
      padding: 0.75rem 2rem;
    }
    .btn-contact:hover {
      background: linear-gradient(45deg, #764ba2, #667eea);
      color: white;
      transform: translateY(-2px);
    }
  </style>
</head>
<body>
<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
  <div class="container">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/">
      <i class="fas fa-graduation-cap"></i> TutorConnect
    </a>
    <div class="navbar-nav ms-auto">
      <a class="nav-link" href="${pageContext.request.contextPath}/tutor-search">
        <i class="fas fa-arrow-left"></i> Back to Search
      </a>
      <a class="nav-link" href="${pageContext.request.contextPath}/">Home</a>
    </div>
  </div>
</nav>

<!-- Profile Header -->
<div class="profile-header">
  <div class="container text-center">
    <h1 class="display-4 mb-3">Tutor Profile</h1>
    <p class="lead">Connect with experienced educators</p>
  </div>
</div>

<!-- Profile Content -->
<div class="container">
  <div class="row justify-content-center">
    <div class="col-lg-10">
      <!-- Profile Card -->
      <div class="card profile-card">
        <!-- Avatar -->
        <div class="profile-avatar">
          <i class="fas fa-user-graduate"></i>
        </div>

        <div class="card-body pt-5">
          <!-- Contact Success Message -->
          <% if (contactSuccess != null) { %>
          <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="fas fa-check-circle"></i> <%= contactSuccess %>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
          </div>
          <% } %>

          <!-- Basic Info -->
          <div class="text-center mb-4">
            <h2 class="mb-2"><%= tutor.getFullName() %></h2>
            <span class="badge specialization-badge">
                                <i class="fas fa-book"></i> <%= tutor.getSpecialization() %>
                            </span>
            <p class="text-muted mt-2">Tutor ID: <%= tutor.getId() %></p>
          </div>

          <!-- Key Info Row -->
          <div class="row mb-4">
            <div class="col-md-6">
              <div class="rate-highlight">
                <i class="fas fa-dollar-sign"></i>
                $<%= String.format("%.2f", tutor.getHourlyRate()) %>/hour
              </div>
            </div>
            <div class="col-md-6 d-flex align-items-center justify-content-center">
                                <span class="badge experience-badge fs-6">
                                    <i class="fas fa-medal"></i> <%= tutor.getExperience() %> Experience
                                </span>
            </div>
          </div>

          <!-- Detailed Information -->
          <div class="row">
            <div class="col-md-6">
              <h4 class="mb-3"><i class="fas fa-info-circle text-primary"></i> About</h4>

              <div class="info-item">
                <h6><i class="fas fa-graduation-cap text-primary"></i> Qualification</h6>
                <p class="mb-0"><%= tutor.getQualification() %></p>
              </div>

              <div class="info-item">
                <h6><i class="fas fa-book text-primary"></i> Specialization</h6>
                <p class="mb-0"><%= tutor.getSpecialization() %></p>
              </div>

              <div class="info-item">
                <h6><i class="fas fa-medal text-primary"></i> Experience Level</h6>
                <p class="mb-0"><%= tutor.getExperience() %></p>
              </div>
            </div>

            <div class="col-md-6">
              <h4 class="mb-3"><i class="fas fa-address-book text-primary"></i> Contact Information</h4>

              <div class="info-item">
                <h6><i class="fas fa-envelope text-primary"></i> Email</h6>
                <p class="mb-0">
                  <a href="mailto:<%= tutor.getEmail() %>" class="text-decoration-none">
                    <%= tutor.getEmail() %>
                  </a>
                </p>
              </div>

              <div class="info-item">
                <h6><i class="fas fa-phone text-primary"></i> Phone</h6>
                <p class="mb-0">
                  <a href="tel:<%= tutor.getPhoneNumber() %>" class="text-decoration-none">
                    <%= tutor.getPhoneNumber() %>
                  </a>
                </p>
              </div>

              <div class="info-item">
                <h6><i class="fas fa-dollar-sign text-primary"></i> Hourly Rate</h6>
                <p class="mb-0 fw-bold text-success">
                  $<%= String.format("%.2f", tutor.getHourlyRate()) %> per hour
                </p>
              </div>
            </div>
          </div>

          <!-- Contact Form -->
          <div class="mt-5">
            <h4 class="mb-3"><i class="fas fa-comment text-primary"></i> Contact This Tutor</h4>
            <div class="contact-form">
              <form method="post" action="tutor-details">
                <input type="hidden" name="action" value="contact">
                <input type="hidden" name="tutorId" value="<%= tutor.getId() %>">

                <div class="row">
                  <div class="col-md-6 mb-3">
                    <label for="studentName" class="form-label">Your Name *</label>
                    <input type="text" class="form-control" id="studentName" name="studentName" required>
                  </div>
                  <div class="col-md-6 mb-3">
                    <label for="studentEmail" class="form-label">Your Email *</label>
                    <input type="email" class="form-control" id="studentEmail" name="studentEmail" required>
                  </div>
                </div>

                <div class="mb-3">
                  <label for="message" class="form-label">Message *</label>
                  <textarea class="form-control" id="message" name="message" rows="4"
                            placeholder="Introduce yourself and describe what you need help with..." required></textarea>
                </div>

                <div class="text-center">
                  <button type="submit" class="btn btn-contact">
                    <i class="fas fa-paper-plane"></i> Send Message
                  </button>
                </div>
              </form>
            </div>
          </div>

          <!-- Quick Actions -->
          <div class="mt-4 text-center">
            <div class="btn-group" role="group">
              <a href="mailto:<%= tutor.getEmail() %>" class="btn btn-outline-primary">
                <i class="fas fa-envelope"></i> Email Directly
              </a>
              <a href="tel:<%= tutor.getPhoneNumber() %>" class="btn btn-outline-success">
                <i class="fas fa-phone"></i> Call Now
              </a>
              <a href="${pageContext.request.contextPath}/tutor-search" class="btn btn-outline-secondary">
                <i class="fas fa-search"></i> Find Other Tutors
              </a>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Footer -->
<footer class="bg-light mt-5 py-4">
  <div class="container text-center">
    <p class="text-muted mb-0">© 2024 TutorConnect. Connecting students with great tutors.</p>
  </div>
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
