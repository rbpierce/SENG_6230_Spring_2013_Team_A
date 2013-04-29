package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.LabRequestRepository;
import dao.LabTestRepository;
import dao.PatientRepository;
import domain.LabRequest;
import domain.LabRequestDetail;
import domain.LabTest;
import domain.Patient;
import domain.Person;
import domain.Role;

@WebServlet("/SavePatient")
public class SavePatient extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
    		throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) 
    		throws ServletException, IOException {

        HttpSession session = request.getSession();
        Person person = (Person) session.getAttribute("person");
        String patientId = request.getParameter("patient_id");
        boolean isNewPatient = patientId==null || patientId.equals("0")? true : false;
        String forwardPage = "/viewPatient.jsp?id=";

    	Patient patient = isNewPatient ? new Patient() : PatientRepository.getById(patientId).getPatient();
    	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
    	
        try {
        	patient.setFirstName(request.getParameter("first_name"));
        	patient.setMiddleName(request.getParameter("middle_name"));
        	patient.setLastName(request.getParameter("last_name"));
        	patient.setBirthDate(request.getParameter("date_of_birth")==null ? null : sdf.parse(request.getParameter("date_of_birth")));
        	patient.setGender(request.getParameter("gender"));
        	patient.setMaritalStatus(request.getParameter("marital_status"));
        	patient.setRole(Role.getRoleByName(Role.PATIENT));
        	patient.setMemberType("PATIENT");
        	int newId = PatientRepository.getMaxID()+1;
        	patient.setId(newId);
        	patient.setPersonId(newId);
        	if (isNewPatient) { 
        		patient.insertPerson(patient);
        		patient.insert(patient);
        	} else { 
        		PatientRepository.updatePerson(patient);
        		PatientRepository.update(patient);        		
        	}
        	forwardPage += patient.getId() + "&msg=" + (isNewPatient ? "New Patient saved!" : "Patient Updated");        	
        } catch (Exception e) {
            e.printStackTrace();
            if (isNewPatient) forwardPage = "/viewSearchPatients.jsp?msg=Adding new patient failed: " + e.getLocalizedMessage();
            else forwardPage += patientId + "&msg=Update patient failed: " + e.getLocalizedMessage();
        }

        request.getRequestDispatcher(forwardPage).forward(request, response);
    }

}
