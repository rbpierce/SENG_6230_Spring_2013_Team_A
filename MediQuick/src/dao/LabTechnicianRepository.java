package dao;

//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.util.Iterator;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class LabTechnicianRepository {

    private int PersonId;

    private float Hourly_rate;

    public int getPersonId() {
        return PersonId;
    }

    public void setPersonId(int personId) {
        this.PersonId = personId;
    }

    public float getHourly_rate() {
        return Hourly_rate;
    }

    public void setHourly_rate(float hourly_rate) {
        this.Hourly_rate = hourly_rate;
    }

    public LabTechnicianRepository() {
    }

    public void deleteLab_technician(LabTechnicianRepository objLab_technician) {
        String sql = "delete * FROM lab_technician where (personId = " + objLab_technician.getPersonId() + ")";
        DB.executeQuery(sql);

    }

    public void deleteLab_technician(int PersonId) {
        String sql = "delete * FROM lab_technician where (personId = " + PersonId + ")";
        DB.executeQuery(sql);

    }

    public void insertLab_technician(LabTechnicianRepository objLab_technician) {
        String sql = "";
        sql = sql.concat(" insert into lab_technician values");

        sql = sql.concat(objLab_technician.getHourly_rate() + " ,");
        // quit the last ,
        sql = sql.substring(0, sql.length() - 1);
        sql = sql.concat(" )");
        DB.executeQuery(sql);

    }

    public static void updateLab_technician(LabTechnicianRepository objLab_technician) {
        String sql = "";
        sql = sql.concat(" update lab_technician set ");

        sql = sql.concat("Hourly_rate=" + objLab_technician.getHourly_rate() + " ,");
        // quit the last ,
        sql = sql.substring(0, sql.length() - 1);
        sql = sql.concat(" where personId=" + objLab_technician.getPersonId());
        DB.executeQuery(sql);

    }

    public static List<LabTechnicianRepository> getList() {

        final List<LabTechnicianRepository> Lab_technicianList = new ArrayList<LabTechnicianRepository>();
        LabTechnicianRepository p1 = null;

        ResultSet result = null;
        String sql = "SELECT * FROM lab_technician ";

        try {

            result = DB.executeQuery(sql);

            while (result.next()) {
                p1 = new LabTechnicianRepository();

                p1.setPersonId(result.getInt("personId"));

                p1.setHourly_rate(result.getFloat("hourly_rate"));
                Lab_technicianList.add(p1);

            }
        } catch (Exception e) {
            System.out.println("Error Sql: " + e.getMessage());
        } finally {
        }

        return Lab_technicianList;
    }

    public static LabTechnicianRepository getLab_technician(int PersonId) {

        LabTechnicianRepository p1 = null;
        ResultSet result = null;
        String sql = "SELECT * FROM lab_technician where (personId = " + PersonId + ")";

        try {

            result = DB.executeQuery(sql);

            if (result.next()) {
                p1 = new LabTechnicianRepository();

                p1.setPersonId(result.getInt("personId"));

                p1.setHourly_rate(result.getFloat("hourly_rate"));

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