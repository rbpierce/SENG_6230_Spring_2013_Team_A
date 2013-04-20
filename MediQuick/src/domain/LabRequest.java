package domain;

import java.util.ArrayList;

import dao.LabRequestDetailRepository;
import dao.LabRequestRepository;
import dao.LabResultRepository;
import dao.LabTestRepository;

public class LabRequest extends LabRequestRepository {

	public static ArrayList<LabRequest> getByLabId(int labID) {
		ArrayList<LabRequest> result = LabRequestRepository.getRequestsOfLab(labID);
		return result;
	}

	public static ArrayList<LabTest> getTests(int reqID) {
		ArrayList<LabTest> List = LabRequestDetailRepository.getTests(reqID);
		return List;
	}
	
	public static int generateResult(int reqID, int TechID)
	{
		//setting the status to "processing"
		LabRequestRepository.updateStatus(reqID, "Processing");
		
		
		LabResultRepository LR = new LabResultRepository();
		int maxID = LabResultRepository.getMaxID();
		LR.setId(maxID);
		
		//today's date
		java.util.Date dt = new java.util.Date();
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String currentTime = sdf.format(dt);
		LR.setCompletionDate(currentTime);
		
		LR.setCompletionStatus("Processed");
		LR.setLabRequestId(reqID);
		LR.setProcessedByTechnicianId(TechID);
		
		
		LR.insert();
		return LR.getId();
	}
	
	public static LabResult getResult(int RequestID)
	{
		LabResult result = LabResultRepository.getResultOfRequest(RequestID);
		return result;
	}

	

}
