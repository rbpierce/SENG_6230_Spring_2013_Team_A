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
	
    <br>
    <br>
    <br>
    <h3> List of <%= person.getRole().getName() %> 's permissions : </h3>
    <div id="ListPanel"> 
			<% for(Permission perm : person.getRole().getPermissions()) { %>
			
			     <a href=<%= perm.getName() %>><%=perm.getDescription() %></a>
			     <br>
			<% } %>
	</div>
	
	<teama:checkRole noPermission="DUMMY PERMISSION">Should be able to see this</teama:checkRole>
	<teama:checkRole permission="DUMMY PERMISSION">Should not be able to see this</teama:checkRole>
	
	
  </body>
</html>