package UserManage.Servlets;

import UserManage.User;
import UserManage.UserManagement;
import UserManage.Admin;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import jakarta.servlet.http.HttpSession;


@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User user = UserManagement.getUserByEmail(email);

        if(user != null && user.getPassword().equals(password)) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            if(user instanceof Admin) {
                response.sendRedirect("admin/dashboard.jsp");
            } else {
                response.sendRedirect("user/dashboard.jsp");
            }
        } else {
            request.setAttribute("error", "Invalid credentials");
            request.getRequestDispatcher("/auth/login.jsp").forward(request, response);
        }
    }
}