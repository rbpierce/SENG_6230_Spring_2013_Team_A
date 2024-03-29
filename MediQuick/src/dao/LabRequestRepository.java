package dao;

//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.util.Iterator;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import domain.LabRequest;
import domain.Nurse;
import domain.Person;
import domain.Physician;

public class LabRequestRepository {

    private int id;

    private int laboratoryId;

    private int patientId;

    private int RequestingNurseId;

    private Date NurseRequest_time;

    private int OrderingPhysicianId;

    private Date OrderPlaced;

    private String Specimen_type;

    private Date Specimen_collection_time;

    private String Specimen_number;

    private Date Urine_collection_start;

    private Date Urine_collection_finish;

    private int Urine_interval_in_minutes;

    private int Urine_volume_in_milliliters;

    private int ICD9CodeId;
    private String Status;

    private static int maxID;
    private static boolean maxIDflag = false;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getLaboratoryId() {
        return laboratoryId;
    }

    public void setLaboratoryId(int laboratoryId) {
        this.laboratoryId = laboratoryId;
    }

    public int getPatientId() {
        return patientId;
    }

    public void setPatientId(int patientId) {
        this.patientId = patientId;
    }

    public int getRequestingNurseId() {
        return RequestingNurseId;
    }

    public void setRequestingNurseId(int requesting_nurse_id) {
        this.RequestingNurseId = requesting_nurse_id;
    }

    public Date getNurseRequest_time() {
        return NurseRequest_time;
    }

    public void setNurseRequest_time(Date nurseRequest_time) {
        this.NurseRequest_time = nurseRequest_time;
    }

    public int getOrderingPhysicianId() {
        return OrderingPhysicianId;
    }

    public void setOrderingPhysicianId(int orderingPhysicianId) {
        this.OrderingPhysicianId = orderingPhysicianId;
    }

    public Date getOrderPlaced() {
        return OrderPlaced;
    }

    public void setOrderPlaced(Date orderPlaced) {
        this.OrderPlaced = orderPlaced;
    }

    public String getSpecimen_type() {
        return Specimen_type;
    }

    public void setSpecimen_type(String specimen_type) {
        this.Specimen_type = specimen_type;
    }

    public Date getSpecimen_collection_time() {
        return Specimen_collection_time;
    }

    public void setSpecimen_collection_time(Date specimen_collection_time) {
        this.Specimen_collection_time = specimen_collection_time;
    }

    public String getSpecimen_number() {
        return Specimen_number;
    }

    public void setSpecimen_number(String specimen_number) {
        this.Specimen_number = specimen_number;
    }

    public Date getUrine_collection_start() {
        return Urine_collection_start;
    }

    public void setUrine_collection_start(Date urine_collection_start) {
        this.Urine_collection_start = urine_collection_start;
    }

    public Date getUrine_collection_finish() {
        return Urine_collection_finish;
    }

    public void setUrine_collection_finish(Date urine_collection_finish) {
        this.Urine_collection_finish = urine_collection_finish;
    }

    public int getUrine_interval_in_minutes() {
        return Urine_interval_in_minutes;
    }

    public void setUrine_interval_in_minutes(int urine_interval_in_minutes) {
        this.Urine_interval_in_minutes = urine_interval_in_minutes;
    }

    public int getUrine_volume_in_milliliters() {
        return Urine_volume_in_milliliters;
    }

    public void setUrine_volume_in_milliliters(int urine_volume_in_milliliters) {
        this.Urine_volume_in_milliliters = urine_volume_in_milliliters;
    }

    public int getICD9CodeId() {
        return ICD9CodeId;
    }

    public void setICD9CodeId(int iCD9CodeId) {
        this.ICD9CodeId = iCD9CodeId;
    }

    public String getStatus() {
        return Status;
    }

    public void setStatus(String status) {
        this.Status = status;
    }

    public LabRequestRepository() {
    }

