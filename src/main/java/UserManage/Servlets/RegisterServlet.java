package UserManage.Servlets;

import UserManage.User;
import UserManage.Student;
import UserManage.Tutor;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

@WebServlet("/auth/register")
public class RegisterServlet extends HttpServlet {
    private static final String DATA_FILE_PATH = "C:\\OOP Project\\Home-Tutor-System\\src\\main\\resources\\User.data.json";
    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[A-Za-z0-9+_.-]+@(.+)$");
    private static final Pattern PHONE_PATTERN = Pattern.compile("^[0-9]{10}$");

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // 1. Get and validate role
            String role = validateRole(request.getParameter("role"));

            // 2. Get and validate other fields
            String name = validateName(request.getParameter("name"));
            String email = validateEmail(request.getParameter("email"));
            String phone = validatePhone(request.getParameter("phone"));
            String password = validatePassword(request.getParameter("password"));

            // 3. Create user object based on role
            User user = createUser(role, request, name, email, phone, password);

            // 4. Save user to JSON file
            saveUserToJsonFile(user);

            // 5. Redirect to login page with success message
            response.sendRedirect(request.getContextPath() + "/auth/login.jsp?success=Registration+successful.+Please+login.");

        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/auth/register.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "An unexpected error occurred. Please try again.");
            request.getRequestDispatcher("/auth/register.jsp").forward(request, response);
        }
    }

    private String validateRole(String role) {
        if (role == null || (!role.equalsIgnoreCase("student") && !role.equalsIgnoreCase("tutor"))) {
            throw new IllegalArgumentException("Please select either Student or Tutor");
        }
        return role.toLowerCase();
    }

    private String validateName(String name) {
        if (name == null || name.trim().isEmpty()) {
            throw new IllegalArgumentException("Full name is required");
        }
        if (name.length() > 100) {
            throw new IllegalArgumentException("Name cannot exceed 100 characters");
        }
        return name.trim();
    }

    private String validateEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            throw new IllegalArgumentException("Email is required");
        }
        if (!EMAIL_PATTERN.matcher(email).matches()) {
            throw new IllegalArgumentException("Please enter a valid email address");
        }
        return email.trim().toLowerCase();
    }

    private String validatePhone(String phone) {
        if (phone == null || phone.trim().isEmpty()) {
            throw new IllegalArgumentException("Phone number is required");
        }
        if (!PHONE_PATTERN.matcher(phone).matches()) {
            throw new IllegalArgumentException("Phone number must be 10 digits");
        }
        return phone.trim();
    }

    private String validatePassword(String password) {
        if (password == null || password.isEmpty()) {
            throw new IllegalArgumentException("Password is required");
        }
        if (password.length() < 8) {
            throw new IllegalArgumentException("Password must be at least 8 characters");
        }
        return password;
    }

    private User createUser(String role, HttpServletRequest request, String name, String email, String phone, String password) {
        if ("tutor".equals(role)) {
            Tutor tutor = new Tutor();
            tutor.setName(name);
            tutor.setEmail(email);
            tutor.setPhone(phone);
            tutor.setPassword(password);
            tutor.setRole("tutor");
            tutor.setPrimarySubject(validateSubject(request.getParameter("primarySubject")));

            try {
                double hourlyRate = Double.parseDouble(request.getParameter("hourlyRate"));
                if (hourlyRate <= 0) {
                    throw new IllegalArgumentException("Hourly rate must be positive");
                }
                tutor.setHourlyRate(hourlyRate);
            } catch (NumberFormatException e) {
                throw new IllegalArgumentException("Invalid hourly rate format");
            }

            tutor.setQualification(request.getParameter("qualification"));
            return tutor;
        } else {
            Student student = new Student();
            student.setName(name);
            student.setEmail(email);
            student.setPhone(phone);
            student.setPassword(password);
            student.setRole("student");
            return student;
        }
    }

    private String validateSubject(String subject) {
        if (subject == null || subject.trim().isEmpty()) {
            throw new IllegalArgumentException("Primary subject is required for tutors");
        }
        return subject.trim();
    }

    private synchronized void saveUserToJsonFile(User newUser) throws IOException {
        ObjectMapper mapper = new ObjectMapper();
        List<User> users = new ArrayList<>();
        File file = new File(DATA_FILE_PATH);

        // Read existing users if file exists
        if (file.exists()) {
            String jsonContent = new String(Files.readAllBytes(Paths.get(DATA_FILE_PATH)));
            users = mapper.readValue(jsonContent,
                    mapper.getTypeFactory().constructCollectionType(List.class, User.class));

            // Check for duplicate email
            for (User user : users) {
                if (user.getEmail().equalsIgnoreCase(newUser.getEmail())) {
                    throw new IllegalArgumentException("Email already registered");
                }
            }
        }

        // Add new user and write back to file
        users.add(newUser);
        mapper.writerWithDefaultPrettyPrinter().writeValue(file, users);
    }
}