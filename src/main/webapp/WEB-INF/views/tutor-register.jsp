<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tutor Registration - Home Tutor System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .registration-container {
            margin: 50px auto;
            max-width: 600px;
        }
        .registration-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            padding: 40px;
        }
        .form-floating input, .form-floating select {
            border-radius: 15px;
            border: 2px solid #e9ecef;
            transition: all 0.3s ease;
        }
        .form-floating input:focus, .form-floating select:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
        .btn-register {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 15px;
            padding: 12px 30px;
            color: white;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
            color: white;
        }
        .alert {
            border-radius: 15px;
            border: none;
        }
        .title-icon {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="registration-container">
        <div class="registration-card">
            <div class="text-center mb-4">
                <i class="fas fa-chalkboard-teacher fa-3x title-icon mb-3"></i>
                <h2 class="fw-bold title-icon">Tutor Registration</h2>
                <p class="text-muted">Join our tutoring community and start teaching</p>
            </div>

            <!-- Error Message -->
            <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-triangle me-2"></i>
                <%= request.getAttribute("error") %>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <% } %>

            <!-- Success Message -->
            <% if (request.getAttribute("success") != null) { %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle me-2"></i>
                <%= request.getAttribute("success") %>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <% } %>

            <form method="post" action="${pageContext.request.contextPath}/tutor-register">
                <div class="row">
                    <div class="col-md-12 mb-3">
                        <div class="form-floating">
                            <input type="text" class="form-control" id="fullName" name="fullName"
                                   placeholder="Full Name" required>
                            <label for="fullName"><i class="fas fa-user me-2"></i>Full Name</label>
                        </div>
                    </div>

                    <div class="col-md-6 mb-3">
                        <div class="form-floating">
                            <input type="tel" class="form-control" id="phoneNumber" name="phoneNumber"
                                   placeholder="Phone Number" required>
                            <label for="phoneNumber"><i class="fas fa-phone me-2"></i>Phone Number</label>
                        </div>
                    </div>

                    <div class="col-md-6 mb-3">
                        <div class="form-floating">
                            <input type="email" class="form-control" id="email" name="email"
                                   placeholder="Email Address" required>
                            <label for="email"><i class="fas fa-envelope me-2"></i>Email Address</label>
                        </div>
                    </div>

                    <div class="col-md-6 mb-3">
                        <div class="form-floating">
                            <input type="password" class="form-control" id="password" name="password"
                                   placeholder="Password" required>
                            <label for="password"><i class="fas fa-lock me-2"></i>Password</label>
                        </div>
                    </div>

                    <div class="col-md-6 mb-3">
                        <div class="form-floating">
                            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword"
                                   placeholder="Confirm Password" required>
                            <label for="confirmPassword"><i class="fas fa-lock me-2"></i>Confirm Password</label>
                        </div>
                    </div>

                    <div class="col-md-12 mb-3">
                        <div class="form-floating">
                            <input type="text" class="form-control" id="qualification" name="qualification"
                                   placeholder="Qualification" required>
                            <label for="qualification"><i class="fas fa-graduation-cap me-2"></i>Qualification (e.g., BSc Computer Science)</label>
                        </div>
                    </div>

                    <div class="col-md-12 mb-3">
                        <div class="form-floating">
                            <select class="form-select" id="specialization" name="specialization" required>
                                <option value="">Choose Specialization</option>
                                <option value="Mathematics">Mathematics</option>
                                <option value="Science">Science</option>
                                <option value="English">English</option>
                                <option value="Computer Science">Computer Science</option>
                                <option value="Physics">Physics</option>
                                <option value="Chemistry">Chemistry</option>
                                <option value="Biology">Biology</option>
                                <option value="History">History</option>
                                <option value="Geography">Geography</option>
                                <option value="Languages">Languages</option>
                                <option value="Arts">Arts</option>
                                <option value="Music">Music</option>
                                <option value="Other">Other</option>
                            </select>
                            <label for="specialization"><i class="fas fa-book me-2"></i>Subject Specialization</label>
                        </div>
                    </div>

                    <div class="col-md-6 mb-3">
                        <div class="form-floating">
                            <select class="form-select" id="experience" name="experience" required>
                                <option value="">Select Experience</option>
                                <option value="Less than 1 year">Less than 1 year</option>
                                <option value="1-2 years">1-2 years</option>
                                <option value="3-5 years">3-5 years</option>
                                <option value="5-10 years">5-10 years</option>
                                <option value="More than 10 years">More than 10 years</option>
                            </select>
                            <label for="experience"><i class="fas fa-briefcase me-2"></i>Teaching Experience</label>
                        </div>
                    </div>

                    <div class="col-md-6 mb-3">
                        <div class="form-floating">
                            <input type="number" class="form-control" id="hourlyRate" name="hourlyRate"
                                   placeholder="Hourly Rate" min="1" step="0.01" required>
                            <label for="hourlyRate"><i class="fas fa-dollar-sign me-2"></i>Hourly Rate ($)</label>
                        </div>
                    </div>
                </div>

                <div class="d-grid gap-2 mt-4">
                    <button type="submit" class="btn btn-register btn-lg">
                        <i class="fas fa-user-plus me-2"></i>Register as Tutor
                    </button>
                </div>
            </form>

            <div class="text-center mt-4">
                <p class="text-muted">Already have an account?
                    <a href="${pageContext.request.contextPath}/tutor-login" class="text-decoration-none fw-bold" style="color: #667eea;">
                        Login here
                    </a>
                </p>
                <p class="text-muted">Looking for a tutor?
                    <a href="${pageContext.request.contextPath}/student-register" class="text-decoration-none fw-bold" style="color: #667eea;">
                        Register as Student
                    </a>
                </p>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Form validation
    document.querySelector('form').addEventListener('submit', function(e) {
        const password = document.getElementById('password').value;
        const confirmPassword = document.getElementById('confirmPassword').value;

        if (password !== confirmPassword) {
            e.preventDefault();
            alert('Passwords do not match!');
            return false;
        }

        if (password.length < 6) {
            e.preventDefault();
            alert('Password must be at least 6 characters long!');
            return false;
        }
    });

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
</script>
</body>
</html>