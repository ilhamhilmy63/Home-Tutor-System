<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register | Home Tutor System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            height: 100vh;
            display: flex;
            align-items: center;
        }
        .register-card {
            background: rgba(255, 255, 255, 0.9);
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            overflow: hidden;
            transition: all 0.3s ease;
        }
        .register-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.3);
        }
        .register-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px;
            text-align: center;
        }
        .form-control:focus {
            border-color: #764ba2;
            box-shadow: 0 0 0 0.25rem rgba(118, 75, 162, 0.25);
        }
        .btn-register {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            width: 100%;
            padding: 12px;
            font-weight: 600;
            transition: all 0.3s;
        }
        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }
        #tutorFields {
            display: none;
            animation: fadeIn 0.5s;
        }
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        .error-message {
            color: #dc3545;
            font-size: 0.875em;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6">
            <div class="register-card animate__animated animate__fadeIn">
                <div class="register-header">
                    <h3>Create an Account</h3>
                    <p>Join our home tutor community</p>
                </div>
                <div class="card-body p-4">
                    <% if (request.getAttribute("error") != null) { %>
                    <div class="alert alert-danger animate__animated animate__shakeX">
                        ${error}
                    </div>
                    <% } %>
                    <form action="${pageContext.request.contextPath}/auth/register" method="post" id="registrationForm">
                        <div class="mb-3">
                            <label class="form-label">I am a</label>
                            <div class="d-flex gap-3">
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="role" id="studentRole" value="student" checked>
                                    <label class="form-check-label" for="studentRole">Student</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="role" id="tutorRole" value="tutor">
                                    <label class="form-check-label" for="tutorRole">Tutor</label>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="name" class="form-label">Full Name</label>
                                <input type="text" class="form-control" id="name" name="name" required>
                                <div class="error-message" id="nameError"></div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="email" class="form-label">Email</label>
                                <input type="email" class="form-control" id="email" name="email" required>
                                <div class="error-message" id="emailError"></div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="phone" class="form-label">Phone Number</label>
                                <input type="tel" class="form-control" id="phone" name="phone" required>
                                <div class="error-message" id="phoneError"></div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="password" class="form-label">Password</label>
                                <input type="password" class="form-control" id="password" name="password" required minlength="8">
                                <div class="error-message" id="passwordError"></div>
                            </div>
                        </div>
                        <div id="tutorFields">
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="primarySubject" class="form-label">Primary Subject</label>
                                    <input type="text" class="form-control" id="primarySubject" name="primarySubject">
                                    <div class="error-message" id="subjectError"></div>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="hourlyRate" class="form-label">Hourly Rate ($)</label>
                                    <input type="number" step="0.01" class="form-control" id="hourlyRate" name="hourlyRate">
                                    <div class="error-message" id="rateError"></div>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="qualification" class="form-label">Qualification</label>
                                <input type="text" class="form-control" id="qualification" name="qualification">
                            </div>
                        </div>
                        <button type="submit" class="btn btn-register btn-primary mt-3">Register</button>
                    </form>
                    <div class="text-center mt-3">
                        <p>Already have an account? <a href="${pageContext.request.contextPath}/auth/login.jsp" style="color: #764ba2;">Login here</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const tutorRole = document.getElementById('tutorRole');
        const studentRole = document.getElementById('studentRole');
        const tutorFields = document.getElementById('tutorFields');

        tutorRole.addEventListener('change', function() {
            if(this.checked) {
                tutorFields.style.display = 'block';
                // Make tutor fields required
                document.getElementById('primarySubject').required = true;
                document.getElementById('hourlyRate').required = true;
            }
        });

        studentRole.addEventListener('change', function() {
            if(this.checked) {
                tutorFields.style.display = 'none';
                // Remove required from tutor fields
                document.getElementById('primarySubject').required = false;
                document.getElementById('hourlyRate').required = false;
            }
        });

        // Client-side validation
        document.getElementById('registrationForm').addEventListener('submit', function(e) {
            let isValid = true;

            // Validate name
            const name = document.getElementById('name').value.trim();
            if (name === '' || name.length > 100) {
                document.getElementById('nameError').textContent =
                    name === '' ? 'Name is required' : 'Name must be 100 characters or less';
                isValid = false;
            } else {
                document.getElementById('nameError').textContent = '';
            }

            // Validate email
            const email = document.getElementById('email').value.trim();
            const emailRegex = /^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$/;
            if (!emailRegex.test(email)) {
                document.getElementById('emailError').textContent = 'Invalid email format';
                isValid = false;
            } else {
                document.getElementById('emailError').textContent = '';
            }

            // Validate phone
            const phone = document.getElementById('phone').value.trim();
            const phoneRegex = /^[0-9]{10,15}$/;
            if (!phoneRegex.test(phone)) {
                document.getElementById('phoneError').textContent = 'Phone must be 10-15 digits';
                isValid = false;
            } else {
                document.getElementById('phoneError').textContent = '';
            }

            // Validate password
            const password = document.getElementById('password').value;
            if (password.length < 8) {
                document.getElementById('passwordError').textContent = 'Password must be at least 8 characters';
                isValid = false;
            } else {
                document.getElementById('passwordError').textContent = '';
            }

            // Validate tutor fields if tutor is selected
            if (tutorRole.checked) {
                const subject = document.getElementById('primarySubject').value.trim();
                if (subject === '') {
                    document.getElementById('subjectError').textContent = 'Primary subject is required';
                    isValid = false;
                } else {
                    document.getElementById('subjectError').textContent = '';
                }

                const rate = document.getElementById('hourlyRate').value;
                if (isNaN(rate) {
                    document.getElementById('rateError').textContent = 'Invalid hourly rate';
                    isValid = false;
                } else {
                    document.getElementById('rateError').textContent = '';
                }
            }

            if (!isValid) {
                e.preventDefault();
            }
        });
    });
</script>
</body>
</html>