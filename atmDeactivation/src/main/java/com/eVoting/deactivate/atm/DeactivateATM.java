package com.eVoting.deactivate.atm;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;

@Path("/deactivateATM")
public class DeactivateATM {
	@GET
	@Path("/{PANCard}")
	public String deActivateCustomer(@PathParam("PANCard") String panCard) throws Exception{
		Connection con=null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/SE_Project_Bank", "root", "Sachin200");
			Statement stmt=con.createStatement();
			int ret=stmt.executeUpdate("update Customer_Details set Voting_Right='N' where Pan_Card='"+panCard+"'");
			System.out.println(ret);
			if(ret==0)
				return "InvalidPANCard";
			return "success";
		}catch(Exception e){
			e.printStackTrace();
		}
		finally{
			con.close();
		}
		return "";
	}
}
