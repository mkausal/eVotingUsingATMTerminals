<html>
<head>
<title>Authenticating OTP</title>
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
function authenticate(panCard,otp) {
	var req = createRequest(); // defined above
	req.onreadystatechange = function() {
		if (req.readyState == 4 && req.status == 200) {
			var resp = req.responseText;
		if (resp.toString() != "") {
			var url="https://localhost:8443/bankForwarding/forwardOTPResponseToClient.jsp";
			var queryString='PANCard='+panCard+'&status='+resp.toString();
		  	var myForm = document.createElement("form");
		  	myForm.method="post" ;
		  	myForm.action = url ;
		    var myInput = document.createElement("input") ;
		    myInput.setAttribute("name", queryString.split('&')[0].split('=')[0]) ;
		    myInput.setAttribute("value", queryString.split('&')[0].split('=')[1]);
		    myForm.appendChild(myInput) ;
		    myInput = document.createElement("input") ;
		    myInput.setAttribute("name", queryString.split('&')[1].split('=')[0]) ;
		    myInput.setAttribute("value", queryString.split('&')[1].split('=')[1]);
		    myForm.appendChild(myInput) ;

		  document.body.appendChild(myForm) ;
		  myForm.submit() ;
		  document.body.removeChild(myForm) ;
			//alert(panCard);
			//window.location.replace('http://localhost:8080/authenticateOTP/authenticateOTP.jsp?PANCard='+panCard+'&otp='+otp);
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
	req.open("GET","https://localhost:8443/authenticateOTP/resources/OTPAuthentication/"+panCard+"/"+otp, true);
	req.send();
}
</script>
<%
String panCard=request.getParameter("PANCard");
String otp=request.getParameter("otp");
%>
<SCRIPT type="text/javascript">
window.history.forward();
function noBack(panCard,otp) { window.history.forward(); authenticate(panCard,otp);}
</SCRIPT>
</head>
<body onload="noBack('<%=panCard%>','<%=otp%>');">
<h2 align=center>Voting - ATM</h2>
	<p align=center>EC server authenticating your OTP...</p>
	<br>
<form name="refreshForm">
<input name="visited" type="hidden" value="">
</form>
</body>
</html>
