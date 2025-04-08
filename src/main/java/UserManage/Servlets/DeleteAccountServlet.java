package UserManage.Servlets;

import UserManage.User;
import UserManage.UserManagement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import jakarta.servlet.http.HttpSession;

@WebServlet("/delete-account")
public class DeleteAccountServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if(user != null) {
            if(UserManagement.deleteUser(user.getEmail())) {
                session.invalidate();
                response.sendRedirect(request.getContextPath() + "/auth/login.jsp?success=Account+Deleted");
            } else {
                response.sendRedirect("user/delete.jsp?error=Deletion+Failed");
            }
        } else {
            response.sendRedirect("auth/login.jsp");
        }
    }
}

