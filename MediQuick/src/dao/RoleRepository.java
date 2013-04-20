package dao;

//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.util.Iterator;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import domain.Permission;
import domain.Role;

public class RoleRepository {

    private int id;

    private String name;

    private ArrayList<Permission> permissions = new ArrayList<Permission>();
    
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

    public ArrayList<Permission> getPermissions() {
        return permissions;
    }

    public void setPermissions(ArrayList<Permission> permissions) {
        this.permissions = permissions;
    }

    
    public RoleRepository() {
    }

    public void insertRole(RoleRepository objRole) {
        String sql = "";
        sql = sql.concat(" insert into role values");

        sql = sql.concat("'" + objRole.getName() + "' ,");
        // quit the last ,
        sql = sql.substring(0, sql.length() - 1);
        sql = sql.concat(" )");
        DB.executeQuery(sql);

    }

    public static void updateRole(RoleRepository objRole) {
        String sql = "";
        sql = sql.concat(" update role set ");

        sql = sql.concat("Name= '" + objRole.getName() + "' ,");
        // quit the last ,
        sql = sql.substring(0, sql.length() - 1);
        sql = sql.concat(" where id=" + objRole.getId());
        DB.executeQuery(sql);

    }

    public static List<Role> getList() {

        final List<Role> roleList = new ArrayList<Role>();
        Role p1 = null;

        ResultSet result = null;
        String sql = "SELECT * FROM role ";

        try {

            result = DB.executeQuery(sql);

            while (result.next()) {
                p1 = new Role();

                p1.setId(result.getInt("id"));

                p1.setName(result.getString("name"));
                roleList.add(p1);

            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        }

        return roleList;
    }

    public static Role getById(int Id) {
        Role role = null;
        ResultSet result = null;
        String sql = "SELECT * FROM role where (id = " + Id + ")";

        try {
            result = DB.executeQuery(sql);
            if (result.next()) {
                role = new Role();
                role.setId(result.getInt("id"));
                role.setName(result.getString("name"));
                ResultSet rs = RolePermissionRepository.getPermissions(role.getId());
                while (rs.next()) { 
                    Permission permission = PermissionRepository.getPermission(rs.getInt("permission_id"));
                    System.out.println("Adding permission" + permission);

                    role.getPermissions().add(permission);
                }                    
            } else {
                System.out.println("No Results Found!" + sql);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
        }
        return role;
    }

    public static Role getRoleByName(String roleName) {
        Role role = null;
        ResultSet result = null;
        String sql = "SELECT * FROM role where (name = '" + roleName + "')";
        try {
            result = DB.executeQuery(sql);
            if (result.next()) {
                role = new Role();
                role.setId(result.getInt("id"));
                role.setName(result.getString("name"));
                ResultSet rs = RolePermissionRepository.getPermissions(role.getId());
                while (rs.next()) { 
                    Permission permission = PermissionRepository.getPermission(rs.getInt("permissionId"));
                    System.out.println("Adding " + permission);
                    role.getPermissions().add(permission);
                }         
            } else {
                System.out.println("No Results Found!" + sql);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
        }
        return role;

    }

}