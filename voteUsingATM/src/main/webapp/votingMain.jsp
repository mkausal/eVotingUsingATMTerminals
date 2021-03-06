<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Voting Services - ATM</title>
<script type="text/javascript">
	var input;
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
	function voterRegistration(atmCard) {
		var req = createRequest(); // defined above
		req.onreadystatechange = function() {
			if (req.readyState == 4 && req.status == 200) {
				var resp = req.responseText;
			if (resp.toString() != "") {
				//window.location.replace('options.jsp?ATMCard='+atmCard);
				register(resp.toString());
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
		req.open("GET","https://localhost:8443/customerDetailsRetrieval/resources/getCustomerDetails/"+ atmCard, true);
		req.send();
	}
	function atmCardRegistration(atmCard) {
		var req = createRequest(); // defined above
		req.onreadystatechange = function() {
			if (req.readyState == 4 && req.status == 200) {
				var resp = req.responseText;
			if (resp.toString() != "") {
				alert(resp.toString());				
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
		req.open("GET","https://localhost:8443/registrationOfATMCardForVoting/resources/registerATMCard/"+ atmCard, true);
		req.send();
	}
	function register(panCard) {
		var req = createRequest(); // defined above
		req.onreadystatechange = function() {
			if (req.readyState == 4 && req.status == 200) {
				var resp = req.responseText;
			if (resp.toString() != "") {
				alert(resp.toString());
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
		req.open("GET","https://localhost:8443/registrationOfRightToVote/resources/registerVoter/"+ panCard, true);
		req.send();
	}
	function eVoting(atmCard){
		//window.location.replace('./eVotingMain.jsp?ATMCard='+atmCard);
		forwardToeVoting(atmCard);
	}
	function forwardToeVoting(atmCard) {
		var url="https://localhost:8443/voteUsingATM/eVotingMain.jsp";
		var queryString="ATMCard="+atmCard;
	  var myForm = document.createElement("form");
	  myForm.method="post" ;
	  myForm.action = url ;
	    var myInput = document.createElement("input") ;
	    myInput.setAttribute("name", queryString.split('=')[0]) ;
	    myInput.setAttribute("value", queryString.split('=')[1]);
	    myForm.appendChild(myInput) ;
	
	  document.body.appendChild(myForm) ;
	  myForm.submit() ;
	  document.body.removeChild(myForm) ;
	}
</script>
<SCRIPT type="text/javascript">
    window.history.forward();
    function noBack() { window.history.forward(); }
</SCRIPT>
</head>
<body onload="noBack();">
<%
String atmCard=request.getParameter("ATMCard");
%>
<h2 align=center>Voting Services - ATM</h2>
<p align=center>
<a href="javascript:voterRegistration('<%=atmCard%>')">Voter Registration</a><br>
<a href="javascript:atmCardRegistration('<%=atmCard%>')">Register this card for Voting</a><br>
<a href="javascript:eVoting('<%=atmCard%>')"">Vote</a><br>
<a href="./index.jsp">Exit</a>
</p>
</body>
</html>