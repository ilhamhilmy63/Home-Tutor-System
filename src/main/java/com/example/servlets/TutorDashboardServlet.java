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

@WebServlet("/tutor-dashboard")
public class TutorDashboardServlet extends HttpServlet {
    private TutorService tutorService = new TutorService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check if tutor is logged in
        if (session == null || session.getAttribute("tutor") == null) {
            response.sendRedirect(request.getContextPath() + "/tutor-login");
            return;
        }

        Tutor tutor = (Tutor) session.getAttribute("tutor");
        request.setAttribute("tutor", tutor);

        // Forward to dashboard JSP
        request.getRequestDispatcher("/WEB-INF/views/tutor-dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("tutor") == null) {
            response.sendRedirect(request.getContextPath() + "/tutor-login");
            return;
        }

        if ("logout".equals(action)) {
            session.invalidate();
            response.sendRedirect(request.getContextPath() + "/tutor-login");
        } else if ("updateProfile".equals(action)) {
            updateTutorProfile(request, response, session);
        } else {
            doGet(request, response);
        }
    }

    private void updateTutorProfile(HttpServletRequest request, HttpServletResponse response,
                                    HttpSession session) throws ServletException, IOException {
        try {
            Tutor currentTutor = (Tutor) session.getAttribute("tutor");

            // Get updated information
            String fullName = request.getParameter("fullName");
            String phoneNumber = request.getParameter("phoneNumber");
            String qualification = request.getParameter("qualification");
            String specialization = request.getParameter("specialization");
            String experience = request.getParameter("experience");
            String hourlyRateStr = request.getParameter("hourlyRate");

            // Convert hourlyRate to double
            double hourlyRate = Double.parseDouble(hourlyRateStr);
            if (hourlyRate <= 0) {
                throw new IllegalArgumentException("Hourly rate must be positive.");
            }

            // Update tutor object
            currentTutor.setFullName(fullName);
            currentTutor.setPhoneNumber(phoneNumber);
            currentTutor.setQualification(qualification);
            currentTutor.setSpecialization(specialization);
            currentTutor.setExperience(experience);
            currentTutor.setHourlyRate(hourlyRate); // Use the double value

            // Save to repository
            tutorService.updateTutor(currentTutor);

            // Update session
            session.setAttribute("tutor", currentTutor);
            session.setAttribute("tutorName", currentTutor.getFullName());

            request.setAttribute("success", "Profile updated successfully!");
            request.setAttribute("tutor", currentTutor);
            request.getRequestDispatcher("/WEB-INF/views/tutor-dashboard.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Hourly rate must be a valid number.");
            doGet(request, response);
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            doGet(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Failed to update profile. Please try again.");
            doGet(request, response);
        }
    }
}
