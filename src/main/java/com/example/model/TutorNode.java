package com.example.model;

public class TutorNode {
    private Tutor tutor;
    private TutorNode left;
    private TutorNode right;

    public TutorNode(Tutor tutor) {
        this.tutor = tutor;
        this.left = null;
        this.right = null;
    }

    // Getters and setters
    public Tutor getTutor() {
        return tutor;
    }

    public TutorNode getLeft() {
        return left;
    }

    public void setLeft(TutorNode left) {
        this.left = left;
    }

    public TutorNode getRight() {
        return right;
    }

    public void setRight(TutorNode right) {
        this.right = right;
    }
}
