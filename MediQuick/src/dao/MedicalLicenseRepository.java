package dao;

//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.util.Iterator;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class MedicalLicenseRepository {

    private int Id;

    private int PersonId;

    private String State_code;

    private String Type;

    private Date IssueDate;

    private Date ExpirationDate;

    public int getId() {
        return Id;
    }

    public void setId(int id) {
        this.Id = id;
    }

    public int getPersonId() {
        return PersonId;
    }

    public void setPersonId(int personId) {
        this.PersonId = personId;
    }

    public String getState_code() {
        return State_code;
    }

    public void setState_code(String state_code) {
        this.State_code = state_code;
    }

    public String getType() {
        return Type;
    }

    public void setType(String type) {
        this.Type = type;
    }

    public Date getIssueDate() {
        return IssueDate;
    }

    public void setIssueDate(Date issueDate) {
        this.IssueDate = issueDate;
    }

    public Date getExpirationDate() {
        return ExpirationDate;
    }

    public void setExpirationDate(Date expirationDate) {
        this.ExpirationDate = expirationDate;
    }

    public MedicalLicenseRepository() {
    }

    public void deleteMedical_license(MedicalLicenseRepository objMedical_license) {
        String sql = "delete * FROM medical_license where (id = " + objMedical_license.getId() + ")";
        DB.executeQuery(sql);

    }

    public void deleteMedical_license(int Id) {
        String sql = "delete * FROM medical_license where (id = " + Id + ")";
        DB.executeQuery(sql);

    }

    public void insertMedical_license(MedicalLicenseRepository objMedical_license) {
        String sql = "";
        sql = sql.concat(" insert into medical_license values");

        sql = sql.concat(objMedical_license.getPersonId() + " ,");
        sql = sql.concat("'" + objMedical_license.getState_code() + "' ,");
        sql = sql.concat("'" + objMedical_license.getType() + "' ,");
        sql = sql.concat("'" + objMedical_license.getIssueDate() + "' , ");
        sql = sql.concat("'" + objMedical_license.getExpirationDate() + "' , ");
        // quit the last ,
        sql = sql.substring(0, sql.length() - 1);
        sql = sql.concat(" )");
        DB.executeQuery(sql);

    }

    public static void updateMedical_license(MedicalLicenseRepository objMedical_license) {
        String sql = "";
        sql = sql.concat(" update medical_license set ");

        sql = sql.concat("PersonId=" + objMedical_license.getPersonId() + " ,");
        sql = sql.concat("State_code= '" + objMedical_license.getState_code() + "' ,");
        sql = sql.concat("Type= '" + objMedical_license.getType() + "' ,");
        sql = sql.concat("IssueDate= '" + objMedical_license.getIssueDate() + "' , ");
        sql = sql.concat("ExpirationDate= '" + objMedical_license.getExpirationDate() + "' , ");
        // quit the last ,
        sql = sql.substring(0, sql.length() - 1);
        sql = sql.concat(" where id=" + objMedical_license.getId());
        DB.executeQuery(sql);

    }

    public static List<MedicalLicenseRepository> getList() {

        final List<MedicalLicenseRepository> Medical_licenseList = new ArrayList<MedicalLicenseRepository>();
        MedicalLicenseRepository p1 = null;

        ResultSet result = null;
        String sql = "SELECT * FROM medical_license ";

        try {

            result = DB.executeQuery(sql);

            while (result.next()) {
                p1 = new MedicalLicenseRepository();

                p1.setId(result.getInt("id"));

                p1.setPersonId(result.getInt("personId"));

                p1.setState_code(result.getString("state_code"));

                p1.setType(result.getString("type"));

                p1.setIssueDate(result.getDate("issueDate"));

                p1.setExpirationDate(result.getDate("expirationDate"));
                Medical_licenseList.add(p1);

            }
        } catch (Exception e) {
            System.out.println("Error Sql: " + e.getMessage());
        } finally {
        }

        return Medical_licenseList;
    }

    public static MedicalLicenseRepository getMedical_license(int Id) {

        MedicalLicenseRepository p1 = null;
        ResultSet result = null;
        String sql = "SELECT * FROM medical_license where (id = " + Id + ")";

        try {

            result = DB.executeQuery(sql);

            if (result.next()) {
                p1 = new MedicalLicenseRepository();

                p1.setId(result.getInt("id"));

                p1.setPersonId(result.getInt("personId"));

                p1.setState_code(result.getString("state_code"));

                p1.setType(result.getString("type"));

                p1.setIssueDate(result.getDate("issueDate"));

                p1.setExpirationDate(result.getDate("expirationDate"));

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

}