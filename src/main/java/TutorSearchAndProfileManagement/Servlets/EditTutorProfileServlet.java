package TutorSearchAndProfileManagement.Servlets;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.*;
import TutorSearchAndProfileManagement.Tutor;
import TutorSearchAndProfileManagement.TutorDataStore;
import TutorSearchAndProfileManagement.TutorAvailability;

@WebServlet("/EditTutorProfile")
public class EditTutorProfileServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Tutor currentTutor = (Tutor) session.getAttribute("tutor");

        if (currentTutor == null) {
            response.sendRedirect(request.getContextPath() + "/Tutors/TutorLogin.jsp");
            return;
        }

        // Validate all required fields
        Map<String, String> errors = validateForm(request);
        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            doGet(request, response);
            return;
        }

        // Get all parameters from the form
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String subject = request.getParameter("subject");
        String location = request.getParameter("location");
        String bio = request.getParameter("bio");
        String expertise = request.getParameter("expertise");

        // Process availability
        Map<String, String> availability = processAvailability(request);

        // Create updated tutor object
        Tutor updatedTutor = new Tutor(id, name, email, phone, password, subject,
                location, bio, expertise, "");
        updatedTutor.setAvailability(availability);

        // Update in data store
        boolean success = TutorDataStore.updateTutor(updatedTutor);

        if (success) {
            // Update session with new tutor data
            session.setAttribute("tutor", updatedTutor);
            session.setAttribute("confirmation", "Profile updated successfully!");
        } else {
            session.setAttribute("error", "Failed to update profile. Please try again.");
        }

        // Redirect back to profile page
        response.sendRedirect(request.getContextPath() + "/TutorProfile?id=" + id);
    }

    private Map<String, String> validateForm(HttpServletRequest request) {
        Map<String, String> errors = new HashMap<>();
        String[] requiredFields = {"name", "email", "phone", "password", "subject", "location", "bio", "expertise"};

        for (String field : requiredFields) {
            String value = request.getParameter(field);
            if (value == null || value.trim().isEmpty()) {
                errors.put(field, "This field is required");
            }
        }

        // Validate email format
        String email = request.getParameter("email");
        if (email != null && !email.matches("^[\\w-.]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
            errors.put("email", "Please enter a valid email address");
        }

        // Validate phone format
        String phone = request.getParameter("phone");
        if (phone != null && !phone.matches("^[0-9]{10,15}$")) {
            errors.put("phone", "Please enter a valid phone number");
        }

        return errors;
    }

    private Map<String, String> processAvailability(HttpServletRequest request) {
        Map<String, String> availability = new HashMap<>();
        String[] days = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"};

        for (String day : days) {
            String dayValue = request.getParameter("day" + day);
            String timeValue = request.getParameter("time" + day);

            if (dayValue != null && !dayValue.equals("None")) {
                // Validate time format (HH:MM-HH:MM)
                if (timeValue != null && timeValue.matches("^\\d{2}:\\d{2}-\\d{2}:\\d{2}$")) {
                    availability.put(dayValue, timeValue);
                }
            }
        }
        return availability;
    }
}