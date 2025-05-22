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

@WebServlet("/student-login")
public class StudentLoginServlet extends HttpServlet {
    private StudentService studentService = new StudentService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Show login page
        request.getRequestDispatcher("/WEB-INF/views/student-login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            // Validate input
            if (email == null || email.trim().isEmpty()) {
                request.setAttribute("error", "Email is required!");
                request.getRequestDispatcher("/WEB-INF/views/student-login.jsp").forward(request, response);
                return;
            }

            if (password == null || password.trim().isEmpty()) {
                request.setAttribute("error", "Password is required!");
                request.getRequestDispatcher("/WEB-INF/views/student-login.jsp").forward(request, response);
                return;
            }

            // Attempt login
            Student student = studentService.loginStudent(email, password);

            if (student != null) {
                // Create session
                HttpSession session = request.getSession();
                session.setAttribute("student", student);
                session.setAttribute("studentId", student.getId());
                session.setAttribute("studentName", student.getFullName());
                session.setAttribute("studentEmail", student.getEmail());

                // Redirect to dashboard
                response.sendRedirect(request.getContextPath() + "/student-dashboard");
            } else {
                request.setAttribute("error", "Invalid email or password!");
                request.setAttribute("email", email); // Keep email in form
                request.getRequestDispatcher("/WEB-INF/views/student-login.jsp").forward(request, response);
            }

        } catch (Exception e) {
            request.setAttribute("error", "Login failed. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/student-login.jsp").forward(request, response);
        }
    }
}
