package TutorSearchAndProfileManagement.Servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import TutorSearchAndProfileManagement.Tutor;
import TutorSearchAndProfileManagement.TutorDataStore;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;

@WebServlet("/registerTutor")
public class TutorRegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Collect form parameters
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String subject = request.getParameter("subjects");
        String location = request.getParameter("location");
        String bio = request.getParameter("bio");
        String expertise = request.getParameter("expertise");

        // Validate required fields
        if (name == null || email == null || password == null || subject == null || location == null || bio == null || expertise == null ||
                name.trim().isEmpty() || email.trim().isEmpty() || password.trim().isEmpty() || subject.trim().isEmpty() ||
                location.trim().isEmpty() || bio.trim().isEmpty() || expertise.equals("None")) {
            request.setAttribute("error", "All required fields must be filled, and expertise must be selected.");
            request.getRequestDispatcher("/Tutors/TutorRegister.jsp").forward(request, response);
            return;
        }

        // Validate email format
        if (!email.matches("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
            request.setAttribute("error", "Invalid email format.");
            request.getRequestDispatcher("/Tutors/TutorRegister.jsp").forward(request, response);
            return;
        }

        // Check for duplicate email
        for (Tutor t : TutorDataStore.getAllTutors()) {
            if (t.getEmail().equalsIgnoreCase(email)) {
                request.setAttribute("error", "This email is already registered. Please use a different email or log in.");
                request.getRequestDispatcher("/Tutors/TutorRegister.jsp").forward(request, response);
                return;
            }
        }

        // Collect availability
        Map<String, String> availability = new HashMap<>();
        for (int i = 0; i < 7; i++) {
            String day = request.getParameter("day" + i);
            String time = request.getParameter("time" + i);
            if (day != null && time != null && !day.equals("None")) {
                if (!time.matches("^\\d{2}:\\d{2}-\\d{2}:\\d{2}$")) {
                    request.setAttribute("error", "Invalid time format for " + day + ": use HH:MM-HH:MM");
                    request.getRequestDispatcher("/Tutors/TutorRegister.jsp").forward(request, response);
                    return;
                }
                availability.put(day, time);
            }
        }

        // Convert availability Map to String
        String availabilityStr = availability.entrySet().stream()
                .map(entry -> entry.getKey() + ":" + entry.getValue())
                .collect(Collectors.joining("|"));

        // Generate unique ID
        String id = String.valueOf(TutorDataStore.getAllTutors().size() + 1);

        try {
            // Create Tutor with availability as String
            Tutor tutor = new Tutor(id, name, email, phone, password, subject, location, bio, expertise, availabilityStr);

            // Save tutor to Tutor.Data.txt
            TutorDataStore.saveTutor(tutor);

            // Set success message and redirect to TutorLogin.jsp
            request.getSession().setAttribute("message", "Tutor registration completed successfully. Please log in.");
            response.sendRedirect(request.getContextPath() + "/Tutors/TutorLogin.jsp");
        }
        catch (Exception e) {
            request.setAttribute("error", "Error: " + e.getMessage());
            request.getRequestDispatcher("/Tutors/TutorRegister.jsp").forward(request, response);
        }
    }
}