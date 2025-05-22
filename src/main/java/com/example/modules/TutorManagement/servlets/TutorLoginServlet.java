package com.example.modules.TutorManagement.servlets;

import com.example.modules.TutorManagement.TutorService;
import com.example.models.Tutor;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/tutor-login")
public class TutorLoginServlet extends HttpServlet {
    private final TutorService tutorService = new TutorService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Tutor tutor = tutorService.loginTutor(email, password);
            if (tutor != null) {
                request.getSession().setAttribute("tutor", tutor);
                response.sendRedirect("tutor-home");
            } else {
                request.setAttribute("error", "Invalid email or password");
                request.getRequestDispatcher("/WEB-INF/tutorJSP/loginJSP.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred during login");
            request.getRequestDispatcher("/WEB-INF/tutorJSP/loginJSP.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/tutorJSP/loginJSP.jsp").forward(request, response);
    }
}