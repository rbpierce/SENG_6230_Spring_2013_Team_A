package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import domain.LabRequest;
import domain.LabTest;
import domain.Person;
import domain.Technician;

@WebServlet("/ViewLabRequests")
public class ViewLabRequests extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ViewLabRequests() {
        super();
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,
            IOException {
        doGet(request, response);
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,
            IOException {
    
        String forward = "ViewRequests.jsp";
        HttpSession session = request.getSession();
        domain.Person p = (Person) session.getAttribute("person");
        
        try {
        	request.setAttribute("Requests", LabRequest.getByLabId(Technician.getLabID(p.getId())));
        	request.setAttribute("message", "Here is the list of test requests, sent to this lab"); 
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.getRequestDispatcher(forward).forward(request, response);
    }

}
