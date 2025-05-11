package TutorSearchAndProfileManagement;

import java.io.*;
import java.util.*;

public class TutorDataStore {
    private static final String FILE_PATH = "tutors.txt";

    public static List<Tutor> getAllTutors() {
        List<Tutor> tutors = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = br.readLine()) != null) {
                // Format: id,name,email,password,subject,location,availabilityDay1:time1|day2:time2
                String[] parts = line.split(",");
                String id = parts[0];
                String name = parts[1];
                String email = parts[2];
                String password = parts[3];
                String subject = parts[4];
                String location = parts[5];

                Map<String, String> availability = new HashMap<>();
                if (parts.length > 6) {
                    String[] slots = parts[6].split("\\|");
                    for (String slot : slots) {
                        String[] pair = slot.split(":");
                        if (pair.length == 2) {
                            availability.put(pair[0], pair[1]);
                        }
                    }
                }

                Tutor tutor = new Tutor(id, name, email, password, subject, location, availability);
                tutors.add(tutor);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return tutors;
    }

    public static void saveTutor(Tutor tutor) {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            StringBuilder availabilityStr = new StringBuilder();
            for (Map.Entry<String, String> entry : tutor.getAvailability().entrySet()) {
                if (availabilityStr.length() > 0) availabilityStr.append("|");
                availabilityStr.append(entry.getKey()).append(":").append(entry.getValue());
            }

            String record = String.join(",", tutor.getId(), tutor.getName(), tutor.getEmail(),
                    tutor.getPassword(), tutor.getSubject(), tutor.getLocation(), availabilityStr.toString());

            bw.write(record);
            bw.newLine();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void deleteTutor(String id) {
        List<Tutor> tutors = getAllTutors();
        tutors.removeIf(t -> t.getId().equals(id));

        try (BufferedWriter bw = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (Tutor tutor : tutors) {
                saveTutor(tutor);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
