<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>HomeTutor.lk - Sri Lanka's Premier Tutoring Platform</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
  <style>
    :root {
      --primary-blue: #1a73e8;
      --light-blue: #e8f0fe;
      --dark-blue: #0d47a1;
      --accent-blue: #4285f4;
      --white: #ffffff;
      --light-gray: #f8f9fa;
      --dark-gray: #5f6368;
    }

    body {
      background-color: var(--light-blue);
      min-height: 100vh;
      display: flex;
      align-items: center;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    .logo-container {
      text-align: center;
      margin-bottom: 2rem;
    }

    .logo {
      font-weight: 700;
      font-size: 2.5rem;
      color: var(--primary-blue);
      margin-bottom: 0.5rem;
    }

    .logo-suffix {
      color: var(--dark-gray);
      font-weight: 300;
    }

    .hero-container {
      background: var(--white);
      border-radius: 16px;
      box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
      overflow: hidden;
      margin: 2rem 0;
    }

    .hero-header {
      background: linear-gradient(135deg, var(--primary-blue) 0%, var(--dark-blue) 100%);
      color: var(--white);
      padding: 3rem 2rem;
      text-align: center;
      position: relative;
      overflow: hidden;
    }

    .hero-header::before {
      content: "";
      position: absolute;
      top: -50%;
      left: -50%;
      width: 200%;
      height: 200%;
      background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, rgba(255,255,255,0) 70%);
      transform: rotate(30deg);
    }

    .hero-content {
      padding: 3rem 2rem;
    }

    .portal-card {
      background: var(--white);
      border-radius: 12px;
      padding: 2rem;
      text-align: center;
      margin-bottom: 1.5rem;
      transition: all 0.3s ease;
      border: 1px solid #e0e0e0;
      height: 100%;
    }

    .portal-card:hover {
      transform: translateY(-8px);
      box-shadow: 0 12px 20px rgba(0,0,0,0.08);
      border-color: var(--accent-blue);
    }

    .portal-icon {
      width: 80px;
      height: 80px;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 2rem;
      margin: 0 auto 1.5rem;
      color: var(--white);
      box-shadow: 0 4px 12px rgba(0,0,0,0.15);
    }

    .student-icon {
      background: linear-gradient(135deg, #34a853 0%, #00c853 100%);
    }

    .tutor-icon {
      background: linear-gradient(135deg, #fbbc05 0%, #ffa000 100%);
    }

    .admin-icon {
      background: linear-gradient(135deg, #ea4335 0%, #d50000 100%);
    }

    .btn-portal {
      padding: 12px 28px;
      font-weight: 600;
      letter-spacing: 0.5px;
      border-radius: 24px;
      text-decoration: none;
      display: inline-block;
      transition: all 0.3s ease;
      margin: 0.25rem;
      width: 100%;
      max-width: 200px;
    }

    .btn-portal:hover {
      transform: translateY(-2px);
      box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    }

    .btn-student {
      background: linear-gradient(135deg, #34a853 0%, #00c853 100%);
      color: var(--white);
      border: none;
    }

    .btn-tutor {
      background: linear-gradient(135deg, #fbbc05 0%, #ffa000 100%);
      color: var(--white);
      border: none;
    }

    .btn-admin {
      background: linear-gradient(135deg, #ea4335 0%, #d50000 100%);
      color: var(--white);
      border: none;
    }

    .btn-outline-student {
      border: 2px solid #34a853;
      color: #34a853;
      background: transparent;
    }

    .btn-outline-tutor {
      border: 2px solid #fbbc05;
      color: #fbbc05;
      background: transparent;
    }

    .btn-outline-admin {
      border: 2px solid #ea4335;
      color: #ea4335;
      background: transparent;
    }

    .feature-list {
      list-style: none;
      padding: 0;
    }

    .feature-list li {
      padding: 0.75rem 0;
      color: var(--dark-gray);
      font-size: 1.05rem;
      border-bottom: 1px solid #f0f0f0;
    }

    .feature-list i {
      width: 24px;
      text-align: center;
      margin-right: 0.75rem;
      color: var(--primary-blue);
    }

    .section-title {
      color: var(--primary-blue);
      position: relative;
      padding-bottom: 0.5rem;
      margin-bottom: 1.5rem;
    }

    .section-title::after {
      content: "";
      position: absolute;
      bottom: 0;
      left: 50%;
      transform: translateX(-50%);
      width: 80px;
      height: 3px;
      background: linear-gradient(90deg, var(--primary-blue) 0%, var(--accent-blue) 100%);
      border-radius: 3px;
    }

    .testimonial-card {
      background: var(--white);
      border-radius: 12px;
      padding: 1.5rem;
      margin-bottom: 1rem;
      box-shadow: 0 4px 12px rgba(0,0,0,0.05);
      border-left: 4px solid var(--primary-blue);
    }

    .testimonial-text {
      font-style: italic;
      color: var(--dark-gray);
    }

    .testimonial-author {
      font-weight: 600;
      color: var(--primary-blue);
      margin-top: 1rem;
    }

    footer {
      background: var(--primary-blue);
      color: var(--white);
      padding: 1.5rem;
      border-radius: 0 0 12px 12px;
    }

    .social-icon {
      color: var(--white);
      font-size: 1.25rem;
      margin: 0 0.5rem;
      transition: all 0.3s ease;
    }

    .social-icon:hover {
      color: var(--light-blue);
      transform: translateY(-3px);
    }

    @media (max-width: 768px) {
      .hero-header {
        padding: 2rem 1rem;
      }

      .hero-content {
        padding: 2rem 1rem;
      }

      .portal-card {
        padding: 1.5rem;
      }
    }
  </style>
</head>
<body>
<div class="container">
  <div class="row justify-content-center">
    <div class="col-lg-10">
      <div class="logo-container">
        <div class="logo">Home<span class="logo-suffix">Tutor.lk</span></div>
        <p class="text-muted">Sri Lanka's Premier Online Tutoring Platform</p>
      </div>

      <div class="hero-container">
        <div class="hero-header">
          <i class="fas fa-chalkboard-teacher fa-3x mb-4"></i>
          <h1 class="display-5 mb-3 fw-bold">Personalized Learning Experience</h1>
          <p class="lead mb-0">Connect with the best tutors across Sri Lanka</p>
          <p class="opacity-90">Quality education at your fingertips</p>
        </div>

        <div class="hero-content">
          <div class="row mb-5">
            <div class="col-md-4 mb-4">
              <div class="portal-card">
                <div class="portal-icon student-icon">
                  <i class="fas fa-user-graduate"></i>
                </div>
                <h4 class="mb-3">Student Portal</h4>
                <p class="text-muted mb-4">Find the perfect tutor, schedule sessions, and track your learning progress.</p>
                <div class="d-grid gap-2 d-flex flex-column align-items-center">
                  <a href="student-login" class="btn btn-student btn-portal">
                    <i class="fas fa-sign-in-alt me-2"></i>Student Login
                  </a>
                  <a href="student-register" class="btn btn-outline-student btn-portal">
                    <i class="fas fa-user-plus me-2"></i>Register
                  </a>
                </div>
              </div>
            </div>

            <div class="col-md-4 mb-4">
              <div class="portal-card">
                <div class="portal-icon tutor-icon">
                  <i class="fas fa-chalkboard-teacher"></i>
                </div>
                <h4 class="mb-3">Tutor Portal</h4>
                <p class="text-muted mb-4">Manage your students, schedule, and teaching materials in one place.</p>
                <div class="d-grid gap-2 d-flex flex-column align-items-center">
                  <a href="tutor-login" class="btn btn-tutor btn-portal">
                    <i class="fas fa-sign-in-alt me-2"></i>Tutor Login
                  </a>
                  <a href="tutor-register" class="btn btn-outline-tutor btn-portal">
                    <i class="fas fa-user-plus me-2"></i>Apply Now
                  </a>
                </div>
              </div>
            </div>

            <div class="col-md-4 mb-4">
              <div class="portal-card">
                <div class="portal-icon admin-icon">
                  <i class="fas fa-user-shield"></i>
                </div>
                <h4 class="mb-3">Admin Portal</h4>
                <p class="text-muted mb-4">Manage the platform, verify tutors, and oversee system operations.</p>
                <div class="d-grid gap-2 d-flex flex-column align-items-center">
                  <a href="admin-login" class="btn btn-admin btn-portal">
                    <i class="fas fa-sign-in-alt me-2"></i>Admin Login
                  </a>
                  <a href="admin-register" class="btn btn-outline-admin btn-portal">
                    <i class="fas fa-user-plus me-2"></i>Register
                  </a>
                </div>
              </div>
            </div>
          </div>

          <div class="row mb-5">
            <div class="col-12 text-center">
              <h3 class="section-title">Why Choose HomeTutor.lk?</h3>
            </div>
            <div class="col-md-6">
              <ul class="feature-list">
                <li><i class="fas fa-check"></i>Verified, qualified tutors across Sri Lanka</li>
                <li><i class="fas fa-check"></i>Personalized 1-on-1 learning sessions</li>
                <li><i class="fas fa-check"></i>Flexible scheduling to suit your routine</li>
                <li><i class="fas fa-check"></i>All subjects from Grade 1 to Advanced Levels</li>
              </ul>
            </div>
            <div class="col-md-6">
              <ul class="feature-list">
                <li><i class="fas fa-check"></i>Interactive online whiteboard technology</li>
                <li><i class="fas fa-check"></i>Progress tracking and performance reports</li>
                <li><i class="fas fa-check"></i>Affordable rates with secure payments</li>
                <li><i class="fas fa-check"></i>24/7 customer support</li>
              </ul>
            </div>
          </div>

          <div class="row mb-4">
            <div class="col-12 text-center">
              <h3 class="section-title">What Our Users Say</h3>
            </div>
            <div class="col-md-4 mb-3">
              <div class="testimonial-card">
                <p class="testimonial-text">"HomeTutor.lk helped my daughter improve her maths grade from C to A in just 3 months. The tutor was patient and knowledgeable."</p>
                <div class="testimonial-author">- Nimali F., Parent</div>
              </div>
            </div>
            <div class="col-md-4 mb-3">
              <div class="testimonial-card">
                <p class="testimonial-text">"As a tutor, I love the platform's tools and the quality of students. It's been a rewarding experience teaching through HomeTutor.lk."</p>
                <div class="testimonial-author">- Rajitha P., Tutor</div>
              </div>
            </div>
            <div class="col-md-4 mb-3">
              <div class="testimonial-card">
                <p class="testimonial-text">"The convenience of learning from home with top tutors has been invaluable for my A/L exam preparation. Highly recommended!"</p>
                <div class="testimonial-author">- Sandun M., Student</div>
              </div>
            </div>
          </div>
        </div>

        <footer class="text-center">
          <div class="mb-3">
            <a href="#" class="social-icon"><i class="fab fa-facebook-f"></i></a>
            <a href="#" class="social-icon"><i class="fab fa-twitter"></i></a>
            <a href="#" class="social-icon"><i class="fab fa-linkedin-in"></i></a>
            <a href="#" class="social-icon"><i class="fab fa-instagram"></i></a>
          </div>
          <p class="mb-2">© 2023 HomeTutor.lk - All Rights Reserved</p>
          <p class="mb-0">
            <a href="#" class="text-white me-3">Privacy Policy</a>
            <a href="#" class="text-white me-3">Terms of Service</a>
            <a href="#" class="text-white">Contact Us</a>
          </p>
        </footer>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>