package UserManage.Servlets;

import UserManage.User;
import UserManage.UserManagement;
import UserManage.Tutor;
import UserManage.Student;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String role = request.getParameter("role");
        User user;

        if("tutor".equalsIgnoreCase(role)) {
            Tutor tutor = new Tutor(
                    request.getParameter("name"),
                    request.getParameter("email"),
                    request.getParameter("phone"),
                    request.getParameter("password")
            );
            tutor.setPrimarySubject(request.getParameter("primarySubject"));
            tutor.setHourlyRate(Double.parseDouble(request.getParameter("hourlyRate")));
            user = tutor;
        } else {
            user = new Student(
                    request.getParameter("name"),
                    request.getParameter("email"),
                    request.getParameter("phone"),
                    request.getParameter("password")
            );
        }

        if(UserManagement.registerUser(user)) {
            response.sendRedirect(request.getContextPath() + "/auth/login.jsp?success=Registration+Successful");
        } else {
            request.setAttribute("error", "Registration failed. Email might be taken.");
            request.getRequestDispatcher("/auth/register.jsp").forward(request, response);
        }
    }
}
