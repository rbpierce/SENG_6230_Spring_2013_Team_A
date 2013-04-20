package dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import domain.Physician;

public class PhysicianRepository extends PersonRepository {

    private int personId;

    private float yearlySalary;

    public int getPersonId() {
        return personId;
    }

    public void setPersonId(int personId) {
        this.personId = personId;
    }

    public float getYearlySalary() {
        return yearlySalary;
    }

    public void setYearlySalary(float yearlySalary) {
        this.yearlySalary = yearlySalary;
    }

    public PhysicianRepository() {
    }

    public void insert(PhysicianRepository objPhysician) {
        String sql = "";
        sql = sql.concat(" insert into physician values");

        sql = sql.concat(objPhysician.getYearlySalary() + " ,");
        // quit the last ,
        sql = sql.substring(0, sql.length() - 1);
        sql = sql.concat(" )");
        DB.executeQuery(sql);

    }

    public static void update(PhysicianRepository objPhysician) {
        String sql = "";
        sql = sql.concat(" update physician set ");

        sql = sql.concat("yearly_salary=" + objPhysician.getYearlySalary() + " ,");
        // quit the last ,
        sql = sql.substring(0, sql.length() - 1);
        sql = sql.concat(" where person_id=" + objPhysician.getPersonId());
        DB.executeQuery(sql);

    }

    public static ResultSet getList() {

        ResultSet result = null;
        String sql = "select * from physician join person where (person.member_type='physician' AND person.id=physician.person_id) ";

        try {

            result = DB.executeQuery(sql);

        } catch (Exception e) {
            System.out.println("Error Sql: " + e.getMessage());
        } finally {
        }

        return result;
    }

    public static Physician getPhysician(int PersonId) {

        Physician p1 = null;
        ResultSet result = null;
        String sql = "SELECT * FROM physician where (person_id = " + PersonId + ")";

        try {

            result = DB.executeQuery(sql);

            if (result.next()) {
                p1 = new Physician();
                p1.setPersonId(result.getInt("person_id"));
                p1.setYearlySalary(result.getFloat("yearly_salary"));
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

}