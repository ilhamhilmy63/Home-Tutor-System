package TutorSearchAndProfileManagement.Servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/editTutor")
public class EditTutorProfileServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String subjects = request.getParameter("subjects");
        String location = request.getParameter("location");
        String bio = request.getParameter("bio");

        String day1 = request.getParameter("day1");
        String time1 = request.getParameter("time1");
        String day2 = request.getParameter("day2");
        String time2 = request.getParameter("time2");
        String day3 = request.getParameter("day3");
        String time3 = request.getParameter("time3");

        // Save/update logic here (e.g., to database)

        request.setAttribute("message", "Profile updated.");
        request.getRequestDispatcher("profile-updated.jsp").forward(request, response);
    }
}