    //TODO: Replace below code (vulnerable to SQL insertion attack) with PreparedStatement
    public void insert() {
    	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
        String sql = "";
        sql = sql.concat(" insert into lab_request values(");

        if (this.getId() <= 0) {
            int maximumID = LabRequestRepository.getMaxID();
            sql = sql.concat(maximumID + " ,");
        } else
            sql = sql.concat(this.getId() + " ,");

        sql = sql.concat(this.getLaboratoryId() + " ,");
        sql = sql.concat(this.getPatientId() + " ,");

        if (this.getRequestingNurseId() != 0)
            sql = sql.concat(this.getRequestingNurseId() + " ,");
        else
            sql = sql.concat("null , ");

        if (this.getNurseRequest_time() != null)
            sql = sql.concat("'" + sdf.format(this.getNurseRequest_time()) + "' , ");
        else
            sql = sql.concat("null , ");

        sql = sql.concat(this.getOrderingPhysicianId() + " ,");

        if (this.getOrderPlaced() != null)
            sql = sql.concat("'" + sdf.format(this.getOrderPlaced()) + "' , ");

        if (this.getSpecimen_type() != null)
            sql = sql.concat("'" + this.getSpecimen_type() + "' ,");
        else
            sql = sql.concat("'Whole Blood' , ");

        if (this.getSpecimen_collection_time() != null)
            sql = sql.concat("'" + sdf.format(this.getSpecimen_collection_time()) + "' , ");
        else
            sql = sql.concat("null , ");

        if (this.getSpecimen_number() != null)
            sql = sql.concat("'" + this.getSpecimen_number() + "' ,");
        else
            sql = sql.concat("null , ");

        if (this.getUrine_collection_start() != null)
            sql = sql.concat("'" + sdf.format(this.getUrine_collection_start()) + "' , ");
        else
            sql = sql.concat("null , ");

        if (this.getUrine_collection_finish() != null)
            sql = sql.concat("'" + sdf.format(this.getUrine_collection_finish()) + "' , ");
        else
            sql = sql.concat("null , ");

        sql = sql.concat(this.getUrine_interval_in_minutes() + " ,");
        sql = sql.concat(this.getUrine_volume_in_milliliters() + " ,");

        sql = sql.concat(this.getICD9CodeId() + ",");

        if (this.getStatus() != null)
            sql = sql.concat("'" + this.getStatus() + "')");
        else
            sql = sql.concat("'Unseen')");

        System.out.println(sql);
        DB.executeUpdate(sql);
    }

    public static void update(LabRequest objLabRequest) {
    	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");

    	String sql = "";
        sql = sql.concat(" update lab_request set ");

        sql = sql.concat("laboratory_id=" + objLabRequest.getLaboratoryId() + " ,");
        sql = sql.concat("patient_id=" + objLabRequest.getPatientId() + " ,");
        sql = sql.concat("requesting_nurse_id=" + objLabRequest.getRequestingNurseId() + " ,");
        if (objLabRequest.getNurseRequest_time()!=null)
        	sql = sql.concat("nurse_request_time= '" + sdf.format(objLabRequest.getNurseRequest_time()) + "' , ");
        sql = sql.concat("ordering_physician_id=" + objLabRequest.getOrderingPhysicianId() + " ,");
        if (objLabRequest.getOrderPlaced()!=null)
        	sql = sql.concat("order_placed= '" + sdf.format(objLabRequest.getOrderPlaced()) + "' , ");
        sql = sql.concat("specimen_type= '" + objLabRequest.getSpecimen_type() + "' ,");
        if (objLabRequest.getSpecimen_collection_time()!=null)
        	sql = sql.concat("specimen_collection_time= '" + sdf.format(objLabRequest.getSpecimen_collection_time()) + "' , ");
        sql = sql.concat("specimen_number= '" + objLabRequest.getSpecimen_number() + "' ,");
        if (objLabRequest.getUrine_collection_start()!=null)
        	sql = sql.concat("urine_collection_start= '" + sdf.format(objLabRequest.getUrine_collection_start()) + "' , ");
        if (objLabRequest.getUrine_collection_finish()!=null)
        	sql = sql.concat("urine_collection_finish= '" + sdf.format(objLabRequest.getUrine_collection_finish()) + "' , ");
        sql = sql.concat("urine_interval_in_minutes=" + objLabRequest.getUrine_interval_in_minutes() + " ,");
        sql = sql.concat("urine_volume_in_milliliters=" + objLabRequest.getUrine_volume_in_milliliters() + " ,");
        sql = sql.concat("icd9_code_id=" + objLabRequest.getICD9CodeId() + " ,");
        // quit the last ,
        sql = sql.substring(0, sql.length() - 1);
        sql = sql.concat(" where id=" + objLabRequest.getId());
        DB.executeQuery(sql);

    }

