<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - HomeTutor.lk</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .role-selection { display: flex; justify-content: center; margin-bottom: 20px; }
        .role-option { padding: 20px; margin: 0 10px; border: 2px solid #dee2e6; border-radius: 10px; cursor: pointer; transition: all 0.3s; text-align: center; }
        .role-option:hover { border-color: #0d6efd; }
        .role-option.active { border-color: #0d6efd; background-color: #f8f9fa; }
        .tutor-fields { display: none; }
        .error-message { color: #dc3545; font-size: 0.875rem; margin-top: 0.25rem; }
        .is-invalid { border-color: #dc3545; }
    </style>
</head>
<body>
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card shadow">
                <div class="card-header bg-primary text-white">
                    <h3 class="text-center">Create an Account</h3>
                </div>
                <div class="card-body">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>

                    <form id="registerForm" action="${pageContext.request.contextPath}/auth/login.jsp" method="post" onsubmit="return validateForm()">
                        <input type="hidden" id="role" name="role" value="">

                        <div class="role-selection">
                            <div class="role-option" onclick="selectRole('student')" id="studentOption">
                                <h4>I'm a Student</h4>
                                <p>Looking for a tutor</p>
                            </div>
                            <div class="role-option" onclick="selectRole('tutor')" id="tutorOption">
                                <h4>I'm a Tutor</h4>
                                <p>Want to reach students</p>
                            </div>
                        </div>
                        <div id="roleError" class="error-message mb-3"></div>

                        <div class="mb-3">
                            <label for="name" class="form-label">Full Name</label>
                            <input type="text" class="form-control" id="name" name="name" required>
                            <div id="nameError" class="error-message"></div>
                        </div>

                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" class="form-control" id="email" name="email" required>
                            <div id="emailError" class="error-message"></div>
                        </div>

                        <div class="mb-3">
                            <label for="phone" class="form-label">Phone Number</label>
                            <input type="tel" class="form-control" id="phone" name="phone" required>
                            <div id="phoneError" class="error-message"></div>
                        </div>

                        <div class="mb-3">
                            <label for="password" class="form-label">Password</label>
                            <input type="password" class="form-control" id="password" name="password" required minlength="8">
                            <div id="passwordError" class="error-message"></div>
                        </div>

                        <div id="tutorFields" class="tutor-fields">
                            <div class="mb-3">
                                <label for="primarySubject" class="form-label">Primary Subject</label>
                                <input type="text" class="form-control" id="primarySubject" name="primarySubject">
                                <div id="subjectError" class="error-message"></div>
                            </div>

                            <div class="mb-3">
                                <label for="hourlyRate" class="form-label">Hourly Rate (LKR)</label>
                                <input type="number" class="form-control" id="hourlyRate" name="hourlyRate" step="0.01" min="0">
                                <div id="rateError" class="error-message"></div>
                            </div>

                            <div class="mb-3">
                                <label for="qualification" class="form-label">Qualification</label>
                                <input type="text" class="form-control" id="qualification" name="qualification">
                            </div>
                        </div>

                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary">Register</button>
                        </div>
                    </form>

                    <div class="mt-3 text-center">
                        <p>Already have an account? <a href="${pageContext.request.contextPath}/auth/login.jsp">Login</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function selectRole(role) {
        document.getElementById('role').value = role;
        document.getElementById('roleError').textContent = '';

        // Update UI for role selection
        document.getElementById('studentOption').classList.remove('active');
        document.getElementById('tutorOption').classList.remove('active');
        document.querySelector(`#${role}Option`).classList.add('active');

        // Show/hide fields based on role
        document.getElementById('tutorFields').style.display = role === 'tutor' ? 'block' : 'none';
    }

    function validateForm() {
        let isValid = true;

        // Reset errors
        document.querySelectorAll('.error-message').forEach(el => el.textContent = '');
        document.querySelectorAll('.is-invalid').forEach(el => el.classList.remove('is-invalid'));

        // Validate role
        const role = document.getElementById('role').value;
        if (!role) {
            document.getElementById('roleError').textContent = 'Please select whether you are a Student or Tutor';
            isValid = false;
        }

        // Validate name
        const name = document.getElementById('name').value.trim();
        if (!name) {
            document.getElementById('nameError').textContent = 'Full name is required';
            document.getElementById('name').classList.add('is-invalid');
            isValid = false;
        } else if (name.length > 100) {
            document.getElementById('nameError').textContent = 'Name cannot exceed 100 characters';
            document.getElementById('name').classList.add('is-invalid');
            isValid = false;
        }

        // Validate email
        const email = document.getElementById('email').value.trim();
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!email) {
            document.getElementById('emailError').textContent = 'Email is required';
            document.getElementById('email').classList.add('is-invalid');
            isValid = false;
        } else if (!emailRegex.test(email)) {
            document.getElementById('emailError').textContent = 'Please enter a valid email address';
            document.getElementById('email').classList.add('is-invalid');
            isValid = false;
        }

        // Validate phone
        const phone = document.getElementById('phone').value.trim();
        const phoneRegex = /^[0-9]{10}$/;
        if (!phone) {
            document.getElementById('phoneError').textContent = 'Phone number is required';
            document.getElementById('phone').classList.add('is-invalid');
            isValid = false;
        } else if (!phoneRegex.test(phone)) {
            document.getElementById('phoneError').textContent = 'Phone number must be 10 digits';
            document.getElementById('phone').classList.add('is-invalid');
            isValid = false;
        }

        // Validate password
        const password = document.getElementById('password').value;
        if (!password) {
            document.getElementById('passwordError').textContent = 'Password is required';
            document.getElementById('password').classList.add('is-invalid');
            isValid = false;
        } else if (password.length < 8) {
            document.getElementById('passwordError').textContent = 'Password must be at least 8 characters';
            document.getElementById('password').classList.add('is-invalid');
            isValid = false;
        }

        // Validate tutor-specific fields if tutor is selected
        if (role === 'tutor') {
            const subject = document.getElementById('primarySubject').value.trim();
            if (!subject) {
                document.getElementById('subjectError').textContent = 'Primary subject is required';
                document.getElementById('primarySubject').classList.add('is-invalid');
                isValid = false;
            }

            const hourlyRate = document.getElementById('hourlyRate').value;
            if (!hourlyRate) {
                document.getElementById('rateError').textContent = 'Hourly rate is required';
                document.getElementById('hourlyRate').classList.add('is-invalid');
                isValid = false;
            } else if (parseFloat(hourlyRate) <= 0) {
                document.getElementById('rateError').textContent = 'Hourly rate must be positive';
                document.getElementById('hourlyRate').classList.add('is-invalid');
                isValid = false;
            }
        }

        return isValid;
    }
</script>
</body>
</html>