package com.example.modules.StudentManagement;

import com.example.model.Student;
import java.io.IOException;
import java.util.List;
import java.util.UUID;
import java.util.regex.Pattern;

public class StudentService {
    private final StudentRepository studentRepository = new StudentRepository();

    // Email validation pattern
    private static final Pattern EMAIL_PATTERN =
            Pattern.compile("^[A-Za-z0-9+_.-]+@(.+)$");

    // Phone number validation pattern (basic)
    private static final Pattern PHONE_PATTERN =
            Pattern.compile("^[0-9]{10,15}$");

    public Student registerStudent(String fullName, String phoneNumber, String email,
                                   String password, String grade, String module) throws IOException {

        // Validate input
        if (!isValidInput(fullName, phoneNumber, email, password, grade, module)) {
            throw new IllegalArgumentException("Invalid input data");
        }

        // Check if email already exists
        if (emailExists(email)) {
            throw new IllegalArgumentException("Email already exists");
        }

        // Check if phone number already exists
        if (phoneExists(phoneNumber)) {
            throw new IllegalArgumentException("Phone number already exists");
        }

        // Generate unique ID and create student
        String id = UUID.randomUUID().toString();
        Student student = new Student(id, fullName, phoneNumber, email, password, grade, module);

        // Save student
        studentRepository.saveStudent(student);
        return student;
    }

    public Student loginStudent(String email, String password) throws IOException {
        if (!isValidEmail(email)) {
            return null;
        }

        Student student = studentRepository.getStudentByEmail(email);
        if (student != null && student.getPassword().equals(password)) {
            return student;
        }
        return null;
    }

    public boolean updatePassword(String email, String newPassword) throws IOException {
        Student student = studentRepository.getStudentByEmail(email);
        if (student != null) {
            student.setPassword(newPassword);
            studentRepository.updateStudent(student);
            return true;
        }
        return false;
    }

    public boolean deleteStudent(String studentId) throws IOException {
        studentRepository.deleteStudent(studentId);
        return true;
    }

    public boolean updateStudent(Student student) throws IOException {
        studentRepository.updateStudent(student);
        return true;
    }

    public List<Student> getAllStudents() throws IOException {
        return studentRepository.getAllStudents();
    }

    public Student getStudentById(String studentId) throws IOException {
        return studentRepository.getStudentById(studentId);
    }

    public boolean emailExists(String email) throws IOException {
        return studentRepository.getStudentByEmail(email) != null;
    }

    public boolean phoneExists(String phoneNumber) throws IOException {
        List<Student> students = studentRepository.getAllStudents();
        return students.stream()
                .anyMatch(student -> student.getPhoneNumber().equals(phoneNumber));
    }

    // Validation methods
    private boolean isValidInput(String fullName, String phoneNumber, String email,
                                 String password, String grade, String module) {
        return isValidName(fullName) &&
                isValidPhone(phoneNumber) &&
                isValidEmail(email) &&
                isValidPassword(password) &&
                isValidGrade(grade) &&
                isValidModule(module);
    }

    private boolean isValidName(String name) {
        return name != null && name.trim().length() >= 2 && name.trim().length() <= 100;
    }

    private boolean isValidPhone(String phone) {
        return phone != null && PHONE_PATTERN.matcher(phone).matches();
    }

    private boolean isValidEmail(String email) {
        return email != null && EMAIL_PATTERN.matcher(email).matches();
    }

    private boolean isValidPassword(String password) {
        return password != null && password.length() >= 6;
    }

    private boolean isValidGrade(String grade) {
        return grade != null && !grade.trim().isEmpty();
    }

    private boolean isValidModule(String module) {
        return module != null && !module.trim().isEmpty();
    }
}