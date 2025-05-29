package com.example.modules.TutorManagement;

import com.example.model.Tutor;
import java.io.IOException;
import java.util.List;
import java.util.UUID;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
import java.util.ArrayList;

public class TutorService {
    private final TutorBST tutorBST = new TutorBST();
    private final TutorRepository tutorRepository = new TutorRepository();

    private static final Pattern EMAIL_PATTERN =
            Pattern.compile("^[A-Za-z0-9+_.-]+@(.+)$");

    private static final Pattern PHONE_PATTERN =
            Pattern.compile("^[0-9]{10,15}$");

    /**
     * Enhanced search method that matches the servlet's expectations
     */
    public List<Tutor> searchTutors(String specialization, String sortBy, String minRate,
                                    String maxRate, String experienceLevel) throws IOException {
        List<Tutor> tutors;

        // Start with all tutors or filter by specialization
        if (specialization == null || specialization.isEmpty() || "all".equalsIgnoreCase(specialization)) {
            tutors = tutorRepository.getAllTutors();
        } else {
            tutors = tutorBST.searchBySpecialization(specialization);
            if (tutors == null || tutors.isEmpty()) {
                // Fallback to repository search if BST doesn't find results
                tutors = getTutorsBySpecialization(specialization);
            }
        }

        // Apply rate filters
        if (tutors != null) {
            tutors = filterByRate(tutors, minRate, maxRate);
            tutors = filterByExperience(tutors, experienceLevel);
        }

        // Apply sorting
        if (tutors != null && sortBy != null && !tutors.isEmpty()) {
            switch (sortBy.toLowerCase()) {
                case "name":
                    TutorSort.sortTutorsByName(tutors);
                    break;
                case "rate":
                case "rate_low":
                    TutorSort.sortTutorsByRate(tutors);
                    break;
                case "rate_high":
                    TutorSort.sortTutorsByRateDescending(tutors);
                    break;
                case "experience":
                    TutorSort.sortTutorsByExperience(tutors);
                    break;
                case "subject":
                case "subject_expertise":
                    TutorSort.sortTutorsBySubjectExpertise(tutors);
                    break;
                default:
                    // Default sorting by name
                    TutorSort.sortTutorsByName(tutors);
                    break;
            }
        }

        return tutors != null ? tutors : new ArrayList<>();
    }

    /**
     * Overloaded method for backward compatibility
     */
    public List<Tutor> searchTutors(String specialization, String sortBy) throws IOException {
        return searchTutors(specialization, sortBy, null, null, null);
    }

    /**
     * Filter tutors by hourly rate range
     */
    private List<Tutor> filterByRate(List<Tutor> tutors, String minRate, String maxRate) {
        if ((minRate == null || minRate.isEmpty()) && (maxRate == null || maxRate.isEmpty())) {
            return tutors;
        }

        return tutors.stream().filter(tutor -> {
            double rate = tutor.getHourlyRate();

            try {
                if (minRate != null && !minRate.isEmpty()) {
                    double min = Double.parseDouble(minRate);
                    if (rate < min) return false;
                }

                if (maxRate != null && !maxRate.isEmpty()) {
                    double max = Double.parseDouble(maxRate);
                    if (rate > max) return false;
                }
            } catch (NumberFormatException e) {
                // Invalid rate format, include tutor in results
                return true;
            }

            return true;
        }).collect(Collectors.toList());
    }

    /**
     * Filter tutors by experience level
     */
    private List<Tutor> filterByExperience(List<Tutor> tutors, String experienceLevel) {
        if (experienceLevel == null || experienceLevel.isEmpty() || "all".equalsIgnoreCase(experienceLevel)) {
            return tutors;
        }

        return tutors.stream().filter(tutor -> {
            String experience = tutor.getExperience();
            if (experience == null) return false;

            int years = extractYearsFromExperience(experience);

            switch (experienceLevel.toLowerCase()) {
                case "beginner":
                case "entry":
                    return years >= 0 && years <= 2;
                case "intermediate":
                case "mid":
                    return years >= 3 && years <= 5;
                case "advanced":
                case "senior":
                    return years >= 6 && years <= 10;
                case "expert":
                    return years > 10;
                default:
                    return true;
            }
        }).collect(Collectors.toList());
    }

