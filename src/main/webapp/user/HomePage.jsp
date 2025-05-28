<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>HomeTutor.lk - Find the Best Tutors in Sri Lanka</title>
  <style>
    /* Main CSS Styles */
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      margin: 0;
      padding: 0;
      background-color: #f8f9fa;
      color: #333;
      line-height: 1.6;
    }

    /* Header Styles */
    header {
      background: linear-gradient(135deg, #1e88e5, #0d47a1);
      color: white;
      padding: 1rem 0;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }

    .header-container {
      width: 90%;
      max-width: 1200px;
      margin: 0 auto;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .logo {
      font-size: 1.8rem;
      font-weight: 700;
      text-decoration: none;
      color: white;
    }

    .logo span {
      color: #ffeb3b;
    }

    nav ul {
      display: flex;
      list-style: none;
    }

    nav ul li {
      margin-left: 1.5rem;
    }

    nav ul li a {
      color: white;
      text-decoration: none;
      font-weight: 500;
      transition: color 0.3s;
    }

    nav ul li a:hover {
      color: #ffeb3b;
    }

    /* Hero Section */
    .hero {
      background: url('https://images.unsplash.com/photo-1523050854058-8df90110c9f1?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80') no-repeat center center/cover;
      height: 500px;
      display: flex;
      align-items: center;
      position: relative;
    }

    .hero::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: rgba(30, 136, 229, 0.7);
    }

    .hero-content {
      position: relative;
      z-index: 1;
      width: 90%;
      max-width: 1200px;
      margin: 0 auto;
      color: white;
    }

    .hero h1 {
      font-size: 2.8rem;
      margin-bottom: 1rem;
    }

    .hero p {
      font-size: 1.2rem;
      margin-bottom: 2rem;
      max-width: 600px;
    }

    .btn {
      display: inline-block;
      background: #ffeb3b;
      color: #0d47a1;
      padding: 0.8rem 1.5rem;
      border: none;
      border-radius: 4px;
      font-weight: 600;
      text-decoration: none;
      transition: all 0.3s;
      cursor: pointer;
    }

    .btn:hover {
      background: #fdd835;
      transform: translateY(-2px);
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    /* Features Section */
    .features {
      padding: 4rem 0;
      background: white;
    }

    .section-title {
      text-align: center;
      margin-bottom: 3rem;
      color: #0d47a1;
    }

    .features-container {
      width: 90%;
      max-width: 1200px;
      margin: 0 auto;
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
      gap: 2rem;
    }

    .feature-card {
      background: #f8f9fa;
      border-radius: 8px;
      padding: 2rem;
      text-align: center;
      transition: transform 0.3s, box-shadow 0.3s;
    }

    .feature-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
    }

    .feature-icon {
      font-size: 2.5rem;
      color: #1e88e5;
      margin-bottom: 1rem;
    }

    .feature-card h3 {
      color: #0d47a1;
      margin-bottom: 1rem;
    }

    /* How It Works Section */
    .how-it-works {
      padding: 4rem 0;
      background: #f1f8fe;
    }

    .steps-container {
      width: 90%;
      max-width: 1200px;
      margin: 0 auto;
      display: flex;
      flex-wrap: wrap;
      justify-content: space-between;
    }

    .step {
      flex: 1;
      min-width: 250px;
      margin: 1rem;
      text-align: center;
      position: relative;
    }

    .step-number {
      background: #1e88e5;
      color: white;
      width: 50px;
      height: 50px;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      margin: 0 auto 1rem;
      font-weight: bold;
      font-size: 1.2rem;
    }

    /* Testimonials */
    .testimonials {
      padding: 4rem 0;
      background: white;
    }

    .testimonial-container {
      width: 90%;
      max-width: 1200px;
      margin: 0 auto;
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
      gap: 2rem;
    }

    .testimonial-card {
      background: #f8f9fa;
      padding: 2rem;
      border-radius: 8px;
      position: relative;
    }

    .testimonial-card::before {
      content: '"';
      font-size: 5rem;
      color: #1e88e5;
      opacity: 0.1;
      position: absolute;
      top: 10px;
      left: 10px;
    }

    .testimonial-text {
      margin-bottom: 1rem;
      font-style: italic;
    }

    .testimonial-author {
      font-weight: bold;
      color: #0d47a1;
    }

    /* Footer */
    footer {
      background: #0d47a1;
      color: white;
      padding: 3rem 0 1rem;
    }

    .footer-container {
      width: 90%;
      max-width: 1200px;
      margin: 0 auto;
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
      gap: 2rem;
    }

    .footer-column h3 {
      color: #ffeb3b;
      margin-bottom: 1.5rem;
    }

    .footer-column ul {
      list-style: none;
      padding: 0;
    }

    .footer-column ul li {
      margin-bottom: 0.8rem;
    }

    .footer-column ul li a {
      color: white;
      text-decoration: none;
      transition: color 0.3s;
    }

    .footer-column ul li a:hover {
      color: #ffeb3b;
    }

    .social-links {
      display: flex;
      gap: 1rem;
    }

    .social-links a {
      color: white;
      font-size: 1.5rem;
      transition: color 0.3s;
    }

    .social-links a:hover {
      color: #ffeb3b;
    }

    .copyright {
      text-align: center;
      margin-top: 3rem;
      padding-top: 1rem;
      border-top: 1px solid rgba(255, 255, 255, 0.1);
    }

    /* Responsive Adjustments */
    @media (max-width: 768px) {
      .header-container {
        flex-direction: column;
        text-align: center;
      }

      nav ul {
        margin-top: 1rem;
        justify-content: center;
      }

      nav ul li {
        margin: 0 0.5rem;
      }

      .hero h1 {
        font-size: 2.2rem;
      }
    }
  </style>
</head>
<body>
<header>
  <div class="header-container">
    <a href="HomePage.jsp" class="logo">Home<span>Tutor.lk</span></a>
    <nav>
      <ul>
        <li><a href="HomePage.jsp">Home</a></li>
        <li><a href="Tutors.jsp">Find Tutors</a></li>
        <li><a href="BecomeTutor.jsp">Become a Tutor</a></li>
        <li><a href="About.jsp">About Us</a></li>
        <li><a href="Contact.jsp">Contact</a></li>
        <li><a href="Login.jsp" class="btn">Login</a></li>
      </ul>
    </nav>
  </div>
</header>

<section class="hero">
  <div class="hero-content">
    <h1>Find the Perfect Tutor for Your Child</h1>
    <p>Connect with qualified, experienced tutors across Sri Lanka for personalized learning at home.</p>
    <a href="Tutors.jsp" class="btn">Find a Tutor Now</a>
  </div>
</section>

<section class="features">
  <h2 class="section-title">Why Choose HomeTutor.lk</h2>
  <div class="features-container">
    <div class="feature-card">
      <div class="feature-icon">👨‍🏫</div>
      <h3>Verified Tutors</h3>
      <p>All our tutors undergo a rigorous verification process to ensure quality and safety.</p>
    </div>
    <div class="feature-card">
      <div class="feature-icon">🎯</div>
      <h3>Personalized Matching</h3>
      <p>We match students with tutors based on learning needs, personality, and location.</p>
    </div>
    <div class="feature-card">
      <div class="feature-icon">💰</div>
      <h3>Affordable Rates</h3>
      <p>Find tutors that fit your budget with transparent pricing and no hidden fees.</p>
    </div>
  </div>
</section>

<section class="how-it-works">
  <h2 class="section-title">How It Works</h2>
  <div class="steps-container">
    <div class="step">
      <div class="step-number">1</div>
      <h3>Search Tutors</h3>
      <p>Browse our database of qualified tutors by subject, location, and availability.</p>
    </div>
    <div class="step">
      <div class="step-number">2</div>
      <h3>Book a Session</h3>
      <p>Select your preferred tutor and schedule sessions at your convenience.</p>
    </div>
    <div class="step">
      <div class="step-number">3</div>
      <h3>Start Learning</h3>
      <p>Begin your personalized learning journey with your home tutor.</p>
    </div>
  </div>
</section>

<section class="testimonials">
  <h2 class="section-title">What Our Clients Say</h2>
  <div class="testimonial-container">
    <div class="testimonial-card">
      <p class="testimonial-text">HomeTutor.lk helped me find an excellent math tutor for my son. His grades have improved significantly in just two months!</p>
      <p class="testimonial-author">- Nimali Perera, Parent</p>
    </div>
    <div class="testimonial-card">
      <p class="testimonial-text">As a tutor, I've found great students through this platform. The process is simple and the support team is very helpful.</p>
      <p class="testimonial-author">- Rajitha Silva, Tutor</p>
    </div>
    <div class="testimonial-card">
      <p class="testimonial-text">The English tutor we found for our daughter is amazing. She's now more confident in speaking and writing.</p>
      <p class="testimonial-author">- Anura Bandara, Parent</p>
    </div>
  </div>
</section>

<footer>
  <div class="footer-container">
    <div class="footer-column">
      <h3>HomeTutor.lk</h3>
      <p>Connecting students with the best tutors in Sri Lanka since 2023.</p>
      <div class="social-links">
        <a href="#"><i class="fab fa-facebook"></i></a>
        <a href="#"><i class="fab fa-twitter"></i></a>
        <a href="#"><i class="fab fa-instagram"></i></a>
        <a href="#"><i class="fab fa-linkedin"></i></a>
      </div>
    </div>
    <div class="footer-column">
      <h3>Quick Links</h3>
      <ul>
        <li><a href="HomePage.jsp">Home</a></li>
        <li><a href="${pageContext.request.contextPath}/WEB-INF/views/student-login.jsp">Find Tutors</a></li>
        <li><a href="${pageContext.request.contextPath}/Tutors/TutorLogin.jsp">Become a Tutor</a></li>
        <li><a href="AboutUs.jsp">About Us</a></li>
      </ul>
    </div>
    <div class="footer-column">
      <h3>Subjects</h3>
      <ul>
        <li><a href="#">Mathematics</a></li>
        <li><a href="#">Science</a></li>
        <li><a href="#">English</a></li>
        <li><a href="#">Sinhala</a></li>
        <li><a href="#">IT</a></li>
      </ul>
    </div>
    <div class="footer-column">
      <h3>Contact Us</h3>
      <ul>
        <li>123 Tutor Lane, Colombo</li>
        <li>info@hometutor.lk</li>
        <li>+94 11 234 5678</li>
      </ul>
    </div>
  </div>
  <div class="copyright">
    <p>&copy; 2023 HomeTutor.lk. All Rights Reserved.</p>
  </div>
</footer>

<!-- Font Awesome for icons (you can link this in head if preferred) -->
<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
</body>
</html>
