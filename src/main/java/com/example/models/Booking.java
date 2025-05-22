package com.example.models;

import java.util.UUID;

public class Booking {
    private String id;
    private String studentId;
    private String tutorId;
    private String subject;
    private String day;
    private String timeSlot;
    private String status; // e.g., "CONFIRMED", "CANCELLED"

    // Constructors
    public Booking() {
        this.id = UUID.randomUUID().toString();
    }

    public Booking(String studentId, String tutorId, String subject, String day, String timeSlot, String status) {
        this.id = UUID.randomUUID().toString();
        this.studentId = studentId;
        this.tutorId = tutorId;
        this.subject = subject;
        this.day = day;
        this.timeSlot = timeSlot;
        this.status = status;
    }

    public Booking(String id, String studentId, String tutorId, String subject, String day, String timeSlot, String status) {
        this.id = id;
        this.studentId = studentId;
        this.tutorId = tutorId;
        this.subject = subject;
        this.day = day;
        this.timeSlot = timeSlot;
        this.status = status;
    }

    // Getters and Setters
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    public String getTutorId() {
        return tutorId;
    }

    public void setTutorId(String tutorId) {
        this.tutorId = tutorId;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Booking{" +
                "id='" + id + '\'' +
                ", studentId='" + studentId + '\'' +
                ", tutorId='" + tutorId + '\'' +
                ", subject='" + subject + '\'' +
                ", day='" + day + '\'' +
                ", timeSlot='" + timeSlot + '\'' +
                ", status='" + status + '\'' +
                '}';
    }
}