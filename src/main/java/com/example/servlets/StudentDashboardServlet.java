package com.example.servlets;

import com.example.model.Student;
import com.example.modules.StudentManagement.StudentService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/student-dashboard")
public class StudentDashboardServlet extends HttpServlet {
    private StudentService studentService = new StudentService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Student student = (Student) session.getAttribute("student");

        // Check if student is logged in
        if (student == null) {
            response.sendRedirect(request.getContextPath() + "/student-login");
            return;
        }

        try {
            // Get fresh student data from database
            Student freshStudent = studentService.getStudentById(student.getId());
            if (freshStudent != null) {
                // Update session with fresh data
                session.setAttribute("student", freshStudent);
                request.setAttribute("student", freshStudent);
            } else {
                request.setAttribute("student", student);
            }

            // Forward to dashboard JSP
            request.getRequestDispatcher("/WEB-INF/views/student-dashboard.jsp").forward(request, response);

        } catch (Exception e) {
            request.setAttribute("error", "Error loading dashboard data.");
            request.setAttribute("student", student);
            request.getRequestDispatcher("/WEB-INF/views/student-dashboard.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Student student = (Student) session.getAttribute("student");

        if (student == null) {
            response.sendRedirect(request.getContextPath() + "/student-login");
            return;
        }

        String action = request.getParameter("action");

        try {
            if ("updateProfile".equals(action)) {
                // Get updated information
                String fullName = request.getParameter("fullName");
                String phoneNumber = request.getParameter("phoneNumber");
                String email = request.getParameter("email");
                String grade = request.getParameter("grade");
                String module = request.getParameter("module");

                // Update student object
                student.setFullName(fullName);
                student.setPhoneNumber(phoneNumber);
                student.setEmail(email);
                student.setGrade(grade);
                student.setModule(module);

                // Save to database
                boolean updated = studentService.updateStudent(student);

                if (updated) {
                    // Update session
                    session.setAttribute("student", student);
                    session.setAttribute("studentName", student.getFullName());
                    session.setAttribute("studentEmail", student.getEmail());

                    request.setAttribute("success", "Profile updated successfully!");
                } else {
                    request.setAttribute("error", "Failed to update profile.");
                }
            } else if ("changePassword".equals(action)) {
                String currentPassword = request.getParameter("currentPassword");
                String newPassword = request.getParameter("newPassword");
                String confirmPassword = request.getParameter("confirmPassword");

                // Validate current password
                if (!student.getPassword().equals(currentPassword)) {
                    request.setAttribute("error", "Current password is incorrect!");
                } else if (!newPassword.equals(confirmPassword)) {
                    request.setAttribute("error", "New passwords do not match!");
                } else if (newPassword.length() < 6) {
                    request.setAttribute("error", "New password must be at least 6 characters long!");
                } else {
                    // Update password
                    boolean updated = studentService.updatePassword(student.getEmail(), newPassword);
                    if (updated) {
                        request.setAttribute("success", "Password changed successfully!");
                    } else {
                        request.setAttribute("error", "Failed to change password.");
                    }
                }
            }

            // Redirect to prevent form resubmission
            response.sendRedirect(request.getContextPath() + "/student-dashboard");

        } catch (Exception e) {
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            doGet(request, response);
        }
    }
}