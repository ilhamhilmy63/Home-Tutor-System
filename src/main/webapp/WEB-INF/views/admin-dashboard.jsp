<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.model.Student" %>
<%@ page import="com.example.model.Tutor" %>
<%@ page import="com.example.model.Admin" %>
<%
  Admin admin = (Admin) session.getAttribute("admin");
  if (admin == null) {
    response.sendRedirect("admin-login");
    return;
  }

  @SuppressWarnings("unchecked")
  List<Student> students = (List<Student>) request.getAttribute("students");
  @SuppressWarnings("unchecked")
  List<Tutor> tutors = (List<Tutor>) request.getAttribute("tutors");
  Long totalStudents = (Long) request.getAttribute("totalStudents");
  Long totalTutors = (Long) request.getAttribute("totalTutors");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Dashboard - Home Tutor System</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #f8f9fa;
    }
    .sidebar {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      min-height: 100vh;
      padding: 0;
    }
    .sidebar .nav-link {
      color: rgba(255,255,255,0.8);
      padding: 15px 20px;
      border-radius: 0;
      margin: 5px 0;
    }
    .sidebar .nav-link:hover {
      background-color: rgba(255,255,255,0.1);
      color: white;
    }
    .sidebar .nav-link.active {
      background-color: rgba(255,255,255,0.2);
      color: white;
    }
    .main-content {
      padding: 2rem;
    }
    .stat-card {
      background: white;
      border-radius: 15px;
      padding: 2rem;
      box-shadow: 0 5px 15px rgba(0,0,0,0.08);
      border: none;
      transition: transform 0.3s ease;
    }
    .stat-card:hover {
      transform: translateY(-5px);
    }
    .stat-icon {
      width: 60px;
      height: 60px;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 24px;
      margin-bottom: 1rem;
    }
    .table-card {
      background: white;
      border-radius: 15px;
      padding: 2rem;
      box-shadow: 0 5px 15px rgba(0,0,0,0.08);
      border: none;
    }
    .btn-action {
      padding: 5px 10px;
      border-radius: 20px;
      font-size: 12px;
      margin: 2px;
    }
    .admin-header {
      background: white;
      padding: 1rem 2rem;
      border-bottom: 1px solid #e9ecef;
      margin-bottom: 2rem;
    }
    .badge-role {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      padding: 8px 15px;
      border-radius: 20px;
      font-size: 12px;
    }
    .nav-tabs .nav-link {
      color: #667eea;
      border: none;
      padding: 10px 20px;
    }
    .nav-tabs .nav-link.active {
      color: #764ba2;
      border-bottom: 3px solid #764ba2;
      background: transparent;
      font-weight: 600;
    }
    .tab-content {
      background: white;
      border-radius: 0 0 15px 15px;
      padding: 20px;
      box-shadow: 0 5px 15px rgba(0,0,0,0.08);
    }
  </style>
