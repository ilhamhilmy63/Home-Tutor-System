package UserManage;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class UserManagement {
    // Customizable data directory - will be created in user's home folder
    private static final String DATA_DIR = System.getProperty("user.home") + "/HomeTutorSystemData";
    private static final String FILE_PATH = DATA_DIR + "/users.dat";

    private static List<User> users = new ArrayList<>();
    private static BSTNode tutorBSTRoot = null;

    // Ensure data directory exists when class is loaded
    static {
        File dataDir = new File(DATA_DIR);
        if (!dataDir.exists()) {
            boolean created = dataDir.mkdirs();
            if (created) {
                System.out.println("Created data directory: " + DATA_DIR);
            } else {
                System.err.println("Failed to create data directory: " + DATA_DIR);
            }
        }
    }

    // BST Node class for tutors
    private static class BSTNode {
        Tutor tutor;
        BSTNode left, right;

        BSTNode(Tutor tutor) {
            this.tutor = tutor;
            this.left = this.right = null;
        }
    }

    // Initialize system and load data
    private static void loadUsers() {
        File file = new File(FILE_PATH);
        if (!file.exists()) {
            System.out.println("No existing data file found. Starting with empty user list.");
            return;
        }

        try (ObjectInputStream ois = new ObjectInputStream(new FileInputStream(FILE_PATH))) {
            users = (List<User>) ois.readObject();
            rebuildTutorBST(); // Rebuild BST after loading
            System.out.println("Loaded " + users.size() + " users from " + FILE_PATH);
        } catch (IOException | ClassNotFoundException e) {
            System.err.println("Error loading users: " + e.getMessage());
            e.printStackTrace();
        }
    }

    // Save users to file
    private static boolean saveUsers() {
        try (ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(FILE_PATH))) {
            oos.writeObject(users);
            System.out.println("Saved " + users.size() + " users to " + FILE_PATH);
            return true;
        } catch (IOException e) {
            System.err.println("Error saving users: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Rebuild BST from users list
    private static void rebuildTutorBST() {
        tutorBSTRoot = null;
        for (User user : users) {
            if (user instanceof Tutor) {
                tutorBSTRoot = insertTutor(tutorBSTRoot, (Tutor)user);
            }
        }
    }

    // BST insertion for tutors
    private static BSTNode insertTutor(BSTNode root, Tutor tutor) {
        if (root == null) return new BSTNode(tutor);

        int cmp = tutor.getEmail().compareTo(root.tutor.getEmail());
        if (cmp < 0) root.left = insertTutor(root.left, tutor);
        else if (cmp > 0) root.right = insertTutor(root.right, tutor);

        return root;
    }

    // BST search for tutors
    private static Tutor searchTutorBST(BSTNode root, String email) {
        if (root == null) return null;

        int cmp = email.compareTo(root.tutor.getEmail());
        if (cmp == 0) return root.tutor;
        return searchTutorBST(cmp < 0 ? root.left : root.right, email);
    }

    // Register a new user
    public static boolean registerUser(User user) {
        loadUsers();
        if (getUserByEmail(user.getEmail()) != null) {
            System.out.println("Registration failed - email already exists: " + user.getEmail());
            return false;
        }
        users.add(user);

        // Add to BST if tutor
        if (user instanceof Tutor) {
            tutorBSTRoot = insertTutor(tutorBSTRoot, (Tutor)user);
        }

        return saveUsers();
    }

    // Get user by email
    public static User getUserByEmail(String email) {
        loadUsers();
        // Check BST first for tutors
        Tutor tutor = searchTutorBST(tutorBSTRoot, email);
        if (tutor != null) return tutor;

        // Check regular list for other users
        for (User user : users) {
            if (user.getEmail().equalsIgnoreCase(email)) {
                return user;
            }
        }
        return null;
    }

    // Update user
    public static boolean updateUser(User updatedUser) {
        loadUsers();
        for (int i = 0; i < users.size(); i++) {
            if (users.get(i).getEmail().equals(updatedUser.getEmail())) {
                // Handle BST updates for tutors
                if (users.get(i) instanceof Tutor && updatedUser instanceof Tutor) {
                    tutorBSTRoot = deleteTutor(tutorBSTRoot, users.get(i).getEmail());
                    tutorBSTRoot = insertTutor(tutorBSTRoot, (Tutor)updatedUser);
                }
                users.set(i, updatedUser);
                return saveUsers();
            }
        }
        return false;
    }

    // Delete user
    public static boolean deleteUser(String email) {
        loadUsers();
        for (int i = 0; i < users.size(); i++) {
            if (users.get(i).getEmail().equals(email)) {
                // Remove from BST if tutor
                if (users.get(i) instanceof Tutor) {
                    tutorBSTRoot = deleteTutor(tutorBSTRoot, email);
                }
                users.remove(i);
                return saveUsers();
            }
        }
        return false;
    }

    // BST deletion for tutors
    private static BSTNode deleteTutor(BSTNode root, String email) {
        if (root == null) return null;

        int cmp = email.compareTo(root.tutor.getEmail());
        if (cmp < 0) root.left = deleteTutor(root.left, email);
        else if (cmp > 0) root.right = deleteTutor(root.right, email);
        else {
            if (root.left == null) return root.right;
            if (root.right == null) return root.left;

            root.tutor = minValue(root.right);
            root.right = deleteTutor(root.right, root.tutor.getEmail());
        }
        return root;
    }

    private static Tutor minValue(BSTNode root) {
        while (root.left != null) root = root.left;
        return root.tutor;
    }

    // Get all users
    public static List<User> getAllUsers() {
        loadUsers();
        return new ArrayList<>(users);
    }

    // Get all tutors sorted by email
    public static List<Tutor> getAllTutorsSorted() {
        List<Tutor> tutors = new ArrayList<>();
        inOrderTraversal(tutorBSTRoot, tutors);
        return tutors;
    }

    private static void inOrderTraversal(BSTNode node, List<Tutor> tutors) {
        if (node != null) {
            inOrderTraversal(node.left, tutors);
            tutors.add(node.tutor);
            inOrderTraversal(node.right, tutors);
        }
    }
}