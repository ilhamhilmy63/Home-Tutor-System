package TutorSearchAndProfileManagement.Servlets;

import TutorSearchAndProfileManagement.TutorDataStore;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;
import TutorSearchAndProfileManagement.Tutor;
import TutorSearchAndProfileManagement.TutorBST;
import TutorSearchAndProfileManagement.SearchService;

@WebServlet("/TutorSearch")
public class SearchTutorServlet extends HttpServlet {
    private TutorBST tutorBST;
    private SearchService searchService;

    @Override
    public void init() throws ServletException {
        super.init();
        // Initialize BST and load all tutors
        tutorBST = new TutorBST();
        List<Tutor> allTutors = TutorDataStore.getAllTutors();
        for (Tutor tutor : allTutors) {
            tutorBST.insert(tutor);
        }
        searchService = new SearchService(tutorBST);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");
        String location = request.getParameter("location");
        String expertise = request.getParameter("expertise");

        List<Tutor> results = searchService.searchTutors(keyword, location, expertise);

        request.setAttribute("tutorList", results);
        request.setAttribute("searchKeyword", keyword);
        request.setAttribute("searchLocation", location);
        request.setAttribute("searchExpertise", expertise);
        request.getRequestDispatcher("/Tutors/TutorList.jsp").forward(request, response);
    }
}