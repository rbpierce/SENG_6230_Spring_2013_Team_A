<%@ page import="domain.*, dao.*, java.util.*" language="java" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/header.jsp" %>

<%
    ArrayList<LabRequest> Tests = (ArrayList<LabRequest>)request.getAttribute("Requests");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>List of Test Requests</title>
</head>

<body>
	<% String message = request.getAttribute("message").toString();	%>
	<h3><%=message %></h3>
	<a href="main.jsp">Back to main page</a>
	<br>
	 <a href="/MediQuick/LogOut">Logout</a>
	 	<br>
	 

	<table style="width: 600px" border=1>
	<tr>
		<td>Ordering Doctor</td>
		<td>Patient Name</td>
		<td>Fill in The Result</td>
	</tr>
	
	<%for(LabRequest LR: Tests){ %>
	<tr>
		<td><%=Person.getPersonName(LR.getOrderingPhysicianId()) %></td>
		<td><%=Person.getPersonName(LR.getPatientId()) %></td>
		<%if(LR.getStatus().equals("Processed")){
			LabResult LRes = LabRequest.getResult(LR.getId());%>
		<td>
			<form action="ModifyResult.jsp" method="post">
			<input name="ResultID" type="hidden" value=<%=LRes.getId()%>>
			<input type="submit" value="View/Modify Result">
			</form>
		</td>
		<%}else{%>
		<td>
			<form action="/MediQuick/RequestDetails" method="post">
			<input name="ReqID" type="hidden" value=<%=LR.getId()%>>
			<input type="submit" value="Submit the Results">
			</form>
		</td>
		<%} %>
	</tr>
	<%} %>
	
	</table>
</body>
</html>