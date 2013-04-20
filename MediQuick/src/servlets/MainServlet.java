package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.PersonRepository;
import domain.*;

@WebServlet("/MainServlet")
public class MainServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public MainServlet() {
        super();
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,
            IOException {
        doGet(request, response);
    }
    

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,
            IOException {
        HttpSession session = request.getSession();
        if (session!=null) session.invalidate();
        session = request.getSession(true);
        String forward = "main.jsp";
        try {

            if (request.getParameter("j_username") != null) {
                // get user
                String UserName = request.getParameter("j_username");
                String Password = request.getParameter("j_password");

                Person person = PersonRepository.getPerson(UserName, Password);
                PersonRepository p = new Person();
                
                request.setAttribute("MESSAGES",printMessage(p.getMessages(person.getId())));
                
                
                // redirect if found the user
                if (person != null) {
                    session.setAttribute("person", person);
                } else {// if not found, return to main.jsp with error
                    request.setAttribute("Error", "LoginError");
                    forward =  "index.jsp";
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally { 
            request.getRequestDispatcher(forward).forward(request, response);
        }
    }
    
    
    public static String printMessage(Message m)
    {
    	if(m == null) return null;
    	
    	String result="";
    	
    	result = "<h4>" + m.title + "</h4>\n";
    	result += "<table border=\"1\" style=\"width: " + m.width + "\"> \n";
        
    	result += "<tr> \n";
        for(String str: m.Columns)
        	result += "<th>" + str + "</th>\n";
        result += "</tr> \n";
        
        for(Message msg: m.Messages)
        {
        	result += "<tr> \n";
            for(String str: msg.Columns)
            	result += "<th>" + str + "</th>\n";
            result += "</tr> \n";
        }
        
        result += "</table>\n";
    	
    	return result;
    }

}
