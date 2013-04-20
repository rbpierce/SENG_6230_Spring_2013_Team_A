package domain;

import dao.LabTechnicianLaboratoryRepository;
import dao.LabTechnicianRepository;

public class Technician extends LabTechnicianRepository{
	public static int getLabID(int technicianID)
	{
		Lab L = LabTechnicianLaboratoryRepository.getLab(technicianID);
		return L.getId();
	}

}
