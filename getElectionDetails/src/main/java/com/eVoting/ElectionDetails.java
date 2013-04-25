package com.eVoting;

import java.sql.*;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;

@Path("/electionDetails")
public class ElectionDetails {
	@GET
	@Path("/{PANCard}")
	public String getElectionDetails(@PathParam("PANCard") String panCard) throws Exception{
		Connection con=null;
		String voterID="",electionType="",constituencyID="",constituencyName="";
		String ret="";
		System.out.println(panCard);
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
			ResultSet rsInner=null;
			Statement stmtInner=con.createStatement();
			rs=stmt.executeQuery("select Constituency_ID from Voter_Constituency where Voter_ID='"+voterID+"' and Constituency_ID NOT IN (select Constituency_ID from Voter_Vote where Voter_ID='"+voterID+"' and Already_Voted='Y')");
			while(rs.next()){
				constituencyID=rs.getString("Constituency_ID");
				String sql="select Election_Type,Constituency_Name from Constituency_List where Constituency_ID='"+constituencyID+"'";
				System.out.println(sql);
				rsInner=stmtInner.executeQuery(sql);
				if(rsInner.next()){
					electionType=rsInner.getString("Election_Type");
					constituencyName=rsInner.getString("Constituency_Name");
					ret+=electionType+"#"+constituencyName;
				}
				ret+="$";
			}
			System.out.println(ret);
		}catch(Exception e){
			e.printStackTrace();
			return "Unknown Error";
		}
		return ret;
	}
}
