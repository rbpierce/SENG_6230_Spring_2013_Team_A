package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import domain.LabRequestDetail;
import domain.LabTest;

public class LabRequestDetailRepository {

    private int Id;

    private int labRequestId;

    private int labTestId;

    private String comments;

    private static int maxID;
    private static boolean maxIDflag = false;

    public int getId() {
        return Id;
    }

    public void setId(int id) {
        this.Id = id;
    }

    public int getLabRequestId() {
        return labRequestId;
    }

    public void setLabRequestId(int labRequestId) {
        this.labRequestId = labRequestId;
    }

    public int getLabTestId() {
        return labTestId;
    }

    public void setLabTestId(int labTestId) {
        this.labTestId = labTestId;
    }

    public String getComments() {
        return comments;
    }

    public void setComments(String comments) {
        this.comments = comments;
    }

    public LabRequestDetailRepository() {
    }

    public void insert() {
        String sql = "";
        sql = sql.concat(" insert into lab_request_details values(");

        if (this.getId() <= 0) {
            int maximumID = LabRequestDetailRepository.getMaxID();
            sql = sql.concat(maximumID + " ,");
        } else
            sql = sql.concat(this.getId() + " ,");

        sql = sql.concat(this.getLabRequestId() + " ,");
        sql = sql.concat(this.getLabTestId() + " ,");
        sql = sql.concat("'" + this.getComments() + "'" + " ,");
        // quit the last ,
        sql = sql.substring(0, sql.length() - 1);
        sql = sql.concat(" )");
        System.out.println(sql);
        DB.executeUpdate(sql);

    }

    public static void update(LabRequestDetailRepository objLabRequestDetails) {
        String sql = "";
        sql = sql.concat(" update lab_request_details set ");

        sql = sql.concat("Lab_request_id=" + objLabRequestDetails.getLabRequestId() + " ,");
        sql = sql.concat("Lab_test_id=" + objLabRequestDetails.getLabTestId() + " ,");
        sql = sql.concat("Comments= '" + objLabRequestDetails.getComments()) + "' ,";
        // quit the last ,
        sql = sql.substring(0, sql.length() - 1);
        sql = sql.concat(" where id=" + objLabRequestDetails.getId());
        DB.executeQuery(sql);

    }

    public static List<LabRequestDetail> getList() {

        final List<LabRequestDetail> labRequestDetails = new ArrayList<LabRequestDetail>();
        LabRequestDetail p1 = null;

        ResultSet result = null;
        String sql = "SELECT * FROM lab_request_details ";

        try {

            result = DB.executeQuery(sql);

            while (result.next()) {
                p1 = new LabRequestDetail();

                p1.setId(result.getInt("id"));

                p1.setLabRequestId(result.getInt("lab_request_id"));

                p1.setLabTestId(result.getInt("lab_test_id"));

                p1.setComments(result.getString("comments"));
                labRequestDetails.add(p1);

            }
        } catch (Exception e) {
            System.out.println("Error Sql: " + e.getMessage());
        } finally {
        }

        return labRequestDetails;
    }

    public static LabRequestDetail getById(int Id) {

        LabRequestDetail p1 = null;
        ResultSet result = null;
        String sql = "SELECT * FROM lab_request_details where (id = " + Id + ")";

        try {

            result = DB.executeQuery(sql);

            if (result.next()) {
                p1 = new LabRequestDetail();

                p1.setId(result.getInt("id"));

                p1.setLabRequestId(result.getInt("lab_request_id"));

                p1.setLabTestId(result.getInt("lab_test_id"));

                p1.setComments(result.getString("comments"));

            } else {
                System.out.println("No Results Found!");
                return null;
            }
        } catch (SQLException e) {
            System.out.println("Error Sql: " + e.getMessage());
            System.out.println("SQLState: " + e.getSQLState());
            System.out.println("ErrorCode: " + e.getErrorCode());
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

        String sql = "SELECT MAX(id) FROM lab_request_details";
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

	public static ArrayList<LabTest> getTests(int reqID) {
		ArrayList<LabTest> tests = new ArrayList<LabTest>();
		LabTest p1 = null;

        ResultSet result = null;
        String sql = "SELECT * FROM lab_request_details where(lab_request_id = " + reqID + ")";

        try {
            result = DB.executeQuery(sql);
            while (result.next()) {
                p1 = LabTest.getLabTest(result.getInt("lab_test_id"));
                tests.add(p1);
            }
        } catch (Exception e) {
            System.out.println("Error Sql: " + e.getMessage());
        } finally {
        }

        return tests;
	}
	
	public static ArrayList<LabRequestDetail> getAll(int labRequestId) {
		ArrayList<LabRequestDetail> testDetails = new ArrayList<LabRequestDetail>();
		LabTest p1 = null;

        ResultSet result = null;
        String sql = "SELECT * FROM lab_request_details where(lab_request_id = " + labRequestId + ")";

        try {
            result = DB.executeQuery(sql);
            while (result.next()) {
            	LabRequestDetail detail = new LabRequestDetail();
            	detail.setId(result.getInt("id"));
            	detail.setComments(result.getString("comments"));
            	detail.setLabRequestId(labRequestId);
            	detail.setLabTestId(result.getInt("lab_test_id"));
                testDetails.add(detail);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        }

        return testDetails;
	}

}