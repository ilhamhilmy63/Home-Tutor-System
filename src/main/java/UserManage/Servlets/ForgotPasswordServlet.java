package UserManage.Servlets;

import UserManage.User;
import UserManage.UserManagement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/auth/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        User user = UserManagement.getUserByEmail(email);

        if (user != null) {
            // In a real application, you would generate a token and send an email
            String token = "generated-token"; // This should be a secure random token
            // Store the token with an expiration date in your database

            // For demo purposes, we'll just redirect with the token
            response.sendRedirect(request.getContextPath() + "/auth/reset-password.jsp?token=" + token);
        } else {
            response.sendRedirect(request.getContextPath() + "/auth/forgot-password.jsp?error=Email+not+found");
        }
    }
}