package TutorSearchAndProfileManagement;

import java.util.ArrayList;
import java.util.List;

public class TutorBST {
    private class Node {
        String tutorId;
        Tutor tutor;
        Node left, right;

        Node(String tutorId, Tutor tutor) {
            this.tutorId = tutorId;
            this.tutor = tutor;
            this.left = null;
            this.right = null;
        }
    }

    private Node root;

    public TutorBST() {
        this.root = null;
    }

    // Insert a tutor into the BST
    public void insert(Tutor tutor) {
        root = insertRec(root, tutor.getId(), tutor);
    }

    private Node insertRec(Node root, String tutorId, Tutor tutor) {
        if (root == null) {
            return new Node(tutorId, tutor);
        }

        if (tutorId.compareTo(root.tutorId) < 0) {
            root.left = insertRec(root.left, tutorId, tutor);
        }
        else if (tutorId.compareTo(root.tutorId) > 0) {
            root.right = insertRec(root.right, tutorId, tutor);
        }

        return root;
    }

    // Search for a tutor by ID
    public Tutor findById(String tutorId) {
        Node node = findRec(root, tutorId);
        return node != null ? node.tutor : null;
    }

    private Node findRec(Node root, String tutorId) {
        if (root == null || root.tutorId.equals(tutorId)) {
            return root;
        }

        if (tutorId.compareTo(root.tutorId) < 0) {
            return findRec(root.left, tutorId);
        }
        return findRec(root.right, tutorId);
    }

    // Search for tutors by subject (BST traversal)
    public List<Tutor> findBySubject(String subject) {
        List<Tutor> results = new ArrayList<>();
        findBySubjectRec(root, subject.toLowerCase(), results);
        return results;
    }

    private void findBySubjectRec(Node root, String subject, List<Tutor> results) {
        if (root != null) {
            findBySubjectRec(root.left, subject, results);
            if (root.tutor.getSubject().toLowerCase().contains(subject)) {
                results.add(root.tutor);
            }
            findBySubjectRec(root.right, subject, results);
        }
    }

    // Search for tutors by location (BST traversal)
    public List<Tutor> findByLocation(String location) {
        List<Tutor> results = new ArrayList<>();
        findByLocationRec(root, location.toLowerCase(), results);
        return results;
    }

    private void findByLocationRec(Node root, String location, List<Tutor> results) {
        if (root != null) {
            findByLocationRec(root.left, location, results);
            if (root.tutor.getLocation().toLowerCase().contains(location)) {
                results.add(root.tutor);
            }
            findByLocationRec(root.right, location, results);
        }
    }

    // Get all tutors (in-order traversal)
    public List<Tutor> getAllTutors() {
        List<Tutor> tutors = new ArrayList<>();
        inOrderRec(root, tutors);
        return tutors;
    }

    private void inOrderRec(Node root, List<Tutor> tutors) {
        if (root != null) {
            inOrderRec(root.left, tutors);
            tutors.add(root.tutor);
            inOrderRec(root.right, tutors);
        }
    }

    // Delete a tutor by ID
    public void delete(String tutorId) {
        root = deleteRec(root, tutorId);
    }

    private Node deleteRec(Node root, String tutorId) {
        if (root == null) {
            return null;
        }

        if (tutorId.compareTo(root.tutorId) < 0) {
            root.left = deleteRec(root.left, tutorId);
        }
        else if (tutorId.compareTo(root.tutorId) > 0) {
            root.right = deleteRec(root.right, tutorId);
        }
        else {
            // Node with only one child or no child
            if (root.left == null) {
                return root.right;
            } else if (root.right == null) {
                return root.left;
            }

            // Node with two children: Get the inorder successor (smallest in right subtree)
            root.tutorId = minValue(root.right);
            root.tutor = findById(root.tutorId);
            root.right = deleteRec(root.right, root.tutorId);
        }
        return root;
    }

    private String minValue(Node root) {
        String minv = root.tutorId;
        while (root.left != null) {
            minv = root.left.tutorId;
            root = root.left;
        }
        return minv;
    }
}