<%@ page import="domain.*, dao.*, java.util.*, java.text.SimpleDateFormat" language="java"
	contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ include file="/header.jsp"%>

<%
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

    int labRequestId = request.getParameter("lab_request_id")==null? -1 : Integer.parseInt(request.getParameter("lab_request_id"));
    if (labRequestId<=0) throw new Exception("Illegal access: Lab Request id must be passed");
    LabRequest labRequest = LabRequestRepository.getById(labRequestId);
    Patient patient = PatientRepository.getById(labRequest.getPatientId()).getPatient();
    Physician orderingPhysician = PhysicianRepository.getById(labRequest.getOrderingPhysicianId()).getPhysician();
    ICD9Code icd9 = ICD9CodeRepository.getICD9Code(labRequest.getICD9CodeId());
    ArrayList<LabRequestDetail> testDetails = LabRequestDetailRepository.getAll(labRequest.getId());
    
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Process Pending Lab Request</title>
    <link type="text/css" rel="stylesheet" href="/MediQuick/resources/main.css" />
</head>

<body id="requestOrderTest">
    <a href="/MediQuick/viewPendingLabRequests.jsp">Back to Pending Lab Requests</a>
	<div id="container">
		<teama:checkRole permission="PROCESS_LAB_REQUEST">

			<form method="POST" action="/MediQuick/SubmitTestResult">
			    <input type="hidden" name="patient_id" value="<%= patient.getId() %>" />
			    <input type="hidden" name="lab_request_id" value="<%= labRequest.getId() %>" />
				<div>
					<div style="float: left; width: 20%">
						<table >
							<tr>
								<td class="required" colspan=4>
									<div class="bold">ORDERING PHYSICIAN/PHONE #</div> 
									   Dr. <%= orderingPhysician.getDisplayName() %>
								</td>
								<td colspan=2 class="required">
									<div class="bold ">UPIN #</div>
								</td>
							</tr>
							<tr>
							<td class="required" colspan=6>
                                    <span class="bold">ICD-9 Code:</span> 
                                    <%= icd9.getCode() %>: <%= icd9.getDescription() %>
                                </td>
							
							</tr>
							<tr>
								<td colspan="1" class="bold">SPECIMEN<br />TYPE
								</td>
								<td colspan="5">
									<%= labRequest.getSpecimen_type() %>
								</td>
							<tr>
								<td colspan=6 class="required"><span class="bold">DATE
										& TIME COLLECTED: </span> 
                                    <%= labRequest.getSpecimen_collection_time()==null?"UNKNOWN":sdf.format(labRequest.getSpecimen_collection_time()) %>
                                </td>
							</tr>
							<tr>
								<td colspan=6><span class="bold">SENDER SPECIMEN #:
								</span><%= labRequest.getSpecimen_number() %></td>
							</tr>
							<tr>
								<td rowspan=4>
									<div class="bold">
										TIMED<br />URINE<br />COLLECTION
									</div>
								</td>
								<td colspan=4>
									<div class="bold">START:</div> 
									<%= labRequest.getUrine_collection_start()==null?"N/A" : sdf.format(labRequest.getUrine_collection_start()) %>
								</td>
							</tr>
							<tr>
								<td colspan="4">
									<div class="bold">FINISH:</div> 
                                    <%= labRequest.getUrine_collection_finish()==null?"N/A" : sdf.format(labRequest.getUrine_collection_finish()) %>

								</td>

							</tr>
							<tr>
								<td colspan="4"><span class="bold">INTERVAL (in minutes): </span> 
                                    <%= labRequest.getUrine_interval_in_minutes() %>
								</td>

							</tr>
							<tr>
								<td colspan="4"><span class="bold">TOTAL VOLUME (in milliliters): </span>  
								    <%= labRequest.getUrine_volume_in_milliliters() %>
								</td>
							</tr>
						</table>
					    <button class="button" style="margin-top: 10px;" type='submit'> Save </button>
						
					</div>
					<div style="float: right; width: 75%">
					   <table>
                           <tr>
                               <th>
                                   Test (Abbrev)
                               </th>
                               <th>Test (Description)</th>
                               <th>Results</th>
                               <th>Comments</th>
                               <th>Rejected</th>
                           </tr>
					
					   <% for (LabRequestDetail detail: testDetails) { 
						    LabTest test = LabTestRepository.getLabTest(detail.getLabTestId());
					   
					   %>
					       <tr>
					           <td>
					               <%= test.getAbbreviation() %>
					           </td>
					           <td>
					               <%= test.getName() %>
					           </td>
					           <td>
					               <textarea name="results_test_<%= detail.getId() %>" cols=30 rows=3 ></textarea>
					           </td>					   
					           <td>
					               <textarea name="comments_test_<%= detail.getId() %>" cols=30 rows=3 ></textarea>
					           </td>
					           <td>
					               <input type="checkbox" name="rejected_test_<%= detail.getId() %>" value="1" />
					               Check this box to reject the test.<br/ >
					           </td>
					       </tr>
					
					   <% }  %>
					   </table>
					   <cite>If a test is rejected for improper specimen, please include in the comments a description of the error.</cite>
					</div>
					<div style="clear: both"></div>
				</div>
			</form>


		</teama:checkRole>

		<teama:checkRole noPermission="PROCESS_LAB_REQUEST">
       YOU DO NOT HAVE PERMISSION TO VIEW THIS PAGE 
    </teama:checkRole>
	</div>

</body>
</html>