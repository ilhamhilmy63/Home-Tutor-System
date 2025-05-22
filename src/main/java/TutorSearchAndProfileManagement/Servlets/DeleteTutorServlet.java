package TutorSearchAndProfileManagement.Servlets;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import TutorSearchAndProfileManagement.TutorDataStore;

@WebServlet("/DeleteTutor")
public class DeleteTutorServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String tutorId = request.getParameter("id");
        TutorDataStore.deleteTutor(tutorId);

        request.setAttribute("message", "Tutor deleted successfully.");
        request.getRequestDispatcher("tutorList").forward(request, response);
    }
}