package edu.ucla.cs.cs144;

import java.io.IOException;
import java.net.HttpURLConnection;
import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.URL;
import java.net.URLEncoder;


public class ProxyServlet extends HttpServlet implements Servlet {
       
    public ProxyServlet() {}

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        // your codes here
        try 
        {
            PrintWriter out = response.getWriter();
            String query = request.getParameter("query");

            //connect
            URL url = new URL("http://google.com/complete/search?output=toolbar&q=" + URLEncoder.encode(query, "UTF-8"));
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Accept-Charset", "UTF-8");
            conn.setRequestProperty("Content-type", "text/xml");
            StringBuffer content = new StringBuffer();

            //read from the connection input stream
            BufferedReader suggestBuffer = new BufferedReader(
                    new InputStreamReader(conn.getInputStream()));
            String data;

            //read into content string
            while ((data = suggestBuffer.readLine()) != null) {
                content.append(data + "\n");
            }

            //wrap up connection and write content
            conn.disconnect();
            response.setContentType("text/xml;charset=UTF-8");
            out.write(content.toString());
        } catch (Exception e) {
            response.sendRedirect("/error.html");
        }
    }
}
