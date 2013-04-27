<%@ page import="domain.*, dao.*, java.util.*" language="java"
	contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<% request.setAttribute("title", "Search for Patients"); %>
<%@ include file="/header.jsp"%>

<%
	String firstName = request.getParameter("PFIRSTNAME")==null ? "" : request.getParameter("PFIRSTNAME");
    String lastName = request.getParameter("PLASTNAME")==null ? "" : request.getParameter("PLASTNAME");
    boolean limitToPhysicianPatients = false;
    if (request.getParameter("testsOnly")!=null && request.getParameter("testsOnly").equals("1") && person.getRole().getName().equals(Role.PHYSICIAN))
    	limitToPhysicianPatients = true;
    ArrayList<Person> patients = Patient.search(
    		(limitToPhysicianPatients?person.getPhysician():null), firstName, lastName);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title><%= title %></title>
    <link type="text/css" rel="stylesheet" href="/MediQuick/resources/main.css" />
    </head>
<body>

    <div id="container">
	<teama:checkRole permission="SEARCH_PATIENTS">
        <%= topLine %>

        <div style="float: left; width: 200px;">
        <h2>Search for Patient:</h2>
		<form action="/MediQuick/viewSearchPatients.jsp" method="post">
			<input name="PFIRSTNAME" type="text" placeholder="First Name"><br />
			<input name="PLASTNAME" type="text" placeholder="Last Name"><br />
			<!-- TODO: Verify functionality
			<teama:checkRole role="PHYSICIAN">
				<div>
					<div style="white-space: nowrap">Only show patients for</div>
					<div style="white-space: nowrap">whom I have ordered tests?</div>
					<input type="radio" name="testsOnly" value="0" checked/ > No 
					&nbsp;&nbsp;
					<input type="radio"	name="testsOnly" value="1"/ > Yes 
				</div><br />
			</teama:checkRole>
			--!>
			<input name="SEAECHED" type="hidden" value="true"> 
			<input type="submit" value="Search" class="button">
		</form>
		</div>

        <div style="float: left">
		<!-- printing the list of patients -->
		<h2>Patient List</h2>
		<table border=1 style="width: 300px">
			<tr>
				<td class="colheader">Name</td>
				<teama:checkRole role="PHYSICIAN,NURSE">
					<td class="colheader">View or Order Tests</td>
				</teama:checkRole>
				<teama:checkRole role="TECHNICIAN">
					<td class="colheader">Process Tests</td>
				</teama:checkRole>
			</tr>

			<%
				for (Person p : patients) {
						String ID = String.valueOf(p.getId());
			%>
			<tr>
				<td><%= p.getDisplayName() %></td>
				<teama:checkRole role="PHYSICIAN,NURSE">
                    <td><a href="/MediQuick/viewPatient.jsp?id=<%= p.getId() %>">View/Order Test</a></td>
                </teama:checkRole>
				<teama:checkRole role="TECHNICIAN">
			    <%   int pendingTests = LabRequestRepository.getTestsForPatient(p.getId(), false).size(); %>			       
                    <td><% if (pendingTests>0) { %>
                        <a href="/MediQuick/viewPatient.jsp?id=<%= p.getId() %>"> Lab Requests Pending (<%= pendingTests %>)</a>
                        <% } else { %>
                        No pending requests
                        <% } %>
                   </td>
                </teama:checkRole>
			</tr>
			<%
				}
			%>
		</table>
		</div>
		<div style="clear: both">
            <button class="button" style="margin-top: 10px;" 
                onClick="document.location='/MediQuick/viewPatient.jsp'; ">Add New Patient</button>
        </div>
		<br />
		<br />
	</teama:checkRole>
	
	<teama:checkRole noPermission="SEARCH_PATIENTS">
	   YOU DO NOT HAVE PERMISSION TO VIEW THIS PAGE	
	</teama:checkRole>
	
	</div>
</body>
</html>