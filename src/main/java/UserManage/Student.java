package UserManage;

public class Student extends User {
    public Student (){
        super();
        setRole("student");
    }

    public Student (String name, String email, String phone, String password) {
        super (name,email,phone,password,"student");
    }
}