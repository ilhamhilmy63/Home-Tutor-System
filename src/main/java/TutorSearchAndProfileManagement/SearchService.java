package TutorSearchAndProfileManagement;

import java.util.ArrayList;
import java.util.List;

public class SearchService {

    public static List<Tutor> searchTutors(String keyword, String location) {
        List<Tutor> results = new ArrayList<>();

        for (Tutor tutor : TutorDataStore.getAllTutors()) {
            boolean matchSubject = tutor.getSubject().toLowerCase().contains(keyword.toLowerCase());
            boolean matchLocation = (location == null || location.isEmpty()) ||
                    tutor.getLocation().equalsIgnoreCase(location);

            if (matchSubject && matchLocation) {
                results.add(tutor);
            }
        }

        return mergeSort(results);
    }

    // Merge Sort based on subject expertise
    private static List<Tutor> mergeSort(List<Tutor> tutors) {
        if (tutors.size() <= 1) return tutors;

        int mid = tutors.size() / 2;
        List<Tutor> left = mergeSort(tutors.subList(0, mid));
        List<Tutor> right = mergeSort(tutors.subList(mid, tutors.size()));

        return merge(left, right);
    }

    private static List<Tutor> merge(List<Tutor> left, List<Tutor> right) {
        List<Tutor> merged = new ArrayList<>();
        int i = 0, j = 0;

        while (i < left.size() && j < right.size()) {
            if (left.get(i).getSubject().compareToIgnoreCase(right.get(j).getSubject()) <= 0) {
                merged.add(left.get(i));
                i++;
            } else {
                merged.add(right.get(j));
                j++;
            }
        }

        while (i < left.size()) {
            merged.add(left.get(i));
            i++;
        }

        while (j < right.size()) {
            merged.add(right.get(j));
            j++;
        }

        return merged;
    }
}
