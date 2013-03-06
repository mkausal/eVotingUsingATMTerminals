<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Forwarding response...</title>
<script type="text/javascript">
window.onload=function(){
	queryString=window.location.search;
	panCard=queryString.substring(1).split('&')[0].split('=')[1];
	status=queryString.substring(1).split('&')[1].split('=')[1];
	if(status=="failed"){
		alert("Your OTP was wrong, your ATM card is now suspended from voting");
		deactivateAtBank(panCard);
	}
	else
		window.location.replace('http://localhost:8080/voteUsingATM/captureVote.jsp?PANCard='+panCard+'&election=general&constituency=AP060');
	//needs getting constituency details from MongoDB and election type to be obtained and sent too
}
function deactivateAtBank(panCard){
	var req = createRequest(); // defined above
	req.onreadystatechange = function() {
		if (req.readyState == 4 && req.status == 200) {
			var resp = req.responseText;
		if (resp.toString() != "") {
			if(resp.toString()=="success")
				window.location.replace('http://localhost:8080/voteUsingATM/index.jsp');
		}
		}
		if (req.readyState != 4)
			return; // Not there yet
		if (req.status != 200) {
			alert("Server failed to respond, please try again!");
			return;
		}
	}
	// Request successful, read the response
	req.open("GET","http://localhost:8080/atmDeactivation/resources/deactivateATM/"+panCard, true);
	req.send();
}
function createRequest() {
	var result = null;
	if (window.XMLHttpRequest) {
		// FireFox, Safari, etc.
		result = new XMLHttpRequest();
		if (typeof result.overrideMimeType != 'undefined') {
			result.overrideMimeType('text/xml'); // Or anything else
		}
	} else if (window.ActiveXObject) {
		// MSIE
		result = new ActiveXObject("Microsoft.XMLHTTP");
	} else {
		// No known mechanism -- consider aborting the application
	}
	return result;
}
</script>
</head>
<body>
<%
String panCard=request.getParameter("PANCard");
String status=request.getParameter("status");
%>
</body>
</html>