package com.eVoting.ec.authenticate.otp;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;

@Path("/OTPAuthentication")
public class ValidateOTP {
	@GET
	@Path("/{PANCard}/{OTP}")
	public String authenticateOTP(@PathParam("PANCard") String panCard,@PathParam("OTP") String otp) throws Exception{
		Connection con=null;
		String voterID="";
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
			rs=stmt.executeQuery("select OTP from Voter_OTP where Voter_ID='"+voterID+"'");
			while(rs.next()){
				long otpFromDB=rs.getLong("OTP");
				if(otpFromDB==Long.parseLong(otp))
					return "authenticated";
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		finally{
			con.close();
		}
		return "failed";
	}
}
