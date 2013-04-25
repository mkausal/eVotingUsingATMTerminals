<%@page import="org.omg.PortableServer.ForwardRequest"%>
<html>
<head>
<title>Forwarding Request...</title>
<script type="text/javascript">
function forwardVote(message) {
	var url="https://localhost:8443/registerVote/validateVote.jsp";
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
}

</script>
<%
String message=request.getParameter("message");
%>
<SCRIPT type="text/javascript">
    window.history.forward();
    function noBack(message) { window.history.forward(); forwardVote(message);}
</SCRIPT>
</head>
<body onload="noBack('<%=message%>');">
<h2 align=center>Voting - ATM</h2>
	<p align=center>Forwarding your request to EC server...</p>
	<br>
	

</body>
</html>
