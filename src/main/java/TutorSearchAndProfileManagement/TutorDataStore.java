package TutorSearchAndProfileManagement;

import java.io.*;
import java.util.*;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.nio.file.Path;
import java.nio.file.Paths;

public class TutorDataStore {
    private static final String FILE_PATH = "C:\\Users\\Shaa\\OneDrive\\Desktop\\Sem 02\\OOP\\Project\\Home Tutor System\\data\\Tutor.Data.txt";

    public static List<Tutor> getAllTutors() {
        List<Tutor> tutors = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",", -1);
                if (parts.length >= 9) { // Minimum required fields
                    String id = parts[0].trim();
                    String name = parts[1].trim();
                    String email = parts[2].trim();
                    String phone = parts[3].trim();
                    String password = parts[4].trim();
                    String subject = parts[5].trim();
                    String location = parts[6].trim();
                    String bio = parts[7].trim();
                    String expertise = parts[8].trim();
                    String availabilityStr = parts.length > 9 ? parts[9].trim() : "";
                    Tutor tutor = new Tutor(id, name, email, phone, password, subject, location, bio, expertise, availabilityStr);
                    tutors.add(tutor);
                }
            }
        }
        catch (IOException e) {
            e.printStackTrace();
        }
        return tutors;
    }

    public static Tutor findTutorByEmailAndPassword(String email, String password) {
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",", -1);
                if (parts.length >= 9) {
                    String tutorEmail = parts[2].trim();
                    String tutorPassword = parts[4].trim();
                    if (tutorEmail.equals(email) && tutorPassword.equals(password)) {
                        String id = parts[0].trim();
                        String name = parts[1].trim();
                        String phone = parts[3].trim();
                        String subject = parts[5].trim();
                        String location = parts[6].trim();
                        String bio = parts[7].trim();
                        String expertise = parts[8].trim();
                        String availabilityStr = parts.length > 9 ? parts[9].trim() : "";
                        return new Tutor(id, name, tutorEmail, phone, tutorPassword, subject, location, bio, expertise, availabilityStr);
                    }
                }
            }
        }
        catch (IOException e) {
            e.printStackTrace();
        }
        return null; // no matching tutor found
    }

    public static Tutor findTutorById(String id) {
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",", -1);
                if (parts.length >= 9 && parts[0].trim().equals(id)) {
                    String tutorId = parts[0].trim();
                    String name = parts[1].trim();
                    String email = parts[2].trim();
                    String phone = parts[3].trim();
                    String password = parts[4].trim();
                    String subject = parts[5].trim();
                    String location = parts[6].trim();
                    String bio = parts[7].trim();
                    String expertise = parts[8].trim();
                    String availabilityStr = parts.length > 9 ? parts[9].trim() : "";
                    return new Tutor(tutorId, name, email, phone, password, subject, location, bio, expertise, availabilityStr);
                }
            }
        }
        catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static void saveTutor(Tutor tutor) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            String line = String.format("%s,%s,%s,%s,%s,%s,%s,%s,%s,%s",
                    tutor.getId(), tutor.getName(), tutor.getEmail(), tutor.getPhone(),
                    tutor.getPassword(), tutor.getSubject(), tutor.getLocation(),
                    tutor.getBio(), tutor.getExpertise(), tutor.getAvailabilityAsString());
            writer.write(line);
            writer.newLine();
        }
        catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static boolean updateTutor(Tutor updatedTutor) {
        List<Tutor> tutors = getAllTutors();
        boolean found = false;

        // Find and update the tutor
        for (int i = 0; i < tutors.size(); i++) {
            if (tutors.get(i).getId().equals(updatedTutor.getId())) {
                tutors.set(i, updatedTutor);
                found = true;
                break;
            }
        }

        if (found) {
            Path originalPath = Paths.get(FILE_PATH);
            Path backupPath = Paths.get(FILE_PATH + ".bak");

            try {
                // Create backup
                if (Files.exists(originalPath)) {
                    Files.copy(originalPath, backupPath, StandardCopyOption.REPLACE_EXISTING);
                }

                // Write updated data
                try (BufferedWriter writer = Files.newBufferedWriter(originalPath)) {
                    for (Tutor tutor : tutors) {
                        String line = String.format("%s,%s,%s,%s,%s,%s,%s,%s,%s,%s",
                                tutor.getId(), tutor.getName(), tutor.getEmail(), tutor.getPhone(),
                                tutor.getPassword(), tutor.getSubject(), tutor.getLocation(),
                                tutor.getBio(), tutor.getExpertise(), tutor.getAvailabilityAsString());
                        writer.write(line);
                        writer.newLine();
                    }
                    return true;
                }
            } catch (IOException e) {
                e.printStackTrace();
                // Restore from backup if update failed
                try {
                    if (Files.exists(backupPath)) {
                        Files.copy(backupPath, originalPath, StandardCopyOption.REPLACE_EXISTING);
                    }
                } catch (IOException ex) {
                    ex.printStackTrace();
                }
                return false;
            }
        }
        return false;
    }

    public static boolean deleteTutor(String id) {
        List<Tutor> tutors = getAllTutors();
        boolean found = tutors.removeIf(tutor -> tutor.getId().equals(id));
        if (found) {
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
                for (Tutor tutor : tutors) {
                    String line = String.format("%s,%s,%s,%s,%s,%s,%s,%s,%s,%s",
                            tutor.getId(), tutor.getName(), tutor.getEmail(), tutor.getPhone(),
                            tutor.getPassword(), tutor.getSubject(), tutor.getLocation(),
                            tutor.getBio(), tutor.getExpertise(), tutor.getAvailabilityAsString());
                    writer.write(line);
                    writer.newLine();
                }
            }
            catch (IOException e) {
                e.printStackTrace();
                return false;
            }
        }
        return found;
    }
}