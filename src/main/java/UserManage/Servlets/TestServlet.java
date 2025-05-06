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

@WebServlet("/test")
public class TestServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        resp.getWriter().println("Server is working!");
    }
}
