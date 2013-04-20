package servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.LabRequestRepository;
import domain.LabRequest;
import domain.LabTest;
import domain.Person;
import domain.Technician;

@WebServlet("/SaveResults")
public class SaveResults extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public SaveResults() {
        super();
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,
            IOException {
        doGet(request, response);
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,
            IOException {
        request.setAttribute("message", "You have saved the results for that test");
        String forward = "main.jsp";
        HttpSession session = request.getSession();
        domain.Person p = (Person) session.getAttribute("person");
        
        try {
        	int resultID = Integer.parseInt(request.getParameter("ResID"));
        	int requestID = Integer.parseInt(request.getParameter("ReqID"));
        	
        	ArrayList<LabTest> LT = LabRequest.getTests(requestID);
        	for(LabTest test : LT)
        	{
        		String TestValue = request.getParameter(String.valueOf(test.getId()));
        		LabTest.SaveResult(resultID, test.getId(), TestValue);
        	}
        	//setting the status to "processing"
    		LabRequestRepository.updateStatus(requestID, "Processed");
        	    		
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.getRequestDispatcher(forward).forward(request, response);
    }

}
