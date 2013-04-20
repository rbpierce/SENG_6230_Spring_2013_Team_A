package domain;

import dao.*;

public class Appointment extends PatientPhysicianAppointmentRepository {
	
	
	public static void Add(Person p, int DrID)
	{
		PatientPhysicianAppointmentRepository appo = new PatientPhysicianAppointmentRepository();
        
        appo.setPatientId(p.getId());
        appo.setPhysicianId(DrID);
        appo.insertPatientPhysician_appointment();
	}
}
