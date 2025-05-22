package TutorSearchAndProfileManagement.Servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import TutorSearchAndProfileManagement.Tutor;
import TutorSearchAndProfileManagement.TutorDataStore;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@WebServlet("/tutorLogin")
public class TutorLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Validate input
        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Email and password are required.");
            request.getRequestDispatcher("/Tutors/TutorLogin.jsp").forward(request, response);
            return;
        }

        Tutor tutor = validateTutorCredentials(email, password);

        if (tutor != null) {
            HttpSession session = request.getSession();
            session.setAttribute("tutor", tutor);

            List<String> availabilityList = new ArrayList<>();
            for (Map.Entry<String, String> entry : tutor.getAvailability().entrySet()) {
                availabilityList.add(entry.getKey() + ": " + entry.getValue());
            }

            request.setAttribute("tutor", tutor);
            request.setAttribute("availabilityList", availabilityList);
            request.getRequestDispatcher("/Tutors/TutorProfile.jsp").forward(request, response);
        } else {
            // Check if the email exists to provide specific error messaging
            boolean emailExists = false;
            for (Tutor t : TutorDataStore.getAllTutors()) {
                if (t.getEmail().equalsIgnoreCase(email)) {
                    emailExists = true;
                    break;
                }
            }
            if (emailExists) {
                request.setAttribute("error", "Invalid password.");
            } else {
                request.setAttribute("error", "No tutor is registered with this email. Please register first.");
            }
            request.getRequestDispatcher("/Tutors/TutorLogin.jsp").forward(request, response);
        }
    }

    private Tutor validateTutorCredentials(String email, String password) {
        List<Tutor> tutors = TutorDataStore.getAllTutors();
        for (Tutor tutor : tutors) {
            if (tutor.getEmail().equalsIgnoreCase(email) && tutor.getPassword().equals(password)) {
                return tutor;
            }
        }
        return null;
    }
}