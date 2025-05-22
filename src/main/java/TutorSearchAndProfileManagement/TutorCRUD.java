package TutorSearchAndProfileManagement;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

public class TutorCRUD {

    private static final String MESSAGES_FILE = "C:\\Users\\Shaa\\OneDrive\\Desktop\\Sem 02\\OOP\\Project\\Home Tutor System\\data\\messages.txt";

    // CREATE: Register a new tutor
    public String createTutor(Map<String, String> params) {
        try {
            String name = params.get("name");
            String email = params.get("email");
            String password = params.get("password");
            String subject = params.get("subject");
            String location = params.get("location");
            String bio = params.get("bio");
            String phone = params.get("phone");
            String expertise = params.get("expertise");

            // Validate input
            if (name == null || email == null || password == null || subject == null || location == null || bio == null || expertise == null ||
                    name.trim().isEmpty() || email.trim().isEmpty() || password.trim().isEmpty() || subject.trim().isEmpty() ||
                    location.trim().isEmpty() || bio.trim().isEmpty() || expertise.equals("None")) {
                return "Error: All required fields must be filled, and expertise must be selected.";
            }

            // Validate email format
            if (!email.matches("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
                return "Error: Invalid email format.";
            }

            // Create availability map
            Map<String, String> availability = new HashMap<>();
            for (int i = 0; i < 7; i++) {
                String day = params.get("day" + i);
                String time = params.get("time" + i);
                if (day != null && !day.equals("None") && time != null && !time.trim().isEmpty()) {
                    if (!time.matches("^\\d{2}:\\d{2}-\\d{2}:\\d{2}$")) {
                        return "Error: Invalid time format for " + day + ": use HH:MM-HH:MM";
                    }
                    availability.put(day, time);
                }
            }

            // Create new tutor
            String tutorId = UUID.randomUUID().toString();
            Tutor tutor = new Tutor(tutorId, name, email, password, subject, location, bio, availability.toString(), phone, expertise);

            // Save to data store
            TutorDataStore.saveTutor(tutor);
            return "Registration successful. Please log in.";
        }
        catch (Exception e) {
            System.out.println("Error creating tutor: " + e.getMessage());
            return "Error: Failed to register tutor due to an unexpected issue.";
        }
    }

    // READ: List all tutors (unsorted)
    public List<Tutor> listTutors() {
        List<Tutor> tutorList = TutorDataStore.getAllTutors();
        return tutorList;
        /*
        // Alternative: Sort by subject using Java's built-in sorting
        tutorList.sort((t1, t2) -> t1.getSubject().compareToIgnoreCase(t2.getSubject()));
        return tutorList;
        */
    }

    // READ: Search tutors by keyword, location, and expertise (unsorted)
    public List<Tutor> searchTutors(String keyword, String location, String expertise) {
        List<Tutor> results = SearchService.searchTutors(keyword, location, expertise);
        return results;
        /*
        // Alternative: Sort by subject using Java's built-in sorting
        results.sort((t1, t2) -> t1.getSubject().compareToIgnoreCase(t2.getSubject()));
        return results;
        */
    }

    // READ: View a tutor's profile
    public Map<String, Object> viewTutorProfile(String tutorId) {
        Map<String, Object> result = new HashMap<>();
        Tutor tutor = TutorDataStore.findTutorById(tutorId);

        if (tutor != null) {
            result.put("tutor", tutor);
            result.put("name", tutor.getName());
            result.put("subjects", tutor.getSubject());
            result.put("location", tutor.getLocation());
            result.put("bio", tutor.getBio());
            result.put("expertise", tutor.getExpertise());
            result.put("phone", tutor.getPhone());
            result.put("availability", tutor.getAvailability()); // Direct use of availability map
        }
        else {
            result.put("error", "Tutor not found.");
        }
        return result;
    }

    // READ: Get tutor data for editing
    public Map<String, Object> getTutorForEdit(String tutorId, boolean isAdmin, String loggedInTutorId) {
        Map<String, Object> result = new HashMap<>();
        if (!isAdmin && (loggedInTutorId == null || !loggedInTutorId.equals(tutorId))) {
            result.put("error", "Unauthorized access.");
            return result;
        }

        Tutor tutor = TutorDataStore.findTutorById(tutorId);
        if (tutor != null) {
            result.put("tutor", tutor);
            result.put("availability", tutor.getAvailability()); // Direct use of availability map
            result.put("expertise", tutor.getExpertise());
        }
        else {
            result.put("error", "Tutor not found.");
        }
        return result;
    }

    // UPDATE: Update a tutor's profile
    public Map<String, Object> updateTutor(String tutorId, Map<String, String> params, boolean isAdmin, String loggedInTutorId) {
        Map<String, Object> result = new HashMap<>();
        if (!isAdmin && (loggedInTutorId == null || !loggedInTutorId.equals(tutorId))) {
            result.put("error", "Unauthorized access.");
            return result;
        }

        String name = params.get("name");
        String subjects = params.get("subjects");
        String location = params.get("location");
        String bio = params.get("bio");
        String phone = params.get("phone");
        String expertise = params.get("expertise");

        // Validate input
        if (name == null || subjects == null || location == null || bio == null || expertise == null ||
                name.trim().isEmpty() || subjects.trim().isEmpty() || location.trim().isEmpty() || bio.trim().isEmpty() || expertise.equals("None")) {
            result.put("error", "All required fields must be filled, and expertise must be selected.");
            return result;
        }

        Map<String, String> availabilityMap = new HashMap<>();
        for (int i = 0; i < 7; i++) {
            String day = params.get("day" + i);
            String time = params.get("time" + i);
            if (day != null && !day.equals("None") && time != null && !time.trim().isEmpty()) {
                if (!time.matches("^\\d{2}:\\d{2}-\\d{2}:\\d{2}$")) {
                    result.put("error", "Invalid time format for " + day + ": use HH:MM-HH:MM");
                    return result;
                }
                availabilityMap.put(day, time);
            }
        }

        Tutor existingTutor = TutorDataStore.findTutorById(tutorId);
        if (existingTutor == null) {
            result.put("error", "Tutor not found.");
            return result;
        }

        // Update tutor details
        existingTutor.setName(name);
        existingTutor.setSubject(subjects);
        existingTutor.setLocation(location);
        existingTutor.setBio(bio);
        existingTutor.setPhone(phone);
        existingTutor.setExpertise(expertise);
        existingTutor.setAvailability(availabilityMap);

        // Save updated tutor
        TutorDataStore.deleteTutor(tutorId);
        TutorDataStore.saveTutor(existingTutor);

        // Prepare result for display
        result.put("tutor", existingTutor);
        result.put("availability", existingTutor.getAvailability());
        result.put("expertise", existingTutor.getExpertise());
        result.put("message", "Profile updated successfully.");
        return result;
    }

    // DELETE: Delete a tutor
    public String deleteTutor(String tutorId, boolean isAdmin) {
        if (!isAdmin) {
            return "Error: Unauthorized access.";
        }

        Tutor tutor = TutorDataStore.findTutorById(tutorId);
        if (tutor == null) {
            return "Error: Tutor not found.";
        }

        TutorDataStore.deleteTutor(tutorId);
        return "Tutor deleted successfully.";
    }

    // CONTACT: Send message to a tutor
    public String contactTutor(String tutorId, String studentName, String message) {
        Tutor tutor = TutorDataStore.findTutorById(tutorId);
        if (tutor == null) {
            return "Error: Tutor not found.";
        }

        // Store message in messages.txt
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(MESSAGES_FILE, true))) {
            String messageId = UUID.randomUUID().toString();
            String record = String.join(",", messageId, tutorId, studentName, message, String.valueOf(System.currentTimeMillis()));
            bw.write(record);
            bw.newLine();
        }
        catch (IOException e) {
            System.out.println("Error writing to messages.txt: " + e.getMessage());
            return "Error: Failed to send message.";
        }

        return "Message sent successfully to " + tutor.getName() + ".";
    }
}