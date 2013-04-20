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

@WebServlet("/RequestDetails")
public class TestResult extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public TestResult() {
        super();
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,
            IOException {
        doGet(request, response);
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,
            IOException {
        request.setAttribute("message", "Please enter the result data :");
        String forward = "EnterResult.jsp";
        HttpSession session = request.getSession();
        domain.Person p = (Person) session.getAttribute("person");
        
        try {
        	int reqID = Integer.parseInt(request.getParameter("ReqID"));
        	//generate a result for the request
    		int resultID = LabRequest.generateResult(reqID, p.getId());
    	
        	request.setAttribute("ResultID", resultID);  
        	request.setAttribute("RequestID", reqID);  
        	
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.getRequestDispatcher(forward).forward(request, response);
    }

}
