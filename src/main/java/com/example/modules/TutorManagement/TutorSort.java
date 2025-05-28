package com.example.modules.TutorManagement;

import com.example.model.Tutor;
import java.util.List;
import java.util.Collections;
import java.util.Comparator;

/**
 * Utility class for sorting tutors based on different criteria
 */
public class TutorSort {

    /**
     * Sort tutors by name (alphabetically, ascending)
     */
    public static void sortTutorsByName(List<Tutor> tutors) {
        if (tutors == null || tutors.isEmpty()) {
            return;
        }

        Collections.sort(tutors, new Comparator<Tutor>() {
            @Override
            public int compare(Tutor t1, Tutor t2) {
                if (t1.getFullName() == null && t2.getFullName() == null) {
                    return 0;
                }
                if (t1.getFullName() == null) {
                    return 1;
                }
                if (t2.getFullName() == null) {
                    return -1;
                }
                return t1.getFullName().compareToIgnoreCase(t2.getFullName());
            }
        });
    }

    /**
     * Sort tutors by hourly rate (ascending - low to high)
     */
    public static void sortTutorsByRate(List<Tutor> tutors) {
        if (tutors == null || tutors.isEmpty()) {
            return;
        }

        Collections.sort(tutors, new Comparator<Tutor>() {
            @Override
            public int compare(Tutor t1, Tutor t2) {
                return Double.compare(t1.getHourlyRate(), t2.getHourlyRate());
            }
        });
    }

    /**
     * Sort tutors by hourly rate (descending - high to low)
     */
    public static void sortTutorsByRateDescending(List<Tutor> tutors) {
        if (tutors == null || tutors.isEmpty()) {
            return;
        }

        Collections.sort(tutors, new Comparator<Tutor>() {
            @Override
            public int compare(Tutor t1, Tutor t2) {
                return Double.compare(t2.getHourlyRate(), t1.getHourlyRate());
            }
        });
    }

    /**
     * Sort tutors by experience (descending - most experienced first)
     */
    public static void sortTutorsByExperience(List<Tutor> tutors) {
        if (tutors == null || tutors.isEmpty()) {
            return;
        }

        Collections.sort(tutors, new Comparator<Tutor>() {
            @Override
            public int compare(Tutor t1, Tutor t2) {
                int years1 = extractYearsFromExperience(t1.getExperience());
                int years2 = extractYearsFromExperience(t2.getExperience());

                // Sort by experience descending, then by name ascending for ties
                int experienceComparison = Integer.compare(years2, years1);
                if (experienceComparison != 0) {
                    return experienceComparison;
                }

                // If experience is the same, sort by name
                if (t1.getFullName() == null && t2.getFullName() == null) {
                    return 0;
                }
                if (t1.getFullName() == null) {
                    return 1;
                }
                if (t2.getFullName() == null) {
                    return -1;
                }
                return t1.getFullName().compareToIgnoreCase(t2.getFullName());
            }
        });
    }

    /**
     * Sort tutors by specialization (alphabetically)
     */
    public static void sortTutorsBySpecialization(List<Tutor> tutors) {
        if (tutors == null || tutors.isEmpty()) {
            return;
        }

        Collections.sort(tutors, new Comparator<Tutor>() {
            @Override
            public int compare(Tutor t1, Tutor t2) {
                if (t1.getSpecialization() == null && t2.getSpecialization() == null) {
                    return 0;
                }
                if (t1.getSpecialization() == null) {
                    return 1;
                }
                if (t2.getSpecialization() == null) {
                    return -1;
                }

                int specializationComparison = t1.getSpecialization().compareToIgnoreCase(t2.getSpecialization());
                if (specializationComparison != 0) {
                    return specializationComparison;
                }

                // If specialization is the same, sort by name
                if (t1.getFullName() == null && t2.getFullName() == null) {
                    return 0;
                }
                if (t1.getFullName() == null) {
                    return 1;
                }
                if (t2.getFullName() == null) {
                    return -1;
                }
                return t1.getFullName().compareToIgnoreCase(t2.getFullName());
            }
        });
    }

    /**
     * Sort tutors by qualification level and then by experience
     */
    public static void sortTutorsByQualification(List<Tutor> tutors) {
        if (tutors == null || tutors.isEmpty()) {
            return;
        }

        Collections.sort(tutors, new Comparator<Tutor>() {
            @Override
            public int compare(Tutor t1, Tutor t2) {
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
            }
        });
    }

    /**
     * Multi-criteria sort: specialization match, then experience, then rate
     */
    public static void sortTutorsByRelevance(List<Tutor> tutors, String preferredSpecialization) {
        if (tutors == null || tutors.isEmpty()) {
            return;
        }

        Collections.sort(tutors, new Comparator<Tutor>() {
            @Override
            public int compare(Tutor t1, Tutor t2) {
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
            }
        });
    }

    /**
     * Extract years of experience from experience string
     * Examples: "5 years", "2 Years Experience", "10+ years" -> extracts the number
     */
    private static int extractYearsFromExperience(String experience) {
        if (experience == null || experience.isEmpty()) {
            return 0;
        }

        try {
            // Remove common words and extract numbers
            String cleanedExp = experience.toLowerCase()
                    .replaceAll("[^0-9\\s]", " ")
                    .trim();

            String[] parts = cleanedExp.split("\\s+");
            for (String part : parts) {
                if (part.matches("\\d+")) {
                    int years = Integer.parseInt(part);
                    // Reasonable bounds check (0-50 years)
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

    /**
     * Get qualification level for sorting
     * Higher number = higher qualification
     */
    private static int getQualificationLevel(String qualification) {
        if (qualification == null) {
            return 0;
        }

        String qual = qualification.toLowerCase();

        // PhD/Doctorate level
        if (qual.contains("phd") || qual.contains("doctorate") || qual.contains("ph.d")) {
            return 5;
        }
        // Master's level
        if (qual.contains("master") || qual.contains("m.s") || qual.contains("m.a") ||
                qual.contains("msc") || qual.contains("ma")) {
            return 4;
        }
        // Bachelor's level
        if (qual.contains("bachelor") || qual.contains("b.s") || qual.contains("b.a") ||
                qual.contains("bsc") || qual.contains("ba")) {
            return 3;
        }
        // Associate/Diploma level
        if (qual.contains("associate") || qual.contains("diploma") || qual.contains("certificate")) {
            return 2;
        }
        // High school/Other
        if (qual.contains("high school") || qual.contains("secondary")) {
            return 1;
        }

        return 0; // Unknown qualification
    }
}