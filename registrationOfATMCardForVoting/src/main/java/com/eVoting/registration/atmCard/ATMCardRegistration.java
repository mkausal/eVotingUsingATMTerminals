package com.eVoting.registration.atmCard;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;

@Path("/registerATMCard")
public class ATMCardRegistration {
	@GET
	@Path("/{ATMCard}")
	public String registerATMCard(@PathParam("ATMCard") String atmCard) throws Exception{
		Connection con=null,conEC=null;
		String alreadyRegistered="",panCard="";
		System.out.println(atmCard);
		try{
			Class.forName("com.mysql.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/SE_Project_Bank", "root", "Sachin200");
			conEC=DriverManager.getConnection("jdbc:mysql://localhost:3306/SE_Project_EC", "root", "Sachin200");
			Statement stmt=con.createStatement();
			ResultSet rs=stmt.executeQuery("select Pan_Card from Customer_Details where ATM_Card_Number="+Long.parseLong(atmCard));
			while(rs.next()){
				panCard=rs.getString("Pan_Card");
			}
			if(!panCard.equals("")){
				rs=stmt.executeQuery("select Voting_Right from Customer_Details where Pan_Card='"+panCard+"'");
				while(rs.next()){
					alreadyRegistered=rs.getString("Voting_Right");
					if(!alreadyRegistered.equals(""))
						break;
				}
				if(alreadyRegistered.equals("")){
					String voterID="";
					Statement stmtEC=conEC.createStatement();
					ResultSet rsEC=stmtEC.executeQuery("select Voter_ID from Voter_Details where Pan_Card='"+panCard+"'");
					while(rsEC.next()){
						voterID=rsEC.getString("Voter_ID");
					}
					if(voterID.equals(""))
						return "Please register for right to franchise first!";
					stmt.executeUpdate("update Customer_Details set Voting_Right='Y' where ATM_Card_Number="+atmCard+" and Pan_Card='"+panCard+"'");
					return "Registered!";
				}
				else
					return "Your card is already Registered!";
			}
			else
				return "Invalid ATM Card";
		}catch(Exception e){
			e.printStackTrace();
		}
		finally{
			con.close();
		}
		return "";
	}
}
