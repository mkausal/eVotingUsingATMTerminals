package com.eVoting.registration.voter;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;

@Path("/registerVoter")
public class RegistrationOfVoter {
	@GET
	@Path("/{PAN}")
	public String registerVoter(@PathParam("PAN") String panCard) throws Exception{
		System.out.println(panCard);
		String voterID="";
		Connection con=null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/SE_Project_EC", "root", "Sachin200");
			Statement stmt=con.createStatement();
			ResultSet rs=stmt.executeQuery("select Voter_ID from Voter_Details where Pan_Card='"+panCard+"'");
			while(rs.next()){
				voterID=rs.getString("Voter_ID");
			}
			if(voterID.equals("")){
				try{
					stmt.executeUpdate("insert into Voter_Registration values('"+panCard+"','Pending')");
				}catch(Exception e){
					return "You have already requested for right to franchise!";
				}
				return "We received request, we'll do backend verification and update you!";
			}
			else
				return "Already registered!";
		}catch(Exception e){
			e.printStackTrace();
		}
		finally{
			con.close();
		}
		return "Some Error, please try again";
	}
}
