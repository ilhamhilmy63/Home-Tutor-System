package UserManage.Servlets;

import UserManage.User;
import UserManage.UserManagement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // 1. Validate inputs
            String email = validateEmail(request.getParameter("email"));
            String password = validatePassword(request.getParameter("password"));

            // 2. Get user from storage
            User user = UserManagement.getUserByEmail(email);
            if (user == null) {
                throw new IllegalArgumentException("Invalid email or password");
            }

            // 3. Verify password (in production, use hashed passwords)
            if (!user.getPassword().equals(password)) {
                throw new IllegalArgumentException("Invalid email or password");
            }

            // 4. Create session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            // 5. Redirect based on role
            if ("admin".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/homepage.jsp");
            }

        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/auth/login.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "An unexpected error occurred. Please try again.");
            request.getRequestDispatcher("/auth/login.jsp").forward(request, response);
        }
    }

    private String validateEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            throw new IllegalArgumentException("Email is required");
        }
        return email.trim().toLowerCase();
    }

    private String validatePassword(String password) {
        if (password == null || password.isEmpty()) {
            throw new IllegalArgumentException("Password is required");
        }
        return password;
    }
}