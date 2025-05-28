<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Contact Us - HomeTutor.lk</title>
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

    .btn {
      display: inline-block;
      background-color: var(--primary-blue);
      color: var(--white);
      padding: 10px 20px;
      border-radius: 5px;
      text-decoration: none;
      font-weight: 500;
      transition: background-color 0.3s;
    }

    .btn:hover {
      background-color: var(--dark-blue);
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

    .contact-section {
      padding: 60px 0;
      background-color: var(--white);
    }

    .section-title {
      text-align: center;
      margin-bottom: 40px;
      color: var(--primary-blue);
    }

    .contact-container {
      display: flex;
      flex-wrap: wrap;
      justify-content: space-between;
      gap: 30px;
    }

    .contact-info {
      flex: 1;
      min-width: 300px;
    }

    .contact-info h3 {
      margin-bottom: 20px;
      color: var(--primary-blue);
    }

    .info-box {
      display: flex;
      align-items: flex-start;
      margin-bottom: 20px;
    }

    .info-icon {
      font-size: 24px;
      color: var(--primary-blue);
      margin-right: 15px;
      margin-top: 5px;
    }

    .info-text h4 {
      margin-bottom: 5px;
      font-size: 18px;
    }

    .info-text p, .info-text a {
      color: #666;
      text-decoration: none;
    }

    .info-text a:hover {
      color: var(--primary-blue);
    }

    .contact-form {
      flex: 1;
      min-width: 300px;
      background-color: var(--light-gray);
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
    }

    .form-group {
      margin-bottom: 20px;
    }

    .form-group label {
      display: block;
      margin-bottom: 8px;
      font-weight: 500;
    }

    .form-control {
      width: 100%;
      padding: 12px 15px;
      border: 1px solid #ddd;
      border-radius: 5px;
      font-size: 16px;
      transition: border-color 0.3s;
    }

    .form-control:focus {
      outline: none;
      border-color: var(--primary-blue);
    }

    textarea.form-control {
      min-height: 150px;
      resize: vertical;
    }

    .submit-btn {
      background-color: var(--primary-blue);
      color: var(--white);
      border: none;
      padding: 12px 25px;
      border-radius: 5px;
      cursor: pointer;
      font-size: 16px;
      font-weight: 500;
      transition: background-color 0.3s;
    }

    .submit-btn:hover {
      background-color: var(--dark-blue);
    }

    .map-container {
      margin-top: 60px;
      border-radius: 10px;
      overflow: hidden;
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    }

    .map-container iframe {
      width: 100%;
      height: 400px;
      border: none;
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

      .contact-container {
        flex-direction: column;
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
        <img src="images/logo.png" alt="HomeTutor.lk">
        <h1>HomeTutor.lk</h1>
      </div>
      <ul class="nav-links">
        <li><a href="HomePage.jsp">Home</a></li>
        <li><a href="AboutUs.jsp">About Us</a></li>
        <li><a href="tutors.jsp">Find Tutors</a></li>
        <li><a href="Contact.jsp">Contact</a></li>
        <li><a href="${pageContext.request.contextPath}/auth/login.jsp" class="btn">Login</a></li>
      </ul>
    </nav>
  </div>
</header>

<section class="hero">
  <div class="container">
    <h2>Contact HomeTutor.lk</h2>
    <p>Have questions or need assistance? We're here to help you find the perfect tutor for your needs.</p>
  </div>
</section>

<section class="contact-section">
  <div class="container">
    <h2 class="section-title">Get In Touch</h2>
    <div class="contact-container">
      <div class="contact-info">
        <h3>Contact Information</h3>
        <div class="info-box">
          <div class="info-icon">
            <i class="fas fa-map-marker-alt"></i>
          </div>
          <div class="info-text">
            <h4>Our Office</h4>
            <p>123 Education Street, Colombo 07, Sri Lanka</p>
          </div>
        </div>
        <div class="info-box">
          <div class="info-icon">
            <i class="fas fa-phone-alt"></i>
          </div>
          <div class="info-text">
            <h4>Call Us</h4>
            <p><a href="tel:+94112345678">+94 11 234 5678</a></p>
            <p><a href="tel:+94771234567">+94 77 123 4567</a> (Hotline)</p>
          </div>
        </div>
        <div class="info-box">
          <div class="info-icon">
            <i class="fas fa-envelope"></i>
          </div>
          <div class="info-text">
            <h4>Email Us</h4>
            <p><a href="mailto:info@hometutor.lk">info@hometutor.com</a></p>
            <p><a href="mailto:support@hometutor.lk">support@hometutor.com</a></p>
          </div>
        </div>
        <div class="info-box">
          <div class="info-icon">
            <i class="fas fa-clock"></i>
          </div>
          <div class="info-text">
            <h4>Working Hours</h4>
            <p>Monday - Friday: 8:30 AM - 6:00 PM</p>
            <p>Saturday: 9:00 AM - 2:00 PM</p>
            <p>Sunday: Closed</p>
          </div>
        </div>
      </div>

      <div class="contact-form">
        <form action="contact-processing.jsp" method="POST">
          <div class="form-group">
            <label for="name">Your Name</label>
            <input type="text" id="name" name="name" class="form-control" required>
          </div>
          <div class="form-group">
            <label for="email">Email Address</label>
            <input type="email" id="email" name="email" class="form-control" required>
          </div>
          <div class="form-group">
            <label for="phone">Phone Number</label>
            <input type="tel" id="phone" name="phone" class="form-control" required>
          </div>
          <div class="form-group">
            <label for="subject">Subject</label>
            <select id="subject" name="subject" class="form-control" required>
              <option value="">Select a subject</option>
              <option value="general">General Inquiry</option>
              <option value="tutor">Become a Tutor</option>
              <option value="booking">Booking Assistance</option>
              <option value="feedback">Feedback/Suggestions</option>
              <option value="complaint">Complaint</option>
            </select>
          </div>
          <div class="form-group">
            <label for="message">Your Message</label>
            <textarea id="message" name="message" class="form-control" required></textarea>
          </div>
          <button type="submit" class="submit-btn">Send Message</button>
        </form>
      </div>
    </div>

    <div class="map-container">
      <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3960.798511757686!2d79.86075541532806!3d6.914657295003785!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3ae2596d3cb8fe07%3A0x2b0ae2b5f1f8c0b8!2sColombo!5e0!3m2!1sen!2slk!4v1620000000000!5m2!1sen!2slk" allowfullscreen="" loading="lazy"></iframe>
    </div>
  </div>
</section>

<footer>
  <div class="container">
    <div class="footer-content">
      <div class="footer-column">
        <h3>HomeTutor.lk</h3>
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
          <li><a href="HomePage.jsp">Home</a></li>
          <li><a href="AboutUs.jsp">About Us</a></li>
          <li><a href="tutors.jsp">Find Tutors</a></li>
          <li><a href="Contact.jsp">Contact</a></li>
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
          <li><i class="fas fa-envelope"></i> info@hometutor.lk</li>
        </ul>
      </div>
    </div>
    <div class="copyright">
      <p>&copy; 2023 HomeTutor.lk. All Rights Reserved.</p>
    </div>
  </div>
</footer>
</body>
</html>
