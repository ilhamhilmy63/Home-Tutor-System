package UserManage.Servlets;

import UserManage.User;
import UserManage.UserManagement;
import UserManage.Tutor;
import UserManage.Student;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/auth/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // 1. Validate required parameters
            String role = validateRole(request.getParameter("role"));
            String name = validateName(request.getParameter("name"));
            String email = validateEmail(request.getParameter("email"));
            String phone = validatePhone(request.getParameter("phone"));
            String password = validatePassword(request.getParameter("password"));

            // 2. Create appropriate user object
            User user = createUser(role, request, name, email, phone, password);

            // 3. Attempt registration
            if (UserManagement.registerUser(user)) {
                response.sendRedirect(request.getContextPath() + "/auth/login.jsp?success=Registration+Successful");
                return;
            } else {
                throw new ServletException("Registration failed. Email might be taken.");
            }
        } catch (IllegalArgumentException | ServletException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/auth/register.jsp").forward(request, response);
        }
    }

    private String validateRole(String role) throws ServletException {
        if (role == null || (!role.equalsIgnoreCase("tutor") && !role.equalsIgnoreCase("student"))) {
            throw new ServletException("Invalid role specified");
        }
        return role.toLowerCase();
    }

    private String validateName(String name) throws ServletException {
        if (name == null || name.trim().isEmpty()) {
            throw new ServletException("Name cannot be empty");
        }
        if (name.length() > 100) {
            throw new ServletException("Name too long");
        }
        return name.trim();
    }

    private String validateEmail(String email) throws ServletException {
        if (email == null || !email.matches("^[\\w-.]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
            throw new ServletException("Invalid email format");
        }
        return email.toLowerCase();
    }

    private String validatePhone(String phone) throws ServletException {
        if (phone == null || !phone.matches("^[0-9]{10,15}$")) {
            throw new ServletException("Phone must be 10-15 digits");
        }
        return phone;
    }

    private String validatePassword(String password) throws ServletException {
        if (password == null || password.length() < 8) {
            throw new ServletException("Password must be at least 8 characters");
        }
        return password;
    }

    private User createUser(String role, HttpServletRequest request, String name, String email, String phone, String password) throws ServletException {
        if ("tutor".equals(role)) {
            Tutor tutor = new Tutor(name, email, phone, password);
            tutor.setPrimarySubject(validateSubject(request.getParameter("primarySubject")));

            try {
                tutor.setHourlyRate(Double.parseDouble(request.getParameter("hourlyRate")));
            } catch (NumberFormatException e) {
                throw new ServletException("Invalid hourly rate");
            }

            return tutor;
        } else {
            return new Student(name, email, phone, password);
        }
    }

    private String validateSubject(String subject) throws ServletException {
        if (subject == null || subject.trim().isEmpty()) {
            throw new ServletException("Primary subject is required for tutors");
        }
        return subject.trim();
    }
}