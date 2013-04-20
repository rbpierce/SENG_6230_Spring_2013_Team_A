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
import domain.LabTest;
import domain.Person;

@WebServlet("/NurseADAppointmentServlet")

public class NurseApproveDenyAppointmentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public NurseApproveDenyAppointmentServlet() {
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
            if (request.getParameter("PATIDApproveAppo") != null) {
                int patientID = Integer.parseInt(request.getParameter("PATIDApproveAppo"));
                String patientName = Person.getPersonName(patientID);
                int DrID = Integer.parseInt(request.getParameter("PHYSICIANID"));
                String DrName = Person.getPersonName(DrID);
                String NurseName =  Person.getPersonName(p.getId());
                request.setAttribute("message", NurseName + " is ordering test for " + patientName + ", Sending to Dr. " + DrName);
                request.setAttribute("tests", LabTest.getTests());
                request.setAttribute("Labs", Lab.getLabs());
                request.setAttribute("ICD9s", ICD9Code.getCodes());
                request.setAttribute("PatientID", patientID);
                request.setAttribute("DrID", DrID);
                
                //put a message for the patient to see later
                String newMessage = "Your appointment request with Dr. " + DrName + " was APPROVED by the nurse " + NurseName + ", and is waiting for approval.";
                MessageRepository.PutNewMessage(patientID, newMessage);
                
                PatientPhysicianAppointmentRepository.deletePatientPhysician_appointment(patientID, DrID);
                forward = "OrderTest.jsp";
            }
            if (request.getParameter("PATIDDenyAppo") != null) {
                int patientID = Integer.parseInt(request.getParameter("PATIDDenyAppo"));
                int DrID = Integer.parseInt(request.getParameter("PHYSICIANID"));
                String DrName = Person.getPersonName(DrID);
                String NurseName =  Person.getPersonName(p.getId());
                String patientName = PersonRepository.getPersonName(patientID);
                request.setAttribute("message", "You DENIED the appointment with " + patientName);
                PatientPhysicianAppointmentRepository.deletePatientPhysician_appointment(patientID, DrID);
                
                //put a message for the patient to see later
                String newMessage = "Your appointment request with Dr. " + DrName + " was DENIED by the nurse " + NurseName + ". You can try again making an appointment later.";
                MessageRepository.PutNewMessage(patientID, newMessage);
                
                request.setAttribute("MESSAGES", MainServlet.printMessage(p.getMessages(p.getId())));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher(forward).forward(request, response);
    }

}
