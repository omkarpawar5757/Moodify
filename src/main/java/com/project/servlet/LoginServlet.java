package com.project.servlet;

import com.project.dao.DBConnection;
import jakarta.servlet.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
@WebServlet("/login")
@MultipartConfig
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String phone = request.getParameter("phone");
        String password = request.getParameter("password");

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM users WHERE phone=? AND password=?"
            );

            ps.setString(1, phone);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                HttpSession session = request.getSession();

                session.setAttribute("userId", rs.getInt("id"));
                session.setAttribute("username", rs.getString("username"));
                session.setAttribute("phone", rs.getString("phone")); // ✅ ADD THIS
                session.setAttribute("profilePic", rs.getString("profile_pic"));

                response.sendRedirect("home.jsp");
            }
 else {
                response.getWriter().println("Invalid Login");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
