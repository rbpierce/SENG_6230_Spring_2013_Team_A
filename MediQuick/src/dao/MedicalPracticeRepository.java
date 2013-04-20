package dao;

//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.util.Iterator;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MedicalPracticeRepository {

    private int Id;

    private String Name;

    private String Phone_number;

    private String Street1;

    private String Street2;

    private String City;

    private String State_code;

    private int Zipcode;

    private int Zipcode_plus4;

    public int getId() {
        return Id;
    }

    public void setId(int id) {
        this.Id = id;
    }

    public String getName() {
        return Name;
    }

    public void setName(String name) {
        this.Name = name;
    }

    public String getPhone_number() {
        return Phone_number;
    }

    public void setPhone_number(String phone_number) {
        this.Phone_number = phone_number;
    }

    public String getStreet1() {
        return Street1;
    }

    public void setStreet1(String street1) {
        this.Street1 = street1;
    }

    public String getStreet2() {
        return Street2;
    }

    public void setStreet2(String street2) {
        this.Street2 = street2;
    }

    public String getCity() {
        return City;
    }

    public void setCity(String city) {
        this.City = city;
    }

    public String getState_code() {
        return State_code;
    }

    public void setState_code(String state_code) {
        this.State_code = state_code;
    }

    public int getZipcode() {
        return Zipcode;
    }

    public void setZipcode(int zipcode) {
        this.Zipcode = zipcode;
    }

    public int getZipcode_plus4() {
        return Zipcode_plus4;
    }

    public void setZipcode_plus4(int zipcode_plus4) {
        this.Zipcode_plus4 = zipcode_plus4;
    }

    public MedicalPracticeRepository() {
    }

    public void deleteMedical_practice(MedicalPracticeRepository objMedical_practice) {
        String sql = "delete * FROM medical_practice where (id = " + objMedical_practice.getId() + ")";
        DB.executeQuery(sql);

    }

    public void deleteMedical_practice(int Id) {
        String sql = "delete * FROM medical_practice where (id = " + Id + ")";
        DB.executeQuery(sql);

    }

    public void insertMedical_practice(MedicalPracticeRepository objMedical_practice) {
        String sql = "";
        sql = sql.concat(" insert into medical_practice values");

        sql = sql.concat("'" + objMedical_practice.getName() + "' ,");
        sql = sql.concat("'" + objMedical_practice.getPhone_number() + "' ,");
        sql = sql.concat("'" + objMedical_practice.getStreet1() + "' ,");
        sql = sql.concat("'" + objMedical_practice.getStreet2() + "' ,");
        sql = sql.concat("'" + objMedical_practice.getCity() + "' ,");
        sql = sql.concat("'" + objMedical_practice.getState_code() + "' ,");
        sql = sql.concat(objMedical_practice.getZipcode() + " ,");
        sql = sql.concat(objMedical_practice.getZipcode_plus4() + " ,");
        // quit the last ,
        sql = sql.substring(0, sql.length() - 1);
        sql = sql.concat(" )");
        DB.executeQuery(sql);

    }

    public static void updateMedical_practice(MedicalPracticeRepository objMedical_practice) {
        String sql = "";
        sql = sql.concat(" update medical_practice set ");

        sql = sql.concat("Name= '" + objMedical_practice.getName() + "' ,");
        sql = sql.concat("Phone_number= '" + objMedical_practice.getPhone_number() + "' ,");
        sql = sql.concat("Street1= '" + objMedical_practice.getStreet1() + "' ,");
        sql = sql.concat("Street2= '" + objMedical_practice.getStreet2() + "' ,");
        sql = sql.concat("City= '" + objMedical_practice.getCity() + "' ,");
        sql = sql.concat("State_code= '" + objMedical_practice.getState_code() + "' ,");
        sql = sql.concat("Zipcode=" + objMedical_practice.getZipcode() + " ,");
        sql = sql.concat("Zipcode_plus4=" + objMedical_practice.getZipcode_plus4() + " ,");
        // quit the last ,
        sql = sql.substring(0, sql.length() - 1);
        sql = sql.concat(" where id=" + objMedical_practice.getId());
        DB.executeQuery(sql);

    }

    public static List<MedicalPracticeRepository> getList() {

        final List<MedicalPracticeRepository> Medical_practiceList = new ArrayList<MedicalPracticeRepository>();
        MedicalPracticeRepository p1 = null;

        ResultSet result = null;
        String sql = "SELECT * FROM medical_practice ";

        try {

            result = DB.executeQuery(sql);

            while (result.next()) {
                p1 = new MedicalPracticeRepository();

                p1.setId(result.getInt("id"));

                p1.setName(result.getString("name"));

                p1.setPhone_number(result.getString("phone_number"));

                p1.setStreet1(result.getString("street1"));

                p1.setStreet2(result.getString("street2"));

                p1.setCity(result.getString("city"));

                p1.setState_code(result.getString("state_code"));

                p1.setZipcode(result.getInt("zipcode"));

                p1.setZipcode_plus4(result.getInt("zipcode_plus4"));
                Medical_practiceList.add(p1);

            }
        } catch (Exception e) {
            System.out.println("Error Sql: " + e.getMessage());
        } finally {
        }

        return Medical_practiceList;
    }

    public static MedicalPracticeRepository getMedical_practice(int Id) {

        MedicalPracticeRepository p1 = null;
        ResultSet result = null;
        String sql = "SELECT * FROM medical_practice where (id = " + Id + ")";

        try {

            result = DB.executeQuery(sql);

            if (result.next()) {
                p1 = new MedicalPracticeRepository();

                p1.setId(result.getInt("id"));

                p1.setName(result.getString("name"));

                p1.setPhone_number(result.getString("phone_number"));

                p1.setStreet1(result.getString("street1"));

                p1.setStreet2(result.getString("street2"));

                p1.setCity(result.getString("city"));

                p1.setState_code(result.getString("state_code"));

                p1.setZipcode(result.getInt("zipcode"));

                p1.setZipcode_plus4(result.getInt("zipcode_plus4"));

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