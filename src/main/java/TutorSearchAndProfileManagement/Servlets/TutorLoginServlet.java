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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Suppose this method checks credentials and returns the Tutor object or null
        Tutor tutor = TutorDataStore.findTutorByEmailAndPassword(email, password);

        if (tutor != null) {
            // Save the tutor object in session
            HttpSession session = request.getSession();
            session.setAttribute("tutor", tutor);

            // Redirect to tutor profile page or servlet that shows the profile
            response.sendRedirect(request.getContextPath() + "/user/TutorProfile.jsp");
            // OR redirect to profile servlet if you want more logic there
            // response.sendRedirect(request.getContextPath() + "/ViewTutorProfile");
        }
        else {
            // Invalid login, forward back to login page with error message
            request.setAttribute("error", "Invalid email or password");
            request.getRequestDispatcher("/Tutors/TutorLogin.jsp").forward(request, response);
        }
    }
}