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

window.onload=function(){
	queryString=window.location.search;
	panCard=queryString.substring(1).split('&')[0].split('=')[1];
	election=queryString.substring(1).split('&')[1].split('=')[1];
	constituency=queryString.substring(1).split('&')[2].split('=')[1];
	candidateID=queryString.substring(1).split('&')[3].split('=')[1];
	pin=queryString.substring(1).split('&')[4].split('=')[1];
	validate(panCard,election,constituency,candidateID,pin);
}
function validate(panCard,election,constituency,candidateID,pin){
	var req = createRequest(); // defined above
	req.onreadystatechange = function() {
		if (req.readyState == 4 && req.status == 200) {
			var resp = req.responseText;
		if (resp.toString() != "") {
			alert(resp.toString());
			window.location.replace('http://localhost:8080/voteUsingATM/index.jsp');
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
	req.open("GET","http://localhost:8080/registerVote/resources/registerVote/"+panCard+"/"+election+"/"+constituency+"/"+candidateID+"/"+pin, true);
	req.send();
}
</script>
</head>
<body>

</body>
</html>