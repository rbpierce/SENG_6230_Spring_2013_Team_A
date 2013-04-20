<%@ page import="domain.*, dao.*, java.util.*" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/header.jsp" %>    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<script type="text/javascript">
	function AddToMyList(){
		var a = document.getElementById("TestNames");
		var text = a.value;
		
		var s= document.getElementById('MyTests');
		s.options[s.options.length]= new Option(text, text);
		
        a.removeChild(a[a.selectedIndex]);
        document.Form1.submitButton.style.display = "none";
        document.getElementById("ApproveButton").style.display = "";
       
	}
	
	function RemoveFromMyList(){
		var a = document.getElementById("MyTests");
		var text = a.value;
		
		var s= document.getElementById('TestNames');
		s.options[s.options.length]= new Option(text, text);
		
        a.removeChild(a[a.selectedIndex]);
        document.Form1.submitButton.style.display = "none";
        document.getElementById("ApproveButton").style.display = "";
	}
	
	function ApproveTest()
	{
		var a = document.getElementById("MyTests");
		document.Form1.submitButton.style.display = "";
		document.getElementById("ApproveButton").style.display = "none";
		for(var i=0; i<a.length; i++)
			document.Form1.Testsss.value = document.Form1.Testsss.value + a.options[i].text+"|";
		
	}
	
	function SelectLab(ID)
	{
		document.Form1.Labsss.value = ID;
		document.getElementById("LAB"+ID).style.color = "red";
	}
	
	function SelectCode(ID)
	{
		document.Form1.ICD9sss.value = ID;
		document.getElementById("ICD"+ID).style.color = "red";
	}
</script>



<title>Order Test</title>
</head>
<body>
	<%String Message = request.getAttribute("message").toString(); %>
	<h3><%=Message %></h3>
	
	<br>
	<h4>Below is the list of all tests, you can choose one and add it to your list</h4>
	<h4>Also you should choose a Lab and an ICD9 code in order to proceed</h4>
	
	<% 
		ArrayList<LabTestRepository> TestList = (ArrayList<LabTestRepository>)request.getAttribute("tests");
	%>
	
	<select id="TestNames" name="TestNames" size=10 style="width: 300px" ondblclick="AddToMyList()">
	<%
		for(LabTestRepository LT: TestList)
		{
	%>
		<option><%=LT.getName()%></option>
	<%
		}
	%>
	</select>
	
	<select id="MyTests" name="MyTests" size=10  style="width: 300px" ondblclick="RemoveFromMyList()">
	</select>
	
	<br>
	<br>
	<button id="ApproveButton" onclick="ApproveTest()">Approve</button>
	
	
	
	
	<!-- Now List of Labs -->
	
	<%
	ArrayList<Lab> Labs = (ArrayList<Lab>)request.getAttribute("Labs");
	%>
	
	<br><br>
	<h4>Choose a Lab here (Default is the first Item)</h4>
	<table border=1 style="width: 300px">
	<tr>
		<td>Lab Name</td>
		<td>Lab Address</td>
		<td>Select</td>
	</tr>
	<tr>
	
	<%
		//and now we'll have a row for each lab
		for(Lab L: Labs){
			int LabID = L.getId();
			String LabName = L.getName();
			String LabAddr = L.getStreet1();
	%>
	<tr>
		<td><div id="LAB<%=LabID%>"><%=LabName %></div></td>
		<td><%=LabAddr %></td>
		<td>
			<a href="#" onclick="SelectLab('<%=LabID %>'); return false;">Select</a>
		</td>
	</tr>
	
	<%  } %>
	
	</table>
	
	
	
	
	
	<!-- Now List of ICD9Codes -->
	
	<%
	ArrayList<ICD9Code> Codes = (ArrayList<ICD9Code>)request.getAttribute("ICD9s");
	%>
	
	<br><br>
	<h4>Choose a Code here (Default is the first Item)</h4>
	<table border=1 style="width: 300px">
	
	<tr>
		<td>Code Name</td>
		<td>Select</td>
	</tr>
	
	
	<%
		//and now we'll have a row for each ICD9Code
		for(ICD9Code c : Codes){
			int CodeID = c.getId();
			String Code = c.getCode();			
	%>
	<tr>
		<td><div id="ICD<%=CodeID%>"><%=Code %></div></td>
		
		<td>
			<a href="#" onclick="SelectCode('<%=CodeID %>');return false;">Select</a>
		</td>
	</tr>
	
	<%  }%>
	
	</table>
	
	
	<% int PatientID = Integer.parseInt(request.getAttribute("PatientID").toString());
	   int DrID = Integer.parseInt(request.getAttribute("DrID").toString()); 
	%>
	
	
	
	
	
	<form name="Form1" action="/MediQuick/OrderTestServlet" method="post">
		<input type="hidden" value="" name="Testsss">
		<input type="hidden" value="1" name="Labsss">
		<input type="hidden" value="1" name="ICD9sss">
		<input type="hidden" value="<%=PatientID %>" name="PatientID">
		<input type="hidden" value="<%=DrID %>" name="DrID">
		<input style="display: none" type="submit" value="Submit" name="submitButton">
	</form>	 
	
	
	
	
	
	
	
	
	
	
	
</body>
</html>