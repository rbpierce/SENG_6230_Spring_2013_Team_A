package domain;

import dao.LabTechnicianRepository;
import dao.NurseRepository;
import dao.PatientRepository;
import dao.PersonRepository;
import dao.PhysicianRepository;

public class Person extends PersonRepository {

    public boolean hasPermission(String _permission) {
        for (Permission p : this.getRole().getPermissions()) {
        	if (p.getName().equals(_permission)) return true;
        }
        return false;
    }
    
    public boolean isPhysician() { 
    	return this.getMemberType().equals(MemberType.PHYSICIAN.name());
    }
    public boolean isNurse() { 
    	return this.getMemberType().equals(MemberType.NURSE.name());
    }
    public boolean isPatient() { 
    	return this.getMemberType().equals(MemberType.PATIENT.name());
    }
    public boolean isTechnician() { 
    	return this.getMemberType().equals(MemberType.TECHNICIAN.name());
    }
    public boolean isAdmin() { 
    	return this.getMemberType().equals(MemberType.ADMIN.name());
    }
    public Physician getPhysician() { 
    	if (this.isPhysician()) return PhysicianRepository.getPhysician(this.getId());
    	else return null;
    }
    
    public Nurse getNurse() { 
    	if (this.isNurse()) return NurseRepository.getNurse(this.getId());
    	else return null;
    }
    
    public Patient getPatient() { 
    	if (this.isPatient()) return PatientRepository.getPatient(this.getId());
    	else return null;
    }
    
    public Technician getTechnician() { 
    	if (this.isTechnician()) return LabTechnicianRepository.getLabTechnician(this.getId());
    	else return null;
    }

    public String getTitle() { 
    	if (this.getRole().equals(Role.PHYSICIAN)) return "Dr.";
    	else if (this.getGender().equals("MALE")) return "Mr.";
    	else if (this.getGender().equals("FEMALE")) {
    		if (this.getMaritalStatus().equals("MARRIED")) return "Mrs.";
    		else return "Ms.";
    	} else return "";
    }
    
    public String getDisplayName() { 
    	return getFirstName() + " " + getLastName();
    }
}
