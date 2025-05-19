package TutorSearchAndProfileManagement;

import java.io.*;
import java.util.*;

public class TutorDataStore {

    public static class BSTNode {
        Tutor data;
        BSTNode left, right;

        public BSTNode(Tutor data) {
            this.data = data;
            this.left = this.right = null;
        }
    }
    private static final String FILE_PATH = "tutors.txt";
    private static BSTNode root = null;

    // Load all tutors from file into BST
    static {
        List<Tutor> tutors = readTutorsFromFile();
        for (Tutor tutor : tutors) {
            insertTutor(tutor);
        }
    }

    private static List<Tutor> readTutorsFromFile() {
        List<Tutor> tutors = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length < 7) continue;

                String id = parts[0];
                String name = parts[1];
                String email = parts[2];
                String password = parts[3];
                String subject = parts[4];
                String location = parts[5];
                String bio = parts[6];

                Map<String, String> availability = new HashMap<>();
                if (parts.length > 7) {
                    String[] slots = parts[7].split("\\|");
                    for (String slot : slots) {
                        String[] pair = slot.split(":");
                        if (pair.length == 2) {
                            availability.put(pair[0], pair[1]);
                        }
                    }
                }

                Tutor tutor = new Tutor(id, name, email, password, subject, location, bio, availability);
                tutors.add(tutor);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return tutors;
    }

    // Insert into BST
    public static void insertTutor(Tutor tutor) {
        root = insertRecursive(root, tutor);
    }

    private static BSTNode insertRecursive(BSTNode node, Tutor tutor) {
        if (node == null) return new BSTNode(tutor);

        if (tutor.getName().compareToIgnoreCase(node.data.getName()) < 0) {
            node.left = insertRecursive(node.left, tutor);
        } else {
            node.right = insertRecursive(node.right, tutor);
        }
        return node;
    }

    // Save to file and BST
    public static void saveTutor(Tutor tutor) {
        insertTutor(tutor);
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            StringBuilder availabilityStr = new StringBuilder();
            for (Map.Entry<String, String> entry : tutor.getAvailability().entrySet()) {
                if (availabilityStr.length() > 0) availabilityStr.append("|");
                availabilityStr.append(entry.getKey()).append(":").append(entry.getValue());
            }

            String record = String.join(",", tutor.getId(), tutor.getName(), tutor.getEmail(),
                    tutor.getPassword(), tutor.getSubject(), tutor.getLocation(), tutor.getBio(), availabilityStr.toString());

            bw.write(record);
            bw.newLine();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // Get all tutors (in-order traversal)
    public static List<Tutor> getAllTutors() {
        List<Tutor> tutors = new ArrayList<>();
        inOrderTraversal(root, tutors);
        return tutors;
    }

    private static void inOrderTraversal(BSTNode node, List<Tutor> tutors) {
        if (node != null) {
            inOrderTraversal(node.left, tutors);
            tutors.add(node.data);
            inOrderTraversal(node.right, tutors);
        }
    }

    // Find tutor by name
    public static Tutor findTutorByName(String name) {
        return searchByName(root, name);
    }

    private static Tutor searchByName(BSTNode node, String name) {
        if (node == null) return null;

        int cmp = name.compareToIgnoreCase(node.data.getName());
        if (cmp == 0) return node.data;
        else if (cmp < 0) return searchByName(node.left, name);
        else return searchByName(node.right, name);
    }

    // Delete tutor by ID from BST and update the file
    public static void deleteTutor(String id) {
        root = deleteRecursive(root, id);
        // Re-write all tutors to file
        List<Tutor> updatedTutors = new ArrayList<>();
        inOrderTraversal(root, updatedTutors);

        try (BufferedWriter bw = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (Tutor tutor : updatedTutors) {
                StringBuilder availabilityStr = new StringBuilder();
                for (Map.Entry<String, String> entry : tutor.getAvailability().entrySet()) {
                    if (availabilityStr.length() > 0) availabilityStr.append("|");
                    availabilityStr.append(entry.getKey()).append(":").append(entry.getValue());
                }

                String record = String.join(",", tutor.getId(), tutor.getName(), tutor.getEmail(),
                        tutor.getPassword(), tutor.getSubject(), tutor.getLocation(), tutor.getBio(), availabilityStr.toString());

                bw.write(record);
                bw.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static BSTNode deleteRecursive(BSTNode node, String id) {
        if (node == null) return null;

        int cmp = id.compareTo(node.data.getId());
        if (cmp < 0) {
            node.left = deleteRecursive(node.left, id);
        } else if (cmp > 0) {
            node.right = deleteRecursive(node.right, id);
        } else {
            // Node to delete found
            if (node.left == null) return node.right;
            else if (node.right == null) return node.left;

            // Two children: get inorder successor
            BSTNode minLargerNode = getMin(node.right);
            node.data = minLargerNode.data;
            node.right = deleteRecursive(node.right, minLargerNode.data.getId());
        }
        return node;
    }

    private static BSTNode getMin(BSTNode node) {
        while (node.left != null) {
            node = node.left;
        }
        return node;
    }
}
