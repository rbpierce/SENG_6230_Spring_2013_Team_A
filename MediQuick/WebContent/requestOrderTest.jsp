<%@ page import="domain.*, dao.*, java.util.*" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="/header.jsp" %>    

<%
    ArrayList<ICD9Code> icd9Codes = ICD9CodeRepository.getList();
    ArrayList<LabTest> labTests = LabTestRepository.getList();


%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title><%= person.isNurse() ? "Request" : "Order" %> Test</title>    
<style>
    
    body {
        text-align: center;
        background-color: #dedede;
        margin: 0px;
    }
    #container{
        width: 1000px;
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
        cursor: pointer;
    }
    
    
    
    .bold { font-weight: bold; }
/* to do  td.required { background-image ... } */


    /* Styles specific to requestOrderTest.jsp */  
    #requestOrderTest td { border: 1px solid #000000; }
    #requestOrderTest input[type=text] { width: 80px; }
    #requestOrderTest #specimen_types td { border: 0px; white-space: nowrap; padding: 0; margin: 0;}
    #requestOrderTest div.quarter { width: 20%; float: left; padding-left: 20px; }
    #requestOrderTest {font-size: 10px; }
    </style>
    
    </head>
<body id="requestOrderTest">

    <div id="container">
    <teama:checkRole permission="ORDER_TESTS,REQUEST_TESTS">
    
    <div>
    <div style="float: left">
    <table width="150px">
        <tr>
            <td class="required" colspan=4>
                <div class="bold">ORDERING PHYSICIAN/PHONE #</div>
                <%= person.hasPermission("ORDER_TESTS") ? person.getDisplayName() : "" %>
            </td>
                <td colspan=2 class="required">
                    <div class="bold ">UPIN #</div>
                </td>
            </tr>
            <tr>
                <td colspan="1" class="bold">SPECIMEN<br />TYPE</td>
                <td colspan="5">
                    <table id="specimen_types">
                        <tr>
                            <td>
	                    <input type="radio" name="specimen_type" value="Serum" />Serum &nbsp;&nbsp;
	                    </td><td>
	                    <input type="radio" name="specimen_type" value="Urine" />Plasma &nbsp;&nbsp;
                        </td><td>
	                    <input type="radio" name="specimen_type" value="Urine" />Urine &nbsp;&nbsp;
                        </td><td>
	                    <input type="radio" name="specimen_type" value="CSF" />CSF &nbsp;&nbsp;
	                    </td></tr>
                        <tr>
                        <td>
	                    <input type="radio" name="specimen_type" value="Whole Blood" />Whole Blood &nbsp;&nbsp;
                        </td><td>
	                    <input type="radio" name="specimen_type" value="Stool" />Stool &nbsp;&nbsp;
                        </td><td>
	                    <input type="radio" name="specimen_type" value="Amniotic" />Amniotic &nbsp;&nbsp;
                        </td><td>
	                    <input type="radio" name="specimen_type" value="Other" />Other &nbsp;&nbsp;
	                    </td>
	                </tr>
	                </table>
                </td>
            <tr>
                <td colspan=6  class="required">
                    <div class="bold">DATE & TIME COLLECTED</div>
                        <input type="text" name='specimen_collection_time' placeholder="yyyy-mm-dd HH:mm:ss" />
                </td>
            </tr>
            <tr>
                <td colspan=6>
                    <div class="bold">SENDER SPECIMEN #</div>
                        <input type="text" name='specimen_number' placeholder="" />
                </td>
            </tr>
            <tr>
                <td rowspan=2>
                    <div class="bold">TIMED<br />URINE<br />COLLECTION</div>
                </td>
                <td colspan=2>
                    <div class="bold">DATES</div>
                    <span class="bold">START</span>
                    <input type="text" name="urine_collection_start_date" placeholder="yyyy-mm-dd" />
                </td>
                <td colspan=2>
                    <div class="bold">TIMES</div>
                    <input type="text" name="urine_collection_start_time" placeholder="HH:mm" />
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <span class="bold">FINISH</span>
                    <input type="text" name="urine_collection_finish_date" placeholder="yyyy-mm-dd" />
                </td>
                <td colspan="2">
                    <input type="text" name="urine_collection_finish_time" placeholder="HH:mm" />
                </td>
            </tr>
            <tr>
                <td colspan=3>
                    <div class="bold">INTERVAL (hours,min)</div>
                    <input type="text" name="urine_interval" />
                </td>
                <td colspan=3>
                    <div class="bold">TOTAL VOLUME</div>
                    <input type="text" name="urine_collection_finish_time" placeholder="HH:mm" />
                </td>
            </tr>
            <tr>
                <td colspan=6 class="required">
                    <div class="bold">ICD9 (diagnosis) code</div>
                    <select name="icd9_code">
                        <% for (ICD9Code code : icd9Codes) { %>
                        <option value="<%= code.getId() %>"><%= code.getCode() + ": " + code.getDescription() %></option>
                        <% } %>
                    </select>
                </td>
            </tr>
        </table>
        </div>
        <div class="quarter">
            <%  int labTestPrinted = 0;
                for  (; labTestPrinted <= Math.ceil(labTests.size()/3); labTestPrinted++) {  
                    LabTest printing = labTests.get(labTestPrinted);
            %>
                	<div>
                	   <div style="float: left">
                	       <input type="checkbox" name="labTest" value="<%= printing.getId() %>"><%= printing.getName() %>
                	   </div>
                	   <div style="float: right">
                	       <%= printing.getAbbreviation() %>
                	   </div>
                    </div>
           <%   } %>
        
        </div>
        <div class="quarter">
            <%
                for  (; labTestPrinted <= Math.ceil((labTests.size()/3)*2); labTestPrinted++) {  
                    LabTest printing = labTests.get(labTestPrinted);
            %>
                    <div>
                       <div style="float: left">
                           <input type="checkbox" name="labTest" value="<%= printing.getId() %>"><%= printing.getName() %>
                       </div>
                       <div style="float: right">
                           <%= printing.getAbbreviation() %>
                       </div>
                       <div style="clear:both"></div>
                    </div>
           <%   } %>
        </div>
        <div class="quarter">
            <%
                for  (; labTestPrinted < labTests.size(); labTestPrinted++) {  
                    LabTest printing = labTests.get(labTestPrinted);
            %>
                    <div>
                       <div style="float: left">
                           <input type="checkbox" name="labTest" value="<%= printing.getId() %>"><%= printing.getName() %>
                       </div>
                       <div style="float: right">
                           <%= printing.getAbbreviation() %>
                       </div>
                    </div>
           <%   } %>
        </div>
        <div style="clear: both"></div>
    </div>
        
        

    </teama:checkRole>
    
    <teama:checkRole noPermission="ORDER_TESTS,REQUEST_TESTS">
       YOU DO NOT HAVE PERMISSION TO VIEW THIS PAGE 
    </teama:checkRole>
    </div>
    
</body>
</html>