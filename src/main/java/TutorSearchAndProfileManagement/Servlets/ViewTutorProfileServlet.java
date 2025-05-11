package TutorSearchAndProfileManagement.Servlets;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/viewTutor")
public class ViewTutorProfileServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String tutorId = request.getParameter("id");

        // In real application, fetch tutor data by ID from database
        // Example (pseudo-code):
        // Tutor tutor = tutorService.getTutorById(tutorId);

        // For now, forward with empty or placeholder values
        request.setAttribute("name", "");
        request.setAttribute("subjects", "");
        request.setAttribute("location", "");
        request.setAttribute("bio", "");
        request.setAttribute("availability", "");

        request.getRequestDispatcher("tutor-profile.jsp").forward(request, response);
    }
}
