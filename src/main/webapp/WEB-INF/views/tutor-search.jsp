<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Find Tutors - TutorConnect</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #4f46e5;
            --secondary-color: #7c3aed;
            --accent-color: #06d6a0;
            --dark-color: #1e293b;
            --light-bg: #f8fafc;
        }

        body {
            background: linear-gradient(135deg, var(--light-bg) 0%, #e2e8f0 100%);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
        }

        .search-header {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            color: white;
            padding: 2rem 0;
            margin-bottom: 2rem;
        }

        .search-form {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            padding: 2rem;
            margin-bottom: 2rem;
        }

        .form-control, .form-select {
            border-radius: 10px;
            border: 2px solid #e2e8f0;
            padding: 0.75rem 1rem;
            transition: all 0.3s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(79, 70, 229, 0.25);
        }

        .btn-search {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            border: none;
            border-radius: 10px;
            padding: 0.75rem 2rem;
            color: white;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-search:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(79, 70, 229, 0.3);
            color: white;
        }

        .tutor-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            transition: all 0.3s ease;
            border: 1px solid #e2e8f0;
        }

        .tutor-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.15);
        }

        .tutor-avatar {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 2rem;
            font-weight: bold;
            margin-right: 1rem;
        }

        .tutor-info h5 {
            color: var(--dark-color);
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .tutor-specialization {
            background: linear-gradient(135deg, var(--accent-color) 0%, #20c997 100%);
            color: white;
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            display: inline-block;
            margin-bottom: 0.5rem;
        }

        .tutor-rate {
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--primary-color);
        }

        .tutor-experience {
            color: #6b7280;
            font-size: 0.9rem;
        }

        .alert {
            border-radius: 10px;
            border: none;
            padding: 1rem 1.5rem;
        }

        .alert-success {
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            color: white;
        }

        .alert-info {
            background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
            color: white;
        }

        .quick-filters {
            background: white;
            border-radius: 10px;
            padding: 1rem;
            margin-bottom: 1rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        .filter-chip {
            display: inline-block;
            background: #f1f5f9;
            color: var(--dark-color);
            padding: 0.5rem 1rem;
            border-radius: 25px;
            text-decoration: none;
            margin: 0.25rem;
            font-size: 0.9rem;
            transition: all 0.3s ease;
        }

        .filter-chip:hover, .filter-chip.active {
            background: var(--primary-color);
            color: white;
            text-decoration: none;
            transform: translateY(-2px);
        }

        .no-results {
            text-align: center;
            padding: 3rem;
            color: #6b7280;
        }

        .no-results i {
            font-size: 4rem;
            margin-bottom: 1rem;
            color: #cbd5e1;
        }

        @media (max-width: 768px) {
            .tutor-card .d-flex {
                flex-direction: column;
                text-align: center;
            }

            .tutor-avatar {
                margin: 0 auto 1rem auto;
            }
        }
    </style>
</head>
<body>
<div class="search-header">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <h1 class="text-center mb-3">
                    <i class="fas fa-search me-3"></i>Find Your Perfect Tutor
                </h1>
                <p class="text-center lead opacity-90">
                    Discover expert tutors tailored to your learning needs
                    <c:if test="${not empty student}">
                        - Personalized for ${student.fullName}
                    </c:if>
                </p>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <!-- Quick Search Form (from Dashboard) -->
    <div class="search-form">
        <form method="post" action="${pageContext.request.contextPath}/tutor-search">
            <div class="row mb-3">
                <div class="col-md-4">
                    <label class="form-label fw-bold">Quick Search</label>
                    <select name="quickSearchType" class="form-select">
                        <option value="subject">Search by Subject</option>
                        <option value="recommended">Recommended for Me</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <label class="form-label fw-bold">Search Query</label>
                    <input type="text" name="searchQuery" class="form-control"
                           placeholder="Enter subject or leave empty for all recommendations">
                </div>
                <div class="col-md-2 d-flex align-items-end">
                    <button type="submit" class="btn btn-search w-100">
                        <i class="fas fa-rocket me-2"></i>Quick Search
                    </button>
                </div>
            </div>
        </form>
    </div>

    <!-- Advanced Search Form -->
    <div class="search-form">
        <h4 class="mb-4"><i class="fas fa-filter me-2"></i>Advanced Search Filters</h4>
        <form method="get" action="${pageContext.request.contextPath}/tutor-search">
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label for="specialization" class="form-label fw-bold">Subject/Specialization</label>
                    <select name="specialization" id="specialization" class="form-select">
                        <option value="">All Subjects</option>
                        <option value="Mathematics" ${selectedSpecialization eq 'Mathematics' ? 'selected' : ''}>Mathematics</option>
                        <option value="Physics" ${selectedSpecialization eq 'Physics' ? 'selected' : ''}>Physics</option>
                        <option value="Chemistry" ${selectedSpecialization eq 'Chemistry' ? 'selected' : ''}>Chemistry</option>
                        <option value="Biology" ${selectedSpecialization eq 'Biology' ? 'selected' : ''}>Biology</option>
                        <option value="Computer Science" ${selectedSpecialization eq 'Computer Science' ? 'selected' : ''}>Computer Science</option>
                        <option value="English" ${selectedSpecialization eq 'English' ? 'selected' : ''}>English</option>
                        <option value="History" ${selectedSpecialization eq 'History' ? 'selected' : ''}>History</option>
                        <option value="Economics" ${selectedSpecialization eq 'Economics' ? 'selected' : ''}>Economics</option>
                    </select>
                </div>
                <div class="col-md-6 mb-3">
                    <label for="sortBy" class="form-label fw-bold">Sort By</label>
                    <select name="sortBy" id="sortBy" class="form-select">
                        <option value="name" ${selectedSortBy eq 'name' ? 'selected' : ''}>Name</option>
                        <option value="rate_low" ${selectedSortBy eq 'rate_low' ? 'selected' : ''}>Rate (Low to High)</option>
                        <option value="rate_high" ${selectedSortBy eq 'rate_high' ? 'selected' : ''}>Rate (High to Low)</option>
                        <option value="experience" ${selectedSortBy eq 'experience' ? 'selected' : ''}>Experience</option>
                        <option value="subject" ${selectedSortBy eq 'subject' ? 'selected' : ''}>Subject</option>
                    </select>
                </div>
            </div>
            <div class="row">
                <div class="col-md-3 mb-3">
                    <label for="minRate" class="form-label fw-bold">Min Rate ($/hour)</label>
                    <input type="number" name="minRate" id="minRate" class="form-control"
                           placeholder="0" min="0" step="0.01" value="${selectedMinRate}">
                </div>
                <div class="col-md-3 mb-3">
                    <label for="maxRate" class="form-label fw-bold">Max Rate ($/hour)</label>
                    <input type="number" name="maxRate" id="maxRate" class="form-control"
                           placeholder="100" min="0" step="0.01" value="${selectedMaxRate}">
                </div>
                <div class="col-md-4 mb-3">
                    <label for="experienceLevel" class="form-label fw-bold">Experience Level</label>
                    <select name="experienceLevel" id="experienceLevel" class="form-select">
                        <option value="">All Levels</option>
                        <option value="beginner" ${selectedExperienceLevel eq 'beginner' ? 'selected' : ''}>Beginner (0-2 years)</option>
                        <option value="intermediate" ${selectedExperienceLevel eq 'intermediate' ? 'selected' : ''}>Intermediate (3-5 years)</option>
                        <option value="advanced" ${selectedExperienceLevel eq 'advanced' ? 'selected' : ''}>Advanced (6-10 years)</option>
                        <option value="expert" ${selectedExperienceLevel eq 'expert' ? 'selected' : ''}>Expert (10+ years)</option>
                    </select>
                </div>
                <div class="col-md-2 d-flex align-items-end mb-3">
                    <button type="submit" class="btn btn-search w-100">
                        <i class="fas fa-search me-2"></i>Search
                    </button>
                </div>
            </div>
        </form>
    </div>

    <!-- Quick Filter Chips -->
    <div class="quick-filters">
        <h6 class="mb-2">Popular Searches:</h6>
        <c:if test="${not empty student and not empty student.module}">
            <a href="${pageContext.request.contextPath}/tutor-search?specialization=${student.module}&sortBy=experience"
               class="filter-chip ${selectedSpecialization eq student.module ? 'active' : ''}">
                <i class="fas fa-star me-1"></i>My Subject (${student.module})
            </a>
        </c:if>
        <a href="${pageContext.request.contextPath}/tutor-search?sortBy=rate_low"
           class="filter-chip ${selectedSortBy eq 'rate_low' ? 'active' : ''}">
            <i class="fas fa-dollar-sign me-1"></i>Most Affordable
        </a>
        <a href="${pageContext.request.contextPath}/tutor-search?sortBy=experience"
           class="filter-chip ${selectedSortBy eq 'experience' ? 'active' : ''}">
            <i class="fas fa-medal me-1"></i>Most Experienced
        </a>
        <a href="${pageContext.request.contextPath}/tutor-search?specialization=Mathematics"
           class="filter-chip ${selectedSpecialization eq 'Mathematics' ? 'active' : ''}">
            <i class="fas fa-calculator me-1"></i>Mathematics
        </a>
        <a href="${pageContext.request.contextPath}/tutor-search?specialization=Computer Science"
           class="filter-chip ${selectedSpecialization eq 'Computer Science' ? 'active' : ''}">
            <i class="fas fa-laptop-code me-1"></i>Computer Science
        </a>
    </div>

    <!-- Messages -->
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success" role="alert">
            <i class="fas fa-check-circle me-2"></i>${successMessage}
        </div>
    </c:if>

    <c:if test="${not empty message}">
        <div class="alert alert-info" role="alert">
            <i class="fas fa-info-circle me-2"></i>${message}
        </div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="alert alert-danger" role="alert">
            <i class="fas fa-exclamation-triangle me-2"></i>${error}
        </div>
    </c:if>

    <!-- Search Results -->
    <c:choose>
        <c:when test="${not empty tutors}">
            <div class="row">
                <c:forEach var="tutor" items="${tutors}">
                    <div class="col-12">
                        <div class="tutor-card">
                            <div class="d-flex align-items-center">
                                <div class="tutor-avatar">
                                        ${tutor.fullName.substring(0,1).toUpperCase()}
                                </div>
                                <div class="tutor-info flex-grow-1">
                                    <h5>${tutor.fullName}</h5>
                                    <div class="tutor-specialization">${tutor.specialization}</div>
                                    <p class="tutor-experience mb-1">
                                        <i class="fas fa-graduation-cap me-1"></i>${tutor.qualification}
                                    </p>
                                    <p class="tutor-experience mb-0">
                                        <i class="fas fa-clock me-1"></i>Experience: ${tutor.experience}
                                    </p>
                                </div>
                                <div class="text-end">
                                    <div class="tutor-rate mb-2">
                                        $<fmt:formatNumber value="${tutor.hourlyRate}" pattern="#,##0.00"/>/hour
                                    </div>
                                    <div>
                                        <a href="${pageContext.request.contextPath}/tutor-profile?id=${tutor.id}"
                                           class="btn btn-outline-primary btn-sm me-2">
                                            <i class="fas fa-user me-1"></i>View Profile
                                        </a>
                                        <a href="${pageContext.request.contextPath}/book-session?tutorId=${tutor.id}"
                                           class="btn btn-primary btn-sm">
                                            <i class="fas fa-calendar-plus me-1"></i>Book Session
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>
        <c:when test="${searchPerformed}">
            <div class="no-results">
                <i class="fas fa-search"></i>
                <h4>No tutors found</h4>
                <p>Try adjusting your search criteria or browse all available tutors.</p>
                <a href="${pageContext.request.contextPath}/tutor-search" class="btn btn-primary">
                    <i class="fas fa-refresh me-2"></i>View All Tutors
                </a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="text-center py-5">
                <i class="fas fa-search fa-4x text-muted mb-3"></i>
                <h4 class="text-muted">Start your search</h4>
                <p class="text-muted">Use the filters above to find the perfect tutor for your needs.</p>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<script>
    // Form enhancement
    document.addEventListener('DOMContentLoaded', function() {
        // Auto-submit on filter change for better UX
        const filters = document.querySelectorAll('#specialization, #sortBy, #experienceLevel');
        filters.forEach(filter => {
            filter.addEventListener('change', function() {
                // Optional: Auto-submit form on change
                // this.form.submit();
            });
        });

        // Clear filters button
        const clearBtn = document.createElement('button');
        clearBtn.type = 'button';
        clearBtn.className = 'btn btn-outline-secondary btn-sm ms-2';
        clearBtn.innerHTML = '<i class="fas fa-times me-1"></i>Clear Filters';
        clearBtn.onclick = function() {
            window.location.href = '${pageContext.request.contextPath}/tutor-search';
        };

        // Add clear button to search form
        const searchButton = document.querySelector('.btn-search');
        if (searchButton && searchButton.parentNode) {
            searchButton.parentNode.appendChild(clearBtn);
        }

        // Rate range validation
        const minRateInput = document.getElementById('minRate');
        const maxRateInput = document.getElementById('maxRate');

        function validateRateRange() {
            const minVal = parseFloat(minRateInput.value) || 0;
            const maxVal = parseFloat(maxRateInput.value) || Infinity;

            if (minVal > maxVal && maxRateInput.value) {
                maxRateInput.setCustomValidity('Maximum rate must be greater than minimum rate');
            } else {
                maxRateInput.setCustomValidity('');
            }
        }

        minRateInput.addEventListener('input', validateRateRange);
        maxRateInput.addEventListener('input', validateRateRange);

        // Smooth scroll to results
        const results = document.querySelector('.tutor-card');
        if (results && ${searchPerformed}) {
            setTimeout(() => {
                results.scrollIntoView({ behavior: 'smooth', block: 'start' });
            }, 300);
        }

        // Loading state for search button
        const searchForms = document.querySelectorAll('form');
        searchForms.forEach(form => {
            form.addEventListener('submit', function() {
                const submitBtn = form.querySelector('button[type="submit"]');
                if (submitBtn) {
                    submitBtn.disabled = true;
                    submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Searching...';
                }
            });
        });
    });

    // Advanced search toggle
    function toggleAdvancedSearch() {
        const advancedForm = document.querySelector('.search-form:nth-of-type(2)');
        if (advancedForm.style.display === 'none') {
            advancedForm.style.display = 'block';
            advancedForm.scrollIntoView({ behavior: 'smooth' });
        } else {
            advancedForm.style.display = 'none';
        }
    }

    // Favorite tutor functionality
    function toggleFavorite(tutorId, element) {
        const icon = element.querySelector('i');
        const isFavorited = icon.classList.contains('fas');

        // Toggle icon
        if (isFavorited) {
            icon.classList.remove('fas');
            icon.classList.add('far');
            element.setAttribute('title', 'Add to favorites');
        } else {
            icon.classList.remove('far');
            icon.classList.add('fas');
            element.setAttribute('title', 'Remove from favorites');
        }

        // Here you would typically make an AJAX call to save the favorite status
        // fetch('/api/favorites', { method: 'POST', body: JSON.stringify({tutorId, action: isFavorited ? 'remove' : 'add'}) });
    }
</script>
</body>
</html>

