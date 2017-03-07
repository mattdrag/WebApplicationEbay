package edu.ucla.cs.cs144;

import java.io.IOException;
import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.io.StringReader;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.CharacterData;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import java.util.Vector;
import java.util.Enumeration;
import java.lang.StringBuilder;
import org.xml.sax.SAXException;

public class ItemServlet extends HttpServlet implements Servlet {
       
    public ItemServlet() {}

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        // your codes here
        try {
            String itemID = request.getParameter("ID");
            String itemData = AuctionSearch.getXMLDataForItemId(itemID);
            
            if (itemData == ""){
            	request.getRequestDispatcher("/itempage.html").forward(request, response);
            	return;
            }
            else{

            	// Name
            	Vector<String> nameVector = parseXML(itemData, "Name", "Item");
            	StringBuilder nameBuilder = new StringBuilder();
				// Traverse entire list, printing them all out
				for (Enumeration e = nameVector.elements(); e.hasMoreElements();)
				{
					String nameString = (String) e.nextElement();
					nameBuilder.append(nameString);
				}
            	request.setAttribute("itemName", nameBuilder.toString());


            	// Category
            	Vector<String> categoryVector = parseXML(itemData, "Category", "Item");
            	StringBuilder categoryBuilder = new StringBuilder("");
				// Traverse entire list, printing them all out
				for (Enumeration e = categoryVector.elements(); e.hasMoreElements();)
				{
					String categoryString = (String) e.nextElement();
					categoryBuilder.append(categoryString);
					categoryBuilder.append(", ");
				}
            	request.setAttribute("itemCategory", categoryBuilder.toString());

            	// Currently
            	Vector<String> currentlyVector = parseXML(itemData, "Currently", "Item");
            	StringBuilder currentlyBuilder = new StringBuilder("");
				// Traverse entire list, printing them all out
				for (Enumeration e = currentlyVector.elements(); e.hasMoreElements();)
				{
					String currentlyString = (String) e.nextElement();
					currentlyBuilder.append(currentlyString);
				}
            	request.setAttribute("itemCurrently", currentlyBuilder.toString());

            	// Buy_Price
            	Vector<String> buyPriceVector = parseXML(itemData, "Buy_Price", "Item");
            	StringBuilder buyPriceBuilder = new StringBuilder("");
				// Traverse entire list, printing them all out
				for (Enumeration e = buyPriceVector.elements(); e.hasMoreElements();)
				{
					String buyPriceString = (String) e.nextElement();
					buyPriceBuilder.append(buyPriceString);
				}
            	request.setAttribute("itemBuy_Price", buyPriceBuilder.toString());

            	// First_Bid
            	Vector<String> firstBidVector = parseXML(itemData, "First_Bid", "Item");
            	StringBuilder firstBidBuilder = new StringBuilder("");
				// Traverse entire list, printing them all out
				for (Enumeration e = firstBidVector.elements(); e.hasMoreElements();)
				{
					String firstBidString = (String) e.nextElement();
					firstBidBuilder.append(firstBidString);
				}
            	request.setAttribute("itemFirst_Bid", firstBidBuilder.toString());

            	// Number_of_Bids
            	Vector<String> numberOfBidsVector = parseXML(itemData, "Number_of_Bids", "Item");
            	StringBuilder numberOfBidsBuilder = new StringBuilder("");
				// Traverse entire list, printing them all out
				for (Enumeration e = numberOfBidsVector.elements(); e.hasMoreElements();)
				{
					String numberOfBidsString = (String) e.nextElement();
					numberOfBidsBuilder.append(numberOfBidsString);
				}
            	request.setAttribute("itemNumber_of_Bids", numberOfBidsBuilder.toString());

            	//Bids
            	Vector<Bid> bidsVector = parseXMLBids(itemData);
            	request.setAttribute("itemBids", bidsVector);

            	// Location
            	Vector<Location> locationVector = parseXMLLocation(itemData);
            	request.setAttribute("itemLocation", locationVector.get(0));


            	// Country
            	Vector<String> countryVector = parseXMLLastOf(itemData, "Country", "Item");
            	StringBuilder countryBuilder = new StringBuilder("");
				// Traverse entire list, printing them all out
				for (Enumeration e = countryVector.elements(); e.hasMoreElements();)
				{
					String countryString = (String) e.nextElement();
					countryBuilder.append(countryString);
				}
            	request.setAttribute("itemCountry", countryBuilder.toString());


            	// Started
            	Vector<String> startedVector = parseXML(itemData, "Started", "Item");
            	StringBuilder startedBuilder = new StringBuilder("");
				// Traverse entire list, printing them all out
				for (Enumeration e = startedVector.elements(); e.hasMoreElements();)
				{
					String startedString = (String) e.nextElement();
					startedBuilder.append(startedString);
				}
            	request.setAttribute("itemStarted", startedBuilder.toString());


            	// Ends
            	Vector<String> endsVector = parseXML(itemData, "Ends", "Item");
            	StringBuilder endsBuilder = new StringBuilder("");
				// Traverse entire list, printing them all out
				for (Enumeration e = endsVector.elements(); e.hasMoreElements();)
				{
					String endsString = (String) e.nextElement();
					endsBuilder.append(endsString);
				}
            	request.setAttribute("itemEnds", endsBuilder.toString());


            	// Description
            	Vector<String> descriptionVector = parseXML(itemData, "Description", "Item");
            	StringBuilder descriptionBuilder = new StringBuilder("");
				// Traverse entire list, printing them all out
				for (Enumeration e = descriptionVector.elements(); e.hasMoreElements();)
				{
					String descriptionString = (String) e.nextElement();
					descriptionBuilder.append(descriptionString);
				}
            	request.setAttribute("itemDescription", descriptionBuilder.toString());

            	// Send request
            	request.getRequestDispatcher("/item.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.getRequestDispatcher("/item.jsp").forward(request, response);
        }
    }

    public Vector<String> parseXML(String itemData, String itemTag, String parentName) throws Exception 
    {	
    	// Parses XML into map
	    DocumentBuilder db = DocumentBuilderFactory.newInstance().newDocumentBuilder();
	    InputSource is = new InputSource();
	    is.setCharacterStream(new StringReader(itemData));

	    //Aquire item
	    Document doc = db.parse(is);
	    NodeList nodes = doc.getElementsByTagName(parentName);
	    Element element = (Element) nodes.item(0);

	    Vector<String> dataVector = new Vector<String>();

	    NodeList tag = element.getElementsByTagName(itemTag);
	    for(int i = 0; i < tag.getLength(); i++){
	    	Element line = (Element) tag.item(i);
		    dataVector.addElement(getCharacterDataFromElement(line));
	    }

	    return dataVector;
  	}

  	public Vector<Bid> parseXMLBids(String itemData) throws Exception 
    {	
    	Vector<Bid> bidVector = new Vector<Bid>();
    	// Parses XML into map
	    DocumentBuilder db = DocumentBuilderFactory.newInstance().newDocumentBuilder();
	    InputSource is = new InputSource();
	    is.setCharacterStream(new StringReader(itemData));

	    //Aquire item
	    Document doc = db.parse(is);
	    NodeList nodes = doc.getElementsByTagName("Bids");
	    Element element = (Element) nodes.item(0);

	    Bid bid;
	    Bidder bidder;
		NodeList bids = element.getElementsByTagName("Bid");
	    for(int i = 0; i < bids.getLength(); i++){
	    	Element line = (Element) bids.item(i);
	    	bid = new Bid();
	    	//bidder
	    	bidder = new Bidder();
	    	NodeList bidderList = element.getElementsByTagName("Bidder");
	    	Element bidderLine = (Element) bidderList.item(i);
	    	NodeList locationList = bidderLine.getElementsByTagName("Location");
	    	Element locationLine = (Element) locationList.item(0);
		    bidder.location = getCharacterDataFromElement(locationLine);
		    NodeList countryList = bidderLine.getElementsByTagName("Country");
	    	Element countryLine = (Element) countryList.item(0);
		    bidder.country = getCharacterDataFromElement(countryLine);
		    bid.bidder = bidder;

	    	//time
	    	NodeList timeList = line.getElementsByTagName("Time");
	    	Element timeLine = (Element) timeList.item(0);
		    bid.time = getCharacterDataFromElement(timeLine);

		    //amount
		    NodeList amountList = line.getElementsByTagName("Amount");
	    	Element amountLine = (Element) amountList.item(0);
		    bid.amount = getCharacterDataFromElement(amountLine);

		    bidVector.addElement(bid);
	    }

	    return bidVector;
  	}

  	public Vector<Location> parseXMLLocation(String itemData) throws Exception 
    {	
    	// Parses XML into map
	    DocumentBuilder db = DocumentBuilderFactory.newInstance().newDocumentBuilder();
	    InputSource is = new InputSource();
	    is.setCharacterStream(new StringReader(itemData));

	    //Aquire item
	    Document doc = db.parse(is);
	    NodeList nodes = doc.getElementsByTagName("Item");
	    Element element = (Element) nodes.item(0);

	    Vector<Location> dataVector = new Vector<Location>();
	    Location location = new Location();

	    NodeList tag = element.getElementsByTagName("Location");
	    for(int i = 0; i < tag.getLength(); i++){
	    	Element line = (Element) tag.item(i);
	    	location.latitude = line.getAttribute("Latitude");
	    	location.longitude = line.getAttribute("Longitude");
	    	location.value = getCharacterDataFromElement(line);
	    }
	    dataVector.addElement(location);

	    return dataVector;
  	}

  	public Vector<String> parseXMLLastOf(String itemData, String itemTag, String parentName) throws Exception 
    {	
    	// Parses XML into map
	    DocumentBuilder db = DocumentBuilderFactory.newInstance().newDocumentBuilder();
	    InputSource is = new InputSource();
	    is.setCharacterStream(new StringReader(itemData));

	    //Aquire item
	    Document doc = db.parse(is);
	    NodeList nodes = doc.getElementsByTagName(parentName);
	    Element element = (Element) nodes.item(0);

	    Vector<String> dataVector = new Vector<String>();

	    NodeList tag = element.getElementsByTagName(itemTag);
	    Element line = (Element) tag.item(tag.getLength() - 1);
	    dataVector.addElement(getCharacterDataFromElement(line));

	    return dataVector;
  	}

  	public static String getCharacterDataFromElement(Element e) {
	    Node child = e.getFirstChild();
	    if (child instanceof CharacterData) {
	      CharacterData cd = (CharacterData) child;
	      return cd.getData();
	    }
	    return "";
  	}
}
