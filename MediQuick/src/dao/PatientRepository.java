package dao;

//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.util.Iterator;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

import domain.Patient;
import domain.Person;

public class PatientRepository extends PersonRepository {

    private int personId;

    private Date lastVisit;

    private Date nextScheduledVisit;

    private float heightInInches;

    private int weightInPounds;

    private String tobaccoStatus;

    public int getPersonId() {
        return personId;
    }

    public void setPersonId(int personId) {
        this.personId = personId;
    }

    public Date getLastVisit() {
        return lastVisit;
    }

    public void setLastVisit(Date lastVisit) {
        this.lastVisit = lastVisit;
    }

    public Date getNextScheduledVisit() {
        return nextScheduledVisit;
    }

    public void setNextScheduledVisit(Date nextScheduledVisit) {
        this.nextScheduledVisit = nextScheduledVisit;
    }

    public float getHeightInInches() {
        return heightInInches;
    }

    public void setHeightInInches(float heightInInches) {
        this.heightInInches = heightInInches;
    }

    public int getWeightInPounds() {
        return weightInPounds;
    }

    public void setWeightInPounds(int weightInPounds) {
        this.weightInPounds = weightInPounds;
    }

    public String getTobaccoStatus() {
        return tobaccoStatus;
    }

    public void setTobaccoStatus(String tobaccoStatus) {
        this.tobaccoStatus = tobaccoStatus;
    }

    public PatientRepository() {
    }

    public void insert(PatientRepository objPatient) throws Exception {
    	if (objPatient.getPersonId()<=0) throw new Exception("Create person first!");
        String sql = "";
        sql = sql.concat(" insert into patient values ");
        sql = sql.concat(" (" + objPatient.getPersonId() + ", ");
        sql = sql.concat(objPatient.getLastVisit()==null?"NULL,": ("'" + objPatient.getLastVisit() + "'") + " , ");
        sql = sql.concat(objPatient.getNextScheduledVisit()==null?"NULL,'": ("'" + objPatient.getNextScheduledVisit() + "'") + " , '");
        sql = sql.concat(objPatient.getHeightInInches() + "' ,'");
        sql = sql.concat(objPatient.getWeightInPounds() + "' ,");
        sql = sql.concat(objPatient.getTobaccoStatus()==null?"\"UNKNOWN\"": ("'" + objPatient.getTobaccoStatus() + "'"));

        sql = sql.concat(" )");
        System.out.println(sql);
        DB.executeUpdate(sql);

    }

    public static void update(PatientRepository objPatient) {
        String sql = "";
        sql = sql.concat(" update patient set ");

        sql = sql.concat("last_visit= '" + objPatient.getLastVisit() + "' , ");
        sql = sql.concat("next_scheduled_visit= '" + objPatient.getNextScheduledVisit() + "' , ");
        sql = sql.concat("height_in_inches=" + objPatient.getHeightInInches() + " ,");
        sql = sql.concat("weight_in_pounds=" + objPatient.getWeightInPounds() + " ,");
        sql = sql.concat("tobacco_status= '" + objPatient.getTobaccoStatus() + "' ,");
        // quit the last ,
        sql = sql.substring(0, sql.length() - 1);
        sql = sql.concat(" where person_id=" + objPatient.getPersonId());
        DB.executeUpdate(sql);

    }

    public static ResultSet getList() {

        final ArrayList<PersonRepository> PatientList = new ArrayList<PersonRepository>();
        PatientRepository p1 = null;

        ResultSet result = null;
        String sql = "select * from patient join person where (person.member_type='PATIENT' AND person.id=patient.person_id) ";

        try {

            result = DB.executeQuery(sql);

            while (result.next()) {
                p1 = new PatientRepository();
                p1.setPersonId(result.getInt("person_id"));
                p1.setLastVisit(result.getDate("last_visit"));
                p1.setNextScheduledVisit(result.getDate("next_scheduled_visit"));
                p1.setHeightInInches(result.getFloat("height_in_inches"));
                p1.setWeightInPounds(result.getInt("weight_in_pounds"));
                p1.setTobaccoStatus(result.getString("tobacco_status"));
                p1.addPersonInfo();
                PatientList.add(p1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        }

        return result;
    }

    public static Patient getPatient(int personId) {

    	Patient p1 = null;
        ResultSet result = null;
        String sql = "SELECT * FROM patient WHERE person_id=" + personId;

        try {

            result = DB.executeQuery(sql);

            if (result.next()) {
                p1 = new Patient();
                p1.setPersonId(result.getInt("person_id"));
                p1.setLastVisit(result.getDate("last_visit"));
                p1.setNextScheduledVisit(result.getDate("next_scheduled_visit"));
                p1.setHeightInInches(result.getFloat("height_in_inches"));
                p1.setWeightInPounds(result.getInt("weight_in_pounds"));
                p1.setTobaccoStatus(result.getString("tobacco_status"));
                p1.addPersonInfo();

            } else {
                System.out.println("No Results Found!" + sql);
                return null;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
        }

        return p1;
    }

    protected void addPersonInfo() {
        ResultSet result = null;
        String sql = "SELECT * FROM person WHERE id=" + this.personId;

        try {
            result = DB.executeQuery(sql);
            if (result.next()) {
                this.setId(result.getInt("id"));
                this.setMemberType(result.getString("member_type"));
                this.setFirstName(result.getString("first_name"));
                this.setMiddleName(result.getString("middle_name"));
                this.setLastName(result.getString("last_name"));
                this.setMaidenName(result.getString("maiden_name"));
                this.setSuffix(result.getString("suffix"));
                this.setGender(result.getString("gender"));
                this.setMaritalStatus(result.getString("marital_status"));
                this.setBirthDate(result.getDate("birth_date"));
                this.setIsTest(result.getBoolean("is_test"));
                this.setIsActive(result.getBoolean("is_active"));
                this.setUsername(result.getString("username"));
                this.setPasswordPlaintext(result.getString("password_plaintext"));
                this.setIsPasswordResetRequired(result.getBoolean("is_password_reset_required"));
            } else {
                System.out.println("No Results Found!");
                return;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
        }

    }

	public static Person getById(String patientId) {
		return getById(Integer.parseInt(patientId));
	}

}