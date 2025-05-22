package com.example.modules.TutorManagement.servlets;

import com.example.modules.TutorManagement.TutorService;
import com.example.modules.TutorManagement.ScheduleService;
import com.example.models.Tutor;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/tutor-register")
public class TutorRegisterServlet extends HttpServlet {
    private final TutorService tutorService = new TutorService();
    private final ScheduleService scheduleService = new ScheduleService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String subject = request.getParameter("subject");
        String[] days = request.getParameterValues("days");
        String[] timeSlots = request.getParameterValues("timeSlots");

        try {
            if (tutorService.emailExists(email)) {
                request.setAttribute("error", "Email already exists");
                request.getRequestDispatcher("/WEB-INF/tutorJSP/registerJSP.jsp").forward(request, response);
                return;
            }

            Tutor tutor = tutorService.registerTutor(name, email, password, subject);
            if (days != null && timeSlots != null) {
                scheduleService.createSchedules(tutor.getId(), days, timeSlots);
            }
            response.sendRedirect("tutor-login");
        } catch (Exception e) {
            throw new ServletException("Error during tutor registration", e);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/tutorJSP/registerJSP.jsp").forward(request, response);
    }
}