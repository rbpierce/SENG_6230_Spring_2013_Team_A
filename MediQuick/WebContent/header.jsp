<%@ page language="java" import="domain.*, dao.*" %>
<%@ taglib uri="/WEB-INF/teama.tld" prefix="teama" %>
    
<%
domain.Person person = (Person) session.getAttribute("person");
if (person==null) {
    System.out.println("No person in session- session expired or illegal access");
    request.getRequestDispatcher("/index.jsp").forward(request, response);
    return;
}
%>
    