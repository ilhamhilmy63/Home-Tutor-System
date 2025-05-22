<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Educational Blog - HomeTutor.lk</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f9ff;
            color: #1e3a8a;
            line-height: 1.6;
        }

        /* Navigation */
        .navbar {
            background: #ffffff;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 1rem 0;
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .nav-container {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 2rem;
        }

        .logo {
            color: #2563eb;
            font-size: 1.8rem;
            font-weight: bold;
            text-decoration: none;
        }

        .nav-links {
            display: flex;
            list-style: none;
            gap: 2rem;
        }

        .nav-links a {
            color: #1e40af;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .nav-links a:hover {
            color: #1a365d;
        }

        /* Blog Header */
        .blog-header {
            background: linear-gradient(135deg, #2563eb 0%, #1e40af 100%);
            color: white;
            padding: 4rem 2rem;
            text-align: center;
        }

        .blog-header h1 {
            font-size: 2.5rem;
            margin-bottom: 1rem;
        }

        .blog-header p {
            font-size: 1.1rem;
            max-width: 700px;
            margin: 0 auto;
        }

        /* Blog Content */
        .blog-container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 2rem;
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 2rem;
        }

        /* Main Blog Posts */
        .blog-posts {
            display: grid;
            gap: 2rem;
        }

        .blog-card {
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .blog-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 15px rgba(0, 0, 0, 0.1);
        }

        .blog-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }

        .blog-content {
            padding: 1.5rem;
        }

        .blog-category {
            display: inline-block;
            background: #dbeafe;
            color: #1e40af;
            padding: 0.3rem 0.8rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            margin-bottom: 0.8rem;
        }

        .blog-title {
            font-size: 1.5rem;
            margin-bottom: 0.8rem;
            color: #1e3a8a;
        }

        .blog-excerpt {
            color: #4b5563;
            margin-bottom: 1.2rem;
        }

        .blog-meta {
            display: flex;
            align-items: center;
            color: #6b7280;
            font-size: 0.9rem;
        }

        .blog-meta span {
            margin-right: 1rem;
            display: flex;
            align-items: center;
        }

        .blog-meta i {
            margin-right: 0.3rem;
        }

        .read-more {
            display: inline-block;
            color: #2563eb;
            font-weight: 600;
            text-decoration: none;
            margin-top: 1rem;
            transition: color 0.3s ease;
        }

        .read-more:hover {
            color: #1e40af;
        }

        /* Sidebar */
        .sidebar {
            display: flex;
            flex-direction: column;
            gap: 2rem;
        }

        .sidebar-widget {
            background: white;
            border-radius: 8px;
            padding: 1.5rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
        }

        .widget-title {
            font-size: 1.2rem;
            margin-bottom: 1rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid #dbeafe;
            color: #1e3a8a;
        }

        .search-form {
            display: flex;
        }

        .search-input {
            flex: 1;
            padding: 0.8rem;
            border: 1px solid #d1d5db;
            border-radius: 6px 0 0 6px;
            font-size: 1rem;
        }

        .search-button {
            background: #2563eb;
            color: white;
            border: none;
            padding: 0 1rem;
            border-radius: 0 6px 6px 0;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .search-button:hover {
            background: #1e40af;
        }

        .categories-list {
            list-style: none;
        }

        .categories-list li {
            margin-bottom: 0.8rem;
        }

        .categories-list a {
            color: #4b5563;
            text-decoration: none;
            transition: color 0.3s ease;
            display: block;
            padding: 0.3rem 0;
        }

        .categories-list a:hover {
            color: #2563eb;
        }

        .popular-posts {
            list-style: none;
        }

        .popular-post {
            display: flex;
            margin-bottom: 1rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid #e5e7eb;
        }

        .popular-post:last-child {
            margin-bottom: 0;
            padding-bottom: 0;
            border-bottom: none;
        }

        .popular-post-image {
            width: 80px;
            height: 60px;
            object-fit: cover;
            border-radius: 4px;
            margin-right: 1rem;
        }

        .popular-post-title {
            font-size: 0.9rem;
            color: #1e3a8a;
            margin-bottom: 0.3rem;
        }

        .popular-post-date {
            font-size: 0.8rem;
            color: #6b7280;
        }

        /* Newsletter */
        .newsletter-form {
            display: flex;
            flex-direction: column;
        }

        .newsletter-input {
            padding: 0.8rem;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            font-size: 1rem;
            margin-bottom: 1rem;
        }

        .newsletter-button {
            background: #2563eb;
            color: white;
            border: none;
            padding: 0.8rem;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 600;
            transition: background 0.3s ease;
        }

        .newsletter-button:hover {
            background: #1e40af;
        }

        /* Pagination */
        .pagination {
            display: flex;
            justify-content: center;
            margin: 3rem 0;
        }

        .pagination a {
            color: #2563eb;
            padding: 0.5rem 1rem;
            margin: 0 0.3rem;
            text-decoration: none;
            border-radius: 4px;
            transition: background 0.3s ease;
        }

        .pagination a:hover {
            background: #dbeafe;
        }

        .pagination a.active {
            background: #2563eb;
            color: white;
        }

        /* Footer */
        .footer {
            background: #1e3a8a;
            color: white;
            padding: 3rem 2rem;
            text-align: center;
        }

        .footer-links {
            display: flex;
            justify-content: center;
            list-style: none;
            margin: 1.5rem 0;
            flex-wrap: wrap;
        }

        .footer-links li {
            margin: 0 1rem;
        }

        .footer-links a {
            color: white;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .footer-links a:hover {
            color: #93c5fd;
        }

        .social-links {
            display: flex;
            justify-content: center;
            list-style: none;
            margin: 1.5rem 0;
        }

        .social-links li {
            margin: 0 0.8rem;
        }

        .social-links a {
            color: white;
            font-size: 1.5rem;
            transition: color 0.3s ease;
        }

        .social-links a:hover {
            color: #93c5fd;
        }

        .copyright {
            margin-top: 1.5rem;
            color: #93c5fd;
            font-size: 0.9rem;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .nav-links {
                display: none;
            }

            .blog-container {
                grid-template-columns: 1fr;
                padding: 0 1rem;
            }

            .sidebar {
                margin-top: 2rem;
            }
        }
    </style>
</head>
<body>
<!-- Navigation -->
<nav class="navbar">
    <div class="nav-container">
        <a href="${pageContext.request.contextPath}/" class="logo">
            <i class="fas fa-graduation-cap"></i> HomeTutor.lk
        </a>
        <ul class="nav-links">
            <li><a href="${pageContext.request.contextPath}/"><i class="fas fa-home"></i> Home</a></li>
            <li><a href="${pageContext.request.contextPath}/about"><i class="fas fa-info-circle"></i> About Us</a></li>
            <li><a href="${pageContext.request.contextPath}/blog"><i class="fas fa-blog"></i> Blog</a></li>
            <li><a href="${pageContext.request.contextPath}/contact"><i class="fas fa-envelope"></i> Contact</a></li>
            <li><a href="${pageContext.request.contextPath}/student-login"><i class="fas fa-sign-in-alt"></i> Login</a></li>
        </ul>
    </div>
</nav>

<!-- Blog Header -->
<header class="blog-header">
    <h1>HomeTutor Educational Blog</h1>
    <p>Discover valuable insights, teaching strategies, and educational resources to enhance your learning journey</p>
</header>

<!-- Blog Content -->
<div class="blog-container">
    <main class="blog-posts">
        <!-- Featured Blog Post -->
        <article class="blog-card">
            <img src="https://images.unsplash.com/photo-1523050854058-8df90110c9f1?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80" alt="Effective Study Techniques" class="blog-image">
            <div class="blog-content">
                <span class="blog-category">Study Tips</span>
                <h2 class="blog-title">10 Effective Study Techniques for Students</h2>
                <p class="blog-excerpt">Discover scientifically proven study methods that can help you retain information better and improve your academic performance...</p>
                <div class="blog-meta">
                    <span><i class="far fa-calendar-alt"></i> June 15, 2023</span>
                    <span><i class="far fa-clock"></i> 5 min read</span>
                    <span><i class="far fa-comment"></i> 12 comments</span>
                </div>
                <a href="#" class="read-more">Read More <i class="fas fa-arrow-right"></i></a>
            </div>
        </article>

        <!-- Blog Post 2 -->
        <article class="blog-card">
            <img src="https://images.unsplash.com/photo-1503676260728-1c00da094a0b?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80" alt="Online Learning" class="blog-image">
            <div class="blog-content">
                <span class="blog-category">Online Education</span>
                <h2 class="blog-title">Maximizing Your Online Learning Experience</h2>
                <p class="blog-excerpt">With the rise of digital education, learn how to create an effective learning environment at home and stay motivated...</p>
                <div class="blog-meta">
                    <span><i class="far fa-calendar-alt"></i> June 8, 2023</span>
                    <span><i class="far fa-clock"></i> 4 min read</span>
                    <span><i class="far fa-comment"></i> 8 comments</span>
                </div>
                <a href="#" class="read-more">Read More <i class="fas fa-arrow-right"></i></a>
            </div>
        </article>

        <!-- Blog Post 3 -->
        <article class="blog-card">
            <img src="https://images.unsplash.com/photo-1522202176988-66273c2fd55f?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80" alt="Time Management" class="blog-image">
            <div class="blog-content">
                <span class="blog-category">Productivity</span>
                <h2 class="blog-title">Time Management Strategies for Busy Students</h2>
                <p class="blog-excerpt">Balancing school, extracurricular activities, and personal life can be challenging. Here are practical tips to manage your time effectively...</p>
                <div class="blog-meta">
                    <span><i class="far fa-calendar-alt"></i> June 1, 2023</span>
                    <span><i class="far fa-clock"></i> 6 min read</span>
                    <span><i class="far fa-comment"></i> 15 comments</span>
                </div>
                <a href="#" class="read-more">Read More <i class="fas fa-arrow-right"></i></a>
            </div>
        </article>

        <!-- Blog Post 4 -->
        <article class="blog-card">
            <img src="https://images.unsplash.com/photo-1546410531-bb4caa6b424d?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80" alt="Math Anxiety" class="blog-image">
            <div class="blog-content">
                <span class="blog-category">Mathematics</span>
                <h2 class="blog-title">Overcoming Math Anxiety: A Guide for Students</h2>
                <p class="blog-excerpt">Math anxiety affects many students. Learn techniques to build confidence and develop a positive attitude towards mathematics...</p>
                <div class="blog-meta">
                    <span><i class="far fa-calendar-alt"></i> May 25, 2023</span>
                    <span><i class="far fa-clock"></i> 7 min read</span>
                    <span><i class="far fa-comment"></i> 10 comments</span>
                </div>
                <a href="#" class="read-more">Read More <i class="fas fa-arrow-right"></i></a>
            </div>
        </article>

        <!-- Pagination -->
        <div class="pagination">
            <a href="#" class="active">1</a>
            <a href="#">2</a>
            <a href="#">3</a>
            <a href="#"><i class="fas fa-chevron-right"></i></a>
        </div>
    </main>

    <!-- Sidebar -->
    <aside class="sidebar">
        <!-- Search Widget -->
        <div class="sidebar-widget">
            <h3 class="widget-title">Search Blog</h3>
            <form class="search-form">
                <input type="text" placeholder="Search articles..." class="search-input">
                <button type="submit" class="search-button"><i class="fas fa-search"></i></button>
            </form>
        </div>

        <!-- Categories Widget -->
        <div class="sidebar-widget">
            <h3 class="widget-title">Categories</h3>
            <ul class="categories-list">
                <li><a href="#">Study Tips (12)</a></li>
                <li><a href="#">Exam Preparation (8)</a></li>
                <li><a href="#">Online Education (5)</a></li>
                <li><a href="#">Mathematics (7)</a></li>
                <li><a href="#">Science (4)</a></li>
                <li><a href="#">Language Learning (3)</a></li>
                <li><a href="#">Career Guidance (6)</a></li>
            </ul>
        </div>

        <!-- Popular Posts Widget -->
        <div class="sidebar-widget">
            <h3 class="widget-title">Popular Posts</h3>
            <ul class="popular-posts">
                <li class="popular-post">
                    <img src="https://images.unsplash.com/photo-1434030216411-0b793f4b4173?ixlib=rb-1.2.1&auto=format&fit=crop&w=100&q=80" alt="Popular Post" class="popular-post-image">
                    <div>
                        <h4 class="popular-post-title">How to Stay Focused While Studying</h4>
                        <p class="popular-post-date">May 18, 2023</p>
                    </div>
                </li>
                <li class="popular-post">
                    <img src="https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?ixlib=rb-1.2.1&auto=format&fit=crop&w=100&q=80" alt="Popular Post" class="popular-post-image">
                    <div>
                        <h4 class="popular-post-title">The Benefits of One-on-One Tutoring</h4>
                        <p class="popular-post-date">May 10, 2023</p>
                    </div>
                </li>
                <li class="popular-post">
                    <img src="https://images.unsplash.com/photo-1542744173-8e7e53415bb0?ixlib=rb-1.2.1&auto=format&fit=crop&w=100&q=80" alt="Popular Post" class="popular-post-image">
                    <div>
                        <h4 class="popular-post-title">Preparing for University Entrance Exams</h4>
                        <p class="popular-post-date">May 5, 2023</p>
                    </div>
                </li>
            </ul>
        </div>

        <!-- Newsletter Widget -->
        <div class="sidebar-widget">
            <h3 class="widget-title">Subscribe to Newsletter</h3>
            <p>Get the latest educational tips and resources delivered to your inbox</p>
            <form class="newsletter-form">
                <input type="email" placeholder="Your email address" class="newsletter-input" required>
                <button type="submit" class="newsletter-button">Subscribe</button>
            </form>
        </div>
    </aside>
</div>

<!-- Footer -->
<footer class="footer">
    <h3>HomeTutor.lk</h3>
    <p>Connecting students with qualified tutors across Sri Lanka</p>

    <ul class="footer-links">
        <li><a href="${pageContext.request.contextPath}/">Home</a></li>
        <li><a href="${pageContext.request.contextPath}/about">About Us</a></li>
        <li><a href="${pageContext.request.contextPath}/blog">Blog</a></li>
        <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
        <li><a href="${pageContext.request.contextPath}/privacy">Privacy Policy</a></li>
        <li><a href="${pageContext.request.contextPath}/terms">Terms of Service</a></li>
    </ul>

    <ul class="social-links">
        <li><a href="#"><i class="fab fa-facebook"></i></a></li>
        <li><a href="#"><i class="fab fa-twitter"></i></a></li>
        <li><a href="#"><i class="fab fa-instagram"></i></a></li>
        <li><a href="#"><i class="fab fa-linkedin"></i></a></li>
        <li><a href="#"><i class="fab fa-youtube"></i></a></li>
    </ul>

    <p class="copyright">© 2023 HomeTutor.lk. All Rights Reserved.</p>
</footer>

<script>
    // Simple search functionality
    document.querySelector('.search-form').addEventListener('submit', function(e) {
        e.preventDefault();
        const searchTerm = document.querySelector('.search-input').value.toLowerCase();
        alert('Searching for: ' + searchTerm);
        // In a real implementation, this would filter blog posts or make an AJAX request
    });

    // Newsletter subscription
    document.querySelector('.newsletter-form').addEventListener('submit', function(e) {
        e.preventDefault();
        const email = document.querySelector('.newsletter-input').value;
        alert('Thank you for subscribing with: ' + email);
        document.querySelector('.newsletter-input').value = '';
    });
</script>
</body>
</html>
