package TutorSearchAndProfileManagement.Servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import TutorSearchAndProfileManagement.Tutor;
import TutorSearchAndProfileManagement.TutorDataStore;

import java.io.IOException;

@WebServlet("/ContactTutor")
public class ContactTutorServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String tutorId = request.getParameter("tutorId");
        String studentName = request.getParameter("studentName");
        String message = request.getParameter("message");

        // Validate input
        if (tutorId == null || studentName == null || message == null ||
                tutorId.isEmpty() || studentName.isEmpty() || message.isEmpty()) {
            request.setAttribute("error", "All fields are required.");
            request.getRequestDispatcher("/Tutors/ContactConfirmation.jsp").forward(request, response);
            return;
        }

        // Fetch tutor by ID
        Tutor tutor = TutorDataStore.findTutorById(tutorId);
        if (tutor == null) {
            request.setAttribute("error", "Tutor not found.");
            request.getRequestDispatcher("/Tutors/ContactConfirmation.jsp").forward(request, response);
            return;
        }

        // Simulate storing or sending the message (e.g., save to a file or send email)
        // For now, we'll just set a confirmation message
        String confirmation = String.format("Message sent to %s (%s): %s",
                tutor.getName(), tutor.getEmail(), message);

        // Set attributes for confirmation page
        request.setAttribute("confirmation", confirmation);
        request.setAttribute("tutor", tutor);
        request.getRequestDispatcher("/Tutors/ContactConfirmation.jsp").forward(request, response);
    }
}