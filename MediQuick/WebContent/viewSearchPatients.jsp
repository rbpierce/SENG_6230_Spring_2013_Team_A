<%@ page import="domain.*, dao.*, java.util.*" language="java"
	contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
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
    <title>Patient List</title>
    </head>
<body>

	<teama:checkRole permission="SEARCH_PATIENTS">
		<h4>Search for Patients</h4>

		<a href="/MediQuick/main.jsp">Back to main page</a>
		<br>
		<a href="/MediQuick/LogOut">Log Out</a>
		<br>
		<br>


		<form action="/MediQuick/viewSearchPatients.jsp" method="post">
			<input name="PFIRSTNAME" type="text" placeholder="First Name">
			<input name="PLASTNAME" type="text" placeholder="Last Name">
			<teama:checkRole role="PHYSICIAN">
				<div>
					Only show patients for whom I have ordered tests?
					<input type="radio" name="testsOnly" value="0"/ > No 
					&nbsp;&nbsp;
					<input type="radio"	name="testsOnly" value="1"/ > Yes 
				</div>
			</teama:checkRole>
			<input name="SEAECHED" type="hidden" value="true"> <input
				type="submit" value="Search">
		</form>

		<br>
		<br>

		<!-- printing the list of patients -->
		<table border=1 style="width: 300px">
			<tr>
				<td>Name</td>
				<teama:checkRole role="PHYSICIAN,NURSE">
					<td>View or Order Tests</td>
				</teama:checkRole>
				<teama:checkRole role="TECHNICIAN">
					<td>Process Tests</td>
				</teama:checkRole>
			</tr>

			<%
				for (Person p : patients) {
						String ID = String.valueOf(p.getId());
			%>
			<tr>
				<td><%= p.getDisplayName() %></td>
				<td><a href="/MediQuick/viewPatient.jsp?id=<%=p.getId()%>">Go</a>
				</td>
			</tr>
			<%
				}
			%>
		</table>
		<br />
		<br />
	</teama:checkRole>
	
	<teama:checkRole noPermission="SEARCH_PATIENTS">
	   YOU DO NOT HAVE PERMISSION TO VIEW THIS PAGE	
	</teama:checkRole>
</body>
</html>