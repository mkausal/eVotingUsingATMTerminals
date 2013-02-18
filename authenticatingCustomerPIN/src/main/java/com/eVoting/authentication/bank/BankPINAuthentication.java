package com.eVoting.authentication.bank;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;

@Path("/authenticateCustomer")
public class BankPINAuthentication {
	@GET
	@Path("/{ATMCard}/{PIN}")
	public String authenticateCustomer(@PathParam("ATMCard") String atmCard,@PathParam("PIN") String pin) throws Exception{
		String customerID="",pinInDB="";
		Connection con=null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/SE_Project_Bank", "root", "Sachin200");
			Statement stmt=con.createStatement();
			ResultSet rs=stmt.executeQuery("select Customer_ID from Customer_Details where ATM_Card_Number="+Long.parseLong(atmCard));
			while(rs.next()){
				customerID=rs.getString("Customer_ID");
			}
			if(!customerID.equals("")){
				PreparedStatement prepare=con.prepareStatement("select PIN from Customer_Authentication where Customer_ID=?");
				prepare.setString(1, customerID);
				rs=prepare.executeQuery();
				while(rs.next()){
					pinInDB=rs.getString("PIN");
				}
				if(pinInDB.equals(pin))
					return "authenticated";
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "fail";
	}
}
