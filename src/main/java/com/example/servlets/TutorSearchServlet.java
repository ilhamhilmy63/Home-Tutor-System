package com.example.servlets;

import com.example.model.Tutor;
import com.example.model.Student;
import com.example.modules.TutorManagement.TutorService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/tutor-search")
public class TutorSearchServlet extends HttpServlet {
    private TutorService tutorService = new TutorService();

    @Override
    public void init() throws ServletException {
        try {
            tutorService.loadTutorsIntoBST();
        } catch (IOException e) {
            throw new ServletException("Failed to load tutors into BST", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("student") == null) {
            response.sendRedirect(request.getContextPath() + "/student-login");
            return;
        }

        // Get student information for personalized search experience
        Student student = (Student) session.getAttribute("student");
        request.setAttribute("student", student);

        String specialization = request.getParameter("specialization");
        String sortBy = request.getParameter("sortBy");
        String minRate = request.getParameter("minRate");
        String maxRate = request.getParameter("maxRate");
        String experienceLevel = request.getParameter("experienceLevel");

        try {
            List<Tutor> tutors = tutorService.searchTutors(specialization, sortBy, minRate, maxRate, experienceLevel);

            // Apply additional sorting based on student's current module for personalized recommendations
            if (tutors != null && !tutors.isEmpty() && student != null) {
                String studentModule = student.getModule();
                if (studentModule != null && !studentModule.isEmpty()) {
                    // Prioritize tutors who match student's current module
                    tutors = prioritizeTutorsByStudentModule(tutors, studentModule);
                }
            }

            request.setAttribute("tutors", tutors);
            request.setAttribute("searchPerformed", true);
            request.setAttribute("selectedSpecialization", specialization);
            request.setAttribute("selectedSortBy", sortBy);
            request.setAttribute("selectedMinRate", minRate);
            request.setAttribute("selectedMaxRate", maxRate);
            request.setAttribute("selectedExperienceLevel", experienceLevel);

            if (tutors == null || tutors.isEmpty()) {
                request.setAttribute("message", "No tutors found matching your criteria. Try adjusting your search filters.");
            } else {
                request.setAttribute("successMessage",
                        "Found " + tutors.size() + " tutor(s) matching your criteria.");
            }

            request.getRequestDispatcher("/WEB-INF/views/tutor-search.jsp").forward(request, response);
        } catch (IOException e) {
            request.setAttribute("error", "Error searching for tutors: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/tutor-search.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Handle quick search from dashboard
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("student") == null) {
            response.sendRedirect(request.getContextPath() + "/student-login");
            return;
        }

        String quickSearchType = request.getParameter("quickSearchType");
        String searchQuery = request.getParameter("searchQuery");

        if ("subject".equals(quickSearchType)) {
            // Redirect to GET with subject filter
            response.sendRedirect(request.getContextPath() + "/tutor-search?specialization=" +
                    (searchQuery != null ? searchQuery : "") + "&sortBy=subject_expertise");
        } else if ("recommended".equals(quickSearchType)) {
            // Show recommended tutors based on student's module
            Student student = (Student) session.getAttribute("student");
            String studentModule = student != null ? student.getModule() : "";
            response.sendRedirect(request.getContextPath() + "/tutor-search?specialization=" +
                    studentModule + "&sortBy=subject_expertise");
        } else {
            // Default search
            response.sendRedirect(request.getContextPath() + "/tutor-search");
        }
    }

    private List<Tutor> prioritizeTutorsByStudentModule(List<Tutor> tutors, String studentModule) {
        // Sort tutors to prioritize those matching student's module
        tutors.sort((t1, t2) -> {
            boolean t1Matches = t1.getSpecialization().equalsIgnoreCase(studentModule);
            boolean t2Matches = t2.getSpecialization().equalsIgnoreCase(studentModule);

            if (t1Matches && !t2Matches) return -1;
            if (!t1Matches && t2Matches) return 1;

            // If both match or both don't match, sort by experience (descending)
            return Integer.compare(
                    extractYearsFromExperience(t2.getExperience()),
                    extractYearsFromExperience(t1.getExperience())
            );
        });

        return tutors;
    }

    private int extractYearsFromExperience(String experience) {
        if (experience == null || experience.isEmpty()) {
            return 0;
        }

        try {
            String[] parts = experience.split("\\s+");
            for (String part : parts) {
                if (part.matches("\\d+")) {
                    return Integer.parseInt(part);
                }
            }
        } catch (NumberFormatException e) {
            return 0;
        }
        return 0;
    }
}