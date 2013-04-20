package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MessageRepository;
import dao.PatientPhysicianAppointmentRepository;
import dao.PersonRepository;
import domain.ICD9Code;
import domain.Lab;
import domain.LabRequest;
import domain.LabTest;
import domain.Person;

@WebServlet("/DoctorADRequest")

public class DoctorApproveDenyRequest extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public DoctorApproveDenyRequest() {
        super();
    }
    
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,
            IOException {
        doGet(request, response);
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,
            IOException {
        // to display
        String result;
        HttpSession session = request.getSession();
        domain.Person p = (Person) session.getAttribute("person");
        String forward = "main.jsp";
        
        try {
            if (request.getParameter("APPROVED") != null) {
               int ReqID = Integer.parseInt(request.getParameter("APPROVED"));
               LabRequest.updateStatus(ReqID, "Unseen"); 
               
               LabRequest LR = LabRequest.getById(ReqID);
               String DrName = Person.getPersonName(LR.getOrderingPhysicianId());
               
               //put a message for the patient to see later
               String newMessage = "Your Test request with Dr. " + DrName + " was APPROVED, and is waiting for the results.";
               MessageRepository.PutNewMessage(LR.getPatientId(), newMessage);
               
               request.setAttribute("MESSAGES", MainServlet.printMessage(p.getMessages(p.getId())));
            }
            if (request.getParameter("DENIED") != null) {
            	int ReqID = Integer.parseInt(request.getParameter("DENIED"));
            	LabRequest.updateStatus(ReqID, "Denied"); 
            	
            	LabRequest LR = LabRequest.getById(ReqID);
                String DrName = Person.getPersonName(LR.getOrderingPhysicianId());
              
                //put a message for the patient to see later
                String newMessage = "Your Test request with Dr. " + DrName + " was DENIED (REQUEST_ID=" + ReqID + "). You have to make another appointment to have another test request.";
                MessageRepository.PutNewMessage(LR.getPatientId(), newMessage);
                
            	request.setAttribute("MESSAGES", MainServlet.printMessage(p.getMessages(p.getId())));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher(forward).forward(request, response);
    }

}
