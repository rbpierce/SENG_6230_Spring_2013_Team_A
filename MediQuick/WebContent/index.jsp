
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
      <title>Welcome</title>
    <link type="text/css" rel="stylesheet" href="/MediQuick/resources/main.css" />
      <script type="text/javascript"> 
		function showhide(id, id2, text1, text2){ 
			if (document.getElementById){ 
				obj = document.getElementById(id); 
				obj2 = document.getElementById(id2); 
				if (obj.style.display == "none"){ 
					obj.style.display = ""; 
					obj2.value = text1;
				} else { 
					obj.style.display = "none";
					obj2.value = text2;
					document.getElementById('LoginErrorPanel').style.display = "none";
				} 
			} 
		} 
	 </script> 
  </head>


  <body>
  <div id="container">
    <h2> Welcome to MediQuik Lab Simulator </h2>
	
    <br>
    <h3> You can choose to Login, Or Register if you are a new member </h3>
    <button id="1" onClick="showhide('LoginPanel', '1', 'Cancel Login', 'Login')">Login</button>
   
    <div style="display: none; color:red;" id="LoginErrorPanel" color="red">The UserName and Password combination returned no result; Please try again!
    	<%
		try {
   			 String Error=String.valueOf(request.getAttribute("Error"));
   			 if(!Error.equals("null")){
   		%>
		<script>
			obj = document.getElementById('LoginErrorPanel').style.display = "";
		</script>
		<%
   			 }
   			 else{
		%>
		<script>
			obj = document.getElementById('LoginErrorPanel').style.display = "none";
		</script>
		<%
   			 }
		}
   		catch(Exception e){
   			e.printStackTrace();
   		}
		%>
		
		
    </div>
    <div style="display: none;" id="LoginPanel"> 
		<form action="/MediQuick/MainServlet" method="post">
			<table border="1">
			<tr>
			<td>User Name</td>
			<td><input type="text" name="j_username"></td>
			</tr>
			<tr>
			<td>Password</td>
			<td><input type="password" name="j_password"></td>
			</tr>
			</table>
			<input type="submit" value="Login!">
		</form>	 
	</div>
	
	<p/>
	<p/>
	<button id="2" onClick="showhide('script', '2', 'Register', 'Do Not Register')">Register</button>
	</div>
  </body>
</html>