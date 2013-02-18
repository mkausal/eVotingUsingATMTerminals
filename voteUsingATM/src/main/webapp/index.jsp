<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ATM</title>
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
	function authenticate() {
		atmCard = document.getElementsByName("ATMCard")[0].value;
		pin = document.getElementsByName("PIN")[0].value;
		//atmCard=ATMCard.value;
		var req = createRequest(); // defined above
		//Create the callback:
		req.onreadystatechange = function() {
			if (req.readyState == 4 && req.status == 200) {
				var resp = req.responseText;
			if (resp.toString() == "authenticated") {
				window.location.replace('options.jsp?ATMCard='+atmCard);
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
		req.open("GET","http://localhost:8080/authenticatingCustomerPIN/resources/authenticateCustomer/"+ atmCard + "/" + pin, true);
		req.send();
	}
</script>
</head>
<body>
	<h2 align=center>ATM</h2>
	<p align=center>This interface is just used to demonstrate the
		actual functioning of this system.</p>
	<br>
	<table align=center>
		<tr>
			<td>Enter 16-digit ATM card number</td>
			<td><input id="ATMCard" type="text" name="ATMCard"></td>
		</tr>
		<tr>
			<td>Enter 4 digit PIN</td>
			<td><input id="PIN" type="text" name="PIN"></td>
		</tr>
		<tr>
			<td colspan=2 align=right><button onclick="authenticate()">Go!</button></td>
		</tr>
	</table>
</body>
</html>