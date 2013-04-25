<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>e-Voting - ATM</title>
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
	function forward(atmCard) {
		otp = document.getElementsByName("OTP")[0].value;
		var url="https://localhost:8443/bankForwarding/forwardRequestToEC.jsp";
		var queryString="ATMCard="+atmCard+"&otp="+otp;
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
<h2 align=center>e-Voting - ATM</h2>
<p align=center>
Please enter your OTP which you must have received on your mobile... <br>
<table align=center>
		<tr>
			<td>OTP</td>
			<td><input id="OTP" type="password" name="OTP"></td>
		</tr>
		<tr>
			<td colspan=2 align=right><button onclick="forward('<%=atmCard%>')">Go!</button></td>
		</tr>
	</table>
</p>

</body>
</html>