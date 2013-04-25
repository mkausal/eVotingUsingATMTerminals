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
				//window.location.replace('options.jsp?ATMCard='+atmCard);
				var url="https://localhost:8443/voteUsingATM/options.jsp";
				var queryString='ATMCard='+atmCard;
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
			}
			if (req.readyState != 4)
				return; // Not there yet
			if (req.status != 200) {
				alert("Server failed to respond, please try again!");
				return;
			}
		}
		// Request successful, read the response
		req.open("GET","https://localhost:8443/authenticatingCustomerPIN/resources/authenticateCustomer/"+ atmCard + "/" + pin, true);
		req.send();
	}
	function postData (url,queryString) {
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
	<h2 align=center>ATM</h2>
	<p align=center>This interface is just used to demonstrate the
		actual functioning of this system.</p>
	<br>
	<table align=center>
		<tr>
			<td>Enter 16-digit ATM card number</td>
			<td><input id="ATMCard" type="text" name="ATMCard" value="9876543210987654"></td>
		</tr>
		<tr>
			<td>Enter 4 digit PIN</td>
			<td><input id="PIN" type="password" name="PIN"></td>
		</tr>
		<tr>
			<td colspan=2 align=right><button onclick="authenticate()">Go!</button></td>
		</tr>
	</table>
</body>
</html>