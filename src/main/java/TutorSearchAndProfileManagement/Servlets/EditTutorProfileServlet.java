package TutorSearchAndProfileManagement.Servlets;

import TutorSearchAndProfileManagement.Tutor;
import TutorSearchAndProfileManagement.TutorAvailability;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/editTutor")
public class EditTutorProfileServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String subjects = request.getParameter("subjects");
        String location = request.getParameter("location");
        String bio = request.getParameter("bio");

        Map<String, String> availabilityMap = new HashMap<>();
        for (int i = 0; i < 3; i++) {
            String day = request.getParameter("day" + i);
            String time = request.getParameter("time" + i);
            if (day != null && !day.equals("None") && time != null && !time.isEmpty()) {
                availabilityMap.put(day, time);
            }
        }

        Tutor tutor = new Tutor("", "", "", "", "", "", "", availabilityMap);
        tutor.setName(name);
        tutor.setSubject(subjects);
        tutor.setLocation(location);
        tutor.setBio(bio);
        tutor.setAvailability(availabilityMap);

        // Save to DB or file if needed
        request.setAttribute("tutor", tutor);

        // Convert to availabilityList for display
        List<TutorAvailability> availabilityList = new ArrayList<>();
        for (Map.Entry<String, String> entry : availabilityMap.entrySet()) {
            String[] parts = entry.getValue().split("–|–|-|—"); // handle dash types
            String start = parts.length > 0 ? parts[0].trim() : "";
            String end = parts.length > 1 ? parts[1].trim() : "";
            availabilityList.add(new TutorAvailability(entry.getKey(), start, end));
        }

        request.setAttribute("tutor", tutor);
        request.setAttribute("availabilityList", availabilityList);
        request.setAttribute("message", "Profile updated successfully.");

        request.getRequestDispatcher("view-profile.jsp").forward(request, response);
    }
}
