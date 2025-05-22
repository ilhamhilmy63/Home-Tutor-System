package com.example.modules.BookingManagement;

import com.example.models.Tutor;
import com.example.models.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/book-tutor")
public class BookingServlet extends HttpServlet {
    private final BookingService bookingService = new BookingService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }

        String step = request.getParameter("step");
        if (step == null || step.isEmpty()) {
            step = "selectSubject";
        }

        switch (step) {
            case "selectSubject":
                List<String> subjects = bookingService.getAllSubjects();
                request.setAttribute("subjects", subjects);
                request.getRequestDispatcher("/WEB-INF/bookingJSP/selectSubject.jsp").forward(request, response);
                break;
            case "selectTutor":
                String subject = request.getParameter("subject");
                if (subject == null) {
                    response.sendRedirect("book-tutor?step=selectSubject");
                    return;
                }
                List<Tutor> tutors = bookingService.getTutorsBySubject(subject);
                request.setAttribute("tutors", tutors);
                request.setAttribute("subject", subject);
                request.getRequestDispatcher("/WEB-INF/bookingJSP/selectTutor.jsp").forward(request, response);
                break;
            case "selectDay":
                String tutorId = request.getParameter("tutorId");
                subject = request.getParameter("subject");
                if (tutorId == null || subject == null) {
                    response.sendRedirect("book-tutor?step=selectSubject");
                    return;
                }
                List<String> days = bookingService.getAvailableDaysForTutor(tutorId);
                request.setAttribute("days", days);
                request.setAttribute("tutorId", tutorId);
                request.setAttribute("subject", subject);
                request.getRequestDispatcher("/WEB-INF/bookingJSP/selectDay.jsp").forward(request, response);
                break;
            case "selectTimeSlot":
                tutorId = request.getParameter("tutorId");
                String day = request.getParameter("day");
                subject = request.getParameter("subject");
                if (tutorId == null || day == null || subject == null) {
                    response.sendRedirect("book-tutor?step=selectSubject");
                    return;
                }
                List<String> timeSlots = bookingService.getAvailableTimeSlotsForTutorAndDay(tutorId, day);
                request.setAttribute("timeSlots", timeSlots);
                request.setAttribute("tutorId", tutorId);
                request.setAttribute("day", day);
                request.setAttribute("subject", subject);
                request.getRequestDispatcher("/WEB-INF/bookingJSP/selectTimeSlot.jsp").forward(request, response);
                break;
            default:
                response.sendRedirect("book-tutor?step=selectSubject");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }

        User student = (User) session.getAttribute("user");
        String tutorId = request.getParameter("tutorId");
        String subject = request.getParameter("subject");
        String day = request.getParameter("day");
        String timeSlot = request.getParameter("timeSlot");

        if (tutorId == null || subject == null || day == null || timeSlot == null) {
            request.setAttribute("error", "Invalid booking details");
            request.getRequestDispatcher("/WEB-INF/bookingJSP/selectSubject.jsp").forward(request, response);
            return;
        }

        try {
            bookingService.createBooking(student.getId(), tutorId, subject, day, timeSlot);
            request.setAttribute("message", "Booking confirmed successfully!");
            request.getRequestDispatcher("/WEB-INF/bookingJSP/bookingConfirmation.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error creating booking: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/bookingJSP/selectTimeSlot.jsp").forward(request, response);
        }
    }
}