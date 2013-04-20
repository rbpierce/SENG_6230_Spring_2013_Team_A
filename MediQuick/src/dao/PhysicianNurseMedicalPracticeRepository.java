package dao;

//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.util.Iterator;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class PhysicianNurseMedicalPracticeRepository {

    private int id;

    private int personId;

    private int medicalPracticeId;

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

    public int getMedicalPracticeId() {
        return medicalPracticeId;
    }

    public void setMedicalPracticeId(int medicalPracticeId) {
        this.medicalPracticeId = medicalPracticeId;
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

    public PhysicianNurseMedicalPracticeRepository() {
    }

    public void insertPhysicianNurseMedicalPractice(
            PhysicianNurseMedicalPracticeRepository objPhysicianNurseMedicalPractice) {
        String sql = "";
        sql = sql.concat(" insert into physician_nurse_medical_practice values");

        sql = sql.concat(objPhysicianNurseMedicalPractice.getPersonId() + " ,");
        sql = sql.concat(objPhysicianNurseMedicalPractice.getMedicalPracticeId() + " ,");
        sql = sql.concat("'" + objPhysicianNurseMedicalPractice.getHireDate() + "' , ");
        sql = sql.concat("'" + objPhysicianNurseMedicalPractice.getTerminationDate() + "' , ");
        // quit the last ,
        sql = sql.substring(0, sql.length() - 1);
        sql = sql.concat(" )");
        DB.executeQuery(sql);

    }

    public static void updatePhysicianNurseMedicalPractice(
            PhysicianNurseMedicalPracticeRepository objPhysicianNurseMedicalPractice) {
        String sql = "";
        sql = sql.concat(" update physician_nurse_medical_practice set ");

        sql = sql.concat("person_id=" + objPhysicianNurseMedicalPractice.getPersonId() + " ,");
        sql = sql.concat("medical_practice_id=" + objPhysicianNurseMedicalPractice.getMedicalPracticeId() + " ,");
        sql = sql.concat("hire_date= '" + objPhysicianNurseMedicalPractice.getHireDate() + "' , ");
        sql = sql.concat("termination_date= '" + objPhysicianNurseMedicalPractice.getTerminationDate() + "' , ");
        // quit the last ,
        sql = sql.substring(0, sql.length() - 1);
        sql = sql.concat(" where id=" + objPhysicianNurseMedicalPractice.getId());
        DB.executeQuery(sql);

    }

    public static List<PhysicianNurseMedicalPracticeRepository> getList() {

        final List<PhysicianNurseMedicalPracticeRepository> PhysicianNurseMedicalPracticeList = new ArrayList<PhysicianNurseMedicalPracticeRepository>();
        PhysicianNurseMedicalPracticeRepository p1 = null;

        ResultSet result = null;
        String sql = "SELECT * FROM physician_nurse_medical_practice ";

        try {

            result = DB.executeQuery(sql);

            while (result.next()) {
                p1 = new PhysicianNurseMedicalPracticeRepository();

                p1.setId(result.getInt("id"));

                p1.setPersonId(result.getInt("person_id"));

                p1.setMedicalPracticeId(result.getInt("medical_practice_id"));

                p1.setHireDate(result.getDate("hire_date"));

                p1.setTerminationDate(result.getDate("termination_date"));
                PhysicianNurseMedicalPracticeList.add(p1);

            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        }

        return PhysicianNurseMedicalPracticeList;
    }

    public static PhysicianNurseMedicalPracticeRepository getById(int id) {

        PhysicianNurseMedicalPracticeRepository p1 = null;
        ResultSet result = null;
        String sql = "SELECT * FROM physician_nurse_medical_practice where (id = " + id + ")";

        try {

            result = DB.executeQuery(sql);

            if (result.next()) {
                p1 = new PhysicianNurseMedicalPracticeRepository();

                p1.setId(result.getInt("id"));

                p1.setPersonId(result.getInt("person_id"));

                p1.setMedicalPracticeId(result.getInt("medical_practice_id"));

                p1.setHireDate(result.getDate("hire_date"));

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
    
    public static int getMedicalPracticeOfPerson(int PersonID) {
		String sql = "SELECT * FROM physician_nurse_medical_practice WHERE(person_id = " + PersonID + ")";
		ResultSet res = DB.executeQuery(sql);
		try {
			if(res.next())
			{
                return res.getInt("medical_practice_id");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
	}

	public static ArrayList<Integer> getDoctors(int MedPracticeID) {
		String sql = "SELECT distinct(person_id) FROM physician_nurse_medical_practice WHERE(medical_practice_id = " + MedPracticeID + ")";
		ResultSet res = DB.executeQuery(sql);
		ArrayList<Integer> Docs = new ArrayList<Integer>();
		
		try {
			while(res.next())
			{	
				int personID = res.getInt("person_id");
				if(PersonRepository.isDoctor(personID))
					Docs.add(personID);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return Docs;

	}

}