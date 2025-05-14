package UserManage.Servlets;

import UserManage.User;
import UserManage.UserManagement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/reset-password")
public class ResetPasswordServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");

        // Check if user exists
        User user = UserManagement.getUserByEmail(email);
        if (user == null) {
            request.setAttribute("error", "No account found with that email");
            request.getRequestDispatcher("/auth/reset-password.jsp").forward(request, response);
            return;
        }

        // In a real application, you would generate a token and send an email
        // Here we'll just simulate it

        request.setAttribute("success", "Password reset link has been sent to your email");
        request.getRequestDispatcher("/auth/reset-password.jsp").forward(request, response);
    }
}