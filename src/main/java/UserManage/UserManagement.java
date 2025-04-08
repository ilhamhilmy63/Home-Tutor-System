package UserManage;

import java.io.*;
import java.util.*;

public class UserManagement {
    private static final String FILE_PATH = "Users.txt";
    private static BSTNode tutorBSTRoot = null; //BST root for tutors

    // Binary Search Tree Node for Tutors
    private static class BSTNode {
        Tutor tutor;
        BSTNode left, right;

        BSTNode(Tutor tutor){
            this.tutor = tutor;
            this.left = this.right = null;
        }
    }

    //1. CREATE - Register a new user
    public static boolean registerUser(User user){
        // Save to file
        try (PrintWriter out= new PrintWriter(new FileWriter(FILE_PATH,true))){
            out.println(serializeUser(user));

            // If it's a tutor, add to BST
            if (user instanceof Tutor){
                tutorBSTRoot = insertTutor(tutorBSTRoot, (Tutor)user);
            }
            return true;
        } catch (IOException e) {
            System.err.println("Error saving user:" + e.getMessage());
            return false;
        }
    }

    //2. READ - Get user by email
    public static User getUserByEmail(String email){
        //First check in BST if looking for tutor
        User user = searchTutorInBST(tutorBSTRoot, email);
        if (user != null) return user;

        // Otherwise search in file
        List<User> users= getAllUsersFromFile();
        for (User u: users){
            if (u.getEmail().equals(email)){
                return u;
            }
        }
        return null;
    }

    // 3. READ - Get all users (for admin)
    public static List<User> getAllUsers(){
        List<User> users = getAllUsersFromFile();
        return users;
    }

    // 4.READ - Get all tutors sorted by subject (using merge sort)
    public static List<Tutor> getAllTutorsSortedBySubject(){
        List<Tutor> tutors = getAllTutorsFromBST (tutorBSTRoot);
        if (tutors.isEmpty()){
            return tutors;
        }
        //Perform merge sort by subject
        return mergeSortTutorsBySubject (tutors);
    }

    // 5. UPDATE- Update user details
    public static boolean updateUser(User updatedUser){
        List<User> users= getAllUsersFromFile ();
        boolean found = false;

        for (int i = 0; i < users.size(); i++){
            if (users.get(i).getEmail().equals(updatedUser.getEmail())){
                // If updating tutor, update BST
                if (users.get(i) instanceof Tutor && updatedUser instanceof Tutor){
                    tutorBSTRoot = deleteTutor(tutorBSTRoot, (Tutor)users.get(i));
                    tutorBSTRoot = insertTutor(tutorBSTRoot, (Tutor)updatedUser);
                }
                users.set(i, updatedUser);
                found = true;
                break;
            }
        }
        if (!found){
            return false;
        }
        return saveAllUsersToFile (users);

    }

    // 6. DELETE - Remove user by email
    public static boolean deleteUser(String email){
        List<User> users = getAllUsersFromFile();
        User userToDelete = null;
        boolean removed = false;

        Iterator<User> iterator = users.iterator();
        while (iterator.hasNext()){
            User user = iterator.next();
            if (user.getEmail().equals(email)) {
                userToDelete = user;
                iterator.remove();
                removed = true;
                break;
            }
        }
        if (!removed){
            return false;
        }
        // If deleting tutor, remove from BST
        if (userToDelete instanceof Tutor){
            tutorBSTRoot = deleteTutor(tutorBSTRoot, (Tutor)userToDelete);
        }
        return saveAllUsersToFile (users);
    }

    // === BST Operations ===
    private static BSTNode insertTutor(BSTNode root, Tutor tutor){
        if (root == null){
            return new BSTNode(tutor);
        }
        // Compare by email (unique identifier)
        if (tutor.getEmail().compareTo(root.tutor.getEmail()) < 0){
            root.left = insertTutor(root.left, tutor);
        } else if (tutor.getEmail().compareTo(root.tutor.getEmail()) > 0){
            root.right = insertTutor(root.right, tutor);
        }
        return root;
    }

    private static User searchTutorInBST(BSTNode root, String email){
        if (root == null){
            return null;
        }
        if (email.equals(root.tutor.getEmail())){
            return root.tutor;
        } else if (email.compareTo(root.tutor.getEmail()) < 0){
            return searchTutorInBST(root.left, email);
        } else {
            return searchTutorInBST(root.right, email);
        }
    }

