package com.example.servlets;

import com.example.model.Tutor;
import com.example.modules.TutorManagement.TutorService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/tutor-login")
public class TutorLoginServlet extends HttpServlet {
    private TutorService tutorService = new TutorService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Show login page
        request.getRequestDispatcher("/WEB-INF/views/tutor-login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            // Attempt login
            Tutor tutor = tutorService.loginTutor(email, password);

            if (tutor != null) {
                // Create session
                HttpSession session = request.getSession();
                session.setAttribute("tutor", tutor);
                session.setAttribute("tutorId", tutor.getId());
                session.setAttribute("tutorName", tutor.getFullName());

                // Redirect to dashboard
                response.sendRedirect(request.getContextPath() + "/tutor-dashboard");
            } else {
                // Login failed
                request.setAttribute("error", "Invalid email or password!");
                request.getRequestDispatcher("/WEB-INF/views/tutor-login.jsp").forward(request, response);
            }

        } catch (Exception e) {
            request.setAttribute("error", "Login failed. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/tutor-login.jsp").forward(request, response);
        }
    }
}
