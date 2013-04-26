package dao;

//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.util.Iterator;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import domain.ICD9Code;

public class ICD9CodeRepository {

    private int Id;

    private String Code;

    private String Description;

    public int getId() {
        return Id;
    }

    public void setId(int id) {
        this.Id = id;
    }

    public String getCode() {
        return Code;
    }

    public void setCode(String code) {
        this.Code = code;
    }

    public String getDescription() {
        return Description;
    }

    public void setDescription(String description) {
        this.Description = description;
    }

    public ICD9CodeRepository() {
    }

    public void deleteICD9Code(ICD9CodeRepository objICD9Code) {
        String sql = "delete FROM iCD9_Code where (id = " + objICD9Code.getId() + ")";
        DB.executeUpdate(sql);

    }

    public void deleteICD9Code(int Id) {
        String sql = "delete FROM iCD9_Code where (id = " + Id + ")";
        DB.executeUpdate(sql);

    }

    public void insertICD9Code(ICD9CodeRepository objICD9Code) {
        String sql = "";
        sql = sql.concat(" insert into iCD9_Code values(");

        sql = sql.concat("'" + objICD9Code.getCode() + "' ,");
        sql = sql.concat("'" + objICD9Code.getDescription() + "'") + " ,";
        // quit the last ,
        sql = sql.substring(0, sql.length() - 1);
        sql = sql.concat(" )");
        DB.executeUpdate(sql);

    }

    public static void updateICD9Code(ICD9CodeRepository objICD9Code) {
        String sql = "";
        sql = sql.concat(" update iCD9_Code set ");

        sql = sql.concat("Code= '" + objICD9Code.getCode() + "' ,");
        sql = sql.concat("Description= '" + objICD9Code.getDescription()) + "' ,";
        // quit the last ,
        sql = sql.substring(0, sql.length() - 1);
        sql = sql.concat(" where id=" + objICD9Code.getId());
        DB.executeUpdate(sql);

    }

    public static ArrayList<ICD9Code> getList() {

        ArrayList<ICD9Code> ICD9CodeList = new ArrayList<ICD9Code>();
        ICD9Code p1 = null;

        ResultSet result = null;
        String sql = "SELECT * FROM iCD9_Code ORDER BY code";

        try {

            result = DB.executeQuery(sql);

            while (result.next()) {
                p1 = new ICD9Code();

                p1.setId(result.getInt("id"));

                p1.setCode(result.getString("code"));

                p1.setDescription(result.getString("description"));
                ICD9CodeList.add(p1);

            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        }

        return ICD9CodeList;
    }

    public static ICD9Code getICD9Code(int id) {

    	ICD9Code p1 = null;
        ResultSet result = null;
        String sql = "SELECT * FROM iCD9_Code where (id = " + id + ")";

        try {

            result = DB.executeQuery(sql);

            if (result.next()) {
                p1 = new ICD9Code();

                p1.setId(result.getInt("id"));

                p1.setCode(result.getString("code"));

                p1.setDescription(result.getString("description"));

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