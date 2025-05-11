package TutorSearchAndProfileManagement;

public class User {
    protected String id;
    protected String name;
    protected String email;
    protected String password;

    public User(String id, String name, String email, String password) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.password = password;
    }

    public String getId() { return id; }
    public String getName() { return name; }
    public String getEmail() { return email; }
    public String getPassword() { return password; }

    public void setEmail(String email) { this.email = email; }
    public void setPassword(String password) { this.password = password; }

    public void displayProfile() {
        System.out.println("User: " + name);
    }
}
