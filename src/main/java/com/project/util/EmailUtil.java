package com.project.util;

import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;

public class EmailUtil {

    private static final String FROM = "omkarshivrajpawar@gmail.com";   // your Gmail
    private static final String APP_PASS = "lqlyvvlxzxjzaxrg";

    public static void sendNewUserMail(String username, String phone, String gender, String dob) {
        try {
            Properties props = new Properties();
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");

            Session session = Session.getInstance(props,
                new Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(FROM, APP_PASS);
                    }
                }
            );

            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(FROM));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(FROM));
            msg.setSubject("🎉 New User Registered on Emotion Music Project");

            String html = 
                "<h2 style='color:#4CAF50;'>New User Registration Alert</h2>" +
                "<p>Hello Omkar 👋,</p>" +
                "<p>A new user has registered on your <b>Emotion Music Project</b>.</p>" +

                "<table border='1' cellpadding='10'>" +
                "<tr><th>Username</th><td>" + username + "</td></tr>" +
                "<tr><th>Phone</th><td>" + phone + "</td></tr>" +
                "<tr><th>Gender</th><td>" + gender + "</td></tr>" +
                "<tr><th>DOB</th><td>" + dob + "</td></tr>" +
                "</table>" +

                "<br><p>Emotion Music System is running successfully 🚀</p>" +
                "<p>Regards,<br><b>Emotion Music AI</b></p>";

            msg.setContent(html, "text/html");

            Transport.send(msg);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}