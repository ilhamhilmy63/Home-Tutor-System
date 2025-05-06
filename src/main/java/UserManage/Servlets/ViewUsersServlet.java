package UserManage.Servlets;

import UserManage.User;
import UserManage.UserManagement;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/viewUsers")
public class ViewUsersServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get all registered users
        List<User> users = UserManagement.getAllUsers();

        // Set users in request attribute
        request.setAttribute("users", users);

        // Forward to view page
        RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/viewUsers.jsp");
        dispatcher.forward(request, response);
    }
}