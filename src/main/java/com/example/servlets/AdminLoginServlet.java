package com.example.servlets;

import com.example.model.Admin;
import com.example.modules.AdminManagement.AdminService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/admin-login")
public class AdminLoginServlet extends HttpServlet {
    private AdminService adminService = new AdminService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Show admin login page
        request.getRequestDispatcher("/WEB-INF/views/admin-login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String usernameOrEmail = request.getParameter("usernameOrEmail");
            String password = request.getParameter("password");

            // Validate input
            if (usernameOrEmail == null || usernameOrEmail.trim().isEmpty()) {
                request.setAttribute("error", "Username or Email is required!");
                request.getRequestDispatcher("/WEB-INF/views/admin-login.jsp").forward(request, response);
                return;
            }

            if (password == null || password.trim().isEmpty()) {
                request.setAttribute("error", "Password is required!");
                request.getRequestDispatcher("/WEB-INF/views/admin-login.jsp").forward(request, response);
                return;
            }

            // Attempt login
            Admin admin = adminService.loginAdmin(usernameOrEmail, password);

            if (admin != null) {
                // Create session
                HttpSession session = request.getSession();
                session.setAttribute("admin", admin);
                session.setAttribute("adminId", admin.getId());
                session.setAttribute("adminName", admin.getFullName());
                session.setAttribute("adminUsername", admin.getUsername());
                session.setAttribute("adminRole", admin.getRole());

                // Redirect to admin dashboard
                response.sendRedirect(request.getContextPath() + "/admin-dashboard");
            } else {
                request.setAttribute("error", "Invalid username/email or password!");
                request.setAttribute("usernameOrEmail", usernameOrEmail); // Keep input in form
                request.getRequestDispatcher("/WEB-INF/views/admin-login.jsp").forward(request, response);
            }

        } catch (Exception e) {
            request.setAttribute("error", "Login failed. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/admin-login.jsp").forward(request, response);
        }
    }
}
