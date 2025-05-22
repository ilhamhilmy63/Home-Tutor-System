package com.example.modules.BookingManagement;

import com.example.models.Tutor;
import com.example.models.User;
import com.example.models.Schedule;
import com.example.models.Booking;
import com.example.modules.TutorManagement.TutorRepository;
import com.example.modules.TutorManagement.ScheduleRepository;
import com.example.modules.UserManagement.UserRepository;
import java.io.IOException;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.locks.ReentrantLock;
import java.util.stream.Collectors;

public class BookingService {
    private final TutorRepository tutorRepository = new TutorRepository();
    private final ScheduleRepository scheduleRepository = new ScheduleRepository();
    private final BookingRepository bookingRepository = new BookingRepository();
    private final UserRepository userRepository = new UserRepository();
    private final Map<String, ReentrantLock> locks = new ConcurrentHashMap<>();

    public List<Tutor> getTutorsBySubject(String subject) throws IOException {
        return tutorRepository.getAllTutors().stream()
                .filter(tutor -> tutor.getSubject().equals(subject))
                .collect(Collectors.toList());
    }

    public List<String> getAvailableDaysForTutor(String tutorId) throws IOException {
        List<Schedule> schedules = scheduleRepository.getSchedulesByTutorId(tutorId);
        System.out.println("Schedules for tutorId " + tutorId + ": " + schedules);
        return schedules.stream()
                .map(Schedule::getDay)
                .distinct()
                .collect(Collectors.toList());
    }

    public List<String> getAvailableTimeSlotsForTutorAndDay(String tutorId, String day) throws IOException {
        List<String> scheduledTimeSlots = scheduleRepository.getSchedulesByTutorId(tutorId).stream()
                .filter(schedule -> schedule.getDay().equals(day))
                .map(Schedule::getTimeSlot)
                .collect(Collectors.toList());

        List<String> bookedTimeSlots = bookingRepository.getBookingsByTutorIdAndDay(tutorId, day).stream()
                .map(Booking::getTimeSlot)
                .collect(Collectors.toList());

        return scheduledTimeSlots.stream()
                .filter(timeSlot -> !bookedTimeSlots.contains(timeSlot))
                .collect(Collectors.toList());
    }

    public void createBooking(String studentId, String tutorId, String subject, String day, String timeSlot) throws IOException {
        ReentrantLock lock = locks.computeIfAbsent(tutorId, k -> new ReentrantLock());
        lock.lock();
        try {
            if (bookingRepository.hasConflictingBooking(studentId, day, timeSlot)) {
                throw new IOException("You already have a booking for this time slot");
            }
            List<String> availableSlots = getAvailableTimeSlotsForTutorAndDay(tutorId, day);
            if (!availableSlots.contains(timeSlot)) {
                throw new IOException("Time slot no longer available");
            }
            Booking booking = new Booking(studentId, tutorId, subject, day, timeSlot, "CONFIRMED");
            bookingRepository.saveBooking(booking);
        } finally {
            lock.unlock();
        }
    }

    public List<String> getAllSubjects() {
        return Arrays.asList("Physics", "Chemistry", "Maths", "IT", "Biology");
    }

    public List<Map<String, String>> getStudentBookingsWithTutorName(String studentId) throws IOException {
        List<Booking> bookings = bookingRepository.getBookingsByStudentId(studentId);
        List<Map<String, String>> bookingDetails = new ArrayList<>();
        for (Booking booking : bookings) {
            Tutor tutor = tutorRepository.getAllTutors().stream()
                    .filter(t -> t.getId().equals(booking.getTutorId()))
                    .findFirst()
                    .orElse(null);
            Map<String, String> details = new HashMap<>();
            details.put("bookingId", booking.getId());
            details.put("tutorName", tutor != null ? tutor.getName() : "Unknown");
            details.put("subject", booking.getSubject());
            details.put("day", booking.getDay());
            details.put("timeSlot", booking.getTimeSlot());
            details.put("status", booking.getStatus());
            bookingDetails.add(details);
        }
        return bookingDetails;
    }

    public List<Map<String, String>> getTutorBookingsWithStudentDetails(String tutorId) throws IOException {
        List<Booking> bookings = bookingRepository.getBookingsByTutorId(tutorId);
        List<Map<String, String>> bookingDetails = new ArrayList<>();
        for (Booking booking : bookings) {
            User student = userRepository.getAllUsers().stream()
                    .filter(u -> u.getId().equals(booking.getStudentId()))
                    .findFirst()
                    .orElse(null);
            Map<String, String> details = new HashMap<>();
            details.put("bookingId", booking.getId());
            details.put("studentName", student != null ? student.getName() : "Unknown");
            details.put("studentEmail", student != null ? student.getEmail() : "Unknown");
            details.put("subject", booking.getSubject());
            details.put("day", booking.getDay());
            details.put("timeSlot", booking.getTimeSlot());
            details.put("status", booking.getStatus());
            bookingDetails.add(details);
        }
        return bookingDetails;
    }
}