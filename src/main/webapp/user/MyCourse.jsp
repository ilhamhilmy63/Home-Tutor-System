<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>My Courses | HomeTutor.lk</title>
  <style>
    /* Reusing your existing styles with some additions */
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      margin: 0;
      padding: 0;
      background-color: #f8f9fa;
      color: #333;
      line-height: 1.6;
    }

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

    /* My Courses Specific Styles */
    .main-container {
      width: 90%;
      max-width: 1200px;
      margin: 2rem auto;
      padding: 2rem;
      background: white;
      border-radius: 8px;
      box-shadow: 0 2px 15px rgba(0, 0, 0, 0.05);
    }

    .page-title {
      color: #0d47a1;
      margin-bottom: 2rem;
      padding-bottom: 1rem;
      border-bottom: 2px solid #f1f8fe;
    }

    .courses-container {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
      gap: 2rem;
    }

    .course-card {
      background: #f8f9fa;
      border-radius: 8px;
      overflow: hidden;
      transition: transform 0.3s, box-shadow 0.3s;
    }

    .course-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
    }

    .course-image {
      height: 180px;
      background-color: #1e88e5;
      background-size: cover;
      background-position: center;
      position: relative;
    }

    .course-image::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: rgba(30, 136, 229, 0.7);
    }

    .course-content {
      padding: 1.5rem;
    }

    .course-title {
      color: #0d47a1;
      margin: 0 0 1rem;
    }

    .course-tutor {
      color: #666;
      margin-bottom: 1rem;
      font-size: 0.9rem;
    }

    .course-meta {
      display: flex;
      justify-content: space-between;
      margin-bottom: 1.5rem;
      font-size: 0.9rem;
    }

    .course-price {
      color: #1e88e5;
      font-weight: bold;
    }

    .course-status {
      background: #e3f2fd;
      color: #0d47a1;
      padding: 0.3rem 0.8rem;
      border-radius: 20px;
      font-size: 0.8rem;
      font-weight: 600;
    }

    .course-actions {
      display: flex;
      justify-content: space-between;
    }

    .btn-secondary {
      background: white;
      color: #0d47a1;
      border: 1px solid #0d47a1;
    }

    .btn-secondary:hover {
      background: #f1f8fe;
    }

    .no-courses {
      text-align: center;
      padding: 3rem;
      color: #666;
      grid-column: 1 / -1;
    }

    footer {
      background: #0d47a1;
      color: white;
      padding: 3rem 0 1rem;
      margin-top: 3rem;
    }

    /* Responsive adjustments */
    @media (max-width: 768px) {
      .header-container {
        flex-direction: column;
        text-align: center;
      }

      nav ul {
        margin-top: 1rem;
        justify-content: center;
        flex-wrap: wrap;
      }

      nav ul li {
        margin: 0.5rem;
      }

      .courses-container {
        grid-template-columns: 1fr;
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
        <li><a href="MyCourses.jsp" class="active">My Courses</a></li>
        <li><a href="Tutors.jsp">Find Tutors</a></li>
        <li><a href="BecomeTutor.jsp">Become a Tutor</a></li>
        <li><a href="Login.jsp" class="btn">Logout</a></li>
      </ul>
    </nav>
  </div>
</header>

<div class="main-container">
  <h1 class="page-title">My Courses</h1>

  <div class="courses-container">
    <%
      // Sample data - in a real application, this would come from a database
      List<String[]> courses = new ArrayList<>();
      courses.add(new String[]{"Mathematics Grade 10", "Mr. Perera", "LKR 1,500/hr", "Ongoing", "math-bg.jpg"});
      courses.add(new String[]{"English Literature", "Ms. Fernando", "LKR 1,200/hr", "Completed", "english-bg.jpg"});
      courses.add(new String[]{"Science Grade 12", "Dr. Silva", "LKR 2,000/hr", "Upcoming", "science-bg.jpg"});

      if (courses.isEmpty()) {
    %>
    <div class="no-courses">
      <h3>You don't have any courses yet</h3>
      <p>Find tutors and book your first session to get started</p>
      <a href="Tutors.jsp" class="btn">Find Tutors</a>
    </div>
    <%
    } else {
      for (String[] course : courses) {
    %>
    <div class="course-card">
      <div class="course-image" style="background-image: url('https://images.unsplash.com/photo-1434030216411-0b793f4b4173?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80');">
      </div>
      <div class="course-content">
        <h3 class="course-title"><%= course[0] %></h3>
        <p class="course-tutor">Tutor: <%= course[1] %></p>
        <div class="course-meta">
          <span class="course-price"><%= course[2] %></span>
          <span class="course-status"><%= course[3] %></span>
        </div>
        <div class="course-actions">
          <a href="CourseDetails.jsp?course=<%= java.net.URLEncoder.encode(course[0], "UTF-8") %>" class="btn btn-secondary">View Details</a>
          <a href="Booking.jsp?course=<%= java.net.URLEncoder.encode(course[0], "UTF-8") %>&tutor=<%= java.net.URLEncoder.encode(course[1], "UTF-8") %>" class="btn">Book Session</a>
        </div>
      </div>
    </div>
    <%
        }
      }
    %>
  </div>
</div>

<footer>
  <div class="footer-container">
    <div class="footer-column">
      <h3>HomeTutor.lk</h3>
      <p>Connecting students with the best tutors in Sri Lanka since 2023.</p>
    </div>
    <div class="footer-column">
      <h3>Quick Links</h3>
      <ul>
        <li><a href="HomePage.jsp">Home</a></li>
        <li><a href="MyCourses.jsp">My Courses</a></li>
        <li><a href="Tutors.jsp">Find Tutors</a></li>
      </ul>
    </div>
    <div class="footer-column">
      <h3>Support</h3>
      <ul>
        <li><a href="Contact.jsp">Contact Us</a></li>
        <li><a href="FAQs.jsp">FAQs</a></li>
        <li><a href="Terms.jsp">Terms of Service</a></li>
      </ul>
    </div>
  </div>
  <div class="copyright">
    <p>&copy; 2023 HomeTutor.lk. All Rights Reserved.</p>
  </div>
</footer>
</body>
</html>