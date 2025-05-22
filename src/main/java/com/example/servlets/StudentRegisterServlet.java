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

@WebServlet("/student-register")
public class StudentRegisterServlet extends HttpServlet {
    private StudentService studentService = new StudentService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Show registration page
        request.getRequestDispatcher("/WEB-INF/views/student-register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Get form parameters
            String fullName = request.getParameter("fullName");
            String phoneNumber = request.getParameter("phoneNumber");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirmPassword");
            String grade = request.getParameter("grade");
            String module = request.getParameter("module");

            // Validate password confirmation
            if (!password.equals(confirmPassword)) {
                request.setAttribute("error", "Passwords do not match!");
                request.getRequestDispatcher("/WEB-INF/views/student-register.jsp").forward(request, response);
                return;
            }

            // Register student
            Student student = studentService.registerStudent(fullName, phoneNumber, email, password, grade, module);

            // Set success message
            request.setAttribute("success", "Registration successful! Welcome " + student.getFullName());

            // Create session for the new student
            HttpSession session = request.getSession();
            session.setAttribute("student", student);
            session.setAttribute("studentId", student.getId());
            session.setAttribute("studentName", student.getFullName());

            // Redirect to dashboard or success page
            response.sendRedirect(request.getContextPath() + "/student-dashboard");

        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/student-register.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Registration failed. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/student-register.jsp").forward(request, response);
        }
    }
}