    private static BSTNode deleteTutor(BSTNode root, Tutor tutor){
        if (root == null){
            return null;
        }
        if (tutor.getEmail().compareTo(root.tutor.getEmail()) < 0){
            root.left = deleteTutor(root.left, tutor);
        } else if (tutor.getEmail().compareTo(root.tutor.getEmail()) > 0){
            root.right = deleteTutor(root.right, tutor);
        } else {
            //Node with only one child or no child
            if (root.left == null) {
                return root.right;
            } else if (root.right == null) {
                return root.left;
            }

            // Node with two children: Get inorder successor
            root.tutor = minValue(root.right);

            //Delete the inorder successor
            root.right = deleteTutor(root.right, root.tutor);
        }
        return root;
    }

    private static Tutor minValue(BSTNode root){
        Tutor min = root.tutor;
        while (root.left != null){
            min = root.left.tutor;
            root = root.left;
        }
        return min;
    }

    private static List<Tutor> getAllTutorsFromBST (BSTNode root){
        List<Tutor> tutors = new ArrayList<>();
        inOrderTraversal (root, tutors);
        return tutors;
    }

    private static void inOrderTraversal(BSTNode node, List<Tutor> tutors){
        if (node != null){
            inOrderTraversal(node.left, tutors);
            tutors.add(node.tutor);
            inOrderTraversal(node.right, tutors);
        }
    }

    // === Merge Sort by Subject ===
    private static List<Tutor> mergeSortTutorsBySubject (List<Tutor> tutors){
        if (tutors.size() <= 1){
            return tutors;
        }

        int mid = tutors.size() / 2;
        List<Tutor> left = new ArrayList<>(tutors.subList(0, mid));
        List<Tutor> right = new ArrayList<>(tutors.subList(mid, tutors.size()));

        left = mergeSortTutorsBySubject(left);
        right = mergeSortTutorsBySubject(right);

        return mergeBySubject (left,right);
    }

    private static List<Tutor> mergeBySubject (List<Tutor> left, List<Tutor> right){
        List<Tutor> merged = new ArrayList<>();
        int i= 0, j = 0;

        while (i < left.size() && j < right.size()){
            // Compare by primary subject (assuming Tutor has getPrimary() method)
            if (left.get(i).getPrimarySubject().compareTo(right.get(j).getPrimarySubject()) <= 0){
                merged.add(left.get(i++));
            } else {
                merged.add(right.get(j++)) ;
            }
        }
        while (i < left.size()){
            merged.add(left.get(i++));
        }
        while (j < right.size()){
            merged.add(right.get(j++));
        }
        return merged;
    }

    // === File Operations ===
    private static List<User> getAllUsersFromFile() {
        List<User> users = new ArrayList<>();
        File file = new File(FILE_PATH);

        if (!file.exists()) {
            return users;
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                User user = deserializeUser(line);
                if (user != null) {
                    users.add(user);
                    // Rebuild BST for tutors
                    if (user instanceof Tutor) {
                        tutorBSTRoot = insertTutor(tutorBSTRoot, (Tutor)user);
                    }
                }
            }
        } catch (IOException e) {
            System.err.println("Error reading users: " + e.getMessage());
        }
        return users;
    }

    private static boolean saveAllUsersToFile(List<User> users) {
        try (PrintWriter out = new PrintWriter(new FileWriter(FILE_PATH))) {
            for (User user : users) {
                out.println(serializeUser(user));
            }
            return true;
        } catch (IOException e) {
            System.err.println("Error saving users: " + e.getMessage());
            return false;
        }
    }

    private static String serializeUser(User user) {
        String base= user.getName() + "," + user.getEmail() + "," +
                user.getPhone() + "," + user.getPassword() + "," + user.getRole();
        if (user instanceof Tutor){
            Tutor t= (Tutor)user;
            base += "," + t.getPrimarySubject() + "," +
                    String.join(";",t.getSecondarySubjects())+","+
                    t.getHourlyRate() + "," + t.getQualification();

        }
        return base;
    }

    private static User deserializeUser(String line) {
        String[] parts = line.split(",",-1);//Allow empty fields
        User user = switch (parts[4].trim().toLowerCase()) {
            case "tutor" -> new Tutor();
            case "admin" -> new Admin();
            case "student" -> new Student();
            default -> new User();
        };

        // Set common fields
        user.setName(parts[0].trim());
        user.setEmail(parts[1].trim());
        user.setPhone(parts[2].trim());
        user.setPassword(parts[3].trim());
        user.setRole(parts[4].trim());

        // Handle Tutor-specific fields
        if (user instanceof Tutor t && parts.length >= 9) {
            t.setPrimarySubject(parts[5].trim());
            if (!parts[6].isEmpty())
                t.setSecondarySubjects(Arrays.asList(parts[6].split(";")));
            t.setHourlyRate(Double.parseDouble(parts[7].trim()));
            t.setQualification(parts[8].trim());
        }
        return user;
    }
}
