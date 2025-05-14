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
import java.io.IOException;

@WebServlet(name = "DashboardServlet", value = "/dashboard")
public class DashboardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // In a real application, you would fetch user data from database
        // For this example, we'll simulate a logged-in user

        HttpSession session = request.getSession();

        // Check if user is logged in (simplified)
        if (session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Set user data (in a real app, this would come from database)
        User user = (User) session.getAttribute("user");

        // Set additional dashboard data based on user role
        if ("tutor".equals(user.getRole())) {
            request.setAttribute("upcomingSessions", 3); // Would come from DB
        } else {
            request.setAttribute("activeTutors", 2); // Would come from DB
        }

        request.getRequestDispatcher("/home.jsp").forward(request, response);
    }
}
