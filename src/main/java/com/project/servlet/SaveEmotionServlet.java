package com.project.servlet;

import com.project.dao.DBConnection;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class SaveEmotionServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String phone = request.getParameter("phone");
        String emotion = request.getParameter("emotion");

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO emotions(phone, emotion) VALUES (?,?)"
            );

            ps.setString(1, phone);
            ps.setString(2, emotion);

            ps.executeUpdate();
            response.getWriter().println("Emotion Saved");

        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
