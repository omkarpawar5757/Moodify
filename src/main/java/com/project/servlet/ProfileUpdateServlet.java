package com.project.servlet;

import com.project.dao.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/updateProfile")
@MultipartConfig
public class ProfileUpdateServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("index.html");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        String username = request.getParameter("username");

        Part filePart = request.getPart("profilePic");
        String fileName = filePart != null ? filePart.getSubmittedFileName() : null;

        String savedFileName = null;

        if (fileName != null && !fileName.isEmpty()) {
            String uploadPath = getServletContext().getRealPath("/uploads");
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            savedFileName = System.currentTimeMillis() + "_" + fileName;
            filePart.write(uploadPath + File.separator + savedFileName);
        }

        try (Connection con = DBConnection.getConnection()) {

            PreparedStatement ps;

            if (savedFileName != null) {
                ps = con.prepareStatement(
                        "UPDATE users SET username=?, profile_pic=? WHERE id=?");
                ps.setString(1, username);
                ps.setString(2, savedFileName);
                ps.setInt(3, userId);

                session.setAttribute("profilePic", savedFileName);
            } else {
                ps = con.prepareStatement(
                        "UPDATE users SET username=? WHERE id=?");
                ps.setString(1, username);
                ps.setInt(2, userId);
            }

            ps.executeUpdate();
            session.setAttribute("username", username);

            response.sendRedirect("home.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Profile update failed");
        }
    }
}
