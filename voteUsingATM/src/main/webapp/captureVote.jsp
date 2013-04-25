<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Capture Vote</title>
<script type="text/javascript">
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
function getElectionDetails(panCard){
	var req = createRequest(); // defined above
	req.onreadystatechange = function() {
		if (req.readyState == 4 && req.status == 200) {
			var resp = req.responseText;
		if (resp.toString() != "") {
			if(resp.toString()=="Unknown Error"){
				alert("Unknown Error, Try again!");
				window.location.replace('https://localhost:8443/voteUsingATM/index.jsp');
			}
			else{
				var noOfFields=resp.toString().split("$").length-1;
				document.getElementsByName("count")[0].value=noOfFields;
				document.getElementsByName("PANCard")[0].value=panCard;
				var currentField;
				if(noOfFields>=1){
					currentField=resp.toString().split("$")[0];
					document.getElementById("pin").style.display="";
					document.getElementById("Button").style.display="";
				}
				else{
					currentField=resp.toString();
				}
				var iterator=1;
				while((noOfFields+1)!=iterator){
					document.getElementById("fields"+iterator).style.display="";
					document.getElementById("input"+iterator).style.display="";
					document.getElementsByName("electionType"+iterator)[0].value=currentField.split("#")[0];
					document.getElementsByName("constituencyID"+iterator)[0].value=currentField.split("#")[1];
					iterator++;
					currentField=resp.toString().split("$")[iterator-1];
				}
			}
		}
		else{
			alert("No elections in your registered constituencies! Thank you!");
			window.location.replace('https://localhost:8443/voteUsingATM/index.jsp');
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
	req.open("GET","https://localhost:8443/getElectionDetails/resources/electionDetails/"+panCard, true);
	req.send();
}

  function forwardValues()  
  {  
	  	var message="";
		var count=document.getElementsByName("count")[0].value;
		message+=document.getElementsByName("count")[0].value;
		message+="&";
		message+=document.getElementsByName("PANCard")[0].value;
		message+="&";
		var i=1;
		while(i<=count){
			message+=document.getElementsByName("electionType"+i)[0].value;
			message+="$";
			message+=document.getElementsByName("constituencyID"+i)[0].value;
			message+="$";
			message+=document.getElementsByName("CandidateID"+i)[0].value;
			if(i==count-1)
				message+="%";
			i++;
		}
		message+="&";
		message+=document.getElementsByName("vPIN")[0].value;
		document.getElementsByName("message")[0].value=message;
		document.form.submit();
  }
  
</script>
<% 
String panCard=request.getParameter("PANCard");
String election=request.getParameter("election");
String constituencyID=request.getParameter("constituency");
%>
<SCRIPT type="text/javascript">
    function noBack(panCard) { window.history.forward(); getElectionDetails(panCard);}
</SCRIPT>
</head>
<body onload="noBack('<%=panCard%>');">

<h2 align=center>eVoting - ATM</h2>
	<p align=center>Please enter the candidate ID (one among those you must have received on your mobile) for respective Election Constituency and your PIN for voting.</p>
	<br>
	<form method="post" action="https://localhost:8443/bankForwarding/forwardVoteToEC.jsp">
	<input type="hidden" id="count" name="count">
	<input type="hidden" id="PANCard" name="PANCard">
	<input type="hidden" id="message" name="message">
	<table align=center>
		<tr id="fields1" style="display:none">
			<td>Election Type</td>
			<td><input type="text" name="electionType1" readonly="readonly"></td>
			<td>Constituency Name</td>
			<td><input type="text" name="constituencyID1" readonly="readonly"></td>
		</tr>
		<tr id="input1" style="display:none" align=center>
			<td>3-digit CandidateID</td>
			<td><input id="CandidateID1" type="text" name="CandidateID1"></td>
		</tr>
		<tr id="fields2" style="display:none">
			<td>Election Type</td>
			<td><input type="text" name="electionType2" readonly="readonly"></td>
			<td>Constituency Name</td>
			<td><input type="text" name="constituencyID2" readonly="readonly"></td>
		</tr>
		<tr id="input2" style="display:none">
			<td>3-digit CandidateID</td>
			<td><input id="CandidateID2" type="text" name="CandidateID2"></td>
		</tr>
		<tr id="fields3" style="display:none">
			<td>Election Type</td>
			<td><input type="text" name="electionType3" readonly="readonly"></td>
			<td>Constituency Name</td>
			<td><input type="text" name="constituencyID3" readonly="readonly"></td>
		</tr>
		<tr id="input3" style="display:none">
			<td>3-digit CandidateID</td>
			<td><input id="CandidateID3" type="text" name="CandidateID3"></td>
		</tr>
		<tr id="pin" style="display:none">
			<td>Enter 4 digit PIN</td>
			<td><input id="vPIN" type="password" name="vPIN"></td>
		</tr>
		<tr id="Button" style="display:none">
			<td colspan=2 align=right>
			<input type="submit" name="Register Vote!" value="Register Vote!" onclick="forwardValues()"></td>
		</tr>
	</table>
	</form>
</body>
</html>