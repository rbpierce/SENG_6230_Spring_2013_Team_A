package domain;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletResponse;

import dao.PatientPhysicianAppointmentRepository;
import dao.PersonRepository;
import dao.PhysicianRepository;

public class Physician extends PhysicianRepository {

    public static ArrayList<Physician> getPhysicianList() {
        ArrayList<Physician> physicians = new ArrayList<Physician>();
        try {
            ResultSet physiciansResultSet = PhysicianRepository.getList();

            while (physiciansResultSet.next()) {
                Physician phys = new Physician();
                phys.setId(physiciansResultSet.getInt("person_id"));
                phys.setFirstName(physiciansResultSet.getString("first_name"));
                phys.setLastName(physiciansResultSet.getString("last_name"));
                physicians.add(phys);
            }
            physiciansResultSet.close();
            return physicians;

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }

    }

    public Message getMessages(int PersonID)
	{
    	Message m = new Message();
    	m.Columns.add("Patient Name");
    	m.Columns.add("From Nurse");
    	m.Columns.add("Test Type");
    	m.Columns.add("Details");
    	m.Columns.add("Approve");
    	m.Columns.add("Deny");
    	
    	ArrayList<LabRequest> LRs = LabRequest.getRequestsWaitingForDoctor(PersonID);
    	
    	if(LRs.size() == 0)
    		return null;
    	else if(LRs.size() == 1)
    		m.title = "You have 1 new waiting request";
    	else if (LRs.size() > 1)
        	m.title = "You have " + LRs.size() + " new waiting requests";
        m.width = 900;
    	
    	for(LabRequest LR: LRs)
    	{
    		String PatientName = Person.getPersonName(LR.getPatientId());
    		String NurseName = Person.getPersonName(LR.getRequestingNurseId());
    		String TestType = LR.getSpecimen_type();
    		
    		Message m1 = new Message();
    		m1.Columns.add(PatientName);
    		m1.Columns.add(NurseName);
    		m1.Columns.add(TestType);
    		
    		ArrayList<LabTest> LT = LabRequest.getTests(LR.getId());
    		String TestDetails = "";
    		for(LabTest test: LT)
    			TestDetails += test.getAbbreviation() + " \n";
    		m1.Columns.add(TestDetails);
    		
    		String result = "";
    		result += "<form action=\"/MediQuick/DoctorADRequest\" method=\"post\">\n";
            result += "<input name=\"APPROVED\" type=\"hidden\" value=" + LR.getId() + ">\n";
            result += "<input type=\"submit\" value=\"Approve\">\n";
            result += "</form>\n";
            m1.Columns.add(result);
            
            result = "<form action=\"/MediQuick/DoctorADRequest\" method=\"post\">\n";
            result += "<input name=\"DENIED\" type=\"hidden\" value=" + LR.getId() + ">\n";
            result += "<input type=\"submit\" value=\"Deny\">\n";
            result += "</form>\n";
            m1.Columns.add(result);
            
            m.Messages.add(m1);
    	}
    	
    	return m;
	}
    
    
    
    public static void orderTest() {
        //
    }

}
