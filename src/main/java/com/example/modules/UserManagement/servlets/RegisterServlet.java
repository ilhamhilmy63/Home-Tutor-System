package com.example.modules.UserManagement.servlets;

import com.example.modules.UserManagement.UserService;
import com.example.models.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private final UserService userService = new UserService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = "student";

        try {
            if (userService.emailExists(email)) {
                request.setAttribute("error", "Email already exists");
                request.getRequestDispatcher("/WEB-INF/userJSP/registerJSP.jsp").forward(request, response);
                return;
            }

            User user = userService.registerUser(name, email, password, role);
            response.sendRedirect("login");
        } catch (Exception e) {
            throw new ServletException("Error during registration", e);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/userJSP/registerJSP.jsp").forward(request, response);
    }
}