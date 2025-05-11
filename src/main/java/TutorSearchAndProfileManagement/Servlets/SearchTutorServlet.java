package TutorSearchAndProfileManagement.Servlets;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.*;

@WebServlet("/searchTutor")
public class SearchTutorServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");

        // Replace this with real search logic (e.g., from a DB)
        List<String> results = new ArrayList<>();

        // Example logic only
        if (keyword != null && !keyword.trim().isEmpty()) {
            // results = tutorService.search(keyword);
        }

        request.setAttribute("results", results);
        request.setAttribute("searchKeyword", keyword);
        request.getRequestDispatcher("search-results.jsp").forward(request, response);
    }
}