</head>
<body>
<div class="container-fluid">
  <div class="row">
    <!-- Sidebar -->
    <div class="col-md-3 col-lg-2 sidebar">
      <div class="p-4 text-center text-white">
        <i class="fas fa-user-shield fa-3x mb-3"></i>
        <h5>Admin Panel</h5>
        <p class="small opacity-75">Home Tutor System</p>
      </div>

      <nav class="nav flex-column">
        <a class="nav-link active" href="#dashboard">
          <i class="fas fa-tachometer-alt me-2"></i>Dashboard
        </a>
        <a class="nav-link" href="#students">
          <i class="fas fa-graduation-cap me-2"></i>Students
        </a>
        <a class="nav-link" href="#tutors">
          <i class="fas fa-chalkboard-teacher me-2"></i>Tutors
        </a>
        <a class="nav-link" href="#reports">
          <i class="fas fa-chart-bar me-2"></i>Reports
        </a>
        <a class="nav-link" href="#settings">
          <i class="fas fa-cog me-2"></i>Settings
        </a>
        <hr class="text-white-50">
        <a class="nav-link" href="logout">
          <i class="fas fa-sign-out-alt me-2"></i>Logout
        </a>
      </nav>
    </div>

    <!-- Main Content -->
    <div class="col-md-9 col-lg-10">
      <!-- Header -->
      <div class="admin-header d-flex justify-content-between align-items-center">
        <div>
          <h3 class="mb-0">Welcome back, <%= admin.getFullName() %>!</h3>
          <p class="text-muted mb-0">
            <span class="badge badge-role text-white"><%= admin.getRole() %></span>
          </p>
        </div>
        <div>
          <span class="text-muted">
            <i class="fas fa-calendar me-2"></i>
            <%= new java.text.SimpleDateFormat("EEEE, MMMM dd, yyyy").format(new java.util.Date()) %>
          </span>
        </div>
      </div>

      <div class="main-content">
        <!-- Alerts -->
        <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-danger alert-dismissible fade show">
          <i class="fas fa-exclamation-circle me-2"></i>
          <%= request.getAttribute("error") %>
          <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <% } %>

        <% if (request.getAttribute("success") != null) { %>
        <div class="alert alert-success alert-dismissible fade show">
          <i class="fas fa-check-circle me-2"></i>
          <%= request.getAttribute("success") %>
          <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <% } %>

        <!-- Statistics Cards -->
        <div class="row mb-4">
          <div class="col-md-3">
            <div class="stat-card text-center">
              <div class="stat-icon bg-primary text-white mx-auto">
                <i class="fas fa-users"></i>
              </div>
              <h3 class="text-primary"><%= totalStudents != null ? totalStudents : 0 %></h3>
              <p class="text-muted mb-0">Total Students</p>
            </div>
          </div>
          <div class="col-md-3">
            <div class="stat-card text-center">
              <div class="stat-icon bg-success text-white mx-auto">
                <i class="fas fa-user-check"></i>
              </div>
              <h3 class="text-success">
                <%= students != null ? students.stream().filter(s -> s.getEmail() != null).count() : 0 %>
              </h3>
              <p class="text-muted mb-0">Active Students</p>
            </div>
          </div>
          <div class="col-md-3">
            <div class="stat-card text-center">
              <div class="stat-icon bg-warning text-white mx-auto">
                <i class="fas fa-chalkboard-teacher"></i>
              </div>
              <h3 class="text-warning"><%= totalTutors != null ? totalTutors : 0 %></h3>
              <p class="text-muted mb-0">Total Tutors</p>
            </div>
          </div>
          <div class="col-md-3">
            <div class="stat-card text-center">
              <div class="stat-icon bg-info text-white mx-auto">
                <i class="fas fa-user-tie"></i>
              </div>
              <h3 class="text-info">
                <%= tutors != null ? tutors.stream().filter(t -> t.getEmail() != null).count() : 0 %>
              </h3>
              <p class="text-muted mb-0">Active Tutors</p>
            </div>
          </div>
        </div>

        <!-- Tabs Navigation -->
        <ul class="nav nav-tabs" id="adminTabs" role="tablist">
          <li class="nav-item" role="presentation">
            <button class="nav-link active" id="students-tab" data-bs-toggle="tab"
                    data-bs-target="#students-tab-pane" type="button" role="tab">
              <i class="fas fa-graduation-cap me-2"></i>Students
            </button>
          </li>
          <li class="nav-item" role="presentation">
            <button class="nav-link" id="tutors-tab" data-bs-toggle="tab"
                    data-bs-target="#tutors-tab-pane" type="button" role="tab">
              <i class="fas fa-chalkboard-teacher me-2"></i>Tutors
            </button>
          </li>
        </ul>

        <!-- Tabs Content -->
        <div class="tab-content" id="adminTabsContent">
          <!-- Students Tab -->
          <div class="tab-pane fade show active" id="students-tab-pane" role="tabpanel">
            <div class="d-flex justify-content-between align-items-center mb-4">
              <h4 class="mb-0">
                <i class="fas fa-users me-2"></i>Students Management
              </h4>
              <button class="btn btn-primary">
                <i class="fas fa-plus me-2"></i>Add New Student
              </button>
            </div>

            <% if (students != null && !students.isEmpty()) { %>
            <div class="table-responsive">
              <table class="table table-hover">
                <thead class="table-light">
                <tr>
                  <th>ID</th>
                  <th>Name</th>
                  <th>Email</th>
                  <th>Phone</th>
                  <th>Grade</th>
                  <th>Module</th>
                  <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <% for (Student student : students) { %>
                <tr>
                  <td>
                    <span class="badge bg-secondary">
                      <%= student.getId().substring(0, 8) %>...
                    </span>
                  </td>
                  <td>
                    <div class="d-flex align-items-center">
                      <div class="bg-primary rounded-circle d-flex align-items-center justify-content-center me-2"
                           style="width: 35px; height: 35px; font-size: 14px; color: white;">
                        <%= student.getFullName().substring(0, 1).toUpperCase() %>
                      </div>
                      <strong><%= student.getFullName() %></strong>
                    </div>
                  </td>
                  <td><%= student.getEmail() %></td>
                  <td><%= student.getPhoneNumber() %></td>
                  <td>
                    <span class="badge bg-info"><%= student.getGrade() %></span>
                  </td>
                  <td>
                    <span class="badge bg-warning text-dark"><%= student.getModule() %></span>
                  </td>
                  <td>
                    <button class="btn btn-sm btn-outline-primary btn-action"
                            onclick="viewStudent('<%= student.getId() %>')">
                      <i class="fas fa-eye"></i>
                    </button>
                    <button class="btn btn-sm btn-outline-success btn-action"
                            onclick="editStudent('<%= student.getId() %>')">
                      <i class="fas fa-edit"></i>
                    </button>
                    <button class="btn btn-sm btn-outline-danger btn-action"
                            onclick="deleteStudent('<%= student.getId() %>', '<%= student.getFullName() %>')">
                      <i class="fas fa-trash"></i>
                    </button>
                  </td>
                </tr>
                <% } %>
                </tbody>
              </table>
            </div>
            <% } else { %>
            <div class="text-center py-5">
              <i class="fas fa-users fa-3x text-muted mb-3"></i>
              <h5 class="text-muted">No students found</h5>
              <p class="text-muted">Students will appear here once they register.</p>
            </div>
            <% } %>
          </div>

          <!-- Tutors Tab -->
          <div class="tab-pane fade" id="tutors-tab-pane" role="tabpanel">
            <div class="d-flex justify-content-between align-items-center mb-4">
              <h4 class="mb-0">
                <i class="fas fa-chalkboard-teacher me-2"></i>Tutors Management
              </h4>
              <button class="btn btn-primary">
                <i class="fas fa-plus me-2"></i>Add New Tutor
              </button>
            </div>

            <% if (tutors != null && !tutors.isEmpty()) { %>
            <div class="table-responsive">
              <table class="table table-hover">
                <thead class="table-light">
                <tr>
                  <th>ID</th>
                  <th>Name</th>
                  <th>Email</th>
                  <th>Phone</th>
                  <th>Specialization</th>
                  <th>Experience</th>
                  <th>Rate</th>
                  <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <% for (Tutor tutor : tutors) { %>
                <tr>
                  <td>
                    <span class="badge bg-secondary">
                      <%= tutor.getId().substring(0, 8) %>...
                    </span>
                  </td>
                  <td>
                    <div class="d-flex align-items-center">
                      <div class="bg-primary rounded-circle d-flex align-items-center justify-content-center me-2"
                           style="width: 35px; height: 35px; font-size: 14px; color: white;">
                        <%= tutor.getFullName().substring(0, 1).toUpperCase() %>
                      </div>
                      <strong><%= tutor.getFullName() %></strong>
                    </div>
                  </td>
                  <td><%= tutor.getEmail() %></td>
                  <td><%= tutor.getPhoneNumber() %></td>
                  <td>
                    <span class="badge bg-success"><%= tutor.getSpecialization() %></span>
                  </td>
                  <td><%= tutor.getExperience() %></td>
                  <td>$<%= tutor.getHourlyRate() %>/hr</td>
                  <td>
                    <button class="btn btn-sm btn-outline-primary btn-action"
                            onclick="viewTutor('<%= tutor.getId() %>')">
                      <i class="fas fa-eye"></i>
                    </button>
                    <button class="btn btn-sm btn-outline-success btn-action"
                            onclick="editTutor('<%= tutor.getId() %>')">
                      <i class="fas fa-edit"></i>
                    </button>
                    <button class="btn btn-sm btn-outline-danger btn-action"
                            onclick="deleteTutor('<%= tutor.getId() %>', '<%= tutor.getFullName() %>')">
                      <i class="fas fa-trash"></i>
                    </button>
                  </td>
                </tr>
                <% } %>
                </tbody>
              </table>
            </div>
            <% } else { %>
            <div class="text-center py-5">
              <i class="fas fa-chalkboard-teacher fa-3x text-muted mb-3"></i>
              <h5 class="text-muted">No tutors found</h5>
              <p class="text-muted">Tutors will appear here once they register.</p>
            </div>
            <% } %>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Delete Confirmation Modal (Student) -->
