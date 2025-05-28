<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>About Us - HomeTutor.com</title>
  <style>
    :root {
      --primary-blue: #1a73e8;
      --light-blue: #e8f0fe;
      --dark-blue: #0d47a1;
      --white: #ffffff;
      --light-gray: #f5f5f5;
    }

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    body {
      background-color: var(--light-gray);
      color: #333;
      line-height: 1.6;
    }

    .container {
      max-width: 1200px;
      margin: 0 auto;
      padding: 0 20px;
    }

    header {
      background-color: var(--white);
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
      position: sticky;
      top: 0;
      z-index: 100;
    }

    .navbar {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 15px 0;
    }

    .logo {
      display: flex;
      align-items: center;
    }

    .logo img {
      height: 40px;
      margin-right: 10px;
    }

    .logo h1 {
      color: var(--primary-blue);
      font-size: 24px;
      font-weight: 700;
    }

    .nav-links {
      display: flex;
      list-style: none;
    }

    .nav-links li {
      margin-left: 30px;
    }

    .nav-links a {
      text-decoration: none;
      color: #333;
      font-weight: 500;
      transition: color 0.3s;
    }

    .nav-links a:hover {
      color: var(--primary-blue);
    }

    .hero {
      background: linear-gradient(135deg, var(--primary-blue), var(--dark-blue));
      color: var(--white);
      padding: 80px 0;
      text-align: center;
    }

    .hero h2 {
      font-size: 36px;
      margin-bottom: 20px;
    }

    .hero p {
      font-size: 18px;
      max-width: 800px;
      margin: 0 auto;
    }

    .about-section {
      padding: 60px 0;
      background-color: var(--white);
    }

    .section-title {
      text-align: center;
      margin-bottom: 40px;
      color: var(--primary-blue);
    }

    .about-content {
      display: flex;
      flex-wrap: wrap;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 40px;
    }

    .about-text {
      flex: 1;
      min-width: 300px;
      padding: 0 20px;
    }

    .about-image {
      flex: 1;
      min-width: 300px;
      text-align: center;
    }

    .about-image img {
      max-width: 100%;
      border-radius: 10px;
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    }

    .features {
      padding: 60px 0;
      background-color: var(--light-blue);
    }

    .features-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
      gap: 30px;
      margin-top: 40px;
    }

    .feature-card {
      background-color: var(--white);
      border-radius: 10px;
      padding: 30px;
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
      transition: transform 0.3s, box-shadow 0.3s;
    }

    .feature-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
    }

    .feature-icon {
      font-size: 40px;
      color: var(--primary-blue);
      margin-bottom: 20px;
    }

    .feature-card h3 {
      margin-bottom: 15px;
      color: var(--primary-blue);
    }

    .team {
      padding: 60px 0;
      background-color: var(--white);
    }

    .team-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
      gap: 30px;
      margin-top: 40px;
    }

    .team-member {
      text-align: center;
      background-color: var(--light-gray);
      padding: 30px 20px;
      border-radius: 10px;
    }

    .team-member img {
      width: 150px;
      height: 150px;
      border-radius: 50%;
      object-fit: cover;
      margin-bottom: 20px;
      border: 5px solid var(--white);
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    }

    .team-member h3 {
      margin-bottom: 5px;
      color: var(--primary-blue);
    }

    .team-member p {
      color: #666;
      font-style: italic;
    }

    footer {
      background-color: var(--dark-blue);
      color: var(--white);
      padding: 40px 0 20px;
    }

    .footer-content {
      display: flex;
      flex-wrap: wrap;
      justify-content: space-between;
      margin-bottom: 30px;
    }

    .footer-column {
      flex: 1;
      min-width: 200px;
      margin-bottom: 20px;
      padding: 0 15px;
    }

    .footer-column h3 {
      margin-bottom: 20px;
      font-size: 18px;
    }

    .footer-column ul {
      list-style: none;
    }

    .footer-column ul li {
      margin-bottom: 10px;
    }

    .footer-column ul li a {
      color: #ccc;
      text-decoration: none;
      transition: color 0.3s;
    }

    .footer-column ul li a:hover {
      color: var(--white);
    }

    .social-links {
      display: flex;
      gap: 15px;
    }

    .social-links a {
      color: var(--white);
      font-size: 20px;
      transition: color 0.3s;
    }

    .social-links a:hover {
      color: #ccc;
    }

    .copyright {
      text-align: center;
      padding-top: 20px;
      border-top: 1px solid rgba(255, 255, 255, 0.1);
      font-size: 14px;
      color: #ccc;
    }

    @media (max-width: 768px) {
      .navbar {
        flex-direction: column;
        padding: 15px 0;
      }

      .nav-links {
        margin-top: 15px;
      }

      .nav-links li {
        margin: 0 10px;
      }

      .about-content {
        flex-direction: column;
      }

      .about-text, .about-image {
        padding: 20px 0;
      }
    }
  </style>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
<header>
  <div class="container">
    <nav class="navbar">
      <div class="logo">
        <img src="images/logo.png" alt="HomeTutor.com">
        <h1>HomeTutor.lk</h1>
      </div>
      <ul class="nav-links">
        <li><a href="HomePage.jsp">Home</a></li>
        <li><a href="tutors.jsp">Find Tutors</a></li>
        <li><a href="Contact.jsp">Contact</a></li>
        <li><a href="${pageContext.request.contextPath}/auth/login.jsp" class="btn">Login</a></li>
      </ul>
    </nav>
  </div>
