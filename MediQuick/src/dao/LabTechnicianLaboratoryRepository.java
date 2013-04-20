package dao;

//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.util.Iterator;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import domain.Lab;

public class LabTechnicianLaboratoryRepository {

    private int id;

    private int personId;

    private int laboratoryId;

    private Date hireDate;

    private Date terminationDate;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getPersonId() {
        return personId;
    }

    public void setPersonId(int personId) {
        this.personId = personId;
    }

    public int getLaboratoryId() {
        return laboratoryId;
    }

    public void setLaboratoryId(int laboratoryId) {
        this.laboratoryId = laboratoryId;
    }

    public Date getHireDate() {
        return hireDate;
    }

    public void setHireDate(Date hireDate) {
        this.hireDate = hireDate;
    }

    public Date getTerminationDate() {
        return terminationDate;
    }

    public void setTerminationDate(Date terminationDate) {
        this.terminationDate = terminationDate;
    }

    public LabTechnicianLaboratoryRepository() {
    }

    public void insert(LabTechnicianLaboratoryRepository objLab_technician_laboratory) {
        String sql = "";
        sql = sql.concat(" insert into lab_technician_laboratory values");

        sql = sql.concat(objLab_technician_laboratory.getPersonId() + " ,");
        sql = sql.concat(objLab_technician_laboratory.getLaboratoryId() + " ,");
        sql = sql.concat("'" + objLab_technician_laboratory.getHireDate() + "' , ");
        sql = sql.concat("'" + objLab_technician_laboratory.getTerminationDate() + "' , ");
        // quit the last ,
        sql = sql.substring(0, sql.length() - 1);
        sql = sql.concat(" )");
        DB.executeQuery(sql);

    }

    public static void update(LabTechnicianLaboratoryRepository objLab_technician_laboratory) {
        String sql = "";
        sql = sql.concat(" update lab_technician_laboratory set ");

        sql = sql.concat("person_id=" + objLab_technician_laboratory.getPersonId() + " ,");
        sql = sql.concat("laboratory_id=" + objLab_technician_laboratory.getLaboratoryId() + " ,");
        sql = sql.concat("hire_date= '" + objLab_technician_laboratory.getHireDate() + "' , ");
        sql = sql.concat("termination_date= '" + objLab_technician_laboratory.getTerminationDate() + "' , ");
        // quit the last ,
        sql = sql.substring(0, sql.length() - 1);
        sql = sql.concat(" where id=" + objLab_technician_laboratory.getId());
        DB.executeQuery(sql);

    }

    public static List<LabTechnicianLaboratoryRepository> getList() {

        final List<LabTechnicianLaboratoryRepository> Lab_technician_laboratoryList = new ArrayList<LabTechnicianLaboratoryRepository>();
        LabTechnicianLaboratoryRepository p1 = null;

        ResultSet result = null;
        String sql = "SELECT * FROM lab_technician_laboratory ";

        try {

            result = DB.executeQuery(sql);

            while (result.next()) {
                p1 = new LabTechnicianLaboratoryRepository();

                p1.setId(result.getInt("id"));

                p1.setPersonId(result.getInt("person_id"));

                p1.setLaboratoryId(result.getInt("laboratory_id"));

                p1.setHireDate(result.getDate("hide_date"));

                p1.setTerminationDate(result.getDate("termination_date"));
                Lab_technician_laboratoryList.add(p1);

            }
        } catch (Exception e) {
            System.out.println("Error Sql: " + e.getMessage());
        } finally {
        }

        return Lab_technician_laboratoryList;
    }

    public static LabTechnicianLaboratoryRepository getLabTechnicianRepository(int id) {

        LabTechnicianLaboratoryRepository p1 = null;
        ResultSet result = null;
        String sql = "SELECT * FROM lab_technician_laboratory where (id = " + id + ")";

        try {

            result = DB.executeQuery(sql);

            if (result.next()) {
                p1 = new LabTechnicianLaboratoryRepository();

                p1.setId(result.getInt("id"));

                p1.setPersonId(result.getInt("person_id"));

                p1.setLaboratoryId(result.getInt("laboratory_id"));

                p1.setHireDate(result.getDate("hide_date"));

                p1.setTerminationDate(result.getDate("termination_date"));

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
    
    public static Lab getLab(int Technicianid) {

        LabTechnicianLaboratoryRepository p1 = null;
        ResultSet result = null;
        String sql = "SELECT * FROM lab_technician_laboratory where (person_id = " + Technicianid + ")";
        Lab L=null;
        try {

            result = DB.executeQuery(sql);
            
            if (result.next()) {
                p1 = new LabTechnicianLaboratoryRepository();
                p1.setLaboratoryId(result.getInt("laboratory_id"));
                L = Lab.getLaboratory(p1.getLaboratoryId());
            } else {
                System.out.println("No Results Found!");
                return null;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
        }

        return L;
    }


}