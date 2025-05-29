package com.example.modules.TutorManagement;

import com.example.model.Tutor;
import java.util.List;


public class TutorSort {


    public static void sortTutorsByName(List<Tutor> tutors) {
        if (tutors == null || tutors.isEmpty()) {
            return;
        }

        mergeSort(tutors, (t1, t2) -> {
            if (t1.getFullName() == null && t2.getFullName() == null) return 0;
            if (t1.getFullName() == null) return 1;
            if (t2.getFullName() == null) return -1;
            return t1.getFullName().compareToIgnoreCase(t2.getFullName());
        });
    }


    public static void sortTutorsByRate(List<Tutor> tutors) {
        if (tutors == null || tutors.isEmpty()) {
            return;
        }

        mergeSort(tutors, (t1, t2) -> Double.compare(t1.getHourlyRate(), t2.getHourlyRate()));
    }


    public static void sortTutorsByRateDescending(List<Tutor> tutors) {
        if (tutors == null || tutors.isEmpty()) {
            return;
        }

        mergeSort(tutors, (t1, t2) -> Double.compare(t2.getHourlyRate(), t1.getHourlyRate()));
    }


    public static void sortTutorsByExperience(List<Tutor> tutors) {
        if (tutors == null || tutors.isEmpty()) {
            return;
        }

        mergeSort(tutors, (t1, t2) -> {
            int years1 = extractYearsFromExperience(t1.getExperience());
            int years2 = extractYearsFromExperience(t2.getExperience());

            // Sort by experience descending, then by name ascending for ties
            int experienceComparison = Integer.compare(years2, years1);
            if (experienceComparison != 0) {
                return experienceComparison;
            }

            // If experience is the same, sort by name
            if (t1.getFullName() == null && t2.getFullName() == null) return 0;
            if (t1.getFullName() == null) return 1;
            if (t2.getFullName() == null) return -1;
            return t1.getFullName().compareToIgnoreCase(t2.getFullName());
        });
    }


      //Sort tutors by subject expertise (alphabetically by specialization, then by experience)

    public static void sortTutorsBySubjectExpertise(List<Tutor> tutors) {
        if (tutors == null || tutors.isEmpty()) {
            return;
        }

        mergeSort(tutors, (t1, t2) -> {
            // First sort by specialization
            if (t1.getSpecialization() == null && t2.getSpecialization() == null) return 0;
            if (t1.getSpecialization() == null) return 1;
            if (t2.getSpecialization() == null) return -1;

            int specializationComparison = t1.getSpecialization().compareToIgnoreCase(t2.getSpecialization());
            if (specializationComparison != 0) {
                return specializationComparison;
            }

            // If same specialization, sort by experience (descending)
            int years1 = extractYearsFromExperience(t1.getExperience());
            int years2 = extractYearsFromExperience(t2.getExperience());
            return Integer.compare(years2, years1);
        });
    }


      //Sort tutors by qualification level and then by experience

    public static void sortTutorsByQualification(List<Tutor> tutors) {
        if (tutors == null || tutors.isEmpty()) {
            return;
        }

        mergeSort(tutors, (t1, t2) -> {
            int qual1Level = getQualificationLevel(t1.getQualification());
            int qual2Level = getQualificationLevel(t2.getQualification());

            // Sort by qualification level descending (higher qualification first)
            int qualificationComparison = Integer.compare(qual2Level, qual1Level);
            if (qualificationComparison != 0) {
                return qualificationComparison;
            }

            // If qualification level is the same, sort by experience
            int years1 = extractYearsFromExperience(t1.getExperience());
            int years2 = extractYearsFromExperience(t2.getExperience());
            return Integer.compare(years2, years1);
        });
    }

     //Multi-criteria sort: specialization match, then experience, then rate

    public static void sortTutorsByRelevance(List<Tutor> tutors, String preferredSpecialization) {
        if (tutors == null || tutors.isEmpty()) {
            return;
        }

        mergeSort(tutors, (t1, t2) -> {
            // First priority: specialization match
            boolean t1Matches = preferredSpecialization != null &&
                    t1.getSpecialization() != null &&
                    t1.getSpecialization().toLowerCase().contains(preferredSpecialization.toLowerCase());
            boolean t2Matches = preferredSpecialization != null &&
                    t2.getSpecialization() != null &&
                    t2.getSpecialization().toLowerCase().contains(preferredSpecialization.toLowerCase());

            if (t1Matches && !t2Matches) return -1;
            if (!t1Matches && t2Matches) return 1;

            // Second priority: experience (more experienced first)
            int years1 = extractYearsFromExperience(t1.getExperience());
            int years2 = extractYearsFromExperience(t2.getExperience());
            int experienceComparison = Integer.compare(years2, years1);
            if (experienceComparison != 0) {
                return experienceComparison;
            }

            // Third priority: rate (lower rate first for same experience)
            return Double.compare(t1.getHourlyRate(), t2.getHourlyRate());
        });
    }

   // Generic merge sort implementation for Tutor objects

      static void mergeSort(List<Tutor> tutors, TutorComparator comparator) {
        if (tutors.size() <= 1) {
            return;
        }

        int mid = tutors.size() / 2;
        List<Tutor> left = new java.util.ArrayList<>(tutors.subList(0, mid));
        List<Tutor> right = new java.util.ArrayList<>(tutors.subList(mid, tutors.size()));

        mergeSort(left, comparator);
        mergeSort(right, comparator);

        merge(tutors, left, right, comparator);
    }

    private static void merge(List<Tutor> result, List<Tutor> left, List<Tutor> right, TutorComparator comparator) {
        int i = 0, j = 0, k = 0;

        while (i < left.size() && j < right.size()) {
            if (comparator.compare(left.get(i), right.get(j)) <= 0) {
                result.set(k++, left.get(i++));
            } else {
                result.set(k++, right.get(j++));
            }
        }

        while (i < left.size()) {
            result.set(k++, left.get(i++));
        }

        while (j < right.size()) {
            result.set(k++, right.get(j++));
        }
    }

    // Functional interface for tutor comparison

    @FunctionalInterface
    private interface TutorComparator {
        int compare(Tutor t1, Tutor t2);
    }

     //Extract years of experience from experience string

    private static int extractYearsFromExperience(String experience) {
        if (experience == null || experience.isEmpty()) {
            return 0;
        }

        try {
            String cleanedExp = experience.toLowerCase()
                    .replaceAll("[^0-9\\s]", " ")
                    .trim();

            String[] parts = cleanedExp.split("\\s+");
            for (String part : parts) {
                if (part.matches("\\d+")) {
                    int years = Integer.parseInt(part);
                    if (years >= 0 && years <= 50) {
                        return years;
                    }
                }
            }
        } catch (NumberFormatException e) {
            return 0;
        }
        return 0;
    }

     //Get qualification level for sorting

    private static int getQualificationLevel(String qualification) {
        if (qualification == null) {
            return 0;
        }

        String qual = qualification.toLowerCase();

        if (qual.contains("phd") || qual.contains("doctorate") || qual.contains("ph.d")) {
            return 5;
        }
        if (qual.contains("master") || qual.contains("m.s") || qual.contains("m.a") ||
                qual.contains("msc") || qual.contains("ma")) {
            return 4;
        }
        if (qual.contains("bachelor") || qual.contains("b.s") || qual.contains("b.a") ||
                qual.contains("bsc") || qual.contains("ba")) {
            return 3;
        }
        if (qual.contains("associate") || qual.contains("diploma") || qual.contains("certificate")) {
            return 2;
        }
        if (qual.contains("high school") || qual.contains("secondary")) {
            return 1;
        }

        return 0;
    }
}