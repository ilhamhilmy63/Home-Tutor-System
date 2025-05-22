package com.example.modules.AdminManagement;

import com.example.model.Admin;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class AdminRepository {
    private static final String FILE_PATH = "C:/OOP Project/Home-Tutor-System/src/main/webapp/admins.txt";

    public void saveAdmin(Admin admin) throws IOException {
        ensureFileExists();
        try (PrintWriter out = new PrintWriter(new FileWriter(FILE_PATH, true))) {
            out.println(adminToString(admin));
        }
    }

    public List<Admin> getAllAdmins() throws IOException {
        ensureFileExists();
        List<Admin> admins = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                admins.add(stringToAdmin(line));
            }
        }
        return admins;
    }

    public Admin getAdminById(String adminId) throws IOException {
        List<Admin> admins = getAllAdmins();
        for (Admin admin : admins) {
            if (admin.getId().equals(adminId)) {
                return admin;
            }
        }
        return null;
    }

    public Admin getAdminByUsername(String username) throws IOException {
        List<Admin> admins = getAllAdmins();
        for (Admin admin : admins) {
            if (admin.getUsername().equals(username)) {
                return admin;
            }
        }
        return null;
    }

    public Admin getAdminByEmail(String email) throws IOException {
        List<Admin> admins = getAllAdmins();
        for (Admin admin : admins) {
            if (admin.getEmail().equals(email)) {
                return admin;
            }
        }
        return null;
    }

    public void updateAdmin(Admin updatedAdmin) throws IOException {
        List<Admin> admins = getAllAdmins();
        for (int i = 0; i < admins.size(); i++) {
            if (admins.get(i).getId().equals(updatedAdmin.getId())) {
                admins.set(i, updatedAdmin);
                break;
            }
        }
        saveAllAdmins(admins);
    }

    public void deleteAdmin(String adminId) throws IOException {
        List<Admin> admins = getAllAdmins();
        admins.removeIf(admin -> admin.getId().equals(adminId));
        saveAllAdmins(admins);
    }

    private void saveAllAdmins(List<Admin> admins) throws IOException {
        try (PrintWriter out = new PrintWriter(new FileWriter(FILE_PATH, false))) {
            for (Admin admin : admins) {
                out.println(adminToString(admin));
            }
        }
    }

    private String adminToString(Admin admin) {
        return admin.getId() + "," +
                admin.getUsername() + "," +
                admin.getFullName() + "," +
                admin.getEmail() + "," +
                admin.getPassword() + "," +
                admin.getRole();
    }

    private Admin stringToAdmin(String str) {
        String[] parts = str.split(",");
        return new Admin(parts[0], parts[1], parts[2], parts[3], parts[4], parts[5]);
    }

    private void ensureFileExists() throws IOException {
        File file = new File(FILE_PATH);
        if (!file.exists()) {
            file.getParentFile().mkdirs();
            file.createNewFile();
        }
    }
}