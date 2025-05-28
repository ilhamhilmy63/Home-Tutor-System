package com.example.modules.TutorManagement;

import com.example.model.Tutor;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class TutorRepository {
    private static final String FILE_PATH = "C:/OOP Project/Home-Tutor-System/src/main/webapp/tutors.txt";

    public void saveTutor(Tutor tutor) throws IOException {
        ensureFileExists();
        try (PrintWriter out = new PrintWriter(new FileWriter(FILE_PATH, true))) {
            out.println(tutorToString(tutor));
        }
    }

    public List<Tutor> getAllTutors() throws IOException {
        ensureFileExists();
        List<Tutor> tutors = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                tutors.add(stringToTutor(line));
            }
        }
        return tutors;
    }

    public Tutor getTutorById(String tutorId) throws IOException {
        List<Tutor> tutors = getAllTutors();
        for (Tutor tutor : tutors) {
            if (tutor.getId().equals(tutorId)) {
                return tutor;
            }
        }
        return null;
    }

    public Tutor getTutorByEmail(String email) throws IOException {
        List<Tutor> tutors = getAllTutors();
        for (Tutor tutor : tutors) {
            if (tutor.getEmail().equals(email)) {
                return tutor;
            }
        }
        return null;
    }

    public void updateTutor(Tutor updatedTutor) throws IOException {
        List<Tutor> tutors = getAllTutors();
        for (int i = 0; i < tutors.size(); i++) {
            if (tutors.get(i).getId().equals(updatedTutor.getId())) {
                tutors.set(i, updatedTutor);
                break;
            }
        }
        saveAllTutors(tutors);
    }

    public void deleteTutor(String tutorId) throws IOException {
        List<Tutor> tutors = getAllTutors();
        tutors.removeIf(tutor -> tutor.getId().equals(tutorId));
        saveAllTutors(tutors);
    }

    private void saveAllTutors(List<Tutor> tutors) throws IOException {
        try (PrintWriter out = new PrintWriter(new FileWriter(FILE_PATH, false))) {
            for (Tutor tutor : tutors) {
                out.println(tutorToString(tutor));
            }
        }
    }

    private String tutorToString(Tutor tutor) {
        return tutor.getId() + "," +
                tutor.getFullName() + "," +
                tutor.getPhoneNumber() + "," +
                tutor.getEmail() + "," +
                tutor.getPassword() + "," +
                tutor.getQualification() + "," +
                tutor.getSpecialization() + "," +
                tutor.getExperience() + "," +
                tutor.getHourlyRate();
    }

    private Tutor stringToTutor(String str) {
        String[] parts = str.split(",");
        double hourlyRate = Double.parseDouble(parts[8]); // convert string to double
        return new Tutor(parts[0], parts[1], parts[2], parts[3], parts[4],
                parts[5], parts[6], parts[7], hourlyRate);
    }

    private void ensureFileExists() throws IOException {
        File file = new File(FILE_PATH);
        if (!file.exists()) {
            file.getParentFile().mkdirs();
            file.createNewFile();
        }
    }
}