package dao;

//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.util.Iterator;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RolePermissionRepository {

    private int Id;

    private int RoleId;

    private int PermissionId;

    public int getId() {
        return Id;
    }

    public void setId(int id) {
        this.Id = id;
    }

    public int getRoleId() {
        return RoleId;
    }

    public void setRoleId(int roleId) {
        this.RoleId = roleId;
    }

    public int getPermissionId() {
        return PermissionId;
    }

    public void setPermissionId(int permissionId) {
        this.PermissionId = permissionId;
    }

    public RolePermissionRepository() {
    }

    public void deleteRole_permission(RolePermissionRepository objRole_permission) {
        String sql = "delete * FROM role_permission where (id = " + objRole_permission.getId() + ")";
        DB.executeQuery(sql);

    }

    public void deleteRole_permission(int Id) {
        String sql = "delete * FROM role_permission where (id = " + Id + ")";
        DB.executeQuery(sql);

    }

    public void insertRole_permission(RolePermissionRepository objRole_permission) {
        String sql = "";
        sql = sql.concat(" insert into role_permission values");

        sql = sql.concat(objRole_permission.getRoleId() + " ,");
        sql = sql.concat(objRole_permission.getPermissionId() + " ,");
        // quit the last ,
        sql = sql.substring(0, sql.length() - 1);
        sql = sql.concat(" )");
        DB.executeQuery(sql);

    }

    public static void updateRole_permission(RolePermissionRepository objRole_permission) {
        String sql = "";
        sql = sql.concat(" update role_permission set ");

        sql = sql.concat("role_id=" + objRole_permission.getRoleId() + " ,");
        sql = sql.concat("permission_id=" + objRole_permission.getPermissionId() + " ,");
        // quit the last ,
        sql = sql.substring(0, sql.length() - 1);
        sql = sql.concat(" where id=" + objRole_permission.getId());
        DB.executeQuery(sql);

    }

    public static List<RolePermissionRepository> getList() {

        final List<RolePermissionRepository> Role_permissionList = new ArrayList<RolePermissionRepository>();
        RolePermissionRepository p1 = null;

        ResultSet result = null;
        String sql = "SELECT * FROM role_permission ";

        try {

            result = DB.executeQuery(sql);

            while (result.next()) {
                p1 = new RolePermissionRepository();

                p1.setId(result.getInt("id"));

                p1.setRoleId(result.getInt("role_id"));

                p1.setPermissionId(result.getInt("permission_id"));
                Role_permissionList.add(p1);

            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        }

        return Role_permissionList;
    }

    public static RolePermissionRepository getRole_permission(int Id) {
        RolePermissionRepository p1 = null;
        ResultSet result = null;
        String sql = "SELECT * FROM role_permission where (id = " + Id + ")";
        System.out.println(sql);
        try {
            result = DB.executeQuery(sql);
            if (result.next()) {
                p1 = new RolePermissionRepository();
                p1.setId(result.getInt("id"));
                p1.setRoleId(result.getInt("role_id"));
                p1.setPermissionId(result.getInt("permission_id"));
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

    public static ResultSet getPermissions(int RoleID) {
        RolePermissionRepository p1 = null;
        ResultSet result = null;
        String sql = "SELECT * FROM role_permission where (role_id = " + RoleID + ")";
        System.out.println(sql);
        try {
            result = DB.executeQuery(sql);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

}