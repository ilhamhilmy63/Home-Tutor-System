package TutorSearchAndProfileManagement;

import java.util.ArrayList;
import java.util.List;

public class SearchService {
    private static TutorBST tutorBST;

    public SearchService(TutorBST tutorBST) {
        this.tutorBST = tutorBST;
    }

    public static List<Tutor> searchTutors(String keyword, String location, String expertise) {
        List<Tutor> allTutors = tutorBST.getAllTutors();
        List<Tutor> results = new ArrayList<>();

        for (Tutor tutor : allTutors) {
            boolean matchSubject = keyword == null || keyword.isEmpty() ||
                    tutor.getSubject().toLowerCase().contains(keyword.toLowerCase()) ||
                    tutor.getName().toLowerCase().contains(keyword.toLowerCase());
            boolean matchLocation = location == null || location.isEmpty() ||
                    tutor.getLocation().equalsIgnoreCase(location);
            boolean matchExpertise = expertise == null || expertise.isEmpty() ||
                    tutor.getExpertise().equalsIgnoreCase(expertise);

            if (matchSubject && matchLocation && matchExpertise) {
                results.add(tutor);
            }
        }
        return results;
    }
}