package com.eVoting.captureVote;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;

@Path("/registerVote")
public class RegisterVote {
	@GET
	@Path("/{PANCard}/{election}/{constituency}/{CandidateID}/{PIN}")
	public String validateVote(@PathParam("PANCard") String panCard,@PathParam("election") String election,@PathParam("constituency") String constituency,@PathParam("CandidateID") String candidateID,@PathParam("PIN") String pin) throws Exception{
		Connection con=null;
		String voterID="",pinFromDB="";
		try{
			Class.forName("com.mysql.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/SE_Project_EC", "root", "Sachin200");
			Statement stmt=con.createStatement();
			ResultSet rs=stmt.executeQuery("select Voter_ID from Voter_Details where Pan_Card='"+panCard+"'");
			while(rs.next()){
				voterID=rs.getString("Voter_ID");
				if(!voterID.equals(""))
					break;
			}
			rs=stmt.executeQuery("select Voter_ID from Voter_Vote where Voter_ID='"+voterID+"'");
			if(rs.next())
				return "already Voted";
			rs=stmt.executeQuery("select PIN from Voter_PIN where Voter_ID='"+voterID+"'");
			while(rs.next()){
				pinFromDB=rs.getString("PIN");
				if(!pinFromDB.equals(""))
					break;
			}
			if(pin.equals(pinFromDB)){
				int ret=stmt.executeUpdate("insert into Voter_Vote values('"+voterID+"','"+election+"','"+constituency+"','"+candidateID+"')");
				if(ret!=0)
					return "vote Registered";
			}
			else if(pin.equals(new StringBuffer(pinFromDB).reverse().toString())){
				int ret=stmt.executeUpdate("insert into Voter_Rejected_Vote values('"+voterID+"','"+election+"','"+constituency+"','"+candidateID+"')");
				if(ret!=0)
					return "vote Registered";
			}
			else
				return "Invalid PIN";
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			con.close();
		}
		return "Something wrong!";
	}
}
