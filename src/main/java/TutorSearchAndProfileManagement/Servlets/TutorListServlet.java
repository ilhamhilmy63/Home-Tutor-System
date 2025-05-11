package TutorSearchAndProfileManagement.Servlets;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.*;

@WebServlet("/tutorList")
public class TutorListServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Normally fetch tutor list from DB or file
        List<Map<String, String>> tutorList = new ArrayList<>();

        // Empty for now – placeholder for real data
        // Example:
        // Map<String, String> tutor = new HashMap<>();
        // tutor.put("name", "John Doe");
        // tutor.put("subjects", "Math, Physics");
        // tutorList.add(tutor);

        request.setAttribute("tutorList", tutorList);
        request.getRequestDispatcher("tutor-list.jsp").forward(request, response);
    }
}
