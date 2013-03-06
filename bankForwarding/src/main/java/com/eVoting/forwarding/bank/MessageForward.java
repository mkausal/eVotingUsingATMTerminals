package com.eVoting.forwarding.bank;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;

@Path("/bankForward")
public class MessageForward {
	@GET
	@Path("/{ATMCard}/{OTP}")
	public String forwardOTPToEC(@PathParam("ATMCard") String atmCard,@PathParam("OTP") String otp) throws Exception{
		
		return "";
	}
}
