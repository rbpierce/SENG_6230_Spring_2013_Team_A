<%@ page import="domain.*, dao.*, java.util.*" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/header.jsp" %>

<%
	int ResultID = Integer.parseInt(request.getParameter("ResultID"));
	LabResult LR = LabResult.getById(ResultID);
	int RequestID = LR.getLabRequestId();
	ArrayList<LabTest> Tests = LabRequest.getTests(RequestID);
	ArrayList<LabResultDetail> LRD = LabResult.getDetails(ResultID);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Enter The Results</title>
</head>
<body>
	
<% String message = "Please modify the result and click on Submit";	%>
	<h3><%=message %></h3>

	<%
		if(person.getMemberType().equals("physician")){
	%>
	<a href="/MediQuick/ViewPatientsServlet">Cancel</a>
	<%
		}else if(person.getMemberType().equals("TECHNICIAN")){
	%>
	<a href="/MediQuick/ViewLabRequests">Cancel</a>
	<%} %>
	
	<br>

	<table style="width: 600px" border=1>
	<tr>
		<td>Request ID</td>
		<td>Test Name</td>
		<td>Abbreviation</td>
		<td>Modify The Result</td>
	</tr>
	
	<form action="/MediQuick/ModifyResults" method="post">
	<%for(LabTest LT: Tests){
		int index=0;
		for(index=0; index<LRD.size(); index++)
			if(LRD.get(index).getLabTestId() == LT.getId())
				break;
	%>
	<tr>
		<td><%=ResultID %></td>
		<td><%=LT.getName() %></td>
		<td><%=LT.getAbbreviation() %></td>
		<td>
			<input name=<%=LT.getId()%> type="text" value=<%=LRD.get(index).getResult()%>>
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