package edu.ucla.cs.cs144;

import java.io.IOException;
import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;

public class SearchServlet extends HttpServlet implements Servlet {
       
    public SearchServlet() {}

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        // your codes here
         try {
            String searchQuery = request.getParameter("q");

            Integer numResultsToSkip = new Integer(request.getParameter("numResultsToSkip"));
            Integer numResultsToReturn = new Integer(request.getParameter("numResultsToReturn"));

            SearchResult[] searchResult = AuctionSearch.basicSearch(
                    searchQuery, numResultsToSkip, numResultsToReturn);

            request.setAttribute("searchResults", searchResult);
            request.getRequestDispatcher("/search.jsp").forward(request, response);

        } catch (Exception e) {
             request.getRequestDispatcher("/searchpage.html").forward(request, response);
        }
    }
}