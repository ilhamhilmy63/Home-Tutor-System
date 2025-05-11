package TutorSearchAndProfileManagement;

import java.util.ArrayList;
import java.util.List;

public class SearchService {

    public static List<Tutor> searchTutors(String keyword, String location) {
        List<Tutor> results = new ArrayList<>();
        for (Tutor tutor : TutorDataStore.getAllTutors()) {
            boolean matchSubject = tutor.getSubject().toLowerCase().contains(keyword.toLowerCase());
            boolean matchLocation = location == null || tutor.getLocation().equalsIgnoreCase(location);

            if (matchSubject && matchLocation) {
                results.add(tutor);
            }
        }
        return results;
    }
}
