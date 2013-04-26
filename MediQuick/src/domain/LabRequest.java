package domain;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

import dao.DB;
import dao.LabRequestDetailRepository;
import dao.LabRequestRepository;
import dao.LabResultRepository;
import dao.LabTestRepository;

public class LabRequest extends LabRequestRepository {

	
	public LabRequest() {
	}
	
	public LabRequest(String status, int id, int laboratory_id, int patient_id, int requesting_nurse_id, 
			Date nurse_request_time, int ordering_physician_id, Date order_placed, 
			Date specimen_collection_time, String specimen_type, Date urine_collection_start, 
			String specimen_number, int urine_interval_in_minutes, Date urine_collection_finish, 
			int urine_volume_in_milliliters, int icd9_code_id) { 
		this.setStatus(status);                
		this.setId(id);
		this.setLaboratoryId(laboratory_id);
		this.setPatientId(patient_id);
		this.setRequestingNurseId(requesting_nurse_id);
		this.setNurseRequest_time(nurse_request_time);
		this.setOrderingPhysicianId(ordering_physician_id);
		this.setOrderPlaced(order_placed);
		this.setSpecimen_type(specimen_type);
		this.setSpecimen_collection_time(specimen_collection_time);
		this.setSpecimen_number(specimen_number);
		this.setUrine_collection_start(urine_collection_start);
		this.setUrine_collection_finish(urine_collection_finish);
		this.setUrine_interval_in_minutes(urine_interval_in_minutes);
		this.setUrine_volume_in_milliliters(urine_volume_in_milliliters);
		this.setICD9CodeId(icd9_code_id);   		
	}

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
				labRequest.setOrderPlaced(rs.getDate("order_placed"));
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
				labRequest.setOrderPlaced(rs.getDate("order_placed"));
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
