package com.example.modules.TutorManagement.servlets;

import com.example.modules.TutorManagement.TutorService;
import com.example.models.Tutor;
import com.example.models.Booking;
import com.example.models.User;
import com.example.modules.UserManagement.UserRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;
import java.util.logging.Level;

@WebServlet("/tutor-login")
public class TutorLoginServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(TutorLoginServlet.class.getName());
    private final TutorService tutorService = new TutorService();
    private final UserRepository userRepository = new UserRepository();
    private static final String BOOKINGS_FILE_PATH = "C:/Users/share/Desktop/HomeTutor/src/main/webapp/WEB-INF/data/bookings.txt";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        LOGGER.log(Level.INFO, "Starting doPost for tutor login");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        LOGGER.log(Level.INFO, "Login attempt for email: {0}", email);

        try {
            Tutor tutor = tutorService.loginTutor(email, password);
            if (tutor != null) {
                LOGGER.log(Level.INFO, "Login successful for tutor ID: {0}", tutor.getId());
                request.getSession().setAttribute("tutor", tutor);
                // Fetch bookings and student names for the tutor
                Map<String, Object> bookingData = getTutorBookings(tutor.getId());
                List<Booking> tutorBookings = (List<Booking>) bookingData.get("bookings");
                Map<String, String> studentIdToName = (Map<String, String>) bookingData.get("studentIdToName");
                LOGGER.log(Level.INFO, "Retrieved {0} bookings and {1} student names for tutor ID: {2}",
                        new Object[]{tutorBookings.size(), studentIdToName.size(), tutor.getId()});
                request.setAttribute("tutorBookings", tutorBookings);
                request.setAttribute("studentIdToName", studentIdToName);
                request.getRequestDispatcher("/WEB-INF/tutorJSP/tutorBookingsJSP.jsp").forward(request, response);
            } else {
                LOGGER.log(Level.WARNING, "Login failed for email: {0}", email);
                request.setAttribute("error", "Invalid email or password");
                request.getRequestDispatcher("/WEB-INF/tutorJSP/loginJSP.jsp").forward(request, response);
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error during login for email: {0}", new Object[]{email, e});
            request.setAttribute("error", "An error occurred during login: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/tutorJSP/loginJSP.jsp").forward(request, response);
        }
        LOGGER.log(Level.INFO, "Completed doPost for tutor login");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        LOGGER.log(Level.INFO, "Starting doGet for tutor login page");
        request.getRequestDispatcher("/WEB-INF/tutorJSP/loginJSP.jsp").forward(request, response);
        LOGGER.log(Level.INFO, "Completed doGet for tutor login page");
    }

    private Map<String, Object> getTutorBookings(String tutorId) throws IOException {
        LOGGER.log(Level.INFO, "Fetching bookings for tutor ID: {0}", tutorId);
        List<Booking> bookings = new ArrayList<>();
        List<String> studentIds = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(BOOKINGS_FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length == 7 && parts[2].equals(tutorId)) {
                    Booking booking = new Booking(parts[0], parts[1], parts[2], parts[3], parts[4], parts[5], parts[6]);
                    bookings.add(booking);
                    studentIds.add(booking.getStudentId());
                    LOGGER.log(Level.FINE, "Found booking ID: {0} for tutor ID: {1}",
                            new Object[]{booking.getId(), tutorId});
                }
            }
        } catch (IOException e) {
            LOGGER.log(Level.SEVERE, "Error reading bookings file for tutor ID: {0}", new Object[]{tutorId, e});
            throw e;
        }

        // Fetch student names for the student IDs
        Map<String, String> studentIdToName = new HashMap<>();
        try {
            List<User> users = userRepository.getAllUsers();
            LOGGER.log(Level.INFO, "Retrieved {0} users for student name mapping", users.size());
            for (User user : users) {
                if (studentIds.contains(user.getId())) {
                    studentIdToName.put(user.getId(), user.getName());
                    LOGGER.log(Level.FINE, "Mapped student ID: {0} to name: {1}",
                            new Object[]{user.getId(), user.getName()});
                }
            }
        } catch (IOException e) {
            LOGGER.log(Level.SEVERE, "Error reading users file for student names: {0}", e);
            throw e;
        }

        Map<String, Object> result = new HashMap<>();
        result.put("bookings", bookings);
        result.put("studentIdToName", studentIdToName);
        LOGGER.log(Level.INFO, "Retrieved {0} bookings and {1} student names for tutor ID: {2}",
                new Object[]{bookings.size(), studentIdToName.size(), tutorId});
        return result;
    }
}