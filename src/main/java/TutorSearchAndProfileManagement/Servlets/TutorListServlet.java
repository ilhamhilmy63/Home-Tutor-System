package TutorSearchAndProfileManagement.Servlets;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;
import TutorSearchAndProfileManagement.Tutor;
import TutorSearchAndProfileManagement.TutorDataStore;

@WebServlet("/TutorList")
public class TutorListServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Tutor> tutorList = TutorDataStore.getAllTutors();

        request.setAttribute("tutorList", tutorList);
        request.getRequestDispatcher("tutor-list.jsp").forward(request, response);
    }
}