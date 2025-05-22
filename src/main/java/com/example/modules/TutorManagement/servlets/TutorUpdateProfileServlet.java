package com.example.modules.TutorManagement.servlets;

import com.example.modules.TutorManagement.TutorService;
import com.example.modules.TutorManagement.ScheduleService;
import com.example.models.Tutor;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/tutor-update-profile")
public class TutorUpdateProfileServlet extends HttpServlet {
    private final TutorService tutorService = new TutorService();
    private final ScheduleService scheduleService = new ScheduleService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            Tutor tutor = (Tutor) session.getAttribute("tutor");
            if (tutor != null) {
                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String subject = request.getParameter("subject");
                String[] days = request.getParameterValues("days");
                String[] timeSlots = request.getParameterValues("timeSlots");

                boolean success = tutorService.updateTutorProfile(tutor.getId(), name, email, subject);
                if (success) {
                    tutor.setName(name);
                    tutor.setEmail(email);
                    tutor.setSubject(subject);
                    session.setAttribute("tutor", tutor);
                    if (days != null && timeSlots != null) {
                        scheduleService.createSchedules(tutor.getId(), days, timeSlots);
                    }
                    request.setAttribute("message", "Profile and schedule updated successfully");
                } else {
                    request.setAttribute("error", "Failed to update profile");
                }
            } else {
                response.sendRedirect("tutor-login");
                return;
            }
        }
        request.getRequestDispatcher("/WEB-INF/tutorJSP/updateProfileJSP.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("tutor") != null) {
            request.getRequestDispatcher("/WEB-INF/tutorJSP/updateProfileJSP.jsp").forward(request, response);
        } else {
            response.sendRedirect("tutor-login");
        }
    }
}