package UserManage;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class UserFileHandling {
    private static final String FILE_PATH = "users.dat";

    // Save users to file
    public static boolean saveUsers(List<User> users) {
        try (ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(FILE_PATH))) {
            oos.writeObject(users);
            return true;
        } catch (IOException e) {
            System.err.println("Error saving users: " + e.getMessage());
            return false;
        }
    }

    // Load users from file
    public static List<User> loadUsers() {
        File file = new File(FILE_PATH);
        if (!file.exists()) {
            return new ArrayList<>();
        }

        try (ObjectInputStream ois = new ObjectInputStream(new FileInputStream(FILE_PATH))) {
            return (List<User>) ois.readObject();
        } catch (IOException | ClassNotFoundException e) {
            System.err.println("Error loading users: " + e.getMessage());
            return new ArrayList<>();
        }
    }

    // Export users to text file (for readability)
    public static boolean exportToTextFile(List<User> users, String filePath) {
        try (PrintWriter writer = new PrintWriter(new FileWriter(filePath))) {
            for (User user : users) {
                writer.println(userToString(user));
            }
            return true;
        } catch (IOException e) {
            System.err.println("Error exporting users: " + e.getMessage());
            return false;
        }
    }

    // Convert User to string representation
    private static String userToString(User user) {
        return String.join(",",
                user.getName(),
                user.getEmail(),
                user.getPhone(),
                user.getPassword(),
                user.getRole());
    }

    // Import users from text file
    public static List<User> importFromTextFile(String filePath) {
        List<User> users = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                User user = stringToUser(line);
                if (user != null) {
                    users.add(user);
                }
            }
        } catch (IOException e) {
            System.err.println("Error importing users: " + e.getMessage());
        }
        return users;
    }

    // Convert string to User object
    private static User stringToUser(String line) {
        String[] parts = line.split(",");
        if (parts.length != 5) {
            return null;
        }
        return new User(
                parts[0].trim(),
                parts[1].trim(),
                parts[2].trim(),
                parts[3].trim(),
                parts[4].trim()
        );
    }
}