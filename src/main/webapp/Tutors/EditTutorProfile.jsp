<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Tutor Profile</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #4361ee;
            --secondary-color: #3f37c9;
            --accent-color: #4895ef;
            --light-color: #f8f9fa;
            --dark-color: #212529;
            --success-color: #4bb543;
            --error-color: #ff3333;
            --border-radius: 8px;
            --box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            --transition: all 0.3s ease;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background-color: #f5f7ff;
            color: var(--dark-color);
            line-height: 1.6;
            padding: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 1.5rem 0;
            text-align: center;
            margin-bottom: 2rem;
            box-shadow: var(--box-shadow);
        }

        .header h1 {
            font-weight: 600;
            font-size: 2rem;
        }

        .container {
            max-width: 800px;
            margin: 0 auto 3rem;
            padding: 0 1rem;
        }

        .form-container {
            background-color: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            padding: 2rem;
            margin-bottom: 2rem;
        }

        .form-section {
            margin-bottom: 1.5rem;
        }

        .form-section h2 {
            color: var(--primary-color);
            font-size: 1.3rem;
            margin-bottom: 1rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid #eee;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1.5rem;
        }

        .form-group {
            margin-bottom: 1.2rem;
        }

        .form-group.full-width {
            grid-column: span 2;
        }

        label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: var(--dark-color);
        }

        input[type="text"],
        input[type="email"],
        input[type="password"],
        input[type="tel"],
        select,
        textarea {
            width: 100%;
            padding: 0.8rem;
            border: 1px solid #ddd;
            border-radius: var(--border-radius);
            font-size: 1rem;
            transition: var(--transition);
        }

        input:focus,
        select:focus,
        textarea:focus {
            outline: none;
            border-color: var(--accent-color);
            box-shadow: 0 0 0 2px rgba(72, 149, 239, 0.2);
        }

        textarea {
            min-height: 120px;
            resize: vertical;
        }

        .availability-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1rem;
            margin-bottom: 1rem;
        }

        .availability-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .availability-item select {
            flex: 1;
        }

        .availability-item input {
            flex: 2;
        }

        .btn {
            background-color: var(--primary-color);
            color: white;
            border: none;
            padding: 0.8rem 1.5rem;
            border-radius: var(--border-radius);
            font-size: 1rem;
            font-weight: 500;
            cursor: pointer;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .btn:hover {
            background-color: var(--secondary-color);
            transform: translateY(-2px);
        }

        .btn-block {
            display: block;
            width: 100%;
        }

        .message {
            padding: 1rem;
            border-radius: var(--border-radius);
            margin-bottom: 1.5rem;
            text-align: center;
        }

        .error {
            background-color: #ffebee;
            color: var(--error-color);
            border: 1px solid #ffcdd2;
        }

        .success {
            background-color: #e8f5e9;
            color: var(--success-color);
            border: 1px solid #c8e6c9;
        }

        @media (max-width: 768px) {
            .form-grid {
                grid-template-columns: 1fr;
            }

            .form-group.full-width {
                grid-column: span 1;
            }

            .availability-grid {
                grid-template-columns: 1fr;
            }
        }

        /* Custom select arrow */
        select {
            appearance: none;
            background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='currentColor' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
            background-repeat: no-repeat;
            background-position: right 0.8rem center;
            background-size: 1rem;
        }

        /* Floating labels effect */
        .floating-label-group {
            position: relative;
            margin-bottom: 1.2rem;
        }

        .floating-label {
            position: absolute;
            pointer-events: none;
            left: 0.8rem;
            top: 0.8rem;
            transition: var(--transition);
            background-color: white;
            padding: 0 0.3rem;
            color: #777;
        }

        input:focus ~ .floating-label,
        input:not(:placeholder-shown) ~ .floating-label,
        textarea:focus ~ .floating-label,
        textarea:not(:placeholder-shown) ~ .floating-label,
        select:focus ~ .floating-label,
        select:not([value=""]):valid ~ .floating-label {
            top: -0.6rem;
            left: 0.8rem;
            font-size: 0.8rem;
            color: var(--primary-color);
        }
    </style>
</head>
<body>
<div class="header">
    <h1>Edit Your Profile</h1>
</div>

<div class="container">
    <c:if test="${not empty errors}">
        <div class="message error">
            <h3>Please correct the following errors:</h3>
            <ul>
                <c:forEach var="error" items="${errors}">
                    <li>${error.value}</li>
                </c:forEach>
            </ul>
        </div>
    </c:if>

    <div class="form-container">
        <form action="${pageContext.request.contextPath}/EditTutorProfile" method="post">
            <input type="hidden" name="id" value="${tutor.id}">

            <div class="form-section">
                <h2>Personal Information</h2>
                <div class="form-grid">
                    <div class="form-group">
                        <div class="floating-label-group">
                            <input type="text" id="name" name="name" value="${tutor.name}" placeholder=" " required>
                            <label class="floating-label" for="name">Full Name</label>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="floating-label-group">
                            <input type="email" id="email" name="email" value="${tutor.email}" placeholder=" " required>
                            <label class="floating-label" for="email">Email Address</label>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="floating-label-group">
                            <input type="tel" id="phone" name="phone" value="${tutor.phone}" placeholder=" " required>
                            <label class="floating-label" for="phone">Phone Number</label>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="floating-label-group">
                            <input type="password" id="password" name="password" value="${tutor.password}" placeholder=" " required>
                            <label class="floating-label" for="password">Password</label>
                        </div>
                    </div>
                </div>
            </div>

            <div class="form-section">
                <h2>Teaching Information</h2>
                <div class="form-grid">
                    <div class="form-group">
                        <div class="floating-label-group">
                            <input type="text" id="subject" name="subject" value="${tutor.subject}" placeholder=" " required>
                            <label class="floating-label" for="subject">Subject</label>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="floating-label-group">
                            <select id="expertise" name="expertise" required>
                                <option value="" disabled selected></option>
                                <option value="Beginner" ${tutor.expertise == 'Beginner' ? 'selected' : ''}>Beginner</option>
                                <option value="Intermediate" ${tutor.expertise == 'Intermediate' ? 'selected' : ''}>Intermediate</option>
                                <option value="Expert" ${tutor.expertise == 'Expert' ? 'selected' : ''}>Expert</option>
                            </select>
                            <label class="floating-label" for="expertise">Expertise Level</label>
                        </div>
                    </div>

                    <div class="form-group full-width">
                        <div class="floating-label-group">
                            <input type="text" id="location" name="location" value="${tutor.location}" placeholder=" " required>
                            <label class="floating-label" for="location">Teaching Location</label>
                        </div>
                    </div>

                    <div class="form-group full-width">
                        <div class="floating-label-group">
                            <textarea id="bio" name="bio" placeholder=" " required>${tutor.bio}</textarea>
                            <label class="floating-label" for="bio">About You</label>
                        </div>
                    </div>
                </div>
            </div>

            <div class="form-section">
                <h2>Availability</h2>
                <p>Select the days and times you're available for tutoring sessions</p>
                <div class="availability-grid">
                    <c:set var="days" value="${['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday']}"/>
                    <c:forEach var="day" items="${days}">
                        <div class="availability-item">
                            <select name="day${day}">
                                <option value="None" ${tutor.availability[day] == null ? 'selected' : ''}>Not Available</option>
                                <option value="${day}" ${tutor.availability[day] != null ? 'selected' : ''}>${day}</option>
                            </select>
                            <input type="text" name="time${day}" placeholder="HH:MM-HH:MM" value="${tutor.availability[day]}">
                        </div>
                    </c:forEach>
                </div>
            </div>

            <button type="submit" class="btn btn-block">Save Changes</button>
        </form>
    </div>
</div>
</body>
</html>