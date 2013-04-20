package dao;

//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.util.Iterator;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import domain.LabTest;

public class LabTestRepository {

    private int Id;

    private String Name;

    private String Abbreviation;

    private String ReflexiveTesting_description;

    private String Panels_description;

    private String Special_collection_requirements;

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

    public String getAbbreviation() {
        return Abbreviation;
    }

    public void setAbbreviation(String abbreviation) {
        this.Abbreviation = abbreviation;
    }

    public String getReflexiveTesting_description() {
        return ReflexiveTesting_description;
    }

    public void setReflexiveTesting_description(String reflexiveTesting_description) {
        this.ReflexiveTesting_description = reflexiveTesting_description;
    }

    public String getPanels_description() {
        return Panels_description;
    }

    public void setPanels_description(String panels_description) {
        this.Panels_description = panels_description;
    }

    public String getSpecial_collection_requirements() {
        return Special_collection_requirements;
    }

    public void setSpecial_collection_requirements(String special_collection_requirements) {
        this.Special_collection_requirements = special_collection_requirements;
    }

    public LabTestRepository() {
    }

    public void deleteLabTest(LabTestRepository objLabTest) {
        String sql = "delete * FROM lab_test where (id = " + objLabTest.getId() + ")";
        DB.executeQuery(sql);

    }

    public void deleteLabTest(int Id) {
        String sql = "delete * FROM lab_test where (id = " + Id + ")";
        DB.executeQuery(sql);

    }

    public void insertLabTest(LabTestRepository objLabTest) {
        String sql = "";
        sql = sql.concat(" insert into lab_test values");

        sql = sql.concat("'" + objLabTest.getName() + "' ,");
        sql = sql.concat("'" + objLabTest.getAbbreviation() + "' ,");
        sql = sql.concat("'" + objLabTest.getReflexiveTesting_description() + "'") + " ,";
        sql = sql.concat("'" + objLabTest.getPanels_description() + "'") + " ,";
        sql = sql.concat("'" + objLabTest.getSpecial_collection_requirements() + "'") + " ,";
        // quit the last ,
        sql = sql.substring(0, sql.length() - 1);
        sql = sql.concat(" )");
        DB.executeQuery(sql);

    }

    public static void updateLabTest(LabTestRepository objLabTest) {
        String sql = "";
        sql = sql.concat(" update lab_test set ");

        sql = sql.concat("Name= '" + objLabTest.getName() + "' ,");
        sql = sql.concat("Abbreviation= '" + objLabTest.getAbbreviation() + "' ,");
        sql = sql.concat("ReflexiveTesting_description= '" + objLabTest.getReflexiveTesting_description()) + "' ,";
        sql = sql.concat("Panels_description= '" + objLabTest.getPanels_description()) + "' ,";
        sql = sql.concat("Special_collection_requirements= '" + objLabTest.getSpecial_collection_requirements())
                + "' ,";
        // quit the last ,
        sql = sql.substring(0, sql.length() - 1);
        sql = sql.concat(" where id=" + objLabTest.getId());
        DB.executeQuery(sql);

    }

    public static List<LabTestRepository> getList() {

        final List<LabTestRepository> LabTestList = new ArrayList<LabTestRepository>();
        LabTestRepository p1 = null;

        ResultSet result = null;
        String sql = "SELECT * FROM lab_test ";

        try {

            result = DB.executeQuery(sql);

            while (result.next()) {
                p1 = new LabTestRepository();

                p1.setId(result.getInt("id"));

                p1.setName(result.getString("name"));

                p1.setAbbreviation(result.getString("abbreviation"));

                p1.setReflexiveTesting_description(result.getString("reflexive_testing_description"));

                p1.setPanels_description(result.getString("panels_description"));

                p1.setSpecial_collection_requirements(result.getString("special_collection_requirements"));
                LabTestList.add(p1);

            }
        } catch (Exception e) {
            System.out.println("Error Sql: " + e.getMessage());
        } finally {
        }

        return LabTestList;
    }

    public static LabTest getLabTest(int Id) {

    	LabTest p1 = null;
        ResultSet result = null;
        String sql = "SELECT * FROM lab_test where (id = " + Id + ")";

        try {

            result = DB.executeQuery(sql);

            if (result.next()) {
                p1 = new LabTest();

                p1.setId(result.getInt("id"));

                p1.setName(result.getString("name"));

                p1.setAbbreviation(result.getString("abbreviation"));

                p1.setReflexiveTesting_description(result.getString("reflexive_testing_description"));

                p1.setPanels_description(result.getString("panels_description"));

                p1.setSpecial_collection_requirements(result.getString("special_collection_requirements"));

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

    public static int getLabTestID(String testName) {
        String sql = "SELECT * FROM lab_test WHERE (name = '" + testName + "')";

        try {
            ResultSet result = DB.executeQuery(sql);
            if (result.next())
                return result.getInt("id");

        } catch (Exception e) {
            System.out.println("Error Sql: " + e.getMessage());
        }

        return 0;
    }


}