package UserManage.Servlets;

import UserManage.User;
import UserManage.UserManagement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/auth/reset-password")
public class ResetPasswordServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String token = request.getParameter("token");
        String newPassword = request.getParameter("newPassword");

        // In a real application, you would validate the token first
        // For demo purposes, we'll assume the token is valid

        // Find user by token (in a real app, you'd have a way to associate tokens with users)
        // For now, we'll just get the email from a parameter
        String email = request.getParameter("email");

        if (email != null) {
            User user = UserManagement.getUserByEmail(email);
            if (user != null) {
                user.setPassword(newPassword);
                if (UserManagement.updateUser(user)) {
                    response.sendRedirect(request.getContextPath() + "/auth/login.jsp?success=Password+reset+successfully");
                } else {
                    response.sendRedirect(request.getContextPath() + "/auth/reset-password.jsp?token=" + token + "&error=Password+reset+failed");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/auth/reset-password.jsp?token=" + token + "&error=User+not+found");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/auth/reset-password.jsp?token=" + token + "&error=Invalid+token");
        }
    }
}