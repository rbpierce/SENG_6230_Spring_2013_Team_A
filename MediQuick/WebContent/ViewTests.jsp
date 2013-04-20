<%@ page import="domain.*, dao.*, java.util.*" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/header.jsp" %>

<%
	boolean ResultFlag=false;
	int MyReqID=0;
	if(request.getParameter("TESTID")!=null) {
		ResultFlag=true;
		MyReqID = Integer.parseInt(request.getParameter("TESTID"));
	}
	
    ArrayList<LabRequest> Tests = LabTest.getListOfTests_Patient(person.getId());
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Test List</title>
</head>
	
<body>
	<h4>This is the list of previous tests for <%=person.getFirstName() + " " + person.getLastName() %></h4>
	<a href="main.jsp">Back to main page</a>
	<br>
	<a href="/MediQuick/LogOut">Log Out</a>
	<br><br>
	
	
	<table style="width: 600px" border="1">
		<tr>
			<th>Ordering Physician</th>
			<th>Date of Request</th>
			<th>Test Type</th>
			<th>Status</th>
			<th>See Results</th>
		</tr>
		<%
		    for (LabRequest test : Tests) {
		    	if(ResultFlag && (test.getId()!=MyReqID))
		    		continue;
		%>
		
		<tr>
			<td><%=Person.getPersonName(test.getOrderingPhysicianId())%></td>
			<td><%=test.getOrderPlaced() %></td>
			<td><%=test.getSpecimen_type() %></td>
			<td><%=test.getStatus() %></td>
			
			<%	 
			
			if(test.getStatus().equals("Processed"))
			{ %>
			<td>
				<form action="ViewTests.jsp" method="post">
				<input name="TESTID" type="hidden" value=<%=test.getId()%>>
				<input type="submit" value="View Result">
				</form>
			</td>
		<%	}else{ %>
			<td>
				<form action="ViewTests.jsp" method="post">
				<input type="button" disabled value="View Result">
				</form>
			</td>
		<%	} %>
			
		</tr>
		<%
		    }
		%>
	</table>
	
	
	
	<!-- if view result is clicked, the rest is gonna show the result -->
	<br><br>
	<%if(ResultFlag){ 
		int testID = Integer.parseInt(request.getParameter("TESTID"));
		LabResult LR = LabRequest.getResult(testID);
		ArrayList<LabTest> LT = LabRequest.getTests(testID);
		ArrayList<LabResultDetail> LRD = LabResult.getDetails(LR.getId());
	%>
	<h4>Here is the result of the selected test: </h4>
	<a href="ViewTests.jsp">Back to the tests list</a>
	<br>
	
	<table style="width: 600px" border="1">
		<tr>
			<td>Test Name</td>
			<td>Test Abbreviation</td>
			<td>Date Completed</td>
			<td>Result</td>
		</tr>
		
		<%for(int i=0; i<LRD.size(); i++){%>
		<tr>
			<td><%=LT.get(i).getName() %></td>
			<td><%=LT.get(i).getAbbreviation() %></td>
			<td><%=LR.getCompletionDate() %></td>
			<td><%=LRD.get(i).getResult() %></td>
		</tr>
		<%} %>
	
	</table>
	
	
	<%} %>
		
</body>
</html>