<div class="modal fade" id="deleteStudentModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Confirm Delete</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">
        <p>Are you sure you want to delete student <strong id="studentName"></strong>?</p>
        <p class="text-danger">This action cannot be undone.</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
        <form method="post" style="display: inline;">
          <input type="hidden" name="action" value="deleteStudent">
          <input type="hidden" name="studentId" id="deleteStudentId">
          <button type="submit" class="btn btn-danger">Delete</button>
        </form>
      </div>
    </div>
  </div>
</div>

<!-- Delete Confirmation Modal (Tutor) -->
<div class="modal fade" id="deleteTutorModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Confirm Delete</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">
        <p>Are you sure you want to delete tutor <strong id="tutorName"></strong>?</p>
        <p class="text-danger">This action cannot be undone.</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
        <form method="post" style="display: inline;">
          <input type="hidden" name="action" value="deleteTutor">
          <input type="hidden" name="tutorId" id="deleteTutorId">
          <button type="submit" class="btn btn-danger">Delete</button>
        </form>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
  // Student functions
  function deleteStudent(studentId, studentName) {
    document.getElementById('studentName').textContent = studentName;
    document.getElementById('deleteStudentId').value = studentId;
    new bootstrap.Modal(document.getElementById('deleteStudentModal')).show();
  }

  function viewStudent(studentId) {
    // Implement view student functionality
    alert('View student: ' + studentId);
  }

  function editStudent(studentId) {
    // Implement edit student functionality
    alert('Edit student: ' + studentId);
  }

  // Tutor functions
  function deleteTutor(tutorId, tutorName) {
    document.getElementById('tutorName').textContent = tutorName;
    document.getElementById('deleteTutorId').value = tutorId;
    new bootstrap.Modal(document.getElementById('deleteTutorModal')).show();
  }

  function viewTutor(tutorId) {
    // Implement view tutor functionality
    alert('View tutor: ' + tutorId);
  }

  function editTutor(tutorId) {
    // Implement edit tutor functionality
    alert('Edit tutor: ' + tutorId);
  }
</script>
</body>
</html>