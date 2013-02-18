<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Options</title>
</head>
<body>
<%
String atmCard=request.getParameter("ATMCard");
%>
<h2 align=center>Options - ATM</h2>
<p align=center>
<a name="FS" id="FS"> Financial Services</a><br>
<a href="nonFinancialServices.jsp?ATMCard=<%=atmCard%>" name="NFS" id="NFS"> Non Financial Services</a><br>
<a href="./index.jsp">Exit</a>
</p>
</body>
</html>
