package UserManage;

public class Admin extends User {
    public Admin(){
        super();
        setRole("admin");
    }

    public Admin(String name,String email,String phone,String password){
        super(name,email,phone,password,"Admin");
    }

    //Additional admin-specification methods can be added here
    public void disableUser(User user){
        //Implementation to disable user
    }

    public void enableUser(User user){
        //Implementation to enable user
    }
}
