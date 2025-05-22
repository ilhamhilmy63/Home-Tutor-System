package com.example.modules.TutorManagement;

import com.example.models.Tutor;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

public class TutorService {
    private final TutorRepository tutorRepository = new TutorRepository();

    public Tutor registerTutor(String name, String email, String password, String subject) throws IOException {
        String id = UUID.randomUUID().toString();
        Tutor tutor = new Tutor(id, name, email, password, subject);
        tutorRepository.saveTutor(tutor);
        return tutor;
    }

    public Tutor loginTutor(String email, String password) throws IOException {
        List<Tutor> tutors = tutorRepository.getAllTutors();
        for (Tutor tutor : tutors) {
            if (tutor.getEmail().equals(email) && tutor.getPassword().equals(password)) {
                return tutor;
            }
        }
        return null;
    }

    public boolean updateTutorProfile(String id, String name, String email, String subject) throws IOException {
        List<Tutor> tutors = tutorRepository.getAllTutors();
        for (Tutor tutor : tutors) {
            if (tutor.getId().equals(id)) {
                tutor.setName(name);
                tutor.setEmail(email);
                tutor.setSubject(subject);
                tutorRepository.updateTutor(tutor);
                return true;
            }
        }
        return false;
    }

    public boolean emailExists(String email) throws IOException {
        return tutorRepository.getAllTutors().stream()
                .anyMatch(tutor -> tutor.getEmail().equals(email));
    }
}