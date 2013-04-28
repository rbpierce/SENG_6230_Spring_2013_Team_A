<%@ page import="domain.*, dao.*, java.util.*, java.text.SimpleDateFormat" language="java"
	contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<% request.setAttribute("title", "View Lab Results"); %>
<%@ include file="/header.jsp"%>

<%
    int labResultId = request.getParameter("id")==null? -1 : Integer.parseInt(request.getParameter("id"));
    if (labResultId<=0) throw new Exception("Illegal access: Lab Result id must be passed");
    LabResult labResult = LabResultRepository.getById(labResultId);
    LabRequest labRequest = LabRequestRepository.getById(labResult.getLabRequestId());
    Patient patient = PatientRepository.getById(labRequest.getPatientId()).getPatient();
    Physician orderingPhysician = PhysicianRepository.getById(labRequest.getOrderingPhysicianId()).getPhysician();
    ICD9Code icd9 = ICD9CodeRepository.getICD9Code(labRequest.getICD9CodeId());
    //ArrayList<LabRequestDetail> testDetails = LabRequestDetailRepository.getAll(labRequest.getId());
    ArrayList<LabResultDetail> resultDetails = new ArrayList<LabResultDetail>(LabResultDetailRepository.getList(labResultId));
    
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title><%= title %></title>
    <link type="text/css" rel="stylesheet" href="/MediQuick/resources/main.css" />
</head>

<body id="requestOrderTest">
	<div id="container">
	   <%= topLine.toString() %>
		<teama:checkRole permission="VIEW_PROCESSED_LAB_RESULTS">

			<form method="POST" action="/MediQuick/SubmitTestResult">
			    <input type="hidden" name="patient_id" value="<%= patient.getId() %>" />
			    <input type="hidden" name="lab_request_id" value="<%= labRequest.getId() %>" />
				<div>
					<div style="float: left; width: 20%">
						<table >
							<tr>
								<td class="required" colspan=4>
									<div class="bold">ORDERING PHYSICIAN/ PHONE #</div> 
									   Dr. <%= orderingPhysician.getDisplayName() %>
								</td>
								<td colspan=2 class="required">
									<div class="bold ">UPIN #</div>
								</td>
							</tr>
							<tr>
							<td class="required" colspan=6>
                                <div>
                                    <span class="bold">ICD-9 Code:</span> 
                                    <%= icd9.getCode() %>
                                </div>
                                <%= icd9.getDescription() %>
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
                                    <%= labRequest.getSpecimen_collection_time()==null?"UNKNOWN":sdfLong.format(labRequest.getSpecimen_collection_time()) %>
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
									<%= labRequest.getUrine_collection_start()==null?"N/A" : sdfLong.format(labRequest.getUrine_collection_start()) %>
								</td>
							</tr>
							<tr>
								<td colspan="4">
									<div class="bold">FINISH:</div> 
                                    <%= labRequest.getUrine_collection_finish()==null?"N/A" : sdfLong.format(labRequest.getUrine_collection_finish()) %>

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
					</div>
					<div style="float: right; width: 75%">
					   <table style="padding-bottom: 30px; float: left">
					       <tr>
					           <td class="bold noborder">Status:</td>
					           <td class="noborder"><%= Util.humancase( labResult.getCompletionStatus() ) %></td>
					       </tr>
					       <tr>
                               <td class="bold noborder">Completed On:</td>
                               <td class="noborder"><%
                                      try { out.print(sdf.format(sdfSQL.parse(labResult.getCompletionDate()))); } catch (Exception e) { out.print(" -- "); } %>
                               </td>
                           </tr>
                           <tr>
                               <td class="bold noborder">Completed By:</td>
                               <td class="noborder"><%= PersonRepository.getById(labResult.getProcessedByTechnicianId()).getDisplayName() %></td>
                           </tr>
                           <tr>
                               <td class="bold noborder">Comments:</td>
                               <td class="noborder"><%= labResult.getCompletionStatusDetails()==null?"&nbsp;":labResult.getCompletionStatusDetails()%></td>
                           </tr>
                       </table>
					
					   <table>
                           <tr>
                               <td class="colheader">Test (Abbrev)</td>
                               <td class="colheader">Test (Description)</td>
                               <td class="colheader">Results</td>
                               <td class="colheader">Comments</td>
                           </tr>
					
					   <% for (LabResultDetail detail: resultDetails) { 
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
					               <%= detail.getResult() %>
					           </td>					   
					           <td>
					               <%= detail.getDetails() %>
					           </td>
					       </tr>
					
					   <% }  %>
					   </table>

                       <div style="float: left; padding-top: 10px;">    
                            <button type='button' class='graybutton' style="margin-top: 10px;"
                                onClick="document.location='/MediQuick/viewPatient.jsp?id=<%= patient.getId() %>'">Back to View Patient</button>
                       </div>
                       <div style="float:right; padding-right: 30px; padding-top: 10px;">
                            <div class="bold" style="text-align: center;">
                                <a href="/MediQuick/PrintTestRequestPDF?id=<%= labRequest.getId() %>" style="text-decoration: none; ">
                                    <img src="/MediQuick/resources/pdf_icon.png" border=0 alt="Download PDF" /><br />View Request
                                </a>
                            </div>    
                       </div>
                       <div style="clear: both"></div>
					</div>
					
					<div style="clear: both"></div>
					
				</div>
			</form>

		</teama:checkRole>

		<teama:checkRole noPermission="VIEW_PROCESSED_LAB_RESULTS">
       YOU DO NOT HAVE PERMISSION TO VIEW THIS PAGE 
    </teama:checkRole>
	</div>

</body>
</html>