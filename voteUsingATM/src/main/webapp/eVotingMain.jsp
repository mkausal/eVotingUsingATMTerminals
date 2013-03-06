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
		window.location.replace('http://localhost:8080/bankForwarding/forwardRequestToEC.jsp?ATMCard='+atmCard+'&otp='+otp);
	}
</script>
</head>
<body>
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