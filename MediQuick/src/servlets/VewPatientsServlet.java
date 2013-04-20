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

@WebServlet("/ViewPatientsServlet")
public class VewPatientsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public VewPatientsServlet() {
        super();
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,
            IOException {
        doGet(request, response);
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,
            IOException {
        request.setAttribute("message", "Here is the list of your patients :");
        String forward = "ViewPatients.jsp";
        HttpSession session = request.getSession();
        domain.Person p = (Person) session.getAttribute("person");
        
        try {
            if (request.getParameter("PATIENTID") != null) {
                int PID = Integer.parseInt(request.getParameter("PATIENTID"));
                request.setAttribute("TestList", LabTest.getListOfTests_DoctorAndPatient(PID, p.getId()));
                request.setAttribute("PatientID", PID);
            }
            
            if(request.getParameter("TESTID")!=null)
            {
            	String TID = request.getParameter("TESTID");
            	request.setAttribute("TESTID", TID);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        if(request.getParameter("SEAECHED")!=null)
        {
        	String PFirstName = request.getParameter("PFIRSTNAME");
        	String PLastName = request.getParameter("PLASTNAME");
        	request.setAttribute("PatientList", LabTest.getListofPatientsByName(p.getId(), PFirstName, PLastName));
        }
        else
        	request.setAttribute("PatientList", LabTest.getListOfPatients(p.getId()));
        
        request.getRequestDispatcher(forward).forward(request, response);
    }

}
