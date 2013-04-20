package dao;

//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.util.Iterator;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class PatientPhysicianAppointmentRepository {

    private int Id;

    private int PatientId;

    private int PhysicianId;

    private Date Date;

    public int getId() {
        return Id;
    }

    public void setId(int id) {
        this.Id = id;
    }

    public int getPatientId() {
        return PatientId;
    }

    public void setPatientId(int patientId) {
        this.PatientId = patientId;
    }

    public int getPhysicianId() {
        return PhysicianId;
    }

    public void setPhysicianId(int physicianId) {
        this.PhysicianId = physicianId;
    }

    public Date getDate() {
        return Date;
    }

    public void setDate(Date date) {
        this.Date = date;
    }

    public PatientPhysicianAppointmentRepository() {
    }

    public void deletePatientPhysician_appointment(
            PatientPhysicianAppointmentRepository objPatientPhysician_appointment) {
        String sql = "DELETE FROM patient_physician_appointment where (id = "
                + objPatientPhysician_appointment.getId() + ")";
        DB.executeUpdate(sql);

    }

    public static void deletePatientPhysician_appointment(int patientID, int physicianID) {
        String sql = "DELETE FROM patient_physician_appointment where (patient_id = " + patientID
                + " AND physician_id=" + physicianID + " )";
        DB.executeUpdate(sql);

    }

    public void insertPatientPhysician_appointment() {
        String sql = "";
        sql = sql.concat(" insert into patient_physician_appointment (`patient_id`, `physician_id`, `date`) values(");

        sql = sql.concat(this.getPatientId() + " ,");
        sql = sql.concat(this.getPhysicianId() + ",");
        sql = sql.concat(this.getDate() + ")");

        DB.executeUpdate(sql);
    }

    public static void updatePatientPhysician_appointment(
            PatientPhysicianAppointmentRepository objPatientPhysician_appointment) {
        String sql = "";
        sql = sql.concat(" update patient_physician_appointment set ");

        sql = sql.concat("patientId=" + objPatientPhysician_appointment.getPatientId() + " ,");
        sql = sql.concat("physicianId=" + objPatientPhysician_appointment.getPhysicianId() + " ,");
        sql = sql.concat("date= '" + objPatientPhysician_appointment.getDate() + "' , ");
        // quit the last ,
        sql = sql.substring(0, sql.length() - 1);
        sql = sql.concat(" where id=" + objPatientPhysician_appointment.getId());
        DB.executeQuery(sql);

    }

    public static ResultSet getList() {

        final List<PatientPhysicianAppointmentRepository> PatientPhysician_appointmentList = new ArrayList<PatientPhysicianAppointmentRepository>();
        PatientPhysicianAppointmentRepository p1 = null;

        ResultSet result = null;
        String sql = "SELECT * FROM patient_physician_appointment ";

        try {

            result = DB.executeQuery(sql);

            while (result.next()) {
                p1 = new PatientPhysicianAppointmentRepository();

                p1.setId(result.getInt("id"));

                p1.setPatientId(result.getInt("patient_id"));

                p1.setPhysicianId(result.getInt("physician_id"));

                p1.setDate(result.getDate("date"));
                PatientPhysician_appointmentList.add(p1);

            }
        } catch (Exception e) {
            System.out.println("Error Sql: " + e.getMessage());
        } finally {
        }

        return result;
    }

    public static ResultSet getListOfAPhysician(int PhysicianID) {
        ResultSet result = null;
        String sql = "SELECT * FROM patient_physician_appointment WHERE physician_id=" + PhysicianID;

        try {
            result = DB.executeQuery(sql);
        } catch (Exception e) {
            System.out.println("Error Sql: " + e.getMessage());
        } finally {
        }

        return result;
    }

    public static PatientPhysicianAppointmentRepository getPatientPhysician_appointment(int Id) {

        PatientPhysicianAppointmentRepository p1 = null;
        ResultSet result = null;
        String sql = "SELECT * FROM patient_physician_appointment where (id = " + Id + ")";

        try {

            result = DB.executeQuery(sql);

            if (result.next()) {
                p1 = new PatientPhysicianAppointmentRepository();

                p1.setId(result.getInt("id"));

                p1.setPatientId(result.getInt("patient_id"));

                p1.setPhysicianId(result.getInt("physicianId"));

                p1.setDate(result.getDate("date"));

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