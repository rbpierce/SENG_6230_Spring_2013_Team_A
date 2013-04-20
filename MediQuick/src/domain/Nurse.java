package domain;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import dao.NurseRepository;
import dao.PatientPhysicianAppointmentRepository;

public class Nurse extends NurseRepository{
	
	public Message getMessages(int PersonID)
	{
    	Message m = new Message();
    	m.Columns.add("Patient Name");
    	m.Columns.add("Doctor Name");
    	m.Columns.add("Approve");
    	m.Columns.add("Deny");
    	
    	ArrayList<Integer> DoctorsWorkingWithNurse = Nurse.getRelatedDoctors(PersonID);
    	int count = 0;
    	m.width = 600;
    			
    			
        for(int DrID : DoctorsWorkingWithNurse){	
	    	ResultSet temp = PatientPhysicianAppointmentRepository.getListOfAPhysician(DrID);
	    	
	    	try {
				while (temp.next()) count++;
			
		    	
		    	
		    	while(temp.previous())
		    	{
		    		Message m1 = new Message();
		    		String PatientName = Person.getPersonName(temp.getInt("patient_id"));
		    		m1.Columns.add(PatientName);
		    		String DrName = Person.getPersonName(DrID);
		    		m1.Columns.add(DrName);
		    		
		    		String result = "";
		    		result += "<form action=\"/MediQuick/NurseADAppointmentServlet\" method=\"post\">\n";
	                result += "<input name=\"PATIDApproveAppo\" type=\"hidden\" value=" + temp.getInt("patient_id") + ">\n";
	                result += "<input name=\"PHYSICIANID\" type=\"hidden\" value=" + DrID + ">\n";
	                result += "<input type=\"submit\" value=\"Send Test Order!\">\n";
	                result += "</form>\n";
	                m1.Columns.add(result);
	               
	                result = "<form action=\"/MediQuick/NurseADAppointmentServlet\" method=\"post\">\n";
	                result += "<input name=\"PATIDDenyAppo\" type=\"hidden\" value=" + temp.getInt("patient_id") + ">\n";
	                result += "<input name=\"PHYSICIANID\" type=\"hidden\" value=" + DrID + ">\n";
	                result += "<input type=\"submit\" value=\"Deny!\">\n";
	                result += "</form>\n";
	                m1.Columns.add(result);
	                
	                m.Messages.add(m1);
		    	}
	    	} catch (SQLException e) {
				e.printStackTrace();
			}	
        }
        
        
        if (count == 0)
            return null;
        else if (count == 1)
        	m.title = "You have 1 new appointment request";
        else if (count > 1)
        	m.title = "You have " + count + " new appointment requests";
        
        
        return m;
	}

	public static ArrayList<Integer> getRelatedDoctors(int NurseID) {
		return NurseRepository.getRelatedDoctors(NurseID);
	}

}
