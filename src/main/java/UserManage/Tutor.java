package UserManage;

import java.util.ArrayList;
import java.util.List;

public class Tutor extends User {
    private String primarySubject;
    private List<String> secondarySubjects = new ArrayList<>();
    private double hourlyRate;
    private String qualification;

    public Tutor() {
        setRole("tutor");
    }

    public Tutor(String name, String email, String phone, String password) {
        super(name, email, phone, password, "tutor");
    }

    // Getters and setters
    public String getPrimarySubject() { return primarySubject; }
    public void setPrimarySubject(String primarySubject) { this.primarySubject = primarySubject; }
    public List<String> getSecondarySubjects() { return secondarySubjects; }
    public void setSecondarySubjects(List<String> secondarySubjects) { this.secondarySubjects = secondarySubjects; }
    public double getHourlyRate() { return hourlyRate; }
    public void setHourlyRate(double hourlyRate) { this.hourlyRate = hourlyRate; }
    public String getQualification() { return qualification; }
    public void setQualification(String qualification) { this.qualification = qualification; }
}