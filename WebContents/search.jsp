<%@ page import="edu.ucla.cs.cs144.SearchResult" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Search Page</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/dropdown.css" rel="stylesheet">

    <!-- Script -->
    <script src="js/bootstrap.min.js"></script>

    <script type="text/javascript" src="js/autosuggest.js"></script>
    <script type="text/javascript">
        window.onload = function () {
            var oTextbox = new AutoSuggestControl(document.getElementById("q"), new SuggestionProvider()); 
        }
    </script>

  </head>

  <body>

        <div class="col-lg-8">
          <h2>Search for an item</h2>
          <form class="form-inline" role="form" action="/eBay/search" method="GET">
            <div class="form-group">
              <label class="sr-only" for="q">Query</label>
              <input class="form-control" type="text" id="q" name="q" placeholder="Search" autocomplete="off">
            </div>
            <input class="btn btn-default" type="submit" value="Search">
            <input type="hidden" name="numResultsToSkip" value="0">
            <input type="hidden" name="numResultsToReturn" value="20">
          </form>
        
       <% String query = request.getParameter("q");
          String numToSkip = request.getParameter("numResultsToSkip");
          String numToReturn = request.getParameter("numResultsToReturn");
          Integer numResultsToSkip = new Integer(numToSkip);
          Integer numResultsToReturn = new Integer(numToReturn);
          SearchResult[] results = (SearchResult[]) request.getAttribute("searchResults"); %>
        
          <h2>Top Results for &quot;<%= query %>&quot;:</h2>
          <div class="list-group">
            <ul>
              <% for (SearchResult result : results) { %>
                <li><a href="/eBay/item?ID=<%= result.getItemId() %>" class="list-group-item"><%= result.getName() %></a></li>
              <% } %>
            </ul>
          </div>
        </div>

        <div class="col-lg-8">
          <ul class="pager">
            <% if (numResultsToSkip == 0) { %>
              <li class="previous disabled"><a href="#">Previous</a></li>
            <% } else { %>
              <li class="previous"><a href="/eBay/search?q=<%= query %>&amp;numResultsToSkip=<%= numResultsToSkip-20 %>&amp;numResultsToReturn=20">Previous</a></li>
            <% } %>

            <% if (results.length < 20) { %>
              <li class="next disabled"><a href="#">Next</a></li>
            <% } else { %>
              <li class="next"><a href="/eBay/search?q=<%= query %>&amp;numResultsToSkip=<%= numResultsToSkip+20 %>&amp;numResultsToReturn=20">Next</a></li>
            <% } %>
          </ul>
        </div>

  </body>
</html>