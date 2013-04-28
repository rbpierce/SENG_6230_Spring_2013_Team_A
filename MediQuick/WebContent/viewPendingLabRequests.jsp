<%@ page import="domain.*, dao.*, java.util.*, java.text.SimpleDateFormat" language="java"
	contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<% request.setAttribute("title", "Process Pending Lab Requests"); %>
<%@ include file="/header.jsp"%>

<%
    ArrayList<LabRequest> pendingRequests = LabRequest.getRequestsOfLab(person.getTechnician().getLabID(person.getId()),"Unseen");
    
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
	<teama:checkRole permission="PROCESS_LAB_REQUEST">
        <%= topLine.toString()  %>

		<table border=1 style="width: 800px">
			<tr>
				<td class="colheader">Patient</td>
                <td class="colheader">Ordering Physician</td>
                <td class="colheader">Date Ordered</td>
                <td class="colheader">Specimen</td>
                <td class="colheader">Request</td>
                <td class="colheader"></td>
			</tr>

			<%
				for (LabRequest labRequest : pendingRequests) { %>
			<tr>
				<td><%= PatientRepository.getById(labRequest.getPatientId()).getDisplayName() %></td>
				<td>Dr. <%= PhysicianRepository.getById(labRequest.getOrderingPhysicianId()).getDisplayName() %></td>
				<td><%= sdf.format(labRequest.getOrderPlaced()) %></td>
				<td><%= labRequest.getSpecimen_type() %> (# <%= labRequest.getSpecimen_number() %>)</td>
				<td>
                   <a href="/MediQuick/PrintTestRequestPDF?id=<%= labRequest.getId() %>" style="text-decoration: none; ">
                        <img src="/MediQuick/resources/pdf_icon.png" border=0 alt="Download PDF" /><br />View Request
                   </a>
                </td>
				<td><a href="/MediQuick/processRequest.jsp?lab_request_id=<%= labRequest.getId() %>">Update Results</a></td>
				</td>
			</tr>
			<%
				}
			%>
		</table>
		<br />
		<br />
	</teama:checkRole>
	
	<teama:checkRole noPermission="PROCESS_LAB_REQUEST">
	   YOU DO NOT HAVE PERMISSION TO VIEW THIS PAGE	
	</teama:checkRole>
	
	</div>
</body>
</html>