package com.example.modules.AdminManagement;

import com.example.model.Admin;
import com.example.model.Student;
import com.example.modules.StudentManagement.StudentService;
import java.io.IOException;
import java.util.List;
import java.util.UUID;
import java.util.regex.Pattern;

public class AdminService {
    private final AdminRepository adminRepository = new AdminRepository();
    private final StudentService studentService = new StudentService();

    // Email validation pattern
    private static final Pattern EMAIL_PATTERN =
            Pattern.compile("^[A-Za-z0-9+_.-]+@(.+)$");

    // Username validation pattern
    private static final Pattern USERNAME_PATTERN =
            Pattern.compile("^[A-Za-z0-9_]{3,20}$");

    public Admin registerAdmin(String username, String fullName, String email, String password, String role) throws IOException {
        // Validate input
        if (!isValidInput(username, fullName, email, password, role)) {
            throw new IllegalArgumentException("Invalid input data");
        }

        // Check if username already exists
        if (usernameExists(username)) {
            throw new IllegalArgumentException("Username already exists");
        }

        // Check if email already exists
        if (emailExists(email)) {
            throw new IllegalArgumentException("Email already exists");
        }

        // Generate unique ID and create admin
        String id = UUID.randomUUID().toString();
        Admin admin = new Admin(id, username, fullName, email, password, role);

        // Save admin
        adminRepository.saveAdmin(admin);
        return admin;
    }

    public Admin loginAdmin(String usernameOrEmail, String password) throws IOException {
        Admin admin = null;

        // Try to find by username first
        if (isValidUsername(usernameOrEmail)) {
            admin = adminRepository.getAdminByUsername(usernameOrEmail);
        }

        // If not found by username, try by email
        if (admin == null && isValidEmail(usernameOrEmail)) {
            admin = adminRepository.getAdminByEmail(usernameOrEmail);
        }

        // Verify password
        if (admin != null && admin.getPassword().equals(password)) {
            return admin;
        }
        return null;
    }

    public boolean updatePassword(String adminId, String newPassword) throws IOException {
        Admin admin = adminRepository.getAdminById(adminId);
        if (admin != null && isValidPassword(newPassword)) {
            admin.setPassword(newPassword);
            adminRepository.updateAdmin(admin);
            return true;
        }
        return false;
    }

    public boolean updateAdmin(Admin admin) throws IOException {
        if (admin != null && isValidInput(admin.getUsername(), admin.getFullName(),
                admin.getEmail(), admin.getPassword(), admin.getRole())) {
            adminRepository.updateAdmin(admin);
            return true;
        }
        return false;
    }

    public boolean deleteAdmin(String adminId) throws IOException {
        adminRepository.deleteAdmin(adminId);
        return true;
    }

    public List<Admin> getAllAdmins() throws IOException {
        return adminRepository.getAllAdmins();
    }

    public Admin getAdminById(String adminId) throws IOException {
        return adminRepository.getAdminById(adminId);
    }

    public Admin getAdminByUsername(String username) throws IOException {
        return adminRepository.getAdminByUsername(username);
    }

    public boolean usernameExists(String username) throws IOException {
        return adminRepository.getAdminByUsername(username) != null;
    }

    public boolean emailExists(String email) throws IOException {
        return adminRepository.getAdminByEmail(email) != null;
    }

    // Student management methods for admin
    public List<Student> getAllStudents() throws IOException {
        return studentService.getAllStudents();
    }

    public Student getStudentById(String studentId) throws IOException {
        return studentService.getStudentById(studentId);
    }

    public boolean deleteStudent(String studentId) throws IOException {
        return studentService.deleteStudent(studentId);
    }

    public boolean updateStudent(Student student) throws IOException {
        return studentService.updateStudent(student);
    }

    public long getTotalStudentCount() throws IOException {
        return studentService.getAllStudents().size();
    }

    // Validation methods
    private boolean isValidInput(String username, String fullName, String email, String password, String role) {
        return isValidUsername(username) &&
                isValidName(fullName) &&
                isValidEmail(email) &&
                isValidPassword(password) &&
                isValidRole(role);
    }

    private boolean isValidUsername(String username) {
        return username != null && USERNAME_PATTERN.matcher(username).matches();
    }

    private boolean isValidName(String name) {
        return name != null && name.trim().length() >= 2 && name.trim().length() <= 100;
    }

    private boolean isValidEmail(String email) {
        return email != null && EMAIL_PATTERN.matcher(email).matches();
    }

    private boolean isValidPassword(String password) {
        return password != null && password.length() >= 6;
    }

    private boolean isValidRole(String role) {
        return role != null && (role.equals("ADMIN") || role.equals("SUPER_ADMIN"));
    }
}