    public static List<LabRequest> getList() {

        List<LabRequest> LabRequestList = new ArrayList<LabRequest>();
        String sql = "SELECT * FROM lab_request ";
        ResultSet result = DB.executeQuery(sql);
        LabRequestList = LabRequest.getAllFromResultSet(result);

        return LabRequestList;
    }

    public static LabRequest getById(int id) {

        LabRequest p1 = null;
        ResultSet result = null;
        String sql = "SELECT * FROM lab_request where (id = " + id + ")";

        try {

            result = DB.executeQuery(sql);

            if (result.next()) {
                p1 = new LabRequest();

                p1.setId(result.getInt("id"));

                p1.setLaboratoryId(result.getInt("laboratory_id"));

                p1.setPatientId(result.getInt("patient_id"));

                p1.setRequestingNurseId(result.getInt("requesting_nurse_id"));

                p1.setNurseRequest_time(result.getDate("nurse_request_time"));

                p1.setOrderingPhysicianId(result.getInt("ordering_physician_id"));

                p1.setOrderPlaced(result.getDate("order_placed"));

                p1.setSpecimen_type(result.getString("specimen_type"));

                p1.setSpecimen_collection_time(result.getDate("specimen_collection_time"));

                p1.setSpecimen_number(result.getString("specimen_number"));

                p1.setUrine_collection_start(result.getDate("urine_collection_start"));

                p1.setUrine_collection_finish(result.getDate("urine_collection_finish"));

                p1.setUrine_interval_in_minutes(result.getInt("urine_interval_in_minutes"));

                p1.setUrine_volume_in_milliliters(result.getInt("urine_volume_in_milliliters"));

                p1.setICD9CodeId(result.getInt("icd9_code_id"));
                p1.setStatus(result.getString("status"));
            } else {
                System.out.println("No Results Found!");
                return null;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
        }

        return p1;
    }

    public static int getMaxID() {
        if (maxIDflag) {
            maxID++;
            return maxID;
        }

        maxID = 0;
        maxIDflag = true;

        String sql = "SELECT MAX(id) FROM lab_request";
        ResultSet res = DB.executeQuery(sql);
        try {
            if (res.next())
                maxID = res.getInt("MAX(id)");
        } catch (SQLException e) {
            e.printStackTrace();
        }

        maxID++;
        return maxID;
    }

    public static ArrayList<Person> getPatientsOfDoctor(int DrID) {
        String sql = "SELECT distinct(patient_id) FROM lab_request WHERE (ordering_physician_id=" + DrID + ")";
        ResultSet res = DB.executeQuery(sql);
        ArrayList<Person> List = new ArrayList<Person>();

        try {
            while (res.next()) {
                Person p = Person.getById(res.getInt("patient_id"));
                List.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return List;
    }

    public static ArrayList<LabRequest> getTests_DoctorAndPatient(int PatientID, int DrID) {
        String sql = "SELECT * FROM lab_request WHERE(ordering_physician_id=" + DrID + " AND patient_id=" + PatientID
                + ")";
        LabRequest p1 = null;
        ArrayList<LabRequest> List = new ArrayList<LabRequest>();

        try {
            ResultSet result = DB.executeQuery(sql);

            while (result.next()) {
                p1 = new LabRequest();
                p1.setId(result.getInt("id"));
                p1.setLaboratoryId(result.getInt("laboratory_id"));
                p1.setPatientId(result.getInt("patient_id"));
                p1.setRequestingNurseId(result.getInt("requesting_nurse_id"));
                p1.setNurseRequest_time(result.getDate("nurse_request_time"));
                p1.setOrderingPhysicianId(result.getInt("ordering_physician_id"));
                p1.setOrderPlaced(result.getDate("order_placed"));
                p1.setSpecimen_type(result.getString("specimen_type"));
                p1.setSpecimen_collection_time(result.getDate("specimen_collection_time"));
                p1.setSpecimen_number(result.getString("specimen_number"));
                p1.setUrine_collection_start(result.getDate("urine_collection_start"));
                p1.setUrine_collection_finish(result.getDate("urine_collection_finish"));
                p1.setUrine_interval_in_minutes(result.getInt("urine_interval_in_minutes"));
                p1.setUrine_volume_in_milliliters(result.getInt("urine_volume_in_milliliters"));
                p1.setICD9CodeId(result.getInt("icd9_code_id"));
                p1.setStatus(result.getString("status"));
                List.add(p1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return List;
    }

    public static ArrayList<LabRequest> getTestsForPatient(int patientId) {
        return getTestsForPatient(patientId, null);
    }

    public static ArrayList<LabRequest> getTestsForPatient(int patientId, Boolean completed) {
    	String sql = "";
        if (completed==null) sql = "SELECT req.* FROM lab_request req WHERE req.patient_id=" + patientId;
        else {
        	sql = 	"SELECT req.* FROM lab_request req left join lab_result res ON (req.id=res.lab_request_id) " + 
        			"	WHERE patient_id=" + patientId;
        	if (completed) sql += " AND (res.id IS NOT NULL OR req.status='Denied')";
        	else sql += " AND res.id IS NULL";        	
        }
        sql += " GROUP BY req.id ORDER BY order_placed";
        ArrayList<LabRequest> patientsLabTests = new ArrayList<LabRequest>();

        ResultSet result = DB.executeQuery(sql);
        patientsLabTests = LabRequest.getAllFromResultSet(result);
        return patientsLabTests;
    }
    
	public static ArrayList<LabRequest> getRequestsOfLab(int labID) {
		String sql = "SELECT * FROM lab_request WHERE(laboratory_id=" + labID + ") " + 
					" AND status NOT IN ('WaitingForDoctor','Denied') ORDER BY order_placed";
        ArrayList<LabRequest> requestsOfLab = new ArrayList<LabRequest>();
        ResultSet result = DB.executeQuery(sql);
        requestsOfLab = LabRequest.getAllFromResultSet(result);
        return requestsOfLab;
	}

	public static ArrayList<LabRequest> getRequestsOfLab(int labID, String status) {
		String sql = "SELECT * FROM lab_request WHERE(laboratory_id=" + labID + ") " + 
					" AND status IN (\"" + status + "\") ORDER BY order_placed";
        ArrayList<LabRequest> requestsOfLab = new ArrayList<LabRequest>();
        ResultSet result = DB.executeQuery(sql);
        requestsOfLab = LabRequest.getAllFromResultSet(result);
        return requestsOfLab;
	}
	
	public static void updateStatus(int reqID, String Status) {
		String sql = "";
        sql = "update lab_request set `status`='" + Status + "' where id=" + String.valueOf(reqID) ;
		DB.executeUpdate(sql);
	}
	
	public static ArrayList<LabRequest> getRequestsWaitingForDoctor(int personID) {
		ArrayList<LabRequest> waitingForDoctor = new ArrayList<LabRequest>();
		String sql = "SELECT * FROM lab_request WHERE " + 
					" ordering_physician_id=" + personID + " AND status='WaitingForDoctor'" + 
					" ORDER BY order_placed";
        ResultSet result = DB.executeQuery(sql);
        waitingForDoctor = LabRequest.getAllFromResultSet(result);

		return waitingForDoctor;
	}
	
	public static ArrayList<LabRequest> getRequestsAwaitingResults(Physician physician) { 
		ArrayList<LabRequest> requestAwaitingResults = new ArrayList<LabRequest>();
		String sql = 	"SELECT * FROM lab_request req LEFT JOIN lab_result res ON req.id=res.lab_request_id" + 
						"	WHERE req.ordering_physician_id=" + physician.getPersonId() + 
						" AND status!='Denied' AND res.id IS NULL ORDER BY order_placed";
        ResultSet result = DB.executeQuery(sql);
        requestAwaitingResults = LabRequest.getAllFromResultSet(result);
		return requestAwaitingResults;
	}
	
	public static ArrayList<LabRequest> getRequestsAwaitingPhysicianApproval(Nurse nurse) { 
		if (nurse == null) return null;
		ArrayList<LabRequest> requestAwaitingApproval = new ArrayList<LabRequest>();
		String sql = 	"SELECT * FROM lab_request req" +
						" WHERE req.requesting_nurse_id=" + nurse.getId() + " AND ordering_physician_id IS NULL" + 
						" ORDER BY order_placed";
        ResultSet result = DB.executeQuery(sql);
        requestAwaitingApproval = LabRequest.getAllFromResultSet(result);
		return requestAwaitingApproval;
	}	
	
}