    /**
     * Extract years from experience string (e.g., "5 years" -> 5)
     */
    private int extractYearsFromExperience(String experience) {
        if (experience == null || experience.isEmpty()) {
            return 0;
        }

        try {
            // Look for number followed by "year" or just a number
            String[] parts = experience.toLowerCase().split("\\s+");
            for (String part : parts) {
                if (part.matches("\\d+")) {
                    return Integer.parseInt(part);
                }
            }
        } catch (NumberFormatException e) {
            return 0;
        }
        return 0;
    }

    public void loadTutorsIntoBST() throws IOException {
        List<Tutor> tutors = tutorRepository.getAllTutors();
        for (Tutor tutor : tutors) {
            tutorBST.insert(tutor);
        }
    }

    public Tutor registerTutor(String fullName, String phoneNumber, String email,
                               String password, String qualification, String specialization,
                               String experience, double hourlyRate) throws IOException {

        if (!isValidInput(fullName, phoneNumber, email, password, qualification,
                specialization, experience, hourlyRate)) {
            throw new IllegalArgumentException("Invalid input data");
        }

        if (emailExists(email)) {
            throw new IllegalArgumentException("Email already exists");
        }

        if (phoneExists(phoneNumber)) {
            throw new IllegalArgumentException("Phone number already exists");
        }

        String id = UUID.randomUUID().toString();
        Tutor tutor = new Tutor(id, fullName, phoneNumber, email, password,
                qualification, specialization, experience, hourlyRate);

        tutorRepository.saveTutor(tutor);

        // Also add to BST for search functionality
        tutorBST.insert(tutor);

        return tutor;
    }

    public Tutor loginTutor(String email, String password) throws IOException {
        if (!isValidEmail(email)) {
            return null;
        }

        Tutor tutor = tutorRepository.getTutorByEmail(email);
        if (tutor != null && tutor.getPassword().equals(password)) {
            return tutor;
        }
        return null;
    }

    public boolean updatePassword(String email, String newPassword) throws IOException {
        Tutor tutor = tutorRepository.getTutorByEmail(email);
        if (tutor != null) {
            tutor.setPassword(newPassword);
            tutorRepository.updateTutor(tutor);
            return true;
        }
        return false;
    }

    public boolean deleteTutor(String tutorId) throws IOException {
        tutorRepository.deleteTutor(tutorId);
        return true;
    }

    public boolean updateTutor(Tutor tutor) throws IOException {
        tutorRepository.updateTutor(tutor);
        return true;
    }

    public List<Tutor> getAllTutors() throws IOException {
        return tutorRepository.getAllTutors();
    }

    public Tutor getTutorById(String tutorId) throws IOException {
        return tutorRepository.getTutorById(tutorId);
    }

    public boolean emailExists(String email) throws IOException {
        return tutorRepository.getTutorByEmail(email) != null;
    }

    public boolean phoneExists(String phoneNumber) throws IOException {
        List<Tutor> tutors = tutorRepository.getAllTutors();
        return tutors.stream()
                .anyMatch(tutor -> tutor.getPhoneNumber().equals(phoneNumber));
    }

    public List<Tutor> getTutorsBySpecialization(String specialization) throws IOException {
        List<Tutor> allTutors = tutorRepository.getAllTutors();
        return allTutors.stream()
                .filter(tutor -> tutor.getSpecialization().toLowerCase()
                        .contains(specialization.toLowerCase()))
                .collect(Collectors.toList());
    }

    private boolean isValidInput(String fullName, String phoneNumber, String email,
                                 String password, String qualification, String specialization,
                                 String experience, double hourlyRate) {
        return isValidName(fullName) &&
                isValidPhone(phoneNumber) &&
                isValidEmail(email) &&
                isValidPassword(password) &&
                isValidQualification(qualification) &&
                isValidSpecialization(specialization) &&
                isValidExperience(experience) &&
                hourlyRate > 0;
    }

    private boolean isValidName(String name) {
        return name != null && name.trim().length() >= 2 && name.trim().length() <= 100;
    }

    private boolean isValidPhone(String phone) {
        return phone != null && PHONE_PATTERN.matcher(phone).matches();
    }

    private boolean isValidEmail(String email) {
        return email != null && EMAIL_PATTERN.matcher(email).matches();
    }

    private boolean isValidPassword(String password) {
        return password != null && password.length() >= 6;
    }

    private boolean isValidQualification(String qualification) {
        return qualification != null && !qualification.trim().isEmpty();
    }

    private boolean isValidSpecialization(String specialization) {
        return specialization != null && !specialization.trim().isEmpty();
    }

    private boolean isValidExperience(String experience) {
        return experience != null && !experience.trim().isEmpty();
    }
}