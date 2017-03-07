package edu.ucla.cs.cs144;

public class Bid {
	public Bid() {
		time = "";
		amount = "";
		bidder = new Bidder();
	}

    public Bidder bidder;
    public String time;
    public String amount;
}