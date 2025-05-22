package com.example.modules.TutorManagement;

import com.example.models.Schedule;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class ScheduleRepository {
    private static final String FILE_PATH = "C:/Users/Amri/Desktop/Testing000/Final_Test/HomeTutor/target/HomeTutor-1.0-SNAPSHOT/WEB-INF/data/schedules.txt";

    public void saveSchedule(Schedule schedule) throws IOException {
        ensureFileExists();
        try (PrintWriter out = new PrintWriter(new FileWriter(FILE_PATH, true))) {
            out.println(scheduleToString(schedule));
        }
    }

    public List<Schedule> getSchedulesByTutorId(String tutorId) throws IOException {
        ensureFileExists();
        List<Schedule> schedules = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                Schedule schedule = stringToSchedule(line);
                if (schedule.getTutorId().equals(tutorId)) {
                    schedules.add(schedule);
                }
            }
        }
        return schedules;
    }

    public void deleteSchedulesByTutorId(String tutorId) throws IOException {
        List<Schedule> allSchedules = getAllSchedules();
        allSchedules.removeIf(schedule -> schedule.getTutorId().equals(tutorId));
        saveAllSchedules(allSchedules);
    }

    private List<Schedule> getAllSchedules() throws IOException {
        ensureFileExists();
        List<Schedule> schedules = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                schedules.add(stringToSchedule(line));
            }
        }
        return schedules;
    }

    private void saveAllSchedules(List<Schedule> schedules) throws IOException {
        try (PrintWriter out = new PrintWriter(new FileWriter(FILE_PATH, false))) {
            for (Schedule schedule : schedules) {
                out.println(scheduleToString(schedule));
            }
        }
    }

    private String scheduleToString(Schedule schedule) {
        return schedule.getId() + "," + schedule.getTutorId() + "," + schedule.getDay() + "," + schedule.getTimeSlot();
    }

    private Schedule stringToSchedule(String str) {
        String[] parts = str.split(",");
        return new Schedule(parts[0], parts[1], parts[2], parts[3]);
    }

    private void ensureFileExists() throws IOException {
        File file = new File(FILE_PATH);
        if (!file.exists()) {
            file.getParentFile().mkdirs();
            file.createNewFile();
        }
    }
}