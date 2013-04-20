package dao;

//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.util.Iterator;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import domain.Permission;

public class PermissionRepository {

    private int id;
    private String name;
    private String description;

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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public PermissionRepository() {
    }

    public void insertPermission(PermissionRepository objPermission) {
        String sql = "";
        sql = sql.concat(" insert into permission values");

        sql = sql.concat("'" + objPermission.getName() + "' ,");
        sql = sql.concat("'" + objPermission.getDescription() + "' ,");
        // quit the last ,
        sql = sql.substring(0, sql.length() - 1);
        sql = sql.concat(" )");
        DB.executeQuery(sql);

    }

    public static void updatePermission(PermissionRepository objPermission) {
        String sql = "";
        sql = sql.concat(" update permission set ");

        sql = sql.concat("name= '" + objPermission.getName() + "' ,");
        sql = sql.concat("description= '" + objPermission.getDescription() + "' ,");
        // quit the last ,
        sql = sql.substring(0, sql.length() - 1);
        sql = sql.concat(" where id=" + objPermission.getId());
        DB.executeQuery(sql);

    }

    public static List<Permission> getList() {

        final List<Permission> PermissionList = new ArrayList<Permission>();
        Permission p1 = null;
        ResultSet result = null;
        String sql = "SELECT * FROM permission ";

        try {
            result = DB.executeQuery(sql);
            while (result.next()) {
                p1 = new Permission();
                p1.setId(result.getInt("id"));
                p1.setName(result.getString("name"));
                p1.setDescription(result.getString("description"));
                PermissionList.add(p1);

            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        }

        return PermissionList;
    }

    public static Permission getPermission(int Id) {
        Permission p1 = null;
        ResultSet result = null;
        String sql = "SELECT * FROM permission where (id = " + Id + ")";
        System.out.println(sql);

        try {
            result = DB.executeQuery(sql);
            if (result.next()) {
                p1 = new Permission();
                p1.setId(result.getInt("id"));
                p1.setName(result.getString("name"));
                p1.setDescription(result.getString("description"));
            } else {
                System.out.println("No Results Found!" + sql);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
        }

        return p1;
    }

}
