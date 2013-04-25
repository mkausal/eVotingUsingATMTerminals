package com.eVoting.sms;

import java.util.Date;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;

@Path("/sendSMS")
public class SendSMS {
	@GET
	@Path("/{MobileNumber}/{Message}")
	public String sendSMS(@PathParam("MobileNumber") String mobileNumber,@PathParam("Message") String message) throws Exception{
		String username = "mkausal";
        String password = "Sachin200";
        String smtphost = "ipipi.com";
        String compression = "Compression Option goes here - find out more";
        String from = "mkausal@ipipi.com";
        String to = "91"+mobileNumber+"@sms.ipipi.com";
        String body = message;
        Transport tr = null;

        try {
         Properties props = System.getProperties();
         props.put("mail.smtp.auth", "true");

         // Get a Session object
         Session mailSession = Session.getDefaultInstance(props, null);

         // construct the message
         Message msg = new MimeMessage(mailSession);

         //Set message attributes
         msg.setFrom(new InternetAddress(from));
         InternetAddress[] address = {new InternetAddress(to)};
         msg.setRecipients(Message.RecipientType.TO, address);
         msg.setSubject(compression);
         msg.setText(body);
         msg.setSentDate(new Date());

         tr = mailSession.getTransport("smtp");
         tr.connect(smtphost, username, password);
         msg.saveChanges();
         tr.sendMessage(msg, msg.getAllRecipients());
         tr.close();
         } catch (Exception e) {
             e.printStackTrace();
             return "Some problem sending SMS, try again";
         }
		return "SMS Sent";
	}
}
