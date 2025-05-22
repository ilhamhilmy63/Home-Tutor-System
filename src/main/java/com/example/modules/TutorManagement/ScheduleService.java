package com.example.modules.TutorManagement;

import com.example.models.Schedule;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class ScheduleService {
    private final ScheduleRepository scheduleRepository = new ScheduleRepository();

    public void createSchedules(String tutorId, String[] days, String[] timeSlots) throws IOException {
        // Delete existing schedules for the tutor
        scheduleRepository.deleteSchedulesByTutorId(tutorId);

        // Create new schedules for each day-timeSlot combination
        for (String day : days) {
            for (String timeSlot : timeSlots) {
                Schedule schedule = new Schedule(tutorId, day, timeSlot);
                scheduleRepository.saveSchedule(schedule);
            }
        }
    }

    public List<Schedule> getTutorSchedules(String tutorId) throws IOException {
        return scheduleRepository.getSchedulesByTutorId(tutorId);
    }
}