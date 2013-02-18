<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Non-Financial Services - ATM</title>
</head>
<body>
<%
String atmCard=request.getParameter("ATMCard");
%>
<h2 align=center>Non-Financial Services - ATM</h2>
<p align=center>
<a >Other Services</a><br>
<a href="./votingMain.jsp?ATMCard=<%=atmCard%>">Voting Services</a><br>
<a href="./index.jsp">Exit</a>
</p>
</body>
</html>