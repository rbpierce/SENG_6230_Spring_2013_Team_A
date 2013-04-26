package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import domain.LabTest;
import domain.Person;

@WebServlet("/OrderTestServlet")
public class NurseOrdersServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public NurseOrdersServlet() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,
            IOException {
        doGet(request, response);
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,
            IOException {
    	
    	HttpSession session = request.getSession();
        domain.Person p = (Person) session.getAttribute("person");
        
        String TestList = request.getParameter("Testsss");
        int Lab = Integer.parseInt(request.getParameter("Labsss"));
        int ICD9Code = Integer.parseInt(request.getParameter("ICD9sss"));
        int PatientID = Integer.parseInt(request.getParameter("PatientID"));
        int DrID = Integer.parseInt(request.getParameter("DrID")); 
        
        LabTest.RequestTest(TestList, Lab, ICD9Code, PatientID, p.getId(), DrID, "WaitingForDoctor");
        request.setAttribute("message", "You have successfully put your order");

        request.getRequestDispatcher("main.jsp").forward(request, response);
    }

}
