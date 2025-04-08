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

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if(user == null) {
            response.sendRedirect("auth/login.jsp");
            return;
        }

        String newPassword = request.getParameter("newPassword");
        user.setPassword(newPassword);

        if(UserManagement.updateUser(user)) {
            session.setAttribute("user", user);
            response.sendRedirect("user/profile.jsp?success=Password+Updated");
        } else {
            response.sendRedirect("user/profile.jsp?error=Update+Failed");
        }
    }
}
