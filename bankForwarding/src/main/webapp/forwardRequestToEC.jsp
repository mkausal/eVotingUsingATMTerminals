<%@page import="org.omg.PortableServer.ForwardRequest"%>
<html>
<head>
<title>Forwarding Request...</title>
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
function getPANCardNumber(atmCard,otp) {
	var req = createRequest(); // defined above
	req.onreadystatechange = function() {
		if (req.readyState == 4 && req.status == 200) {
			var resp = req.responseText;
		if (resp.toString() != "") {
			panCard=resp.toString();
			//alert(panCard);
			window.location.replace('http://localhost:8080/authenticateOTP/authenticateOTP.jsp?PANCard='+panCard+'&otp='+otp);
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
	req.open("GET","http://localhost:8080/customerDetailsRetrieval/resources/getCustomerDetails/"+ atmCard, true);
	req.send();
}
window.onload=function(){
	queryString=window.location.search;
	atmCard=queryString.substring(1).split('&')[0].split('=')[1];
	otp=queryString.substring(1).split('&')[1].split('=')[1];
	getPANCardNumber(atmCard,otp);
}
</script>
</head>
<body>
<h2 align=center>Voting - ATM</h2>
	<p align=center>Forwarding your request to EC server...</p>
	<br>

</body>
</html>
