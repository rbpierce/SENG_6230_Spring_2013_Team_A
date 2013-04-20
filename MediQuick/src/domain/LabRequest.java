package domain;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import dao.DB;
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
	
	
	public static ArrayList<LabRequest> getAllFromResultSet(ResultSet rs) { 
		ArrayList<LabRequest> results = new ArrayList<LabRequest>();
		try { 
			rs.beforeFirst();
			while (rs.next()) {
				LabRequest labRequest = new LabRequest();
				labRequest.setStatus(rs.getString("status"));                
				labRequest.setId(rs.getInt("id"));
				labRequest.setLaboratoryId(rs.getInt("laboratory_id"));
				labRequest.setPatientId(rs.getInt("patient_id"));
				labRequest.setRequestingNurseId(rs.getInt("requesting_nurse_id"));
				labRequest.setNurseRequest_time(rs.getDate("nurse_request_time"));
				labRequest.setOrderingPhysicianId(rs.getInt("ordering_physician_id"));
				labRequest.setOrderPlaced(rs.getString("order_placed"));
				labRequest.setSpecimen_type(rs.getString("specimen_type"));
				labRequest.setSpecimen_collection_time(rs.getDate("specimen_collection_time"));
				labRequest.setSpecimen_number(rs.getString("specimen_number"));
				labRequest.setUrine_collection_start(rs.getDate("urine_collection_start"));
				labRequest.setUrine_collection_finish(rs.getDate("urine_collection_finish"));
				labRequest.setUrine_interval_in_minutes(rs.getInt("urine_interval_in_minutes"));
				labRequest.setUrine_volume_in_milliliters(rs.getInt("urine_volume_in_milliliters"));
				labRequest.setICD9CodeId(rs.getInt("icd9_code_id"));                
				results.add(labRequest);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return results;		
	}

	public static LabRequest getFromResultSet(ResultSet rs) { 
		LabRequest labRequest = null;
		try { 
			rs.beforeFirst();
			if (rs.next()) {
				labRequest = new LabRequest();
				labRequest.setStatus(rs.getString("status"));                
				labRequest.setId(rs.getInt("id"));
				labRequest.setLaboratoryId(rs.getInt("laboratory_id"));
				labRequest.setPatientId(rs.getInt("patient_id"));
				labRequest.setRequestingNurseId(rs.getInt("requesting_nurse_id"));
				labRequest.setNurseRequest_time(rs.getDate("nurse_request_time"));
				labRequest.setOrderingPhysicianId(rs.getInt("ordering_physician_id"));
				labRequest.setOrderPlaced(rs.getString("order_placed"));
				labRequest.setSpecimen_type(rs.getString("specimen_type"));
				labRequest.setSpecimen_collection_time(rs.getDate("specimen_collection_time"));
				labRequest.setSpecimen_number(rs.getString("specimen_number"));
				labRequest.setUrine_collection_start(rs.getDate("urine_collection_start"));
				labRequest.setUrine_collection_finish(rs.getDate("urine_collection_finish"));
				labRequest.setUrine_interval_in_minutes(rs.getInt("urine_interval_in_minutes"));
				labRequest.setUrine_volume_in_milliliters(rs.getInt("urine_volume_in_milliliters"));
				labRequest.setICD9CodeId(rs.getInt("icd9_code_id"));                
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return labRequest;		
	}

}
