package UserManage.Servlets;

import UserManage.User;
import UserManage.UserManagement;
import UserManage.Tutor;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect to profile page - actual profile data will be loaded by the JSP
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login.jsp");
            return;
        }

        request.getRequestDispatcher("/user/profile.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login.jsp");
            return;
        }

        // Get updated information from the form
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        try {
            // Verify current password if changing password
            if ((newPassword != null && !newPassword.isEmpty()) &&
                    !currentUser.getPassword().equals(currentPassword)) {
                throw new Exception("Current password is incorrect");
            }

            // Validate new password if provided
            if (newPassword != null && !newPassword.isEmpty()) {
                if (!newPassword.equals(confirmPassword)) {
                    throw new Exception("New passwords do not match");
                }
                if (newPassword.length() < 8) {
                    throw new Exception("Password must be at least 8 characters");
                }
            }

            // Update user information
            currentUser.setName(name);
            currentUser.setPhone(phone);

            // Update password if new one was provided
            if (newPassword != null && !newPassword.isEmpty()) {
                currentUser.setPassword(newPassword);
            }

            // Handle tutor-specific fields
            if (currentUser instanceof Tutor) {
                Tutor tutor = (Tutor) currentUser;
                String primarySubject = request.getParameter("primarySubject");
                String hourlyRateStr = request.getParameter("hourlyRate");
                String qualification = request.getParameter("qualification");

                if (primarySubject == null || primarySubject.trim().isEmpty()) {
                    throw new Exception("Primary subject is required");
                }

                try {
                    double hourlyRate = Double.parseDouble(hourlyRateStr);
                    if (hourlyRate < 0) {
                        throw new Exception("Hourly rate must be positive");
                    }
                    tutor.setHourlyRate(hourlyRate);
                } catch (NumberFormatException e) {
                    throw new Exception("Invalid hourly rate format");
                }

                tutor.setPrimarySubject(primarySubject);
                tutor.setQualification(qualification);
            }

            // Save updated user
            if (UserManagement.updateUser(currentUser)) {
                // Update session with new user data
                session.setAttribute("user", currentUser);
                response.sendRedirect(request.getContextPath() + "/user/profile.jsp?success=Profile+updated+successfully");
            } else {
                throw new Exception("Failed to update profile. Please try again.");
            }

        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/user/profile.jsp").forward(request, response);
        }
    }
}