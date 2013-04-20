package dao;

//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.util.Iterator;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import domain.Lab;

public class LaboratoryRepository {

    private int id;

    private String name;

    private String phoneNumber;

    private String street1;

    private String street2;

    private String city;

    private String stateCode;

    private int zipcode;

    private int zipcodePlus4;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phone_number) {
        this.phoneNumber = phone_number;
    }

    public String getStreet1() {
        return street1;
    }

    public void setStreet1(String street1) {
        this.street1 = street1;
    }

    public String getStreet2() {
        return street2;
    }

    public void setStreet2(String street2) {
        this.street2 = street2;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getStateCode() {
        return stateCode;
    }

    public void setStateCode(String state_code) {
        this.stateCode = state_code;
    }

    public int getZipcode() {
        return zipcode;
    }

    public void setZipcode(int zipcode) {
        this.zipcode = zipcode;
    }

    public int getZipcodePlus4() {
        return zipcodePlus4;
    }

    public void setZipcodePlus4(int zipcodePlus4) {
        this.zipcodePlus4 = zipcodePlus4;
    }

    public LaboratoryRepository() {
    }

    public void deleteLaboratory(LaboratoryRepository objLaboratory) {
        String sql = "delete * FROM laboratory where (id = " + objLaboratory.getId() + ")";
        DB.executeQuery(sql);

    }

    public void deleteLaboratory(int Id) {
        String sql = "delete * FROM laboratory where (id = " + Id + ")";
        DB.executeQuery(sql);

    }

    public void insertLaboratory(LaboratoryRepository objLaboratory) {
        String sql = "";
        sql = sql.concat(" insert into laboratory values");

        sql = sql.concat("'" + objLaboratory.getName() + "' ,");
        sql = sql.concat("'" + objLaboratory.getPhoneNumber() + "' ,");
        sql = sql.concat("'" + objLaboratory.getStreet1() + "' ,");
        sql = sql.concat("'" + objLaboratory.getStreet2() + "' ,");
        sql = sql.concat("'" + objLaboratory.getCity() + "' ,");
        sql = sql.concat("'" + objLaboratory.getStateCode() + "' ,");
        sql = sql.concat(objLaboratory.getZipcode() + " ,");
        sql = sql.concat(objLaboratory.getZipcodePlus4() + " ,");
        // quit the last ,
        sql = sql.substring(0, sql.length() - 1);
        sql = sql.concat(" )");
        DB.executeQuery(sql);

    }

    public static void updateLaboratory(LaboratoryRepository objLaboratory) {
        String sql = "";
        sql = sql.concat(" update laboratory set ");

        sql = sql.concat("Name= '" + objLaboratory.getName() + "' ,");
        sql = sql.concat("Phone_number= '" + objLaboratory.getPhoneNumber() + "' ,");
        sql = sql.concat("Street1= '" + objLaboratory.getStreet1() + "' ,");
        sql = sql.concat("Street2= '" + objLaboratory.getStreet2() + "' ,");
        sql = sql.concat("City= '" + objLaboratory.getCity() + "' ,");
        sql = sql.concat("State_code= '" + objLaboratory.getStateCode() + "' ,");
        sql = sql.concat("Zipcode=" + objLaboratory.getZipcode() + " ,");
        sql = sql.concat("Zipcode_plus4=" + objLaboratory.getZipcodePlus4() + " ,");
        // quit the last ,
        sql = sql.substring(0, sql.length() - 1);
        sql = sql.concat(" where id=" + objLaboratory.getId());
        DB.executeQuery(sql);

    }

    public static ArrayList<Lab> getList() {

        final ArrayList<Lab> LaboratoryList = new ArrayList<Lab>();
        Lab p1 = null;

        ResultSet result = null;
        String sql = "SELECT * FROM laboratory ";

        try {

            result = DB.executeQuery(sql);

            while (result.next()) {
                p1 = new Lab();

                p1.setId(result.getInt("id"));

                p1.setName(result.getString("name"));

                p1.setPhoneNumber(result.getString("phone_number"));

                p1.setStreet1(result.getString("street1"));

                p1.setStreet2(result.getString("street2"));

                p1.setCity(result.getString("city"));

                p1.setStateCode(result.getString("state_code"));

                p1.setZipcode(result.getInt("zipcode"));

                p1.setZipcodePlus4(result.getInt("zipcode_plus4"));
                LaboratoryList.add(p1);

            }
        } catch (Exception e) {
            System.out.println("Error Sql: " + e.getMessage());
        } finally {
        }

        return LaboratoryList;
    }

    public static Lab getLaboratory(int Id) {

    	Lab p1 = null;
        ResultSet result = null;
        String sql = "SELECT * FROM laboratory where (id = " + Id + ")";

        try {

            result = DB.executeQuery(sql);

            if (result.next()) {
                p1 = new Lab();

                p1.setId(result.getInt("id"));

                p1.setName(result.getString("name"));

                p1.setPhoneNumber(result.getString("phone_number"));

                p1.setStreet1(result.getString("street1"));

                p1.setStreet2(result.getString("street2"));

                p1.setCity(result.getString("city"));

                p1.setStateCode(result.getString("state_code"));

                p1.setZipcode(result.getInt("zipcode"));

                p1.setZipcodePlus4(result.getInt("zipcode_plus4"));

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