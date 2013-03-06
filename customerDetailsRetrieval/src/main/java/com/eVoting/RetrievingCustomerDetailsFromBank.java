package com.eVoting;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;

@Path("/getCustomerDetails")
public class RetrievingCustomerDetailsFromBank {
	@GET
	@Path("/{ATMCard}")
	public String registerVoter(@PathParam("ATMCard") String atmCard) throws Exception{
		String panCard="";
		Connection con=null;
		if(atmCard==null)
			return null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/SE_Project_Bank", "root", "Sachin200");
			Statement stmt=con.createStatement();
			ResultSet rs=stmt.executeQuery("select Pan_Card from Customer_Details where ATM_Card_Number="+Long.parseLong(atmCard));
			while(rs.next()){
				panCard=rs.getString("Pan_Card");
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		finally{
			con.close();
		}
		return panCard;
	}
}
