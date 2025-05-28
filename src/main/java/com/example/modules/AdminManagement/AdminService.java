package com.example.modules.AdminManagement;

import com.example.model.Admin;
import com.example.model.Student;
import com.example.model.Tutor;
import com.example.modules.StudentManagement.StudentService;
import com.example.modules.TutorManagement.TutorService;
import java.io.IOException;
import java.util.List;
import java.util.UUID;
import java.util.regex.Pattern;

public class AdminService {
    private final AdminRepository adminRepository = new AdminRepository();
    private final StudentService studentService = new StudentService();
    private final TutorService tutorService = new TutorService();

    // Validation patterns
    private static final Pattern EMAIL_PATTERN =
            Pattern.compile("^[A-Za-z0-9+_.-]+@(.+)$");
    private static final Pattern USERNAME_PATTERN =
            Pattern.compile("^[A-Za-z0-9_]{3,20}$");
    private static final Pattern PHONE_PATTERN =
            Pattern.compile("^[0-9]{10,15}$");

    public Admin registerAdmin(String username, String fullName, String email, String password, String role) throws IOException {
        validateAdminInput(username, fullName, email, password, role);

        // Check if username or email already exists
        if (usernameExists(username)) {
            throw new IllegalArgumentException("Username already exists");
        }
        if (emailExists(email)) {
            throw new IllegalArgumentException("Email already exists");
        }

        // Create and save admin
        String id = UUID.randomUUID().toString();
        Admin admin = new Admin(id, username, fullName, email, password, role);
        adminRepository.saveAdmin(admin);
        return admin;
    }

    public Admin loginAdmin(String usernameOrEmail, String password) throws IOException {
        Admin admin = isValidUsername(usernameOrEmail)
                ? adminRepository.getAdminByUsername(usernameOrEmail)
                : (isValidEmail(usernameOrEmail)
                ? adminRepository.getAdminByEmail(usernameOrEmail)
                : null);

        if (admin != null && admin.getPassword().equals(password)) {
            return admin;
        }
        return null;
    }

    // Admin management methods
    public boolean updateAdminProfile(Admin admin) throws IOException {
        if (admin == null) return false;

        validateAdminInput(
                admin.getUsername(),
                admin.getFullName(),
                admin.getEmail(),
                admin.getPassword(),
                admin.getRole()
        );

        adminRepository.updateAdmin(admin);
        return true;
    }

    public boolean updateAdminPassword(String adminId, String newPassword) throws IOException {
        if (!isValidPassword(newPassword)) return false;

        Admin admin = adminRepository.getAdminById(adminId);
        if (admin == null) return false;

        admin.setPassword(newPassword);
        adminRepository.updateAdmin(admin);
        return true;
    }

    public boolean deleteAdmin(String adminId) throws IOException {
        // Prevent deletion of last admin
        if (adminRepository.getAllAdmins().size() <= 1) {
            throw new IllegalStateException("Cannot delete the last admin");
        }
        return adminRepository.deleteAdmin(adminId);
    }

    public List<Admin> getAllAdmins() throws IOException {
        return adminRepository.getAllAdmins();
    }

    public Admin getAdminById(String adminId) throws IOException {
        return adminRepository.getAdminById(adminId);
    }

    // Student management methods
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
        validateStudentInput(student);
        return studentService.updateStudent(student);
    }

    public long getTotalStudentCount() throws IOException {
        return studentService.getAllStudents().size();
    }

    // Tutor management methods
    public List<Tutor> getAllTutors() throws IOException {
        return tutorService.getAllTutors();
    }

    public Tutor getTutorById(String tutorId) throws IOException {
        return tutorService.getTutorById(tutorId);
    }

    public boolean deleteTutor(String tutorId) throws IOException {
        return tutorService.deleteTutor(tutorId);
    }

    public boolean updateTutor(Tutor tutor) throws IOException {
        validateTutorInput(tutor);
        return tutorService.updateTutor(tutor);
    }

    public long getTotalTutorCount() throws IOException {
        return tutorService.getAllTutors().size();
    }

    // Validation methods
    private void validateAdminInput(String username, String fullName, String email, String password, String role) {
        if (!isValidUsername(username)) {
            throw new IllegalArgumentException("Invalid username format");
        }
        if (!isValidName(fullName)) {
            throw new IllegalArgumentException("Full name must be 2-100 characters");
        }
        if (!isValidEmail(email)) {
            throw new IllegalArgumentException("Invalid email format");
        }
        if (!isValidPassword(password)) {
            throw new IllegalArgumentException("Password must be at least 6 characters");
        }
        if (!isValidRole(role)) {
            throw new IllegalArgumentException("Invalid role specified");
        }
    }

    private void validateStudentInput(Student student) {
        if (student == null) throw new IllegalArgumentException("Student cannot be null");

        if (!isValidName(student.getFullName())) {
            throw new IllegalArgumentException("Invalid student name");
        }
        if (!isValidEmail(student.getEmail())) {
            throw new IllegalArgumentException("Invalid student email");
        }
        if (!PHONE_PATTERN.matcher(student.getPhoneNumber()).matches()) {
            throw new IllegalArgumentException("Invalid phone number format");
        }
        // Add additional student-specific validations as needed
    }

    private void validateTutorInput(Tutor tutor) {
        if (tutor == null) throw new IllegalArgumentException("Tutor cannot be null");

        if (!isValidName(tutor.getFullName())) {
            throw new IllegalArgumentException("Invalid tutor name");
        }
        if (!isValidEmail(tutor.getEmail())) {
            throw new IllegalArgumentException("Invalid tutor email");
        }
        if (!PHONE_PATTERN.matcher(tutor.getPhoneNumber()).matches()) {
            throw new IllegalArgumentException("Invalid phone number format");
        }
        if (tutor.getHourlyRate() <= 0) {
            throw new IllegalArgumentException("Hourly rate must be positive");
        }
        // Add additional tutor-specific validations as needed
    }

    // Helper validation methods
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

    public boolean usernameExists(String username) throws IOException {
        return adminRepository.getAdminByUsername(username) != null;
    }

    public boolean emailExists(String email) throws IOException {
        return adminRepository.getAdminByEmail(email) != null;
    }
}