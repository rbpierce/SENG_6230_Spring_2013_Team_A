<%@ page
	import="domain.*, dao.*, java.util.*, java.text.SimpleDateFormat"
	language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<% request.setAttribute("title", "Patient Overview"); %>
<%@ include file="/header.jsp"%>

<%
    int patientId = request.getParameter("id")==null ? -1 : Integer.parseInt(request.getParameter("id"));
	if (person.isPatient()) patientId = person.getId();
    boolean isNewPatient = 	patientId == -1;
	Patient patient = isNewPatient ? new Patient() :  PatientRepository.getById(patientId).getPatient();
	String message = request.getParameter("msg")==null ? "" : request.getParameter("msg");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title> <%= title %></title>
		<link type="text/css" rel="stylesheet" href="/MediQuick/resources/main.css" />
	</head>
	
	<body>
	<div id="container">
		<teama:checkRole permission="VIEW_SUMMARY_PATIENT_DEMOGRAPHICS,VIEW_COMPLETE_PATIENT_DEMOGRAPHICS">
			<%= topLine %>

			<%= message.isEmpty() ?"":"<h3 style='text-align: center; color: darkblue; padding-bottom: 10px;'>" + message + "</h3>" %>
			<div style="float: left; width: 50%;">
			<form method="POST" action="/MediQuick/SavePatient">
				<table class="width300 border">
					<tr>
						<td class="colheader" colspan="2">GENERAL INFO
						</th>
					</tr>
					<tr>
						<td class="label">ID:</td>
						<td>
						  <a href="/MediQuick/viewPatient.jsp?id=<%= patient.getId() %>"><%= patient.getId() %></a>
						  <input type="hidden" name="patient_id" value="<%= patient.getId() %>" />
						</td>
					</tr>
					<tr>
						<td class="label">First Name:</td>
						<td><teama:checkRole permission="EDIT_PATIENT_DEMOGRAPHICS">
								<input type="text" name="first_name"
									value="<%= patient.getFirstName()==null?"":patient.getFirstName() %>" />
							</teama:checkRole> <teama:checkRole noPermission="EDIT_PATIENT_DEMOGRAPHICS">
								<%= patient.getFirstName()==null?"":patient.getFirstName() %>
							</teama:checkRole></td>
					</tr>
					<tr>
						<td class="label">Middle Name:</td>
						<td><teama:checkRole permission="EDIT_PATIENT_DEMOGRAPHICS">
								<input type="text" name="middle_name"
									value="<%= patient.getMiddleName()==null?"":patient.getMiddleName() %>" />
							</teama:checkRole> 
							<teama:checkRole noPermission="EDIT_PATIENT_DEMOGRAPHICS">
								<%= patient.getMiddleName()==null?"":patient.getMiddleName() %>
							</teama:checkRole></td>
					</tr>
					<tr>
						<td class="label">Last Name:</td>
						<td><teama:checkRole permission="EDIT_PATIENT_DEMOGRAPHICS">
								<input type="text" name="last_name"
									value="<%= patient.getLastName()==null?"":patient.getLastName() %>" />
							</teama:checkRole> <teama:checkRole noPermission="EDIT_PATIENT_DEMOGRAPHICS">
								<%= patient.getLastName()==null?"":patient.getLastName() %>
							</teama:checkRole></td>
					</tr>
					<tr>
						<td class="label">Gender:</td>
						<td><teama:checkRole permission="EDIT_PATIENT_DEMOGRAPHICS">
								<select name="gender" size=3>
									<option value="UNKNOWN">Unspecified</option>
									<option value="MALE"
										<%= patient.getGender().equals("MALE")?"SELECTED":"" %>>
										Male</option>
									<option value="FEMALE"
										<%= patient.getGender().equals("FEMALE")?"SELECTED":"" %>>
										Female</option>
								</select>
							</teama:checkRole> <teama:checkRole noPermission="EDIT_PATIENT_DEMOGRAPHICS">
								<%= patient.getGender()==null?"Unspecified":patient.getGender().substring(0,1) + patient.getGender().substring(1).toLowerCase() %>
							</teama:checkRole></td>
					</tr>
					<tr>
						<td class="label">Birth Date:</td>
						<td><teama:checkRole permission="EDIT_PATIENT_DEMOGRAPHICS">
								<input type="text" name="date_of_birth" placeholder="yyyy-mm-dd"
									value="<%= patient.getBirthDate()==null?"": patient.getBirthDate() %>" />
							</teama:checkRole> <teama:checkRole noPermission="EDIT_PATIENT_DEMOGRAPHICS">
								<%= patient.getBirthDate()==null?"":sdf.format(patient.getBirthDate()) %>
							</teama:checkRole></td>
					</tr>
					<tr>
						<td class="label">Marital Status:</td>
						<td><teama:checkRole permission="EDIT_PATIENT_DEMOGRAPHICS">
								<select name="marital_status" size=3>
									<option value="UNREPORTED">Unreported</option>
									<option value="SINGLE"
										<%= patient.getMaritalStatus().equals("SINGLE")?"SELECTED":"" %>>
										Single</option>
									<option value="MARRIED"
										<%= patient.getMaritalStatus().equals("MARRIED")?"SELECTED":"" %>>
										Married</option>
									<option value="DOMESTICPARTNERSHIP"
										<%= patient.getMaritalStatus().equals("DOMESTICPARTNERSHIP")?"SELECTED":"" %>>
										Domestic Partnership</option>
									<option value="DIVORCED"
										<%= patient.getMaritalStatus().equals("DIVORCED")?"SELECTED":"" %>>
										Divorced</option>
									<option value="SEPARATED"
										<%= patient.getMaritalStatus().equals("SEPARATED")?"SELECTED":"" %>>
										Separated</option>
									<option value="WIDOWED"
										<%= patient.getMaritalStatus().equals("WIDOWED")?"SELECTED":"" %>>
										Widowed</option>
								</select>
							</teama:checkRole> <teama:checkRole noPermission="EDIT_PATIENT_DEMOGRAPHICS">
								<%= patient.getMaritalStatus()==null?"Unreported" : 
                                    	patient.getMaritalStatus().equals("DOMESTICPARTNERSHIP") ? 
                                    		"Domestic Partnership" : 
                                    			patient.getMaritalStatus().substring(0,1) + patient.getMaritalStatus().substring(1).toLowerCase() %>
							</teama:checkRole></td>
					</tr>
				</table>
				<teama:checkRole permission="EDIT_PATIENT_DEMOGRAPHICS">
				    <div style="padding-left: 30%">
				    
					   <button class="button" style="margin-top: 10px;" type='submit'>
						  Save
						</button>
				    </div>					
				</teama:checkRole>
			</form>
			</div>

			<!--  Test Pane -->
			<div style="float: left; ">
			<teama:checkRole permission="ORDER_TESTS,REQUEST_TESTS">
				<div>
					<% if (!isNewPatient) { %>

					<button class="button" style="margin-bottom: 10px;"
						onClick="document.location='/MediQuick/requestOrderTest.jsp?patient_id=<%= patientId %>'; ">Order
						New Test</button>
					<% }  %>
				</div>
			</teama:checkRole>
			<table>
				<tr>
					<td class="colheader">Test Ordered</td>
					<td class="colheader">Test Type</td>
					<td class="colheader">Request</td>
					<td class="colheader">Status</td>
					<td class="colheader">Results</td>
				</tr>
				<% for (LabRequest labRequest : LabRequest.getTestsForPatient(patientId)) { 
					 ArrayList<LabResult> results = LabResultRepository.getAllResultsOfRequest(labRequest.getId()); 
				%>
				<tr>
					<td><%= labRequest.getOrderPlaced()==null ? "Pending Approval" : sdf.format(labRequest.getOrderPlaced()) %>
					</td>
					<td><%= labRequest.getSpecimen_type() %></td>
					<td>
					   <a href="/MediQuick/PrintTestRequestPDF?id=<%= labRequest.getId() %>" style="text-decoration: none; ">
                            <img src="/MediQuick/resources/pdf_icon.png" border=0 alt="Download PDF" /><br />View Request
                       </a>
					</td>
					<td>
					   <% if (labRequest.getStatus().equals("Unseen")) { %>
		                       <teama:checkRole permission="PROCESS_LAB_REQUEST">
							       <a href="/MediQuick/processRequest.jsp?lab_request_id=<%= labRequest.getId() %>">Process Request</a>
		                       </teama:checkRole>
					   <% } else {  %>
		                       <%= labRequest.getStatus() %>
				       <% } %>				       
				    </td>
				    <td style="white-space: nowrap">
				        <% if (results.size()==0) { %>
				         None on file
				         <% } else for (LabResult result : results) { %>
				            <div>
                                <a href="/MediQuick/viewResult.jsp?id=<%= result.getId() %>">
				                    <%= Util.humancase(result.getCompletionStatus()) %> - <%= sdf.format(sdfSQL.parse(result.getCompletionDate())) %>
				                </a>
				            </div>
				         <% } %>
				    </td>
				</tr>
				<% } %>

			</table>
            </div>
            <div style="clear: both; "></div>
			<!--  End Test Pane -->
		</teama:checkRole>
		

		<teama:checkRole
			noPermission="VIEW_SUMMARY_PATIENT_DEMOGRAPHICS,VIEW_COMPLETE_PATIENT_DEMOGRAPHICS">
	   YOU DO NOT HAVE PERMISSION TO VIEW THIS PAGE	
	</teama:checkRole>
	</div>

</body>
</html>