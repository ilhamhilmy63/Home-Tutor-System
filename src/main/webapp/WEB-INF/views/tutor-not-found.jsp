<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tutor Not Found - TutorConnect</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .error-container {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            min-height: 100vh;
            display: flex;
            align-items: center;
        }
        .error-card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 3rem;
            text-align: center;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        .error-icon {
            font-size: 5rem;
            margin-bottom: 2rem;
            color: rgba(255, 255, 255, 0.8);
        }
        .btn-home {
            background: rgba(255, 255, 255, 0.2);
            border: 2px solid rgba(255, 255, 255, 0.3);
            color: white;
            padding: 0.75rem 2rem;
            border-radius: 25px;
            transition: all 0.3s ease;
        }
        .btn-home:hover {
            background: rgba(255, 255, 255, 0.3);
            border-color: rgba(255, 255, 255, 0.5);
            color: white;
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
<div class="error-container">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-6 col-md-8">
                <div class="error-card">
                    <i class="fas fa-user-slash error-icon"></i>
                    <h1 class="mb-3">Tutor Not Found</h1>
                    <p class="lead mb-4">
                        <% if (error != null) { %>
                        <%= error %>
                        <% } else { %>
                        The tutor you're looking for doesn't exist or may have been removed.
                        <% } %>
                    </p>
                    <p class="mb-4">Don't worry! There are many other great tutors available.</p>

                    <div class="d-flex flex-column flex-md-row gap-3 justify-content-center">
                        <a href="${pageContext.request.contextPath}/tutor-search" class="btn btn-home">
                            <i class="fas fa-search"></i> Search Tutors
                        </a>
                        <a href="${pageContext.request.contextPath}/" class="btn btn-home">
                            <i class="fas fa-home"></i> Go Home
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>