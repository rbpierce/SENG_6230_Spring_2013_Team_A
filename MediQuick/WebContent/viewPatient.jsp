<%@ page import="domain.*, dao.*, java.util.*, java.text.SimpleDateFormat" language="java"
	contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ include file="/header.jsp"%>

<%
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

    int patientId = request.getParameter("id")==null ? -1 : Integer.parseInt(request.getParameter("id"));
	if (person.isPatient()) patientId = person.getId();
	if (patientId<=0) throw new Exception("Illegal access: Patient id must be passed");
	
	Patient patient = PatientRepository.getById(patientId).getPatient();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Patient Overview</title>
    
<style>
    
    body {
        text-align: center;
        background-color: #dedede;
        margin: 0px;
    }
    #container{
        width: 800px;
        margin-left: auto;
        margin-right: auto;
        text-align: left;
        background-color: #ffffff;
        padding: 20px;
        border-left: 1px solid #000000;
        border-right: 1px solid #000000;
        border-bottom: 1px solid #000000;
    }
    h3, h4 {
        margin-top: 0px;
        padding-top: 0px;    
    }

    .width300 { width: 300px; }
    
    td { 
        vertical-align: top;
        padding: 3px;
    
    }
    
    td.label { 
        font-weight: bold; 
        text-align: right; 
    }
    
    th { 
        background-color: #cccccc;
        border-bottom: 1px solid #000000;
        padding: 0px;
    }
    table { 
        padding: 0px; 
        margin: 0px;
        border-spacing:0;
        border-collapse:collapse;
    }
    table.border { 
        border: 1px solid #000000;
        overflow: auto;
    }
    
    .button {
	    font-family: Arial, Helvetica, sans-serif;
	    font-size: 14px;
	    color: #ffffff;
	    padding: 10px 20px;
	    background: -moz-linear-gradient(
	        top,
	        #a3a3a3 0%,
	        #3b3b3b 50%,
	        #242424 50%,
	        #000000);
	    background: -webkit-gradient(
	        linear, left top, left bottom, 
	        from(#a3a3a3),
	        color-stop(0.50, #3b3b3b),
	        color-stop(0.50, #242424),
	        to(#000000));
	    -moz-border-radius: 10px;
	    -webkit-border-radius: 10px;
	    border-radius: 10px;
	    border: 1px solid #000000;
	    -moz-box-shadow:
	        0px 1px 3px rgba(000,000,000,0.5),
	        inset 0px 0px 1px rgba(255,255,255,0.6);
	    -webkit-box-shadow:
	        0px 1px 3px rgba(000,000,000,0.5),
	        inset 0px 0px 1px rgba(255,255,255,0.6);
	    box-shadow:
	        0px 1px 3px rgba(000,000,000,0.5),
	        inset 0px 0px 1px rgba(255,255,255,0.6);
	    text-shadow:
	        0px -1px 0px rgba(000,000,000,1),
	        0px 1px 0px rgba(255,255,255,0.2);
	    text-decoration: none;
	}
    
    </style>
    
    </head>
<body>

    <div id="container">
	<teama:checkRole permission="VIEW_SUMMARY_PATIENT_DEMOGRAPHICS,VIEW_COMPLETE_PATIENT_DEMOGRAPHICS">
		<h4>Patient Overview: <%= patient.getDisplayName() %></h4>

		<a href="/MediQuick/main.jsp">Back to main page</a>
		<br>
		<a href="/MediQuick/LogOut">Log Out</a>
		<br>
		<br>

        <table>
            <tr>
                <td style="padding-right: 40px">
                    <form method="POST" action="#">
                    <table class="width300 border">
                        <tr>
                            <th colspan="2">GENERAL INFO</th>
                        </tr>
                        <tr>
                            <td class="label">ID:</td>
                            <td>
                                <%= patient.getId() %>
                                <input type="hidden" name="ID" value="<%= patient.getId() %>" />
                            </td>
                        </tr>
                         <tr>
                            <td class="label">First Name:</td>
                            <td>
                                <teama:checkRole permission="EDIT_PATIENT_DEMOGRAPHICS">
                                    <input type="text" name="FIRSTNAME" value="<%= patient.getFirstName()==null?"":patient.getFirstName() %>" />                                
                                </teama:checkRole>
                                <teama:checkRole noPermission="EDIT_PATIENT_DEMOGRAPHICS">
                                    <%= patient.getFirstName()==null?"":patient.getFirstName() %>                           
                                </teama:checkRole>
                            </td>
                        </tr>
                         <tr>
                            <td class="label">Middle Name:</td>
                            <td>
                                <teama:checkRole permission="EDIT_PATIENT_DEMOGRAPHICS">
                                    <input type="text" name="MIDDLENAME" value="<%= patient.getMiddleName()==null?"":patient.getMiddleName() %>" />                                
                                </teama:checkRole>
                                <teama:checkRole noPermission="EDIT_PATIENT_DEMOGRAPHICS">
                                    <%= patient.getMiddleName()==null?"":patient.getMiddleName() %>                           
                                </teama:checkRole>
                            </td>
                        </tr>
                         <tr>
                            <td class="label">Last Name:</td>
                            <td>
                                <teama:checkRole permission="EDIT_PATIENT_DEMOGRAPHICS">
                                    <input type="text" name="LASTNAME" value="<%= patient.getLastName()==null?"":patient.getLastName() %>" />                                
                                </teama:checkRole>
                                <teama:checkRole noPermission="EDIT_PATIENT_DEMOGRAPHICS">
                                    <%= patient.getLastName()==null?"":patient.getLastName() %>                           
                                </teama:checkRole>
                            </td>
                        </tr>
                         <tr>
                            <td class="label">Gender:</td>
                            <td>
                                <teama:checkRole permission="EDIT_PATIENT_DEMOGRAPHICS">
                                    <select name="GENDER" size=3>
                                        <option value="UNKNOWN">Unspecified</option>
                                        <option value="MALE" <%= patient.getGender().equals("MALE")?"SELECTED":"" %>> Male</option>
                                        <option value="FEMALE" <%= patient.getGender().equals("FEMALE")?"SELECTED":"" %>> Female</option>
                                    </select>
                                </teama:checkRole>
                                <teama:checkRole noPermission="EDIT_PATIENT_DEMOGRAPHICS">
                                    <%= patient.getGender()==null?"Unspecified":patient.getGender().substring(0,1) + patient.getGender().substring(1).toLowerCase() %>
                                </teama:checkRole>
                            </td>
                        </tr>
                         <tr>
                            <td class="label">Birth Date:</td>
                            <td>
                                <teama:checkRole permission="EDIT_PATIENT_DEMOGRAPHICS">
                                    <input type="text" name="DATEOFBIRTH" value="<%= patient.getBirthDate()==null?"": patient.getBirthDate() %>" />   
                                    <div>yyyy-mm-dd</div>                             
                                </teama:checkRole>
                                <teama:checkRole noPermission="EDIT_PATIENT_DEMOGRAPHICS">
                                    <%= patient.getBirthDate()==null?"":sdf.format(patient.getBirthDate()) %>                           
                                </teama:checkRole>
                            </td>
                        </tr>
                         <tr>
                            <td class="label">Marital Status:</td>
                            <td>
                                <teama:checkRole permission="EDIT_PATIENT_DEMOGRAPHICS">
                                    <select name="MARITALSTATUS" size=3>
                                        <option value="UNREPORTED">Unreported</option>
                                        <option value="SINGLE" <%= patient.getMaritalStatus().equals("SINGLE")?"SELECTED":"" %>> Single</option>
                                        <option value="MARRIED" <%= patient.getMaritalStatus().equals("MARRIED")?"SELECTED":"" %>> Married</option>
                                        <option value="DOMESTICPARTNERSHIP" <%= patient.getMaritalStatus().equals("DOMESTICPARTNERSHIP")?"SELECTED":"" %>> Domestic Partnership</option>
                                        <option value="DIVORCED" <%= patient.getMaritalStatus().equals("DIVORCED")?"SELECTED":"" %>> Divorced</option>
                                        <option value="SEPARATED" <%= patient.getMaritalStatus().equals("SEPARATED")?"SELECTED":"" %>> Separated</option>
                                        <option value="WIDOWED" <%= patient.getMaritalStatus().equals("WIDOWED")?"SELECTED":"" %>> Widowed</option>
                                    </select>
                                </teama:checkRole>
                                <teama:checkRole noPermission="EDIT_PATIENT_DEMOGRAPHICS">
                                    <%= patient.getMaritalStatus()==null?"Unreported" : 
                                    	patient.getMaritalStatus().equals("DOMESTICPARTNERSHIP") ? 
                                    		"Domestic Partnership" : 
                                    			patient.getMaritalStatus().substring(0,1) + patient.getMaritalStatus().substring(1).toLowerCase() %>                           
                                </teama:checkRole>
                            </td>
                        </tr>                       
                        
                    </table>
                    <button class="button" style="margin-top: 10px;" type='submit'> Save </button>
                    </form>
                </td>
                <td>
                <!--  Test Pane -->
                    <div><button href="#" class="button" style="margin-bottom: 10px;" onClick="document.location='somewhere'">Order New Test</button></div>
                    <table class="width300 border">
                        <tr>
                            <th>Test Ordered</th>
                            <th>Test Type</th>
                            <th>Status</th>
                        </tr>
                        <% for (LabRequest labRequest : LabRequest.getTestsForPatient(patientId)) { %>
                        <tr>
                            <td><%= labRequest.getOrderPlaced()==null ? "Pending Approval" : sdf.format(labRequest.getOrderPlaced()) %> </td>
                            <td><%= labRequest.getSpecimen_type() %> </td>
                            <td><%= labRequest.getStatus() %></td>
                        </tr>
                        <% } %>
                    
                    </table>
                
                <!--  End Test Pane -->
            </tr>
             
        
        
        </table>

    </teama:checkRole>
	
	<teama:checkRole noPermission="VIEW_SUMMARY_PATIENT_DEMOGRAPHICS,VIEW_COMPLETE_PATIENT_DEMOGRAPHICS">
	   YOU DO NOT HAVE PERMISSION TO VIEW THIS PAGE	
	</teama:checkRole>
	</div>
	
</body>
</html>