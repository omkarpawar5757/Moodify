package com.project.servlet;
import com.project.util.EmailUtil;

import com.project.dao.DBConnection;
import jakarta.servlet.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/register")
@MultipartConfig
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String gender = request.getParameter("gender");
        String dob = request.getParameter("dob");
//        String about = request.getParameter("About");

        Part picPart = request.getPart("profilePic");
        String picName = System.currentTimeMillis() + "_" + picPart.getSubmittedFileName();

        String uploadPath = getServletContext().getRealPath("/uploads");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        picPart.write(uploadPath + File.separator + picName);

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO users(username, phone, password, gender, dob, profile_pic) VALUES (?,?,?,?,?,?)"
            );

            ps.setString(1, username);
            ps.setString(2, phone);
            ps.setString(3, password);
            ps.setString(4, gender);
            ps.setDate(5, java.sql.Date.valueOf(dob));
            ps.setString(6, picName);

            ps.executeUpdate();
            EmailUtil.sendNewUserMail(username, phone, gender, dob);

            response.sendRedirect("index.html");

        } catch (Exception e) {
            String msg = e.getMessage();

            if (msg.contains("users_username_key")) {
                response.getWriter().println("Username already exists. Please choose another.");
            } 
            else if (msg.contains("users_phone_key")) {
                response.getWriter().println("Phone number already registered.");
            } 
            else {
                e.printStackTrace();
                response.getWriter().println("Registration Failed. Try again.");
            }
        }
        }
    }


