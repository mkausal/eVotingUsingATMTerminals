<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Validate Vote</title>
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


function validate(message){
	var url="https://localhost:8443/registerVote/resources/registerVote";
	var myForm = document.createElement("form");
  	myForm.method = "post" ;
  	myForm.action = url ;
    var myInput = document.createElement("input") ;
    myInput.setAttribute("type", "hidden") ;
    myInput.setAttribute("name", "message") ;
    myInput.setAttribute("value", message);
    myForm.appendChild(myInput) ;
    document.body.appendChild(myForm) ;
    myForm.submit() ;
    document.body.removeChild(myForm) ;
	// Request successful, read the response
	//req.open("GET","https://localhost:8443/registerVote/resources/registerVote/", true);
	//req.send();
}
</script>
<%
String message=request.getParameter("message");
%>
<SCRIPT type="text/javascript">
    window.history.forward();
    function noBack(message) { window.history.forward(); validate(message);}
</SCRIPT>
</head>
<body onload="noBack('<%=message%>');">
</head>
<body>

</body>
</html>