package com.example.modules.StudentManagement;

import com.example.model.Student;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class StudentRepository {
    private static final String FILE_PATH = "C:/OOP Project/Home-Tutor-System/src/main/webapp/users.txt";

    public void saveStudent(Student student) throws IOException {
        ensureFileExists();
        try (PrintWriter out = new PrintWriter(new FileWriter(FILE_PATH, true))) {
            out.println(studentToString(student));
        }
    }

    public List<Student> getAllStudents() throws IOException {
        ensureFileExists();
        List<Student> students = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                students.add(stringToStudent(line));
            }
        }
        return students;
    }

    public Student getStudentById(String studentId) throws IOException {
        List<Student> students = getAllStudents();
        for (Student student : students) {
            if (student.getId().equals(studentId)) {
                return student;
            }
        }
        return null;
    }

    public Student getStudentByEmail(String email) throws IOException {
        List<Student> students = getAllStudents();
        for (Student student : students) {
            if (student.getEmail().equals(email)) {
                return student;
            }
        }
        return null;
    }

    public void updateStudent(Student updatedStudent) throws IOException {
        List<Student> students = getAllStudents();
        for (int i = 0; i < students.size(); i++) {
            if (students.get(i).getId().equals(updatedStudent.getId())) {
                students.set(i, updatedStudent);
                break;
            }
        }
        saveAllStudents(students);
    }

    public void deleteStudent(String studentId) throws IOException {
        List<Student> students = getAllStudents();
        students.removeIf(student -> student.getId().equals(studentId));
        saveAllStudents(students);
    }

    private void saveAllStudents(List<Student> students) throws IOException {
        try (PrintWriter out = new PrintWriter(new FileWriter(FILE_PATH, false))) {
            for (Student student : students) {
                out.println(studentToString(student));
            }
        }
    }

    private String studentToString(Student student) {
        return student.getId() + "," +
                student.getFullName() + "," +
                student.getPhoneNumber() + "," +
                student.getEmail() + "," +
                student.getPassword() + "," +
                student.getGrade() + "," +
                student.getModule();
    }

    private Student stringToStudent(String str) {
        String[] parts = str.split(",");
        return new Student(parts[0], parts[1], parts[2], parts[3], parts[4], parts[5], parts[6]);
    }

    private void ensureFileExists() throws IOException {
        File file = new File(FILE_PATH);
        if (!file.exists()) {
            file.getParentFile().mkdirs();
            file.createNewFile();
        }
    }
}
