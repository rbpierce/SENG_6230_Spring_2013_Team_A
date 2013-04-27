package dao;


import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import domain.LabResult;
import domain.LabResultDetail;

public class LabResultRepository {

    private int id;

    private int labRequestId;

    private int processedByTechnicianId;

    private String completionStatus;

    private String completionStatusDetails;

    private String completionDate;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getLabRequestId() {
        return labRequestId;
    }

    public void setLabRequestId(int labRequestId) {
        this.labRequestId = labRequestId;
    }

    public int getProcessedByTechnicianId() {
        return processedByTechnicianId;
    }

    public void setProcessedByTechnicianId(int processedByTechnicianId) {
        this.processedByTechnicianId = processedByTechnicianId;
    }

    public String getCompletionStatus() {
        return completionStatus;
    }

    public void setCompletionStatus(String completionStatus) {
        this.completionStatus = completionStatus;
    }

    public String getCompletionStatusDetails() {
        return completionStatusDetails;
    }

    public void setCompletionStatusDetails(String completionStatusDetails) {
        this.completionStatusDetails = completionStatusDetails;
    }

    public String getCompletionDate() {
        return completionDate;
    }

    public void setCompletionDate(String completionDate) {
        this.completionDate = completionDate;
    }

    public LabResultRepository() {
    }

    public void insert(LabResultRepository objLab_result) {
        String sql = "";
        sql = sql.concat(" insert into lab_result values");

        sql = sql.concat(objLab_result.getLabRequestId() + " ,");
        sql = sql.concat(objLab_result.getProcessedByTechnicianId() + " ,");
        sql = sql.concat("'" + objLab_result.getCompletionStatus() + "' ,");
        sql = sql.concat("'" + objLab_result.getCompletionStatusDetails() + "'") + " ,";
        sql = sql.concat("'" + objLab_result.getCompletionDate() + "' , ");
        // quit the last ,
        sql = sql.substring(0, sql.length() - 1);
        sql = sql.concat(" )");
        DB.executeQuery(sql);

    }
    
    public void insert()
    {
	    String sql = "";
	    sql = sql.concat(" insert into lab_result values(");
	
	    if (this.getId() <= 0) {
	        int maximumID = LabResultRepository.getMaxID();
	        this.setId(maximumID);
	        sql = sql.concat(maximumID + " ,");
	    } else
	        sql = sql.concat(this.getId() + " ,");
	
	    sql = sql.concat(this.getLabRequestId() + " ,");
	    sql = sql.concat(this.getProcessedByTechnicianId() + " ,");
	
	    if (this.getCompletionStatus() != null)
	        sql = sql.concat("'" + this.getCompletionStatus() + "' ,");
	    else
	        sql = sql.concat("'PROCESSED' , ");
	
	    if (this.getCompletionStatusDetails() != null)
	        sql = sql.concat("'" + this.getCompletionStatusDetails() + "' , ");
	    else
	    	sql = sql.concat("null , ");
	
	    if (this.getCompletionDate() != null)
	        sql = sql.concat("'" + this.getCompletionDate() + "')");
	  
	    System.out.println(sql);
	    DB.executeUpdate(sql);
    }

    public static void update(LabResultRepository objLab_result) {
        String sql = "";
        sql = sql.concat(" update lab_result set ");

        sql = sql.concat("lab_request_id=" + objLab_result.getLabRequestId() + " ,");
        sql = sql.concat("processed_by_technician_id=" + objLab_result.getProcessedByTechnicianId() + " ,");
        sql = sql.concat("completion_status= '" + objLab_result.getCompletionStatus() + "' ,");
        sql = sql.concat("completion_status_details= '" + objLab_result.getCompletionStatusDetails()) + "' ,";
        sql = sql.concat("completion_date= '" + objLab_result.getCompletionDate() );
        sql = sql.concat(" where id=" + objLab_result.getId());
        DB.executeQuery(sql);

    }

    public static List<LabResult> getList() {

        final List<LabResult> labResultList = new ArrayList<LabResult>();
        LabResult p1 = null;

        ResultSet result = null;
        String sql = "SELECT * FROM lab_result ";

        try {

            result = DB.executeQuery(sql);

            while (result.next()) {
                p1 = new LabResult();

                p1.setId(result.getInt("id"));

                p1.setLabRequestId(result.getInt("lab_request_id"));

                p1.setProcessedByTechnicianId(result.getInt("processed_by_technician_id"));

                p1.setCompletionStatus(result.getString("completion_status"));

                p1.setCompletionStatusDetails(result.getString("completion_status_details"));

                p1.setCompletionDate(result.getString("completion_date"));
                labResultList.add(p1);

            }
        } catch (Exception e) {
            System.out.println("Error Sql: " + e.getMessage());
        } finally {
        }

        return labResultList;
    }

    public static LabResult getById(int Id) {

        LabResult p1 = null;
        ResultSet result = null;
        String sql = "SELECT * FROM lab_result where (id = " + Id + ")";

        try {

            result = DB.executeQuery(sql);

            if (result.next()) {
                p1 = new LabResult();

                p1.setId(result.getInt("id"));

                p1.setLabRequestId(result.getInt("lab_request_id"));

                p1.setProcessedByTechnicianId(result.getInt("processed_by_technician_id"));

                p1.setCompletionStatus(result.getString("completion_status"));

                p1.setCompletionStatusDetails(result.getString("completion_status_details"));

                p1.setCompletionDate(result.getString("completion_date"));

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
        int maxID = 0;
        String sql = "SELECT MAX(id) FROM lab_result";
        ResultSet res = DB.executeQuery(sql);
        try {
            if (res.next())
                maxID = res.getInt("MAX(id)");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return maxID+1;
    }

	public static LabResult getResultOfRequest(int requestID) {
		LabResult p1 = null;
		String sql = "SELECT * FROM lab_result WHERE(lab_request_id=" + requestID + ")";
		ResultSet result = DB.executeQuery(sql);
		try {
			if(result.next())
			{
				p1 = new LabResult();
                p1.setId(result.getInt("id"));
                p1.setLabRequestId(result.getInt("lab_request_id"));
                p1.setProcessedByTechnicianId(result.getInt("processed_by_technician_id"));
                p1.setCompletionStatus(result.getString("completion_status"));
                p1.setCompletionStatusDetails(result.getString("completion_status_details"));
                p1.setCompletionDate(result.getString("completion_date"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return p1;

	}

	public static ArrayList<LabResultDetail> getDetails(int resultID) {
		LabResultDetail p1 = null;
		ArrayList<LabResultDetail> LRD = new ArrayList<LabResultDetail>();;
		
		String sql = "SELECT * FROM lab_result_details WHERE(lab_result_id=" + resultID + ")";
		ResultSet result = DB.executeQuery(sql);
		try {
			while(result.next())
			{
				p1 = new LabResultDetail();
				p1.setId(result.getInt("id"));
                p1.setLab_resultId(result.getInt("lab_result_id"));
                p1.setLabTestId(result.getInt("lab_test_id"));
                p1.setResult(result.getString("result"));
                p1.setDetails(result.getString("details"));
                LRD.add(p1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return LRD;
	}

}