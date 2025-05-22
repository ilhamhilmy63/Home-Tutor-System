package com.example.models;

import java.util.UUID;

public class Schedule {
    private String id;
    private String tutorId;
    private String day; // Monday, Tuesday, ..., Saturday
    private String timeSlot; // 8:00am-10:00am, 10:00am-12:00pm, 2:00pm-4:00pm, 4:00pm-6:00pm

    // Constructors
    public Schedule() {
        this.id = UUID.randomUUID().toString();
    }

    public Schedule(String tutorId, String day, String timeSlot) {
        this.id = UUID.randomUUID().toString();
        this.tutorId = tutorId;
        this.day = day;
        this.timeSlot = timeSlot;
    }

    public Schedule(String id, String tutorId, String day, String timeSlot) {
        this.id = id;
        this.tutorId = tutorId;
        this.day = day;
        this.timeSlot = timeSlot;
    }

    // Getters and Setters
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTutorId() {
        return tutorId;
    }

    public void setTutorId(String tutorId) {
        this.tutorId = tutorId;
    }

    public String getDay() {
        return day;
    }

    public void setDay(String day) {
        this.day = day;
    }

    public String getTimeSlot() {
        return timeSlot;
    }

    public void setTimeSlot(String timeSlot) {
        this.timeSlot = timeSlot;
    }

    @Override
    public String toString() {
        return "Schedule{" +
                "id='" + id + '\'' +
                ", tutorId='" + tutorId + '\'' +
                ", day='" + day + '\'' +
                ", timeSlot='" + timeSlot + '\'' +
                '}';
    }
}