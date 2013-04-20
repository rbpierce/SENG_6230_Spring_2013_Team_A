package dao;

//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.util.Iterator;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class NurseRepository extends PersonRepository{

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

    public NurseRepository() {
    }

    public void deleteNurse(NurseRepository objNurse) {
        String sql = "delete * FROM nurse where (personId = " + objNurse.getPersonId() + ")";
        DB.executeQuery(sql);
    }

    public void deleteNurse(int PersonId) {
        String sql = "delete * FROM nurse where (personId = " + PersonId + ")";
        DB.executeQuery(sql);
    }

    public void insertNurse(NurseRepository objNurse) {
        String sql = "";
        sql = sql.concat(" insert into nurse values");
        sql = sql.concat(objNurse.getHourly_rate() + ")");
        DB.executeQuery(sql);
    }

    public static void updateNurse(NurseRepository objNurse) {
        String sql = "";
        sql = sql.concat(" update nurse set ");
        sql = sql.concat("Hourly_rate=" + objNurse.getHourly_rate());
        sql = sql.concat(" where personId=" + objNurse.getPersonId());
        DB.executeQuery(sql);
    }

    public static ResultSet getList() {

        ArrayList<NurseRepository> NurseList = new ArrayList<NurseRepository>();
        NurseRepository p1 = null;

        ResultSet result = null;
        String sql = "SELECT * FROM nurse ";

        try {

            result = DB.executeQuery(sql);
            while (result.next()) {
                p1 = new NurseRepository();
                p1.setPersonId(result.getInt("personId"));
                p1.setHourly_rate(result.getFloat("hourly_rate"));
                NurseList.add(p1);
            }
        } catch (Exception e) {
            System.out.println("Error Sql: " + e.getMessage());
        } finally {
        }

        return result;
    }

    public static NurseRepository getNurse(int PersonId) {

        NurseRepository p1 = null;
        ResultSet result = null;
        String sql = "SELECT * FROM nurse where (personId = " + PersonId + ")";

        try {
            result = DB.executeQuery(sql);
            if (result.next()) {
                p1 = new NurseRepository();
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


	public static ArrayList<Integer> getRelatedDoctors(int NurseID) {
		int MedicalPracticeID = PhysicianNurseMedicalPracticeRepository.getMedicalPracticeOfPerson(NurseID);
		if(MedicalPracticeID != 0)
			return PhysicianNurseMedicalPracticeRepository.getDoctors(MedicalPracticeID);
		return null;
	}

	

}