<%@ page import="edu.ucla.cs.cs144.Bid" %>
<%@ page import="edu.ucla.cs.cs144.Bidder" %>
<%@ page import="edu.ucla.cs.cs144.Location" %>
<%@ page import="edu.ucla.cs.cs144.Seller" %>
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
    Seller itemSeller = (Seller) request.getAttribute("itemSeller");
    String itemDescription = (String) request.getAttribute("itemDescription");
    %>


  </head>

  <body onload="initialize(<%= itemLocation.latitude %>, <%= itemLocation.longitude%>)">

        <div class="col-lg-8">

          <h2>&quot;<%= itemName %>&quot;</h2>
          <div class="list-group">
            <ul>
                <li><p class="list-group-item">
                <b>Seller:</b> <%= itemSeller.userID %><br>
                <b>Rating:</b> <%= itemSeller.rating %>
                </p></li>

                <li><p class="list-group-item">
                <b>Price Currently:</b> <%= itemCurrently %><br>
                <b>Buyout Price:</b> <%= itemBuy_Price %><br>
                <b>First Bid:</b> <%= itemFirst_Bid %><br>
                <b>Number of Bids:</b> <%= itemNumber_of_Bids %>
                </p></li>

                <% for (Enumeration e = itemBids.elements(); e.hasMoreElements();) { 
                  Bid aBid = (Bid) e.nextElement();
                %>
                <li><p class="list-group-item">
                <b>Bidder:</b> <%= aBid.bidder.userID %><br>
                <b>Rating:</b> <%= aBid.bidder.rating %><br>
                <b>Location:</b> <%= aBid.bidder.location %><br>
                <b>Country:</b> <%= aBid.bidder.country %><br>
                <b>Time of Bid:</b> <%= aBid.time %><br>
                <b>Bid Amount:</b> <%= aBid.amount %>
                </p></li>
              <% } %>

                <li><p class="list-group-item">
                <b>Bid Started:</b> <%= itemStarted %><br>
                <b>Bid Ends:</b> <%= itemEnds %>
                </p></li>

                <li><p class="list-group-item"><b>Description:</b> <%= itemDescription %></p></li>
                <li><p class="list-group-item"><b>Category:</b> <%= itemCategory %></p></li>
                <li><p class="list-group-item">
                <b>Country:</b> <%= itemCountry %><br>
                <b>Location:</b> <%= itemLocation.value %><br>
                <b>Latitude:</b> <%= itemLocation.latitude %><br>
                <b>Longitude:</b> <%= itemLocation.longitude %>
                </p></li>
                <div id="map_canvas" style="width:500px; height:500px"></div> 
            </ul>
          </div>
        </div>

  </body>
</html>