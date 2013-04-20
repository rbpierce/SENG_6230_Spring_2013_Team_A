<%@ page import="domain.*, dao.*" contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/header.jsp" %>


<html>
  <head>
      <title>Welcome</title>
      
  </head>


  <body>
    <h2> Welcome, <%= person.getFirstName() + " " + person.getLastName() %> </h2>
    <a href="/MediQuick/LogOut">Logout</a>
    
    <%
            String message = "";
            if(request.getAttribute("message")!=null)
                message = request.getAttribute("message").toString();
        %>
    <h4><%= message %></h4>
    
    <%
            if(request.getAttribute("MESSAGES")!=null){
                message = request.getAttribute("MESSAGES").toString();
            }
            else 
                message = "";
        %>
    
    <%= message %>
	
    <teama:checkRole role="PHYSICIAN">
        <h3>Welcome Dr. <%= person.getLastName() %></h3>    
	    <ul>
	        <li>You have <%= LabRequest.getRequestsWaitingForDoctor(person.getId()).size() %> lab requests from nurses awaiting your sign-off</li>
	        <li>You have <%= LabRequest.getRequestsAwaitingResults(person.getPhysician()).size() %> requests pending lab results</li>
	    </ul>
    </teama:checkRole>

    <teama:checkRole role="NURSE">
        <h3>Welcome Nurse. <%= person.getLastName() %></h3>    
        <ul>
            <li>You have <%= LabRequest.getRequestsAwaitingPhysicianApproval(person.getNurse()).size() %> lab requests awaiting physician sign-off</li>
        </ul>   
    </teama:checkRole>
    
     <teama:checkRole role="PATIENT">
        <h3>Welcome <%= person.getDisplayName() %></h3>    
        <ul>
            <li>You have <%= LabRequest.getTestsForPatient(person.getId(), Boolean.FALSE).size() %> pending lab requests which have been ordered for you</li>
            <li>You have <%= LabRequest.getTestsForPatient(person.getId(), Boolean.TRUE).size() %> completed lab requests which have been ordered for you</li>
        </ul>   
    </teama:checkRole>

    <h3> List of <%= person.getRole().getName() %> 's permissions : </h3>
    <div id="ListPanel"> 
			<% for(Permission perm : person.getRole().getPermissions()) { %>
			
			     <a href=<%= perm.getName() %>><%=perm.getDescription() %></a>
			     <br>
			<% } %>
	</div>
	
	<teama:checkRole permission="SEARCH_PATIENTS">
	   <a href="/MediQuick/viewSearchPatients.jsp">Search For Patients</a>	   
    </teama:checkRole>
	
	
  </body>
</html>