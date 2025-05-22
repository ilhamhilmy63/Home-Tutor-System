package TutorSearchAndProfileManagement;

import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;

public class Tutor {
    private String id;
    private String name;
    private String email;
    private String phone;
    private String password;
    private String subject;
    private String location;
    private String bio;
    private String expertise;
    private Map<String, String> availability;

    public Tutor(String id, String name, String email, String phone, String password,
                 String subject, String location, String bio, String expertise, String availabilityStr) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.password = password;
        this.subject = subject;
        this.location = location;
        this.bio = bio;
        this.expertise = expertise;
        this.availability = new HashMap<>();
        if (availabilityStr != null && !availabilityStr.isEmpty()) {
            String[] availPairs = availabilityStr.split("\\|");
            for (String pair : availPairs) {
                String[] avail = pair.split(":", 2);
                if (avail.length == 2) {
                    this.availability.put(avail[0].trim(), avail[1].trim());
                }
            }
        }
    }

    // Getters
    public String getId() {
        return id;
    }
    public String getName() {
        return name;
    }
    public String getEmail() {
        return email;
    }
    public String getPhone() {
        return phone;
    }
    public String getPassword() {
        return password;
    }
    public String getSubject() {
        return subject;
    }
    public String getLocation() {
        return location;
    }
    public String getBio() {
        return bio;
    }
    public String getExpertise() {
        return expertise;
    }
    public Map<String, String> getAvailability() {
        return availability;
    }

    // Setters
    public void setId(String id) {
        this.id = id;
    }
    public void setName(String name) {
        this.name = name;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public void setPhone(String phone) {
        this.phone = phone;
    }
    public void setPassword(String password) {
        this.password = password;
    }
    public void setSubject(String subject) {
        this.subject = subject;
    }
    public void setLocation(String location) {
        this.location = location;
    }
    public void setBio(String bio) {
        this.bio = bio;
    }
    public void setExpertise(String expertise) {
        this.expertise = expertise;
    }
    public void setAvailability(Map<String, String> availability) {
        this.availability = availability;
    }

    public String getAvailabilityAsString() {
        return availability.entrySet().stream()
                .map(entry -> entry.getKey() + ":" + entry.getValue())
                .collect(Collectors.joining("|"));
    }
}