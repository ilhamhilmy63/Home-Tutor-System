package TutorSearchAndProfileManagement;

import java.io.Serializable;

public class TutorAvailability implements Serializable {
    private String day;
    private String startTime;
    private String endTime;

    public TutorAvailability(String day, String startTime, String endTime) {
        this.day = day;
        this.startTime = startTime;
        this.endTime = endTime;
    }

    public String getDay() {
        return day;
    }

    public void setDay(String day) {
        this.day = day;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    @Override
    public String toString() {
        return day + ": " + startTime + " – " + endTime;
    }

    public String toFileFormat() {
        return day + ":" + startTime + "-" + endTime; // e.g., Monday:14:00-16:00
    }

    public static TutorAvailability fromFileFormat(String data) {
        // e.g., input: Monday:14:00-16:00
        String[] parts = data.split(":");
        if (parts.length == 2) {
            String day = parts[0];
            String[] times = parts[1].split("-");
            if (times.length == 2) {
                return new TutorAvailability(day, times[0], times[1]);
            }
        }
        return null;
    }
}
