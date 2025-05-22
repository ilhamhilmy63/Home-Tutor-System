package TutorSearchAndProfileManagement;

import java.util.*;

public class Subject {
    private static Map<String, List<Tutor>> subjectTutorMap = new HashMap<>();

    public static void associateTutor(String subject, Tutor tutor) {
        subjectTutorMap.computeIfAbsent(subject.toLowerCase(), k -> new ArrayList<>()).add(tutor);
    }

    public static List<Tutor> getTutorsBySubject(String subject) {
        return subjectTutorMap.getOrDefault(subject.toLowerCase(), new ArrayList<>());
    }
}
