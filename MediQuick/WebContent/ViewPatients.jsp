<%@ page import="domain.*, dao.*, java.util.*" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/header.jsp" %>

<%
	boolean ResultFlag=false;
	int MyReqID=0;
	if(request.getAttribute("TESTID")!=null) {
		ResultFlag=true;
		MyReqID = Integer.parseInt(request.getAttribute("TESTID").toString());
	}
    ArrayList<LabRequest> Tests = LabTest.getListOfTests_Patient(person.getId());
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Patient List</title>





<script type="text/javascript" src="js/jquery.min.js"></script> 
<script type="text/javascript" src="js/jquery.min.js">
  
      function getData(DATA) {
    	  var dataToBeSent  = {
    	            VALUE : DATA //
    	            
    	            }; // you can change parameter name

    	          $.ajax({
    	        	  	type : "POST",
    	                url : "/MediQuick/ViewPatientsServlet", // Your Servlet mapping or JSP(not suggested)
    	                data : "ABC", 
    	                dataType : "html", // Returns HTML as plain text; included script tags are evaluated when inserted in the DOM.
    	                
    	            });
      }



  function TurnRed(ID)
  {
  	document.getElementById("STATUSID"+ID).style.color = "red";
  }


</script>


</head>
<body>
	<%
	//String message = request.getAttribute("message").toString();
	//request.setAttribute("message", message);
	%>
	<h4>Here is the list of your patients</h4>
		
	<a href="main.jsp">Back to main page</a>
	<br>
	<a href="/MediQuick/LogOut">Log Out</a>
	<br><br>
	
	<form action="/MediQuick/ViewPatientsServlet" method="post">
		<input name="PFIRSTNAME" type="text">
		<input name="PLASTNAME" type="text">
		<input name="SEAECHED" type="hidden" value="true">
		<input type="submit" value="Search">
	</form>
	
	<br><br>
	
	<!-- printing the list of Doctor's patients -->
	<%
	ArrayList<Person> PList= null;
	if(request.getAttribute("PatientList")!=null){
		 PList = (ArrayList<Person>)request.getAttribute("PatientList");
		 
	%>

		<table border=1 style="width: 300px">
		<tr>
			<td>Name</td>
			<td>View Tests</td>
		</tr>
	
	<%
		for(Person p: PList)
		{
			String ID = String.valueOf(p.getId());
			String Name = Person.getPersonName(p.getId());
	%>
		<tr>
			<td><%=Name %></td>
			<td>
				<form action="/MediQuick/ViewPatientsServlet" method="post">
				<input name="PATIENTID" type="hidden" value=<%=ID%>>
				<input name="PatientList" type="hidden" value=<%=PList %>>
				<input type="submit" value="View Tests">
				</form>
			</td>
		</tr>	
	<%	} %>
	</table>
	<br><br>
	
	<%
	}
	
	
	//if we have a test list, we'll print it
	if(request.getAttribute("TestList")!=null)
	{
		ArrayList<LabRequest> TestList = (ArrayList<LabRequest>)request.getAttribute("TestList");
		int PID = Integer.parseInt(request.getAttribute("PatientID").toString());
	%>
	
	<table border=1 style="width: 600px">
		<tr>
			<th>Date of Request</th>
			<th>Test Type</th>
			<th>Status</th>
			<th>See Results</th>
		</tr>
	<%	
		for(LabRequest req: TestList)
		{
			if(ResultFlag && (req.getId()!=MyReqID))
	    		continue;
	%>
	<tr>
		<td><%= req.getOrderPlaced()%></td>
		<td><%= req.getSpecimen_type()%></td>
		<td><%= req.getStatus()%></td>
		<%	 
		if(req.getStatus().equals("Processed"))
		{ %>
		<td>
			<form action="/MediQuick/ViewPatientsServlet" method="post">
			<input name="TESTID" type="hidden" value=<%=req.getId()%>>
			<input name="PATIENTID" type="hidden" value=<%=PID%>>
			<input type="submit" value="View Result">
			</form>
		</td>
		<%	}else{ %>
		<td>
			<form action="ViewPatients.jsp" method="post">
			<input type="button" disabled value="View Result">
			</form>
		</td>
		<%	} %>
		
	</tr>
	<%	} %>
	</table>
	<%} %>
	
	
	
	<!-- if view result is clicked, the rest is gonna show the result -->
	<br><br>
	<%if(ResultFlag){ 
		int testID = Integer.parseInt(request.getParameter("TESTID"));
		LabResult LR = LabRequest.getResult(testID);
		ArrayList<LabTest> LT = LabRequest.getTests(testID);
		ArrayList<LabResultDetail> LRD = LabResult.getDetails(LR.getId());
	%>
	<h4>Here is the result of the selected test: </h4>
	<h4>To go back to the list of tests, just click on View Tests button next to the patient.</h4>
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
			<!-- <td><a href="/MediQuick/ModifyResults" onclick="getData('<%=LT.get(i).getName() %>')">Select</a></td>
			 -->
		</tr>
		<%} %>
			
		
	</table>
			
			
			<form action="ModifyResult.jsp" method="post">
			<input type="hidden" name="ResultID" value=<%=LR.getId()%>>
			<input type="submit" value="Modify Result">
			</form>
	
	<%} %>
</body>
</html>