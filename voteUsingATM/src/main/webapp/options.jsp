<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Options</title>
<script type="text/javascript">
	function forwardToNFS(atmCard) {
		var url="https://localhost:8443/voteUsingATM/nonFinancialServices.jsp";
		var queryString="ATMCard="+atmCard;
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
    function noBack() { window.history.forward();  }
</SCRIPT>
</head>
<body onload="noBack();">
<%
String atmCard=request.getParameter("ATMCard");
%>
<h2 align=center>Options - ATM</h2>
<p align=center>
<a name="FS" id="FS"> Financial Services</a><br>
<a href="javascript:forwardToNFS('<%=atmCard%>')" name="NFS" id="NFS"> Non Financial Services</a><br>
<a href="./index.jsp">Exit</a>
</p>
</body>
</html>
