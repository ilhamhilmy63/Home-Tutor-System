<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tutor Registration - HomeTutor.lk</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .error-message { color: #dc3545; font-size: 0.875rem; margin-top: 0.25rem; }
        .is-invalid { border-color: #dc3545; }
        label {
            color: #1e3a8a;
            font-weight: 500;
        }
        input[type="text"],
        input[type="email"],
        input[type="tel"],
        input[type="password"],
        textarea,
        select {
            border: 1px solid #93c5fd;
            border-radius: 4px;
            background-color: #f0f9ff;
        }
        textarea {
            resize: vertical;
            min-height: 100px;
        }
        .add-another-day {
            background-color: #a78bfa;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin: 10px 0;
        }
        .add-another-day:hover {
            background-color: #8b5cf6;
        }
        #availability div {
            display: flex;
            gap: 10px;
            margin-bottom: 10px;
        }
        #availability select,
        #availability input[type="text"] {
            flex: 1;
        }
        .btn-primary {
            background-color: #2563eb;
            border-radius: 4px;
        }
        .btn-primary:hover {
            background-color: #1e40af;
        }
        .alert {
            border-radius: 4px;
            padding: 10px;
            margin-bottom: 15px;
        }
        @media (max-width: 600px) {
            #availability div {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card shadow">
                <div class="card-header bg-primary text-white">
                    <h3 class="text-center">Register as a Tutor</h3>
                </div>
                <div class="card-body">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">
                                ${error}
                            <c:if test="${error.contains('already registered')}">
                                <br><a href="${pageContext.request.contextPath}/Tutors/TutorLogin.jsp">Log in here</a>
                            </c:if>
                        </div>
                    </c:if>
                    <c:if test="${not empty message}">
                        <div class="alert alert-success">${message}</div>
                    </c:if>

                    <form id="tutorRegisterForm" action="${pageContext.request.contextPath}/registerTutor" method="post" onsubmit="return validateForm()">
                        <input type="hidden" name="role" value="tutor">

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
                            <input type="tel" class="form-control" id="phone" name="phone">
                            <div id="phoneError" class="error-message"></div>
                        </div>

                        <div class="mb-3">
                            <label for="password" class="form-label">Password</label>
                            <input type="password" class="form-control" id="password" name="password" required>
                            <div id="passwordError" class="error-message"></div>
                        </div>

                        <div class="mb-3">
                            <label for="subjects" class="form-label">Subject</label>
                            <input type="text" class="form-control" id="subjects" name="subjects" required>
                            <div id="subjectError" class="error-message"></div>
                        </div>

                        <div class="mb-3">
                            <label for="location" class="form-label">Location</label>
                            <input type="text" class="form-control" id="location" name="location" required>
                            <div id="locationError" class="error-message"></div>
                        </div>

                        <div class="mb-3">
                            <label for="bio" class="form-label">Bio</label>
                            <textarea class="form-control" id="bio" name="bio" required></textarea>
                            <div id="bioError" class="error-message"></div>
                        </div>

                        <div class="mb-3">
                            <label>Availability</label>
                            <div id="availability">
                                <div>
                                    <select name="day0" class="form-control">
                                        <option value="None">None</option>
                                        <option value="Monday">Monday</option>
                                        <option value="Tuesday">Tuesday</option>
                                        <option value="Wednesday">Wednesday</option>
                                        <option value="Thursday">Thursday</option>
                                        <option value="Friday">Friday</option>
                                        <option value="Saturday">Saturday</option>
                                        <option value="Sunday">Sunday</option>
                                    </select>
                                    <input type="text" name="time0" class="form-control" placeholder="e.g., 14:00-16:00">
                                </div>
                            </div>
                            <button type="button" class="add-another-day" onclick="addAvailability()">Add Another Day</button>
                        </div>

                        <div class="mb-3">
                            <label for="expertise" class="form-label">Expertise</label>
                            <select name="expertise" id="expertise" class="form-control" required>
                                <option value="None">Select Expertise</option>
                                <option value="Basic">Basic</option>
                                <option value="Intermediate">Intermediate</option>
                                <option value="Expert">Expert</option>
                            </select>
                            <div id="expertiseError" class="error-message"></div>
                        </div>

                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary">Register</button>
                        </div>
                    </form>

                    <div class="mt-3 text-center">
                        <p>Already have an account? <a href="${pageContext.request.contextPath}/Tutors/TutorLogin.jsp">Login</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    let dayCount = 1;
    function addAvailability() {
        console.log('Adding availability slot #' + dayCount);
        const container = document.getElementById('availability');
        const div = document.createElement('div');
        div.className = 'd-flex gap-2 mb-2';
        div.innerHTML = `
            <select name="day${dayCount}" class="form-control">
                <option value="None">None</option>
                <option value="Monday">Monday</option>
                <option value="Tuesday">Tuesday</option>
                <option value="Wednesday">Wednesday</option>
                <option value="Thursday">Thursday</option>
                <option value="Friday">Friday</option>
                <option value="Saturday">Saturday</option>
                <option value="Sunday">Sunday</option>
            </select>
            <input type="text" name="time${dayCount}" class="form-control" placeholder="e.g., 14:00-16:00">
        `;
        container.appendChild(div);
        dayCount++;
    }

    function validateForm() {
        console.log('Starting tutor form validation...');
        let isValid = true;
        document.querySelectorAll('.error-message').forEach(el => el.textContent = '');
        document.querySelectorAll('.is-invalid').forEach(el => el.classList.remove('is-invalid'));

        const fields = [
            { id: 'name', errorId: 'nameError', message: 'Full name is required', validate: val => val.trim() !== '' },
            { id: 'email', errorId: 'emailError', message: 'Valid email is required', validate: val => /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(val.trim()) },
            { id: 'password', errorId: 'passwordError', message: 'Password is required', validate: val => val.trim() !== '' },
            { id: 'subjects', errorId: 'subjectError', message: 'Subject is required', validate: val => val.trim() !== '' },
            { id: 'location', errorId: 'locationError', message: 'Location is required', validate: val => val.trim() !== '' },
            { id: 'bio', errorId: 'bioError', message: 'Bio is required', validate: val => val.trim() !== '' },
            { id: 'expertise', errorId: 'expertiseError', message: 'Expertise level is required', validate: val => val !== 'None' }
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

        for (let i = 0; i < dayCount; i++) {
            const day = document.querySelector(`select[name="day${i}"]`).value;
            const time = document.querySelector(`input[name="time${i}"]`).value.trim();
            if (day !== 'None' && time && !time.match(/^\d{2}:\d{2}-\d{2}:\d{2}$/)) {
                alert(`Invalid time format for ${day}. Use HH:MM-HH:MM`);
                isValid = false;
                console.log(`Invalid time format for day${i}: ${time}`);
            }
        }

        console.log('Tutor form validation ' + (isValid ? 'passed' : 'failed'));
        if (isValid) {
            console.log('Submitting form to: ' + document.getElementById('tutorRegisterForm').action);
        }
        return isValid;
    }
</script>
</body>
</html>