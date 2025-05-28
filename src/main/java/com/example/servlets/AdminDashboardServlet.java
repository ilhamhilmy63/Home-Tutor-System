package com.example.servlets;

import com.example.model.Admin;
import com.example.model.Student;
import com.example.model.Tutor;
import com.example.modules.AdminManagement.AdminService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin-dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private AdminService adminService = new AdminService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Admin admin = (Admin) session.getAttribute("admin");

        // Check if admin is logged in
        if (admin == null) {
            response.sendRedirect(request.getContextPath() + "/admin-login");
            return;
        }

        try {
            // Get all students and tutors for dashboard
            List<Student> students = adminService.getAllStudents();
            List<Tutor> tutors = adminService.getAllTutors();
            long totalStudents = adminService.getTotalStudentCount();
            long totalTutors = adminService.getTotalTutorCount();

            // Set attributes for JSP
            request.setAttribute("students", students);
            request.setAttribute("tutors", tutors);
            request.setAttribute("totalStudents", totalStudents);
            request.setAttribute("totalTutors", totalTutors);
            request.setAttribute("admin", admin);

            // Forward to dashboard JSP
            request.getRequestDispatcher("/WEB-INF/views/admin-dashboard.jsp").forward(request, response);

        } catch (Exception e) {
            request.setAttribute("error", "Error loading dashboard data.");
            request.getRequestDispatcher("/WEB-INF/views/admin-dashboard.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Admin admin = (Admin) session.getAttribute("admin");

        if (admin == null) {
            response.sendRedirect(request.getContextPath() + "/admin-login");
            return;
        }

        String action = request.getParameter("action");

        try {
            if ("deleteStudent".equals(action)) {
                String studentId = request.getParameter("studentId");
                boolean deleted = adminService.deleteStudent(studentId);

                if (deleted) {
                    request.setAttribute("success", "Student deleted successfully!");
                } else {
                    request.setAttribute("error", "Failed to delete student.");
                }
            } else if ("deleteTutor".equals(action)) {
                String tutorId = request.getParameter("tutorId");
                boolean deleted = adminService.deleteTutor(tutorId);

                if (deleted) {
                    request.setAttribute("success", "Tutor deleted successfully!");
                } else {
                    request.setAttribute("error", "Failed to delete tutor.");
                }
            }

            // Redirect to prevent form resubmission
            response.sendRedirect(request.getContextPath() + "/admin-dashboard");

        } catch (Exception e) {
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            doGet(request, response);
        }
    }
}