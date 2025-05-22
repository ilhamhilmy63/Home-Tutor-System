package com.example.modules.UserManagement;

import com.example.models.User;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

public class UserService {
    private final UserRepository userRepository = new UserRepository();

    public User registerUser(String name, String email, String password, String role) throws IOException {
        String id = UUID.randomUUID().toString();
        User user = new User(id, name, email, password, role);
        userRepository.saveUser(user);
        return user;
    }

    public User loginUser(String email, String password) throws IOException {
        List<User> users = userRepository.getAllUsers();
        for (User user : users) {
            if (user.getEmail().equals(email) && user.getPassword().equals(password)) {
                return user;
            }
        }
        return null;
    }

    public boolean updatePassword(String email, String newPassword) throws IOException {
        List<User> users = userRepository.getAllUsers();
        for (User user : users) {
            if (user.getEmail().equals(email)) {
                user.setPassword(newPassword);
                userRepository.updateUser(user);
                return true;
            }
        }
        return false;
    }

    public boolean deleteUser(String userId) throws IOException {
        userRepository.deleteUser(userId);
        return true;
    }

    public boolean emailExists(String email) throws IOException {
        return userRepository.getAllUsers().stream()
                .anyMatch(user -> user.getEmail().equals(email));
    }
}