<%@ page language="java" import="domain.*, dao.*, java.text.SimpleDateFormat" %>
<%@ taglib uri="/WEB-INF/teama.tld" prefix="teama" %>
    
<%
domain.Person person = (Person) session.getAttribute("person");
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
SimpleDateFormat sdfLong = new SimpleDateFormat("yyyy-MM-dd HH:mm");

if (person==null) {
    System.out.println("No person in session- session expired or illegal access");
    request.getRequestDispatcher("/index.jsp").forward(request, response);
    return;
}

String title = request.getAttribute("title")!=null ? (String)(request.getAttribute("title")) : "MediQuick: Team A";
StringBuffer topLine = new StringBuffer("");
topLine.append("        <div style=\"float: left; width: 20%; text-align: center;\"><a href=\"/MediQuick/main.jsp\">Overview Page</a></div>\n");
topLine.append("        <div style=\"float: left; width: 60%; text-align: center;\">You are logged in as " + person.getDisplayName() + "</div>\n");
topLine.append("        <div style=\"float: right; width: 20%; text-align: center;\"><a href=\"/MediQuick/LogOut\">Log Out</a></div>\n");
topLine.append("        <div style=\"clear: both; \"></div>\n");
topLine.append("        <div style=\"width: 100%; text-align: center;\"> <h2>" + title + "</h2></div>\n");

%>
    