<%@ page import="edu.ucla.cs.cs144.Bid" %>
<%@ page import="edu.ucla.cs.cs144.Bidder" %>
<%@ page import="edu.ucla.cs.cs144.Location" %>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.Enumeration" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Item Page</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- more CSS -->

    <!-- Script -->
    <script src="js/bootstrap.min.js"></script>
    <script type="text/javascript" 
    src="http://maps.google.com/maps/api/js?sensor=false"> 
    </script> 
    <script type="text/javascript"> 
      function initialize(lat, long) { 
        var latlng = new google.maps.LatLng(lat,long); 
        var myOptions = { 
          zoom: 14, // default is 8  
          center: latlng, 
          mapTypeId: google.maps.MapTypeId.ROADMAP 
        }; 
        var map = new google.maps.Map(document.getElementById("map_canvas"), 
            myOptions); 
      } 

    </script> 
    
    <!-- JSP code -->
    <% String itemID = request.getParameter("ID");
    String itemName = (String) request.getAttribute("itemName");
    String itemCategory = (String) request.getAttribute("itemCategory");
    String itemCurrently = (String) request.getAttribute("itemCurrently");
    String itemBuy_Price = (String) request.getAttribute("itemBuy_Price");
    String itemFirst_Bid = (String) request.getAttribute("itemFirst_Bid");
    String itemNumber_of_Bids = (String) request.getAttribute("itemNumber_of_Bids");
    Vector<Bid> itemBids = (Vector<Bid>) request.getAttribute("itemBids");
    Location itemLocation = (Location) request.getAttribute("itemLocation");
    String itemCountry = (String) request.getAttribute("itemCountry");
    String itemStarted = (String) request.getAttribute("itemStarted");
    String itemEnds = (String) request.getAttribute("itemEnds");
    String itemDescription = (String) request.getAttribute("itemDescription");
    %>


  </head>

  <body onload="initialize(<%= itemLocation.latitude %>, <%= itemLocation.longitude%>)">

        <div class="col-lg-8">

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
                <li><b class="list-group-item">Country: <%= itemCountry %></b></li>
                <li><b class="list-group-item">Started: <%= itemStarted %></b></li>
                <li><b class="list-group-item">Ends: <%= itemEnds %></b></li>
                <li><b class="list-group-item">Description: <%= itemDescription %></b></li>
                 <li><b class="list-group-item">Location: <%= itemLocation.value %><br>
                Latitude: <%= itemLocation.latitude %><br>
                Longitude: <%= itemLocation.longitude %>
                </b></li>
                <div id="map_canvas" style="width:500px; height:500px"></div> 
            </ul>
          </div>
        </div>

  </body>
</html>