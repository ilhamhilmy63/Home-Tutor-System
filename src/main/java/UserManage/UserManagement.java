package UserManage;

import java.util.*;
import java.util.concurrent.locks.ReentrantReadWriteLock;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;

public class UserManagement {
    private static final Logger logger = Logger.getLogger(UserManagement.class.getName());
    private static final ReentrantReadWriteLock lock = new ReentrantReadWriteLock();
    private static List<User> users = UserFileHandling.loadUsers();
    private static BSTNode tutorBSTRoot = buildTutorBST();

    // BST implementation for tutors
    private static class BSTNode {
        Tutor tutor;
        BSTNode left, right;

        BSTNode(Tutor tutor) {
            this.tutor = tutor;
        }
    }

    /* ---------------------- CRUD Operations ---------------------- */

    // CREATE
    public static boolean registerUser(User user) {
        if (user == null) {
            logger.warning("Attempt to register null user");
            return false;
        }

        lock.writeLock().lock();
        try {
            // Check for duplicate email
            if (users.stream().anyMatch(u -> u.getEmail().equalsIgnoreCase(user.getEmail()))) {
                logger.warning("Registration failed - email already exists: " + user.getEmail());
                return false;
            }

            users.add(user);

            // Add to BST if tutor
            if (user instanceof Tutor) {
                tutorBSTRoot = insertTutor(tutorBSTRoot, (Tutor) user);
            }

            // Save to file
            boolean saved = UserFileHandling.saveUsers(users);
            if (saved) {
                logger.info("Registered new user: " + user.getEmail());
            } else {
                logger.warning("Registration succeeded but failed to save to file");
            }
            return saved;
        } finally {
            lock.writeLock().unlock();
        }
    }

    // READ
    public static User getUserByEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            return null;
        }

        lock.readLock().lock();
        try {
            // Check BST first for tutors (faster lookup)
            Tutor tutor = searchTutorBST(tutorBSTRoot, email.toLowerCase());
            if (tutor != null) return tutor;

            // Check regular list for other users
            return users.stream()
                    .filter(u -> u.getEmail().equalsIgnoreCase(email))
                    .findFirst()
                    .orElse(null);
        } finally {
            lock.readLock().unlock();
        }
    }

    // READ (all users)
    public static List<User> getAllUsers() {
        lock.readLock().lock();
        try {
            return new ArrayList<>(users); // Return a copy
        } finally {
            lock.readLock().unlock();
        }
    }

    // UPDATE
    public static boolean updateUser(User updatedUser) {
        if (updatedUser == null) {
            logger.warning("Attempt to update null user");
            return false;
        }

        lock.writeLock().lock();
        try {
            for (int i = 0; i < users.size(); i++) {
                if (users.get(i).getEmail().equalsIgnoreCase(updatedUser.getEmail())) {
                    User oldUser = users.get(i);

                    // Handle BST updates for tutors
                    if (oldUser instanceof Tutor && updatedUser instanceof Tutor) {
                        tutorBSTRoot = deleteTutor(tutorBSTRoot, oldUser.getEmail());
                        tutorBSTRoot = insertTutor(tutorBSTRoot, (Tutor) updatedUser);
                    }

                    users.set(i, updatedUser);
                    boolean saved = UserFileHandling.saveUsers(users);
                    if (saved) {
                        logger.info("Updated user: " + updatedUser.getEmail());
                    }
                    return saved;
                }
            }
            logger.warning("User not found for update: " + updatedUser.getEmail());
            return false;
        } finally {
            lock.writeLock().unlock();
        }
    }

    // DELETE
    public static boolean deleteUser(String email) {
        if (email == null || email.trim().isEmpty()) {
            logger.warning("Attempt to delete user with empty email");
            return false;
        }

        lock.writeLock().lock();
        try {
            Iterator<User> iterator = users.iterator();
            while (iterator.hasNext()) {
                User user = iterator.next();
                if (user.getEmail().equalsIgnoreCase(email)) {
                    // Remove from BST if tutor
                    if (user instanceof Tutor) {
                        tutorBSTRoot = deleteTutor(tutorBSTRoot, email);
                    }

                    iterator.remove();
                    boolean saved = UserFileHandling.saveUsers(users);
                    if (saved) {
                        logger.info("Deleted user: " + email);
                    }
                    return saved;
                }
            }
            logger.warning("User not found for deletion: " + email);
            return false;
        } finally {
            lock.writeLock().unlock();
        }
    }

    /* ---------------------- BST Operations ---------------------- */

    private static BSTNode buildTutorBST() {
        BSTNode root = null;
        for (User user : users) {
            if (user instanceof Tutor) {
                root = insertTutor(root, (Tutor) user);
            }
        }
        return root;
    }

    private static BSTNode insertTutor(BSTNode root, Tutor tutor) {
        if (root == null) return new BSTNode(tutor);

        int cmp = tutor.getEmail().compareToIgnoreCase(root.tutor.getEmail());
        if (cmp < 0) root.left = insertTutor(root.left, tutor);
        else if (cmp > 0) root.right = insertTutor(root.right, tutor);

        return root;
    }

    private static Tutor searchTutorBST(BSTNode root, String email) {
        if (root == null) return null;

        int cmp = email.compareToIgnoreCase(root.tutor.getEmail());
        if (cmp == 0) return root.tutor;
        return cmp < 0 ? searchTutorBST(root.left, email) : searchTutorBST(root.right, email);
    }

    private static BSTNode deleteTutor(BSTNode root, String email) {
        if (root == null) return null;

        int cmp = email.compareToIgnoreCase(root.tutor.getEmail());
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
        return root.left == null ? root.tutor : minValue(root.left);
    }

    /* ---------------------- Additional Methods ---------------------- */

    public static List<Tutor> getAllTutors() {
        lock.readLock().lock();
        try {
            List<Tutor> tutors = new ArrayList<>();
            inOrderTraversal(tutorBSTRoot, tutors);
            return tutors;
        } finally {
            lock.readLock().unlock();
        }
    }

    private static void inOrderTraversal(BSTNode node, List<Tutor> tutors) {
        if (node != null) {
            inOrderTraversal(node.left, tutors);
            tutors.add(node.tutor);
            inOrderTraversal(node.right, tutors);
        }
    }

    public static List<Tutor> findTutorsBySubject(String subject) {
        if (subject == null || subject.trim().isEmpty()) {
            return Collections.emptyList();
        }

        lock.readLock().lock();
        try {
            return getAllTutors().stream()
                    .filter(t -> t.getPrimarySubject().equalsIgnoreCase(subject) ||
                            t.getSecondarySubjects().stream()
                                    .anyMatch(s -> s.equalsIgnoreCase(subject)))
                    .collect(Collectors.toList());
        } finally {
            lock.readLock().unlock();
        }
    }

    public static boolean changePassword(String email, String currentPassword, String newPassword) {
        if (email == null || currentPassword == null || newPassword == null) {
            logger.warning("Invalid parameters for password change");
            return false;
        }

        lock.writeLock().lock();
        try {
            User user = getUserByEmail(email);
            if (user == null) {
                logger.warning("User not found for password change: " + email);
                return false;
            }

            if (!user.getPassword().equals(currentPassword)) {
                logger.warning("Incorrect current password for: " + email);
                return false;
            }

            user.setPassword(newPassword);
            return updateUser(user);
        } finally {
            lock.writeLock().unlock();
        }
    }

    public static boolean isEmailAvailable(String email) {
        lock.readLock().lock();
        try {
            return getUserByEmail(email) == null;
        } finally {
            lock.readLock().unlock();
        }
    }
}