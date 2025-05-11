package TutorSearchAndProfileManagement.Servlets;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/contactTutor")
public class ContactTutorServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String tutorId = request.getParameter("tutorId");
        String studentName = request.getParameter("studentName");
        String message = request.getParameter("message");

        // Normally send/store message here

        request.setAttribute("confirmation", "Message sent successfully.");
        request.getRequestDispatcher("contact-confirmation.jsp").forward(request, response);
    }
}
