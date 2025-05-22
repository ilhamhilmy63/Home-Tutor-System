<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tutor Login - HomeTutor.lk</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Arial, sans-serif;
        }
        body {
            background-color: #e8f0fe;
            color: #1e3a8a;
            line-height: 1.6;
        }
        .card {
            border: none;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }
        .card-header {
            background-color: #2563eb;
            color: white;
            border-radius: 8px 8px 0 0;
        }
        label {
            color: #1e3a8a;
            font-weight: 500;
        }
        input[type="email"],
        input[type="password"] {
            border: 1px solid #93c5fd;
            border-radius: 4px;
            background-color: #f0f9ff;
        }
        .btn-primary {
            background-color: #2563eb;
            border-radius: 4px;
            border: none;
        }
        .btn-primary:hover {
            background-color: #1e40af;
        }
        .error-message {
            color: #dc3545;
            font-size: 0.875rem;
            margin-top: 0.25rem;
        }
        .is-invalid {
            border-color: #dc3545;
        }
        a {
            color: #1d4ed8;
            text-decoration: none;
            transition: color 0.3s ease;
        }
        a:hover {
            color: #60a5fa;
        }
        .alert {
            border-radius: 4px;
            padding: 10px;
            margin-bottom: 15px;
        }
        @media (max-width: 600px) {
            .card {
                margin: 10px;
            }
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow">
                <div class="card-header bg-primary text-white">
                    <h3 class="text-center">Tutor Login</h3>
                </div>
                <div class="card-body">
                    <c:if test="${not empty message}">
                        <div class="alert alert-success">${message}</div>
                        <% session.removeAttribute("message"); %>
                    </c:if>
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">
                                ${error}
                            <c:if test="${error.contains('Please register first')}">
                                <br><a href="${pageContext.request.contextPath}/Tutors/TutorRegister.jsp">Register now</a>
                            </c:if>
                        </div>
                    </c:if>
                    <form id="tutorLoginForm" action="${pageContext.request.contextPath}/tutorLogin" method="post" onsubmit="return validateForm()">
                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" class="form-control" id="email" name="email" required>
                            <div id="emailError" class="error-message"></div>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">Password</label>
                            <input type="password" class="form-control" id="password" name="password" required>
                            <div id="passwordError" class="error-message"></div>
                        </div>
                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary">Login</button>
                        </div>
                    </form>
                    <div class="mt-3 text-center">
                        <p>Don't have an account? <a href="${pageContext.request.contextPath}/Tutors/TutorRegister.jsp">Register as Tutor</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function validateForm() {
        console.log('Starting login form validation...');
        let isValid = true;
        document.querySelectorAll('.error-message').forEach(el => el.textContent = '');
        document.querySelectorAll('.is-invalid').forEach(el => el.classList.remove('is-invalid'));

        const fields = [
            {
                id: 'email',
                errorId: 'emailError',
                message: 'Valid email is required',
                validate: val => /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(val.trim())
            },
            {
                id: 'password',
                errorId: 'passwordError',
                message: 'Password is required',
                validate: val => val.trim() !== ''
            }
        ];

        fields.forEach(field => {
            const value = document.getElementById(field.id).value;
            if (!field.validate(value)) {
                document.getElementById(field.errorId).textContent = field.message;
                document.getElementById(field.id).classList.add('is-invalid');
                isValid = false;
                console.log(`Validation failed for ${field.id}: ${field.message}`);
            }
        });

        console.log('Login form validation ' + (isValid ? 'passed' : 'failed'));
        return isValid;
    }
</script>
</body>
</html>