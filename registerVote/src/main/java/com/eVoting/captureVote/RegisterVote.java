package com.eVoting.captureVote;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.Consumes;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;

@Path("/registerVote")
public class RegisterVote {
	@POST
	@Produces(MediaType.TEXT_HTML)
	@Consumes(MediaType.APPLICATION_FORM_URLENCODED)
	public void validateVote(@FormParam("message") String message,@Context HttpServletResponse servletResponse) throws IOException {
		int count=Integer.parseInt(message.split("&")[0]);
		String panCard=message.split("&")[1];
		String votes=message.split("&")[2];
		System.out.println(votes);
		String pin=message.split("&")[3];
		String electionType="";
		String constituency="";
		String candidateID="";
		int i=0;
		String currentVote="";
		Connection con=null;
		String voterID="",pinFromDB="";
		String constituencyID="";
		int noOfVotesRegistered=0;
		for(;i<count;i++){
			currentVote=votes.split("%")[i];
			System.out.println(currentVote);
			electionType=currentVote.split("\\$")[0];
			constituency=currentVote.split("\\$")[1];
			try{
				candidateID=currentVote.split("\\$")[2];
			}catch(Exception e){
				e.printStackTrace();
				continue;
			}
			System.out.println("CandidateID"+candidateID);
			//if(candidateID)
			try{
				Class.forName("com.mysql.jdbc.Driver");
				con=DriverManager.getConnection("jdbc:mysql://localhost:3306/SE_Project_EC", "root", "Sachin200");
				Statement stmt=con.createStatement();
				ResultSet rs=stmt.executeQuery("select Constituency_ID from Constituency_List where Election_Type='"+electionType+"' and Constituency_Name='"+constituency+"'");
				while(rs.next()){
					constituencyID=rs.getString("Constituency_ID");
					if(!constituencyID.equals(""))
						break;
				}
				rs=stmt.executeQuery("select Voter_ID from Voter_Details where Pan_Card='"+panCard+"'");
				while(rs.next()){
					voterID=rs.getString("Voter_ID");
					if(!voterID.equals(""))
						break;
				}
				rs=stmt.executeQuery("select PIN from Voter_PIN where Voter_ID='"+voterID+"'");
				while(rs.next()){
					pinFromDB=rs.getString("PIN");
					if(!pinFromDB.equals(""))
						break;
				}
				String sql="select Already_Voted from Voter_Vote where Voter_ID='"+voterID+"' and Election_Type='"+electionType+"' and Constituency_ID='"+constituencyID+"'";
				rs=stmt.executeQuery(sql);
				String alreadyVoted="";
				while(rs.next()){
					alreadyVoted=rs.getString("Already_Voted");
					if(!alreadyVoted.equalsIgnoreCase(""))
						break;
				}
				if(!alreadyVoted.equalsIgnoreCase("Y")){
					sql="select Vote_Count from Candidate_Vote where Election_Type='"+electionType+"' and Constituency_ID='"+constituencyID+"' and Candidate_ID='"+candidateID+"'";
					System.out.println(sql);
					rs=stmt.executeQuery(sql);
					int voteCount=0;
					while(rs.next()){
						voteCount=rs.getInt("Vote_Count");
					}
					voteCount++;
					int ret=0;
					if(pin.equals(pinFromDB)){
						ret=stmt.executeUpdate("update Candidate_Vote set Vote_Count="+voteCount+" where Election_Type='"+electionType+"' and Constituency_ID='"+constituencyID+"' and Candidate_ID='"+candidateID+"'");
						ret=stmt.executeUpdate("insert into Voter_Vote values('"+voterID+"','"+electionType+"','"+constituencyID+"','Y')");
						noOfVotesRegistered++;
					}
					else if(pin.equals(new StringBuffer(pinFromDB).reverse().toString())){
						rs=stmt.executeQuery("select Already_Voted_Count from Voter_Rejected_Vote where Election_Type='"+electionType+"' and Constituency_ID='"+constituencyID+"' and Voter_ID='"+voterID+"'");
						int alreadyVotedCount=0;
						while(rs.next()){
							alreadyVotedCount=rs.getInt("Already_Voted_Count");
						}
						alreadyVotedCount++;
						if(alreadyVotedCount>1)
							ret=stmt.executeUpdate("update Voter_Rejected_Vote set Already_Voted_Count="+alreadyVotedCount+" where Election_Type='"+electionType+"' and Constituency_ID='"+constituencyID+"' and Voter_ID='"+voterID+"'");
						else
							ret=stmt.executeUpdate("insert into Voter_Rejected_Vote values('"+voterID+"','"+electionType+"','"+constituencyID+"',"+alreadyVotedCount+")");
						System.out.println(ret);
						noOfVotesRegistered++;
					}
				}
			}
			catch(Exception e){
				e.printStackTrace();
			}
		}
		String responseMessage=noOfVotesRegistered+"_votes_registered!";
		servletResponse.sendRedirect("https://localhost:8443/voteUsingATM/voteResponse.html?message="+responseMessage);
	}
	@GET
	@Path("/{message}")
	public String validateVoteUsingGet(@PathParam("message") String message) throws Exception{
		System.out.println(message);
		int count=Integer.parseInt(message.split("$%")[0]);
		System.out.println(count);
		String panCard=message.split("$%")[1];
		System.out.println(panCard);
		String votes=message.split("$%")[2];
		System.out.println(votes);
		String pin=message.split("$%")[3];
		System.out.println(pin);
		/*Connection con=null;
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
		}*/
		return "Something wrong!";
	}
}
