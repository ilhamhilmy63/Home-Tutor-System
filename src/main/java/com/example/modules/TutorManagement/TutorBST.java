package com.example.modules.TutorManagement;

import com.example.model.Tutor;
import com.example.model.TutorNode;
import java.util.ArrayList;
import java.util.List;

public class TutorBST {
    private TutorNode root;

    public TutorBST() {
        this.root = null;
    }

    public void insert(Tutor tutor) {
        root = insertRec(root, tutor);
    }

    private TutorNode insertRec(TutorNode root, Tutor tutor) {
        if (root == null) {
            root = new TutorNode(tutor);
            return root;
        }

        // Compare by name (you can change the comparison criteria)
        if (tutor.getFullName().compareToIgnoreCase(root.getTutor().getFullName()) < 0) {
            root.setLeft(insertRec(root.getLeft(), tutor));
        } else if (tutor.getFullName().compareToIgnoreCase(root.getTutor().getFullName()) > 0) {
            root.setRight(insertRec(root.getRight(), tutor));
        }

        return root;
    }

    public List<Tutor> inOrderTraversal() {
        List<Tutor> tutors = new ArrayList<>();
        inOrderRec(root, tutors);
        return tutors;
    }

    private void inOrderRec(TutorNode root, List<Tutor> tutors) {
        if (root != null) {
            inOrderRec(root.getLeft(), tutors);
            tutors.add(root.getTutor());
            inOrderRec(root.getRight(), tutors);
        }
    }

    public List<Tutor> searchBySpecialization(String specialization) {
        List<Tutor> allTutors = inOrderTraversal();
        List<Tutor> result = new ArrayList<>();

        for (Tutor tutor : allTutors) {
            if (tutor.getSpecialization().equalsIgnoreCase(specialization)) {
                result.add(tutor);
            }
        }

        return result;
    }
}
