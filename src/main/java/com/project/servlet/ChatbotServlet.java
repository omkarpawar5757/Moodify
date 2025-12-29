package com.project.servlet;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;

import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet("/chatbot")
public class ChatbotServlet extends HttpServlet {

    private static final String GROQ_API_KEY = "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";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession();

        String userMessage = request.getParameter("message");
        if (userMessage == null || userMessage.trim().isEmpty()) {
            userMessage = "Hello";
        }

        // Get or create conversation memory
        JSONArray history = (JSONArray) session.getAttribute("history");
        if (history == null) {
            history = new JSONArray();
            history.put(new JSONObject()
                .put("role", "system")
                .put("content", "You are a friendly emotion-aware chatbot.   Give short, conversational replies (2–3 sentences max). Do not give long paragraphs unless the user asks for details and remember the conversation."));
        }

        // Add user message
        history.put(new JSONObject()
            .put("role", "user")
            .put("content", userMessage));

        String reply = callGroq(history);

        // Add assistant reply
        history.put(new JSONObject()
            .put("role", "assistant")
            .put("content", reply));

        session.setAttribute("history", history);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(
            new JSONObject().put("reply", reply).toString()
        );
    }

    private String callGroq(JSONArray history) throws IOException {

        URL url = new URL("https://api.groq.com/openai/v1/chat/completions");
        HttpURLConnection con = (HttpURLConnection) url.openConnection();

        con.setRequestMethod("POST");
        con.setRequestProperty("Content-Type", "application/json");
        con.setRequestProperty("Authorization", "Bearer " + GROQ_API_KEY);
        con.setDoOutput(true);

        JSONObject body = new JSONObject();
        body.put("model", "llama-3.1-8b-instant");
        body.put("messages", history);

        try (OutputStream os = con.getOutputStream()) {
            os.write(body.toString().getBytes());
        }

        InputStream stream = con.getResponseCode() >= 200 && con.getResponseCode() < 300
                ? con.getInputStream()
                : con.getErrorStream();

        BufferedReader br = new BufferedReader(new InputStreamReader(stream));
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = br.readLine()) != null) {
            sb.append(line);
        }

        String raw = sb.toString();
        System.out.println("Groq raw: " + raw);

        JSONObject json = new JSONObject(raw);
        return json.getJSONArray("choices")
                   .getJSONObject(0)
                   .getJSONObject("message")
                   .getString("content");
    }
}
