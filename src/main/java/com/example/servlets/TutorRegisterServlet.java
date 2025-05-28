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

@WebServlet("/tutor-register")
public class TutorRegisterServlet extends HttpServlet {
    private TutorService tutorService = new TutorService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Show registration page
        request.getRequestDispatcher("/WEB-INF/views/tutor-register.jsp").forward(request, response);
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
            String qualification = request.getParameter("qualification");
            String specialization = request.getParameter("specialization");
            String experience = request.getParameter("experience");
            String hourlyRateStr = request.getParameter("hourlyRate");

            // Validate and parse hourly rate
            double hourlyRate = Double.parseDouble(hourlyRateStr);
            if (hourlyRate <= 0) {
                throw new IllegalArgumentException("Hourly rate must be a positive number.");
            }

            // Validate password confirmation
            if (!password.equals(confirmPassword)) {
                request.setAttribute("error", "Passwords do not match!");
                request.getRequestDispatcher("/WEB-INF/views/tutor-register.jsp").forward(request, response);
                return;
            }

            // Register tutor
            Tutor tutor = tutorService.registerTutor(fullName, phoneNumber, email, password,
                    qualification, specialization, experience, hourlyRate);

            // Set success message
            request.setAttribute("success", "Registration successful! Welcome " + tutor.getFullName());

            // Create session for the new tutor
            HttpSession session = request.getSession();
            session.setAttribute("tutor", tutor);
            session.setAttribute("tutorId", tutor.getId());
            session.setAttribute("tutorName", tutor.getFullName());

            // Redirect to dashboard
            response.sendRedirect(request.getContextPath() + "/tutor-dashboard");

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Hourly rate must be a valid number.");
            request.getRequestDispatcher("/WEB-INF/views/tutor-register.jsp").forward(request, response);
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/tutor-register.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Registration failed. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/tutor-register.jsp").forward(request, response);
        }
    }
}
