package com.example.modules.BookingManagement;

import com.example.models.Booking;
import com.example.models.User;
import com.example.modules.UserManagement.UserRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/tutor-booking-details")
public class TutorBookingDetailsServlet extends HttpServlet {
    private static final String BOOKINGS_FILE_PATH = "C:/Users/share/Desktop/HomeTutor/src/main/webapp/WEB-INF/data/bookings.txt";
    private final UserRepository userRepository = new UserRepository();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("tutor") == null) {
            response.sendRedirect("tutor-login");
            return;
        }

        String bookingId = request.getParameter("bookingId");
        if (bookingId == null) {
            request.setAttribute("error", "Invalid booking ID");
            request.getRequestDispatcher("/WEB-INF/tutorJSP/bookingDetailsJSP.jsp").forward(request, response);
            return;
        }

        // Fetch booking details
        Booking booking = getBookingById(bookingId);
        if (booking == null) {
            request.setAttribute("error", "Booking not found");
            request.getRequestDispatcher("/WEB-INF/tutorJSP/bookingDetailsJSP.jsp").forward(request, response);
            return;
        }

        // Verify tutor ownership
        String tutorId = ((com.example.models.Tutor) session.getAttribute("tutor")).getId();
        if (!booking.getTutorId().equals(tutorId)) {
            request.setAttribute("error", "Unauthorized access to booking");
            request.getRequestDispatcher("/WEB-INF/tutorJSP/bookingDetailsJSP.jsp").forward(request, response);
            return;
        }

        // Fetch student details
        User student = userRepository.getAllUsers().stream()
                .filter(u -> u.getId().equals(booking.getStudentId()))
                .findFirst()
                .orElse(null);

        Map<String, String> details = new HashMap<>();
        details.put("studentName", student != null ? student.getName() : "Unknown");
        details.put("studentEmail", student != null ? student.getEmail() : "Unknown");
        details.put("subject", booking.getSubject());
        details.put("day", booking.getDay());
        details.put("timeSlot", booking.getTimeSlot());
        details.put("status", booking.getStatus());

        request.setAttribute("bookingDetails", details);
        request.getRequestDispatcher("/WEB-INF/tutorJSP/bookingDetailsJSP.jsp").forward(request, response);
    }

    private Booking getBookingById(String bookingId) throws IOException {
        try (BufferedReader reader = new BufferedReader(new FileReader(BOOKINGS_FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts[0].equals(bookingId)) {
                    return new Booking(parts[0], parts[1], parts[2], parts[3], parts[4], parts[5], parts[6]);
                }
            }
        }
        return null;
    }
}