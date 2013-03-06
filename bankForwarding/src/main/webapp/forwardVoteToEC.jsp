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
function forwardVote(panCard,candidateID,pin) {	
	window.location.replace('http://localhost:8080/registerVote/validateVote.jsp?PANCard='+panCard+'&election=general&constituency=AP060&candidateID='+candidateID+'&pin='+pin);
}
window.onload=function(){
	queryString=window.location.search;
	panCard=queryString.substring(1).split('&')[0].split('=')[1];
	election=queryString.substring(1).split('&')[1].split('=')[1];
	constituency=queryString.substring(1).split('&')[2].split('=')[1];
	candidateID=queryString.substring(1).split('&')[3].split('=')[1];
	pin=queryString.substring(1).split('&')[4].split('=')[1];
	forwardVote(panCard,candidateID,pin);
}
</script>
</head>
<body>
<h2 align=center>Voting - ATM</h2>
	<p align=center>Forwarding your request to EC server...</p>
	<br>

</body>
</html>
