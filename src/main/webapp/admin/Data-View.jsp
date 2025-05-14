<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Administration - HomeTutor.lk</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css">
    <style>
        .stat-card {
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .stat-card.tutors {
            background-color: #e3f2fd;
        }
        .stat-card.students {
            background-color: #e8f5e9;
        }
        .stat-card.total {
            background-color: #f3e5f5;
        }
    </style>
</head>
<body>
<jsp:include page="../includes/admin-navbar.jsp" />

<div class="container mt-4">
    <h2 class="mb-4">User Administration Dashboard</h2>

    <!-- Statistics Cards -->
    <div class="row mb-4">
        <div class="col-md-4">
            <div class="stat-card total">
                <h5>Total Users</h5>
                <h3>${totalUsers}</h3>
            </div>
        </div>
        <div class="col-md-4">
            <div class="stat-card tutors">
                <h5>Tutors</h5>
                <h3>${totalTutors}</h3>
            </div>
        </div>
        <div class="col-md-4">
            <div class="stat-card students">
                <h5>Students</h5>
                <h3>${totalStudents}</h3>
            </div>
        </div>
    </div>

    <!-- Export Buttons -->
    <div class="mb-4">
        <a href="${pageContext.request.contextPath}/admin/view-data?export=txt"
           class="btn btn-outline-primary">Export as Text</a>
        <a href="${pageContext.request.contextPath}/admin/view-data?export=csv"
           class="btn btn-outline-success ms-2">Export as CSV</a>
    </div>

    <!-- User Data Tabs -->
    <ul class="nav nav-tabs" id="userTabs" role="tablist">
        <li class="nav-item" role="presentation">
            <button class="nav-link active" id="all-tab" data-bs-toggle="tab"
                    data-bs-target="#all" type="button" role="tab">All Users</button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link" id="tutors-tab" data-bs-toggle="tab"
                    data-bs-target="#tutors" type="button" role="tab">Tutors</button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link" id="students-tab" data-bs-toggle="tab"
                    data-bs-target="#students" type="button" role="tab">Students</button>
        </li>
    </ul>

    <div class="tab-content p-3 border border-top-0 rounded-bottom">
        <!-- All Users Tab -->
        <div class="tab-pane fade show active" id="all" role="tabpanel">
            <table class="table table-striped table-bordered">
                <thead>
                <tr>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Role</th>
                    <th>Type</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${allUsers}" var="user">
                    <tr>
                        <td>${user.name}</td>
                        <td>${user.email}</td>
                        <td>${user.phone}</td>
                        <td>${user.role}</td>
                        <td>
                            <c:choose>
                                <c:when test="${user.role eq 'tutor'}">Tutor</c:when>
                                <c:when test="${user.role eq 'admin'}">Admin</c:when>
                                <c:otherwise>Student</c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- Tutors Tab -->
        <div class="tab-pane fade" id="tutors" role="tabpanel">
            <table class="table table-striped table-bordered">
                <thead>
                <tr>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Primary Subject</th>
                    <th>Hourly Rate</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${tutors}" var="tutor">
                    <tr>
                        <td>${tutor.name}</td>
                        <td>${tutor.email}</td>
                        <td>${tutor.phone}</td>
                        <td>${tutor.primarySubject}</td>
                        <td>LKR ${tutor.hourlyRate}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- Students Tab -->
        <div class="tab-pane fade" id="students" role="tabpanel">
            <table class="table table-striped table-bordered">
                <thead>
                <tr>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Status</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${students}" var="student">
                    <tr>
                        <td>${student.name}</td>
                        <td>${student.email}</td>
                        <td>${student.phone}</td>
                        <td>Active</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>
<script>
    $(document).ready(function() {
        // Initialize DataTables
        $('table').DataTable({
            responsive: true
        });

        // Activate Bootstrap tabs
        var tabEls = document.querySelectorAll('button[data-bs-toggle="tab"]');
        tabEls.forEach(function(tabEl) {
            tabEl.addEventListener('shown.bs.tab', function (event) {
                $($.fn.dataTable.tables(true)).DataTable().columns.adjust().responsive.recalc();
            });
        });
    });
</script>
</body>
</html>