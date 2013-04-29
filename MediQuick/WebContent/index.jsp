<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%  %>

<html>
  <head>
      <title>Welcome</title>
    <link type="text/css" rel="stylesheet" href="/MediQuick/resources/main.css" />
    
    <script>
    function setUNPW(un, pw) {
    	document.getElementById("j_username").value=un;
    	document.getElementById("j_password").value=pw;
    }
    
    </script>
    
  </head>


  <body>
  <div id="container">
    
    <div style="margin: 0 auto; text-align: center; padding: 30px;">
        <h2 style="margin: 0 auto;"> MediQuik: Lab Request/Result Prototype </h2>

        <h3 style="margin: 0 auto; padding-top: 20px; "> Login Below </h3>
	    <% if (request.getAttribute("Error")!=null && !((String)request.getAttribute("Error")).isEmpty()) { %>
	    <div style="color:red; font-weight: bold;">
	        <%= request.getAttribute("Error") %>		
	    </div>
	    <% } %>
	    <div id="LoginPanel" style="padding: 10px;"> 
			<form action="/MediQuick/MainServlet" method="post">
				<table border="1">
				     <tr>
				         <td class="colheader">User Name</td>
				         <td><input type="text" name="j_username" id="j_username"></td>
				     </tr>
				     <tr>
				         <td class="colheader">Password</td>
				         <td><input type="password" name="j_password" id="j_password"></td>
				     </tr>
				</table>
				<input type="submit" value="Login!" class="button" style="margin-top: 10px;">
			</form>	 
		</div>
		
		<p/>
		<p/>
		<div>
		  <h3>Testing Accounts</h3>
		  <div onClick="setUNPW('ozzy','osbourne')" style="text-decoration: underline; padding: 3px;">
		      Physician: Ozzy Osbourne</div>
		  <div onClick="setUNPW('joe','satriani')" style="text-decoration: underline; padding: 3px;">
		      Lab Technician: Joe Satriani</div>
		  <div onClick="setUNPW('john','petrucci')"style="text-decoration: underline; padding: 3px;">
		      Patient: John Petrucci</div>	
		</div>
		</div>
	</div>
  </body>
</html>