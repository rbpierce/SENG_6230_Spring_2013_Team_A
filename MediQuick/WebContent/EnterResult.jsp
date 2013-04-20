<%@ page import="domain.*, dao.*, java.util.*" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/header.jsp" %>

<%
	int ResultID = Integer.parseInt(request.getAttribute("ResultID").toString());
	int RequestID = Integer.parseInt(request.getAttribute("RequestID").toString());
	ArrayList<LabTest> Tests = LabRequest.getTests(RequestID); 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Enter The Results</title>
</head>
<body>
	
<% String message = request.getAttribute("message").toString();	%>
	<h3><%=message %></h3>

	<table style="width: 600px" border=1>
	<tr>
		<td>Request ID</td>
		<td>Test Name</td>
		<td>Abbreviation</td>
		<td>Fill in The Result</td>
	</tr>
	
	<form action="/MediQuick/SaveResults" method="post">
	<%for(LabTest LT: Tests){ %>
	<tr>
		<td><%=ResultID %></td>
		<td><%=LT.getName() %></td>
		<td><%=LT.getAbbreviation() %></td>
		<td>
			<input name=<%=LT.getId()%> type="text" value='0'>
		</td>
	</tr>
	<%} %>
	<input type="hidden" value=<%=ResultID %> name="ResID">
	<input type="hidden" value=<%=RequestID %> name="ReqID">
	<input type="submit" value="Submit">
	</form>
	
	</table>
</body>
</html>