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

@WebServlet("/admin-register")
public class AdminRegisterServlet extends HttpServlet {
    private AdminService adminService = new AdminService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Show admin registration page
        request.getRequestDispatcher("/WEB-INF/views/admin-register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Get form parameters
            String username = request.getParameter("username");
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirmPassword");
            String role = request.getParameter("role");

            // Set default role if not provided
            if (role == null || role.trim().isEmpty()) {
                role = "ADMIN";
            }

            // Validate password confirmation
            if (!password.equals(confirmPassword)) {
                request.setAttribute("error", "Passwords do not match!");
                request.getRequestDispatcher("/WEB-INF/views/admin-register.jsp").forward(request, response);
                return;
            }

            // Register admin
            Admin admin = adminService.registerAdmin(username, fullName, email, password, role);

            // Set success message
            request.setAttribute("success", "Registration successful! Welcome " + admin.getFullName());

            // Create session for the new admin
            HttpSession session = request.getSession();
            session.setAttribute("admin", admin);
            session.setAttribute("adminId", admin.getId());
            session.setAttribute("adminName", admin.getFullName());
            session.setAttribute("adminUsername", admin.getUsername());
            session.setAttribute("adminRole", admin.getRole());

            // Redirect to admin dashboard
            response.sendRedirect(request.getContextPath() + "/admin-dashboard");

        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/admin-register.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Registration failed. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/admin-register.jsp").forward(request, response);
        }
    }
}