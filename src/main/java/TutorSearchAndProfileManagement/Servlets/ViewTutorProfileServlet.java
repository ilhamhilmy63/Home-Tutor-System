package TutorSearchAndProfileManagement.Servlets;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import TutorSearchAndProfileManagement.Tutor;
import TutorSearchAndProfileManagement.TutorDataStore;
import TutorSearchAndProfileManagement.TutorAvailability;

@WebServlet("/TutorProfile")
public class ViewTutorProfileServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Tutor tutor = (Tutor) session.getAttribute("tutor");
        String tutorId = request.getParameter("id");
        boolean editMode = "true".equals(request.getParameter("edit"));

        // If tutor not in session but ID provided, load from data store
        if (tutor == null && tutorId != null) {
            tutor = TutorDataStore.findTutorById(tutorId);
            if (tutor != null) {
                session.setAttribute("tutor", tutor);
            }
        }

        if (tutor == null) {
            response.sendRedirect(request.getContextPath() + "/Tutors/TutorLogin.jsp");
            return;
        }

        // Convert availability to list for display
        List<TutorAvailability> availabilityList = new ArrayList<>();
        for (Map.Entry<String, String> entry : tutor.getAvailability().entrySet()) {
            String[] parts = entry.getValue().split("\\s*[-–—]\\s*");
            String start = parts.length > 0 ? parts[0].trim() : "";
            String end = parts.length > 1 ? parts[1].trim() : "";
            availabilityList.add(new TutorAvailability(entry.getKey(), start, end));
        }

        request.setAttribute("tutor", tutor);
        request.setAttribute("availabilityList", availabilityList);

        // Determine which page to show based on edit mode
        if (editMode && tutor.getId().equals(tutorId)) {
            request.getRequestDispatcher("/Tutors/EditTutorProfile.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/Tutors/TutorProfile.jsp").forward(request, response);
        }
    }
}