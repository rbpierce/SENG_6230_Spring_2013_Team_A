<%@ page import="domain.*, dao.*, java.util.*" language="java"
	contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<% request.setAttribute("title", "Order Test"); %>
<%@ include file="/header.jsp"%>

<%
	ArrayList<ICD9Code> icd9Codes = ICD9CodeRepository.getList();
	ArrayList<LabTest> labTests = LabTestRepository.getList();


    int patientId = request.getParameter("patient_id")==null ? -1 : Integer.parseInt(request.getParameter("patient_id"));
    if (person.isPatient()) patientId = person.getId();
    if (patientId<=0) throw new Exception("Illegal access: Patient id must be passed");
    
    Patient patient = PatientRepository.getById(patientId).getPatient();
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title><%=person.isNurse() ? "Request" : "Order"%> Test</title>
    <link type="text/css" rel="stylesheet" href="/MediQuick/resources/main.css" />
</head>
<body id="requestOrderTest">
    
	<div id="container">
		<teama:checkRole permission="ORDER_TESTS,REQUEST_TESTS">
            <%= topLine %>
			<form method="POST" action="/MediQuick/SubmitTestRequest">
			    <input type="hidden" name="patient_id" value="<%= patientId %>" />
				<div>
					<div style="float: left">
						<table width="150px">
							<tr>
								<td class="required" colspan=4>
									<div class="bold">ORDERING PHYSICIAN/PHONE #</div> 
									<%=person.hasPermission("ORDER_TESTS") ? person.getDisplayName() : ""%>
								</td>
								<td colspan=2 class="required">
									<div class="bold ">UPIN #</div>
								</td>
							</tr>
							<tr>
							<td class="required" colspan=6>
                                    <span class="bold">ICD-9 Code:</span> 
                                    <select name="icd9_code_id">
                                    <% for (ICD9Code i : icd9Codes) { %>
                                        <option value="<%= i.getId() %>"><%= i.getCode() %>: 
                                        <%= i.getDescription().length()>20 ? i.getDescription().substring(0,20) + "..." : i.getDescription() %>
                                        </option>                                    
                                    <% }  %>
                                    </select>
                                </td>
							
							</tr>
							<tr>
								<td colspan="1" class="bold">SPECIMEN<br />TYPE
								</td>
								<td colspan="5">
									<ul id="specimen_types">
										<li><input type="radio" name="specimen_type"
											value="Serum" />Serum &nbsp;&nbsp;</li>
										<li><input type="radio" name="specimen_type"
											value="Urine" />Plasma &nbsp;&nbsp;</li>
										<li><input type="radio" name="specimen_type"
											value="Urine" />Urine &nbsp;&nbsp;</li>
										<li><input type="radio" name="specimen_type" value="CSF" />CSF
											&nbsp;&nbsp;</li>
										<li><input type="radio" name="specimen_type"
											value="Whole Blood" />Whole Blood &nbsp;&nbsp;</li>
										<li><input type="radio" name="specimen_type"
											value="Stool" />Stool &nbsp;&nbsp;</li>
										<li><input type="radio" name="specimen_type"
											value="Amniotic" />Amniotic &nbsp;&nbsp;</li>
										<li><input type="radio" name="specimen_type"
											value="Other" />Other &nbsp;&nbsp;</li>
									</ul>
								</td>
							<tr>
								<td colspan=6 class="required"><span class="bold">DATE
										& TIME COLLECTED: </span> <input type="text"
									name='specimen_collection_time'
									placeholder="yyyy-mm-dd HH:mm:ss" /></td>
							</tr>
							<tr>
								<td colspan=6><span class="bold">SENDER SPECIMEN #:
								</span> <input type="text" name='specimen_number' placeholder="" /></td>
							</tr>
							<tr>
								<td rowspan=4>
									<div class="bold">
										TIMED<br />URINE<br />COLLECTION
									</div>
								</td>
								<td colspan=4>
									<div class="bold">START:</div> <input type="text"
									name="urine_collection_start_date" placeholder="yyyy-mm-dd" />
									<input type="text" name="urine_collection_start_time"
									placeholder="HH:mm" />
								</td>
							</tr>
							<tr>
								<td colspan="4">
									<div class="bold">FINISH:</div> <input type="text"
									name="urine_collection_finish_date" placeholder="yyyy-mm-dd" />
									<input type="text" name="urine_collection_finish_time"
									placeholder="HH:mm" />
								</td>

							</tr>
							<tr>
								<td colspan="4"><span class="bold">INTERVAL (in
										minutes): </span> <input type="text" name="urine_interval_in_minutes" />
								</td>

							</tr>
							<tr>
								<td colspan="4"><span class="bold">TOTAL VOLUME (in
										milliliters): </span> <input type="text"
									name="urine_volume_in_milliliters" /></td>
							</tr>
						</table>
						<center>
							<button class="button" style="margin-top: 10px; min-width: 100px;"
								type="submit">Submit Order</button>
						    <button class="graybutton" style="margin-top: 10px; min-width: 100px;"" 
						          onClick="document.location='/MediQuick/viewPatient.jsp?id=<%= patientId %>'"
                                    type="button">Cancel</button>  								
						</center>
						
					</div>
					<div class="quarter">
						<table>
							<%
								int labTestPrinted = 0;
									for (; labTestPrinted <= Math.ceil(labTests.size() / 3); labTestPrinted++) {
										LabTest printing = labTests.get(labTestPrinted);
							%>
							<tr>
								<td><input type="checkbox" name="labTest"
									value="<%=printing.getId()%>"></td>
								<td><%=printing.getName()%></td>
								<td style="text-align: right;"><%=printing.getAbbreviation()%>
								</td>
							</tr>
							<%
								}
							%>
						</table>
					</div>
					<div class="quarter">
						<table>
							<%
								for (; labTestPrinted <= Math.ceil((labTests.size() / 3) * 2); labTestPrinted++) {
										LabTest printing = labTests.get(labTestPrinted);
							%>
							<tr>
								<td><input type="checkbox" name="labTest"
									value="<%=printing.getId()%>"></td>
								<td><%=printing.getName()%></td>
								<td style="text-align: right;"><%=printing.getAbbreviation()%>
								</td>
							</tr>
							<%
								}
							%>
						</table>
					</div>
					<div class="quarter">
						<table>
							<%
								for (; labTestPrinted < labTests.size(); labTestPrinted++) {
										LabTest printing = labTests.get(labTestPrinted);
							%>
							<tr>
								<td><input type="checkbox" name="labTest"
									value="<%=printing.getId()%>"></td>
								<td><%=printing.getName()%></td>
								<td style="text-align: right;"><%=printing.getAbbreviation()%>
								</td>
							</tr>
							<%
								}
							%>
						</table>
					</div>
					<div style="clear: both"></div>
				</div>
			</form>


		</teama:checkRole>

		<teama:checkRole noPermission="ORDER_TESTS,REQUEST_TESTS">
       YOU DO NOT HAVE PERMISSION TO VIEW THIS PAGE 
    </teama:checkRole>
	</div>

</body>
</html>