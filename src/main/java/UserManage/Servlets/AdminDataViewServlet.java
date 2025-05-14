package UserManage.Servlets;

import UserManage.User;
import UserManage.UserManagement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.ArrayList;

@WebServlet("/admin/view-data")
public class AdminDataViewServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // Check if user is admin
        if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/auth/login.jsp?error=Unauthorized+access");
            return;
        }

        // Handle export requests
        String exportType = request.getParameter("export");
        if (exportType != null) {
            handleExportRequest(response, exportType);
            return;
        }

        // Get all users
        List<User> allUsers = UserManagement.getAllUsers();
        List<User> tutors = new ArrayList<>();
        List<User> students = new ArrayList<>();
        List<User> admins = new ArrayList<>();

        // Categorize users
        for (User u : allUsers) {
            if ("tutor".equalsIgnoreCase(u.getRole())) {
                tutors.add(u);
            } else if ("admin".equalsIgnoreCase(u.getRole())) {
                admins.add(u);
            } else {
                students.add(u);
            }
        }

        // Set attributes for the view
        request.setAttribute("totalUsers", allUsers.size());
        request.setAttribute("totalTutors", tutors.size());
        request.setAttribute("totalStudents", students.size());
        request.setAttribute("totalAdmins", admins.size());
        request.setAttribute("allUsers", allUsers);
        request.setAttribute("tutors", tutors);
        request.setAttribute("students", students);
        request.setAttribute("admins", admins);

        // Forward to admin view page
        request.getRequestDispatcher("/admin/data-view.jsp").forward(request, response);
    }

    private void handleExportRequest(HttpServletResponse response, String exportType)
            throws IOException {
        response.setContentType("text/plain");
        response.setHeader("Content-Disposition", "attachment; filename=users_export." + exportType);

        try (PrintWriter out = response.getWriter()) {
            List<User> allUsers = UserManagement.getAllUsers();

            if ("csv".equalsIgnoreCase(exportType)) {
                exportAsCsv(out, allUsers);
            } else {
                exportAsText(out, allUsers);
            }
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Export failed: " + e.getMessage());
        }
    }

    private void exportAsCsv(PrintWriter out, List<User> users) {
        out.println("Name,Email,Phone,Role");
        for (User user : users) {
            out.println(String.format("\"%s\",\"%s\",\"%s\",\"%s\"",
                    user.getName(),
                    user.getEmail(),
                    user.getPhone(),
                    user.getRole()));
        }
    }

    private void exportAsText(PrintWriter out, List<User> users) {
        out.println("=== User Data Export ===");
        out.println("Total Users: " + users.size());

        out.println("\n=== User List ===");
        for (User user : users) {
            out.println(String.format("- %s (%s) - %s | Role: %s",
                    user.getName(),
                    user.getEmail(),
                    user.getPhone(),
                    user.getRole()));
        }
    }
}