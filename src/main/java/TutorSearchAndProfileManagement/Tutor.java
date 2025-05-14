package TutorSearchAndProfileManagement;

import java.util.Map;

public class Tutor extends User {
    private String subject;
    private String location;
    private Map<String, String> availability; // e.g., { "Monday": "2–4 PM" }

    public Tutor(String id, String name, String email, String password,
                 String subject, String location, Map<String, String> availability) {
        super(id, name, email, password);
        this.subject = subject;
        this.location = location;
        this.availability = availability;
    }

    public String getSubject() { return subject; }
    public String getLocation() { return location; }
    public Map<String, String> getAvailability() { return availability; }

    public void setSubject(String subject) { this.subject = subject; }
    public void setLocation(String location) { this.location = location; }
    public void setAvailability(Map<String, String> availability) {
        this.availability = availability;
    }

    @Override
    public void displayProfile() {
        System.out.println("Tutor: " + name + " | Subject: " + subject + " | Location: " + location);
    }
}