</header>

<section class="hero">
  <div class="container">
    <h2>About HomeTutor.com</h2>
    <p>Connecting students with qualified home tutors across Sri Lanka to provide personalized education at your doorstep.</p>
  </div>
</section>

<section class="about-section">
  <div class="container">
    <h2 class="section-title">Our Story</h2>
    <div class="about-content">
      <div class="about-text">
        <h3>Bridging the Education Gap</h3>
        <p>Founded in 2023, HomeTutor.com was born out of a simple idea: to make quality education accessible to every student in Sri Lanka. We recognized the challenges parents face in finding reliable, qualified tutors who can provide personalized attention to their children.</p>
        <p>Our platform brings together certified educators and students in a secure, transparent environment. Whether you need help with school subjects, exam preparation, or special skills development, we connect you with the perfect tutor for your needs.</p>
        <p>With over 5,000 registered tutors and 20,000 successful sessions, we're proud to be Sri Lanka's fastest growing home tuition platform.</p>
      </div>
      <div class="about-image">
        <img src="images/about-us.jpg" alt="Tutor teaching student">
      </div>
    </div>
  </div>
</section>

<section class="features">
  <div class="container">
    <h2 class="section-title">Why Choose HomeTutor.com</h2>
    <div class="features-grid">
      <div class="feature-card">
        <div class="feature-icon">
          <i class="fas fa-user-graduate"></i>
        </div>
        <h3>Verified Tutors</h3>
        <p>All our tutors undergo a rigorous verification process including background checks and qualification verification.</p>
      </div>
      <div class="feature-card">
        <div class="feature-icon">
          <i class="fas fa-search-dollar"></i>
        </div>
        <h3>Transparent Pricing</h3>
        <p>Clear pricing with no hidden fees. Compare tutor rates and choose what fits your budget.</p>
      </div>
      <div class="feature-card">
        <div class="feature-icon">
          <i class="fas fa-star"></i>
        </div>
        <h3>Rating System</h3>
        <p>Read genuine reviews from other students and parents to make informed decisions.</p>
      </div>
      <div class="feature-card">
        <div class="feature-icon">
          <i class="fas fa-shield-alt"></i>
        </div>
        <h3>Secure Payments</h3>
        <p>Our secure payment system ensures your transactions are safe and protected.</p>
      </div>
      <div class="feature-card">
        <div class="feature-icon">
          <i class="fas fa-calendar-check"></i>
        </div>
        <h3>Flexible Scheduling</h3>
        <p>Book sessions at your convenience with our easy-to-use scheduling system.</p>
      </div>
      <div class="feature-card">
        <div class="feature-icon">
          <i class="fas fa-headset"></i>
        </div>
        <h3>24/7 Support</h3>
        <p>Our customer support team is always ready to assist you with any questions or concerns.</p>
      </div>
    </div>
  </div>
</section>

<section class="team">
  <div class="container">
    <h2 class="section-title">Meet Our Team</h2>
    <div class="team-grid">
      <div class="team-member">
        <img src="images/team1.jpg" alt="Team Member">
        <h3>John Smith</h3>
        <p>Founder & CEO</p>
      </div>
      <div class="team-member">
        <img src="images/team2.jpg" alt="Team Member">
        <h3>Sarah Johnson</h3>
        <p>Head of Tutor Relations</p>
      </div>
      <div class="team-member">
        <img src="images/team3.jpg" alt="Team Member">
        <h3>David Lee</h3>
        <p>Technology Director</p>
      </div>
      <div class="team-member">
        <img src="images/team4.jpg" alt="Team Member">
        <h3>Priya Fernando</h3>
        <p>Customer Support Manager</p>
      </div>
    </div>
  </div>
</section>

<footer>
  <div class="container">
    <div class="footer-content">
      <div class="footer-column">
        <h3>HomeTutor.com</h3>
        <p>Your trusted partner for quality home education across Sri Lanka.</p>
        <div class="social-links">
          <a href="#"><i class="fab fa-facebook-f"></i></a>
          <a href="#"><i class="fab fa-twitter"></i></a>
          <a href="#"><i class="fab fa-instagram"></i></a>
          <a href="#"><i class="fab fa-linkedin-in"></i></a>
        </div>
      </div>
      <div class="footer-column">
        <h3>Quick Links</h3>
        <ul>
          <li><a href="index.jsp">Home</a></li>
          <li><a href="about.jsp">About Us</a></li>
          <li><a href="tutors.jsp">Find Tutors</a></li>
          <li><a href="contact.jsp">Contact</a></li>
        </ul>
      </div>
      <div class="footer-column">
        <h3>Subjects</h3>
        <ul>
          <li><a href="#">Mathematics</a></li>
          <li><a href="#">Science</a></li>
          <li><a href="#">English</a></li>
          <li><a href="#">Sinhala</a></li>
          <li><a href="#">ICT</a></li>
        </ul>
      </div>
      <div class="footer-column">
        <h3>Contact Us</h3>
        <ul>
          <li><i class="fas fa-map-marker-alt"></i> 123 Education St, Colombo</li>
          <li><i class="fas fa-phone"></i> +94 11 234 5678</li>
          <li><i class="fas fa-envelope"></i> info@hometutor.com</li>
        </ul>
      </div>
    </div>
    <div class="copyright">
      <p>&copy; 2023 HomeTutor.com. All Rights Reserved.</p>
    </div>
  </div>
</footer>
</body>
</html>
