package servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.PatientPhysicianAppointmentRepository;
import dao.PersonRepository;
import dao.PhysicianRepository;
import domain.*;

@WebServlet("/DoctorAppointmentServlet")
public class DoctorAppointmentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public DoctorAppointmentServlet() {
        super();
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,
            IOException {
        doGet(request, response);
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,
            IOException {
    	
    	HttpSession session = request.getSession(true);
    	domain.Person p = (Person) session.getAttribute("person");
       
    	String forward="doctor_appointment.jsp";
     
        // get the list of doctors to display
        try {
            String DrID = request.getParameter("DRIDAPP");
            if (DrID != null) {
                // add this request to Dr's List also
            	Appointment.Add(p, Integer.parseInt(DrID));
                
                // returning to the main page
                request.setAttribute("message", "You have requested an appointment with Dr. " + Person.getPersonName(Integer.parseInt(DrID)));
                forward = "main.jsp";
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher(forward).forward(request, response);
    }

}
