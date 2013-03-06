<html>
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
function authenticate(atmCard,otp) {
	var req = createRequest(); // defined above
	req.onreadystatechange = function() {
		if (req.readyState == 4 && req.status == 200) {
			var resp = req.responseText;
		if (resp.toString() != "") {
			if(resp.toString()=="authenticated")
				window.location.replace('http://localhost:8080/bankForwarding/forwardOTPResponseToClient.jsp?PANCard='+panCard+'&status=authenticated');
			else
				window.location.replace('http://localhost:8080/bankForwarding/forwardOTPResponseToClient.jsp?PANCard='+panCard+'&status=failed');
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
	req.open("GET","http://localhost:8080/authenticateOTP/resources/OTPAuthentication/"+panCard+"/"+otp, true);
	req.send();
}
var i=0;
function bodyOnLoad(){
	queryString=window.location.search;
	panCard=queryString.substring(1).split('&')[0].split('=')[1];
	otp=queryString.substring(1).split('&')[1].split('=')[1];
	i++;
	if(document.refreshForm.visited.value==""){
		authenticate(panCard,otp);
		document.refreshForm.visited.value="1";
	}
}
</script>
<body onLoad="javascript:bodyOnLoad()">
<h2 align=center>Voting - ATM</h2>
	<p align=center>EC server authenticating your OTP...</p>
	<br>
<form name="refreshForm">
<input name="visited" type="hidden" value="">
</form>
</body>
</html>
