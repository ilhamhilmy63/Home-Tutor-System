package com.example.modules.BookingManagement;

import com.example.models.Booking;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class BookingRepository {
    private static final String FILE_PATH = "C:/Users/share/Desktop/HomeTutor/src/main/webapp/WEB-INF/data/bookings.txt";

    public void saveBooking(Booking booking) throws IOException {
        ensureFileExists();
        try (PrintWriter out = new PrintWriter(new FileWriter(FILE_PATH, true))) {
            out.println(bookingToString(booking));
        }
    }

    public List<Booking> getBookingsByTutorIdAndDay(String tutorId, String day) throws IOException {
        ensureFileExists();
        List<Booking> bookings = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                Booking booking = stringToBooking(line);
                if (booking.getTutorId().equals(tutorId) && booking.getDay().equals(day) && booking.getStatus().equals("CONFIRMED")) {
                    bookings.add(booking);
                }
            }
        }
        return bookings;
    }

    public List<Booking> getBookingsByStudentId(String studentId) throws IOException {
        ensureFileExists();
        List<Booking> bookings = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                Booking booking = stringToBooking(line);
                if (booking.getStudentId().equals(studentId) && booking.getStatus().equals("CONFIRMED")) {
                    bookings.add(booking);
                }
            }
        }
        return bookings;
    }

    public List<Booking> getBookingsByTutorId(String tutorId) throws IOException {
        ensureFileExists();
        List<Booking> bookings = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                Booking booking = stringToBooking(line);
                if (booking.getTutorId().equals(tutorId) && booking.getStatus().equals("CONFIRMED")) {
                    bookings.add(booking);
                }
            }
        }
        return bookings;
    }

    public boolean hasConflictingBooking(String studentId, String day, String timeSlot) throws IOException {
        ensureFileExists();
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                Booking booking = stringToBooking(line);
                if (booking.getStudentId().equals(studentId) &&
                        booking.getDay().equals(day) &&
                        booking.getTimeSlot().equals(timeSlot) &&
                        booking.getStatus().equals("CONFIRMED")) {
                    return true;
                }
            }
        }
        return false;
    }

    private String bookingToString(Booking booking) {
        return booking.getId() + "," + booking.getStudentId() + "," + booking.getTutorId() + "," +
                booking.getSubject() + "," + booking.getDay() + "," + booking.getTimeSlot() + "," + booking.getStatus();
    }

    private Booking stringToBooking(String str) {
        String[] parts = str.split(",");
        return new Booking(parts[0], parts[1], parts[2], parts[3], parts[4], parts[5], parts[6]);
    }

    private void ensureFileExists() throws IOException {
        File file = new File(FILE_PATH);
        if (!file.exists()) {
            file.getParentFile().mkdirs();
            file.createNewFile();
        }
    }
}