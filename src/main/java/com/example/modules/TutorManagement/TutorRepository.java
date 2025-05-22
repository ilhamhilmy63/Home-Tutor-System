package com.example.modules.TutorManagement;

import com.example.models.Tutor;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class TutorRepository {
    private static final String FILE_PATH = "C:/Users/share/Desktop/HomeTutor/src/main/webapp/WEB-INF/data/tutors.txt";

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

    private void saveAllTutors(List<Tutor> tutors) throws IOException {
        try (PrintWriter out = new PrintWriter(new FileWriter(FILE_PATH, false))) {
            for (Tutor tutor : tutors) {
                out.println(tutorToString(tutor));
            }
        }
    }

    private String tutorToString(Tutor tutor) {
        return tutor.getId() + "," + tutor.getName() + "," + tutor.getEmail() + "," +
                tutor.getPassword() + "," + tutor.getSubject();
    }

    private Tutor stringToTutor(String str) {
        String[] parts = str.split(",");
        return new Tutor(parts[0], parts[1], parts[2], parts[3], parts[4]);
    }

    private void ensureFileExists() throws IOException {
        File file = new File(FILE_PATH);
        if (!file.exists()) {
            file.getParentFile().mkdirs();
            file.createNewFile();
        }
    }
}