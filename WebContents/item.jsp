<%@ page import="edu.ucla.cs.cs144.Bid" %>
<%@ page import="edu.ucla.cs.cs144.Bidder" %>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.Enumeration" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Search Page</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Script -->
    <script src="js/bootstrap.min.js"></script>

  </head>

  <body>

        <div class="col-lg-8">
        <% String itemID = request.getParameter("ID");
          String itemName = (String) request.getAttribute("itemName");
          String itemCategory = (String) request.getAttribute("itemCategory");
          String itemCurrently = (String) request.getAttribute("itemCurrently");
          String itemBuy_Price = (String) request.getAttribute("itemBuy_Price");
          String itemFirst_Bid = (String) request.getAttribute("itemFirst_Bid");
          String itemNumber_of_Bids = (String) request.getAttribute("itemNumber_of_Bids");
          Vector<Bid> itemBids = (Vector<Bid>) request.getAttribute("itemBids");
          String itemLocation = (String) request.getAttribute("itemLocation");
          String itemCountry = (String) request.getAttribute("itemCountry");
          String itemStarted = (String) request.getAttribute("itemStarted");
          String itemEnds = (String) request.getAttribute("itemEnds");
          String itemDescription = (String) request.getAttribute("itemDescription");
          %>

          <h2>Item Name: &quot;<%= itemName %>&quot;:</h2>
          <div class="list-group">
            <ul>
                <li><b class="list-group-item">ID: <%= itemID %></b></li>
                <li><b class="list-group-item">Category: <%= itemCategory %></b></li>
                <li><b class="list-group-item">Currently: <%= itemCurrently %></b></li>
                <li><b class="list-group-item">Buy Price: <%= itemBuy_Price %></b></li>
                <li><b class="list-group-item">First Bid: <%= itemFirst_Bid %></b></li>
                <li><b class="list-group-item">Number of Bids: <%= itemNumber_of_Bids %></b></li>
                <% for (Enumeration e = itemBids.elements(); e.hasMoreElements();) { 
                  Bid aBid = (Bid) e.nextElement();
                %>
                <li><p><b class="list-group-item">
                Bidder location: <%= aBid.bidder.location %><br>
                Bidder country: <%= aBid.bidder.country %><br>
                Bid time: <%= aBid.time %><br>
                Bid amount: <%= aBid.amount %>
                </b></p></li>
              <% } %>
                <li><b class="list-group-item">Location: <%= itemLocation %></b></li>
                <li><b class="list-group-item">Country: <%= itemCountry %></b></li>
                <li><b class="list-group-item">Started: <%= itemStarted %></b></li>
                <li><b class="list-group-item">Ends: <%= itemEnds %></b></li>
                <li><b class="list-group-item">Description: <%= itemDescription %></b></li>
            </ul>
          </div>
        </div>

  </body>
</html>