<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Reset Password | Home Tutor System</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" rel="stylesheet">
  <style>
    body {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      height: 100vh;
      display: flex;
      align-items: center;
    }
    .reset-card {
      background: rgba(255, 255, 255, 0.9);
      border-radius: 15px;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
      overflow: hidden;
      transition: all 0.3s ease;
    }
    .reset-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 15px 35px rgba(0, 0, 0, 0.3);
    }
    .reset-header {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      color: white;
      padding: 20px;
      text-align: center;
    }
    .form-control:focus {
      border-color: #764ba2;
      box-shadow: 0 0 0 0.25rem rgba(118, 75, 162, 0.25);
    }
    .btn-update {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      border: none;
      width: 100%;
      padding: 12px;
      font-weight: 600;
      transition: all 0.3s;
    }
    .btn-update:hover {
      transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
    }
  </style>
</head>
<body>
<div class="container">
  <div class="row justify-content-center">
    <div class="col-md-6 col-lg-4">
      <div class="reset-card animate__animated animate__fadeIn">
        <div class="reset-header">
          <h3>Reset Password</h3>
          <p>Enter your new password</p>
        </div>
        <div class="card-body p-4">
          <% if (request.getParameter("error") != null) { %>
          <div class="alert alert-danger animate__animated animate__shakeX">
            <%= request.getParameter("error") %>
          </div>
          <% } %>
          <% if (request.getParameter("token") == null) { %>
          <div class="alert alert-danger animate__animated animate__shakeX">
            Invalid or expired token
          </div>
          <% } else { %>
          <form action="reset-password" method="post">
            <input type="hidden" name="token" value="<%= request.getParameter("token") %>">
            <div class="mb-3">
              <label for="newPassword" class="form-label">New Password</label>
              <input type="password" class="form-control" id="newPassword" name="newPassword" required minlength="8">
            </div>
            <div class="mb-3">
              <label for="confirmPassword" class="form-label">Confirm Password</label>
              <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required minlength="8">
            </div>
            <button type="submit" class="btn btn-update btn-primary mb-3">Update Password</button>
          </form>
          <% } %>
          <div class="text-center">
            <a href="auth/login.jsp" style="color: #764ba2;">Back to Login</a>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
  document.getElementById('registrationForm').addEventListener('submit', function(e) {
    const password = document.getElementById('newPassword').value;
    const confirmPassword = document.getElementById('confirmPassword').value;

    if (password !== confirmPassword) {
      e.preventDefault();
      alert('Passwords do not match!');
    }
  });
</script>
</body>
</html>