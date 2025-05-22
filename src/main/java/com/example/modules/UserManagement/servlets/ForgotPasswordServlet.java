package com.example.modules.UserManagement.servlets;

import com.example.modules.UserManagement.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {
    private final UserService userService = new UserService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String newPassword = request.getParameter("newPassword");

        try {
            boolean success = userService.updatePassword(email, newPassword);
            if (success) {
                request.setAttribute("message", "Password updated successfully. Please login with your new password.");
                request.getRequestDispatcher("/WEB-INF/userJSP/loginJSP.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Email not found in our system.");
                request.getRequestDispatcher("/WEB-INF/userJSP/forgotPasswordJSP.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred. Please try again.");
            request.getRequestDispatcher("/WEB-INF/userJSP/forgotPasswordJSP.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/userJSP/forgotPasswordJSP.jsp").forward(request, response);
    }
}