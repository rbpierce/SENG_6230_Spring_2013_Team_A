package dao;

//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.util.Iterator;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class LabResultDetailRepository {

    private int Id;

    private int Lab_resultId;

    private int LabTestId;

    private String Result;

    private String Details;

    public int getId() {
        return Id;
    }

    public void setId(int id) {
        this.Id = id;
    }

    public int getLab_resultId() {
        return Lab_resultId;
    }

    public void setLab_resultId(int lab_resultId) {
        this.Lab_resultId = lab_resultId;
    }

    public int getLabTestId() {
        return LabTestId;
    }

    public void setLabTestId(int labTestId) {
        this.LabTestId = labTestId;
    }

    public String getResult() {
        return Result;
    }

    public void setResult(String result) {
        this.Result = result;
    }

    public String getDetails() {
        return Details;
    }

    public void setDetails(String details) {
        this.Details = details;
    }

    public LabResultDetailRepository() {
    }

    public void deleteLab_resultDetails(LabResultDetailRepository objLab_resultDetails) {
        String sql = "delete * FROM lab_resultDetails where (id = " + objLab_resultDetails.getId() + ")";
        DB.executeQuery(sql);

    }

    public void deleteLab_resultDetails(int Id) {
        String sql = "delete * FROM lab_resultDetails where (id = " + Id + ")";
        DB.executeQuery(sql);

    }

    public void insertLab_resultDetails(LabResultDetailRepository objLab_resultDetails) {
        String sql = "";
        sql = sql.concat(" insert into lab_resultDetails values");

        sql = sql.concat(objLab_resultDetails.getLab_resultId() + " ,");
        sql = sql.concat(objLab_resultDetails.getLabTestId() + " ,");
        sql = sql.concat("'" + objLab_resultDetails.getResult() + "'") + " ,";
        sql = sql.concat("'" + objLab_resultDetails.getDetails() + "'") + " ,";
        // quit the last ,
        sql = sql.substring(0, sql.length() - 1);
        sql = sql.concat(" )");
        DB.executeQuery(sql);

    }

    public static void updateLab_resultDetails(LabResultDetailRepository objLab_resultDetails) {
        String sql = "";
        sql = sql.concat(" update lab_resultDetails set ");

        sql = sql.concat("Lab_resultId=" + objLab_resultDetails.getLab_resultId() + " ,");
        sql = sql.concat("LabTestId=" + objLab_resultDetails.getLabTestId() + " ,");
        sql = sql.concat("Result= '" + objLab_resultDetails.getResult()) + "' ,";
        sql = sql.concat("Details= '" + objLab_resultDetails.getDetails()) + "' ,";
        // quit the last ,
        sql = sql.substring(0, sql.length() - 1);
        sql = sql.concat(" where id=" + objLab_resultDetails.getId());
        DB.executeQuery(sql);

    }

    public static List<LabResultDetailRepository> getList() {

        final List<LabResultDetailRepository> Lab_resultDetailsList = new ArrayList<LabResultDetailRepository>();
        LabResultDetailRepository p1 = null;

        ResultSet result = null;
        String sql = "SELECT * FROM lab_resultDetails ";

        try {

            result = DB.executeQuery(sql);

            while (result.next()) {
                p1 = new LabResultDetailRepository();

                p1.setId(result.getInt("id"));

                p1.setLab_resultId(result.getInt("lab_resultId"));

                p1.setLabTestId(result.getInt("labTestId"));

                p1.setResult(result.getString("result"));

                p1.setDetails(result.getString("details"));
                Lab_resultDetailsList.add(p1);

            }
        } catch (Exception e) {
            System.out.println("Error Sql: " + e.getMessage());
        } finally {
        }

        return Lab_resultDetailsList;
    }

    public static LabResultDetailRepository getLab_resultDetails(int Id) {

        LabResultDetailRepository p1 = null;
        ResultSet result = null;
        String sql = "SELECT * FROM lab_result_details where (id = " + Id + ")";

        try {

            result = DB.executeQuery(sql);

            if (result.next()) {
                p1 = new LabResultDetailRepository();
                p1.setId(result.getInt("id"));
                p1.setLab_resultId(result.getInt("lab_result_id"));
                p1.setLabTestId(result.getInt("lab_test_id"));
                p1.setResult(result.getString("result"));
                p1.setDetails(result.getString("details"));
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
		int maxID = 0;
        String sql = "SELECT MAX(id) FROM lab_result_details";
        ResultSet res = DB.executeQuery(sql);
        try {
            if (res.next())
                maxID = res.getInt("MAX(id)");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return maxID+1;
	}

	public void insert() {
		String sql = "";
		sql = sql.concat(" insert into lab_result_details values(");

        sql = sql.concat(this.getId() + " ," + this.getLab_resultId() + ", " + this.getLabTestId() + ", ");
        sql = sql.concat("'" + this.getResult() + "', null)");
        
        DB.executeUpdate(sql);
	}

	public void update() {
		String sql = "";
		sql = " update lab_result_details set `result` = '"+ this.getResult() + "'";
		sql += " WHERE (`lab_result_id`=" + this.getLab_resultId() + " AND `lab_test_id`=" + this.getLabTestId() + ")";

		DB.executeUpdate(sql);
	}

}