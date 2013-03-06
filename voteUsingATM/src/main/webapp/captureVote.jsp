<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Capture Vote</title>
<script type="text/javascript">
function registerVote(panCard){
	queryString=window.location.search;
	panCard=queryString.substring(1).split('&')[0].split('=')[1];
	election=queryString.substring(1).split('&')[1].split('=')[1];
	constituency=queryString.substring(1).split('&')[2].split('=')[1];
	candidateID=document.getElementsByName("CandidateID")[0].value;
	pin=document.getElementsByName("vPIN")[0].value;
	url='http://localhost:8080/bankForwarding/forwardVoteToEC.jsp?PANCard='+panCard+'&election=general&constituency=AP060&CandidateID='+candidateID+'&PIN='+pin;
	window.location.replace(url);
}
</script>
</head>
<body>
<% 
String panCard=request.getParameter("PANCard");
%>
<h2 align=center>eVoting - ATM</h2>
	<p align=center>Please enter the candidate ID (one among those you must have received on your mobile) and your PIN for voting.</p>
	<br>
	<table align=center>
		<tr>
			<td>Election Type</td>
			<td>General[Hardcoded for now]</td>
		</tr>
		<tr>
			<td>Constituency Name</td>
			<td>L B Nagar(AP060)[Hardcoded for now]</td>
		</tr>
		<tr>
			<td>3-digit CandidateID</td>
			<td><input id="CandidateID" type="text" name="CandidateID"></td>
		</tr>
		<tr>
			<td>Enter 4 digit PIN</td>
			<td><input id="vPIN" type="password" name="vPIN"></td>
		</tr>
		<tr>
			<td colspan=2 align=right><button onclick="registerVote('<%=panCard%>')">Go!</button></td>
		</tr>
	</table>
</body>
</html>