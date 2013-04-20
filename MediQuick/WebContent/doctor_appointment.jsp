<%@ page import="domain.*, dao.*, java.util.*"
	contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="/header.jsp"%>

<%
    ArrayList<Physician> doctors = Physician.getPhysicianList();
//TEST
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Appointments</title>

</head>
<body>

	<h2>Here are the list of the Doctors:</h2>
	<h4>
		Or, you can <a href="main.jsp">Cancel</a> making the appointment
	</h4>
	<table style="width: 300px" border="1">
		<tr>
			<th>Name</th>
			<th>Request Appointment</th>
		</tr>
		<%
		    for (Physician physician : doctors) {
		%>
		
		<tr>
			<td><%=physician.getFirstName() + " " + physician.getLastName()%></td>
			<td>
				<form action="/MediQuick/DoctorAppointmentServlet" method="post">
					<input name="DRIDAPP" type="hidden" value=<%=physician.getId()%>>
					<input type="submit" value="Make Appointment!">
				</form>
			</td>
		</tr>
		<%
		    }
		%>
	</table>
</body>
</html>