package com.example.modules.UserManagement;

import com.example.models.User;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class UserRepository {
    private static final String FILE_PATH = "C:/Users/share/Desktop/HomeTutor/src/main/webapp/WEB-INF/data/users.txt";

    public void saveUser(User user) throws IOException {
        ensureFileExists();
        try (PrintWriter out = new PrintWriter(new FileWriter(FILE_PATH, true))) {
            out.println(userToString(user));
        }
    }

    public List<User> getAllUsers() throws IOException {
        ensureFileExists();
        List<User> users = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                users.add(stringToUser(line));
            }
        }
        return users;
    }

    public void updateUser(User updatedUser) throws IOException {
        List<User> users = getAllUsers();
        for (int i = 0; i < users.size(); i++) {
            if (users.get(i).getId().equals(updatedUser.getId())) {
                users.set(i, updatedUser);
                break;
            }
        }
        saveAllUsers(users);
    }

    public void deleteUser(String userId) throws IOException {
        List<User> users = getAllUsers();
        users.removeIf(user -> user.getId().equals(userId));
        saveAllUsers(users);
    }

    private void saveAllUsers(List<User> users) throws IOException {
        try (PrintWriter out = new PrintWriter(new FileWriter(FILE_PATH, false))) {
            for (User user : users) {
                out.println(userToString(user));
            }
        }
    }

    private String userToString(User user) {
        return user.getId() + "," + user.getName() + "," + user.getEmail() + "," +
                user.getPassword() + "," + user.getRole();
    }

    private User stringToUser(String str) {
        String[] parts = str.split(",");
        return new User(parts[0], parts[1], parts[2], parts[3], parts[4]);
    }

    private void ensureFileExists() throws IOException {
        File file = new File(FILE_PATH);
        if (!file.exists()) {
            file.getParentFile().mkdirs();
            file.createNewFile();
        }
    }
}