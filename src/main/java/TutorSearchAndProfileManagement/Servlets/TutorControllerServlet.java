package TutorSearchAndProfileManagement.Servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import TutorSearchAndProfileManagement.Tutor;
import TutorSearchAndProfileManagement.TutorCRUD;
import TutorSearchAndProfileManagement.TutorAvailability;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@WebServlet("/TutorController")
public class TutorControllerServlet extends HttpServlet {
    private TutorCRUD tutorCRUD = new TutorCRUD();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "view":
                viewTutorProfile(request, response);
                break;
            // Other cases (list, editForm, adminList, etc.) remain unchanged
            default:
                listTutors(request, response);
                break;
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action != null) {
            switch (action) {
                case "contact":
                    contactTutor(request, response);
                    break;
                case "edit":
                    updateTutor(request, response);
                    break;
                // Other cases remain unchanged
            }
        }
    }

    private void viewTutorProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String tutorId = request.getParameter("id");
        Map<String, Object> profile = tutorCRUD.viewTutorProfile(tutorId);

        if (profile.containsKey("error")) {
            request.setAttribute("error", profile.get("error"));
            request.getRequestDispatcher("/Tutors/TutorProfile.jsp").forward(request, response);
            return;
        }

        Tutor tutor = (Tutor) profile.get("tutor");

        // Prepare availability list for display
        List<TutorAvailability> availabilityList = new ArrayList<>();
        for (Map.Entry<String, String> entry : tutor.getAvailability().entrySet()) {
            String day = entry.getKey();
            String time = entry.getValue();
            String[] parts = time.split("–|—|-");
            String start = parts.length > 0 ? parts[0].trim() : "";
            String end = parts.length > 1 ? parts[1].trim() : "";
            availabilityList.add(new TutorAvailability(day, start, end));
        }

        // Set attributes for TutorProfile.jsp
        request.setAttribute("tutor", tutor);
        request.setAttribute("name", tutor.getName());
        request.setAttribute("subjects", tutor.getSubject());
        request.setAttribute("location", tutor.getLocation());
        request.setAttribute("bio", tutor.getBio());
        request.setAttribute("expertise", tutor.getExpertise());
        request.setAttribute("availabilityList", availabilityList);

        request.getRequestDispatcher("/Tutors/TutorProfile.jsp").forward(request, response);
    }

    private void listTutors(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Tutor> tutorList = tutorCRUD.listTutors();
        request.setAttribute("tutorList", tutorList);
        request.getRequestDispatcher("/Tutors/TutorList.jsp").forward(request, response);
    }

    private void contactTutor(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String tutorId = request.getParameter("tutorId");
        String studentName = request.getParameter("studentName");
        String message = request.getParameter("message");

        String result = tutorCRUD.contactTutor(tutorId, studentName, message);
        if (result.startsWith("Error")) {
            request.setAttribute("error", result);
        }
        else {
            request.setAttribute("confirmation", result);
        }
        request.getRequestDispatcher("/Tutors/ContactConfirmation.jsp").forward(request, response);
    }

    private void updateTutor(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Implementation for update action (not shown for brevity)
    }
}