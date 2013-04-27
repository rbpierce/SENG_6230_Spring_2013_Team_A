<%@ page import="domain.*, dao.*" contentType="text/html;charset=UTF-8" language="java" %>
<% request.setAttribute("title", "Overview"); %>
<%@ include file="/header.jsp" %>
<% title =  "Welcome, " + person.getFirstName() + " " + person.getLastName(); %>

<html>
  <head>
      <title>Welcome</title>
    <link type="text/css" rel="stylesheet" href="/MediQuick/resources/main.css" />
      
  </head>


  <body>
    <div id="container">
    <%= topLine %>    
	
    <teama:checkRole role="PHYSICIAN">
        <h3>Welcome, Dr. <%= person.getLastName() %></h3>    
	    <ul>
	        <li>You have <%= LabRequest.getRequestsWaitingForDoctor(person.getId()).size() %> lab requests from nurses awaiting your sign-off</li>
	        <li>You have <%= LabRequest.getRequestsAwaitingResults(person.getPhysician()).size() %> requests pending lab results</li>
	    </ul>
    </teama:checkRole>

     <teama:checkRole role="TECHNICIAN">
        <h3>Welcome, <%= person.getDisplayName() %></h3>    
        <ul>
            <li>You have <%= LabRequest.getRequestsOfLab(person.getTechnician().getLabID(person.getId()),"Unseen").size() %> pending lab requests at your laboratory, which you may complete</li>
        </ul>   
    </teama:checkRole>

    <teama:checkRole role="NURSE">
        <h3>Welcome, Nurse. <%= person.getLastName() %></h3>    
        <ul>
            <li>You have <%= LabRequest.getRequestsAwaitingPhysicianApproval(person.getNurse()).size() %> lab requests awaiting physician sign-off</li>
        </ul>   
    </teama:checkRole>
    
     <teama:checkRole role="PATIENT">
        <h3>Welcome, <%= person.getDisplayName() %></h3>    
        <ul>
            <li>You have <%= LabRequest.getTestsForPatient(person.getId(), Boolean.FALSE).size() %> pending lab requests which have been ordered for you</li>
            <li>You have <%= LabRequest.getTestsForPatient(person.getId(), Boolean.TRUE).size() %> completed lab requests which have been ordered for you</li>
        </ul>   
    </teama:checkRole>   
    
    <teama:checkRole permission="SEARCH_PATIENTS">
	   <div><a href="/MediQuick/viewSearchPatients.jsp">Search For Patients</a></div>
    </teama:checkRole>
    
    <teama:checkRole permission="PROCESS_LAB_REQUEST">
        <div><a href="/MediQuick/viewPendingLabRequests.jsp">View Pending Lab Requests</a></div>
    </teama:checkRole>
    
	</div>
  </body>
</html>
