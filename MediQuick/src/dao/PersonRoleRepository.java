package dao;

//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.util.Iterator;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import domain.Role;

public class PersonRoleRepository {

    private int Id;

    private int personId;

    private int roleId;

    public int getId() {
        return Id;
    }

    public void setId(int id) {
        this.Id = id;
    }

    public int getPersonId() {
        return personId;
    }

    public void setPersonId(int personId) {
        this.personId = personId;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    public PersonRoleRepository() {
    }

    public void insert(PersonRoleRepository objPerson_role) {
        String sql = "";
        sql = sql.concat(" insert into person_role values");

        sql = sql.concat(objPerson_role.getPersonId() + " ,");
        sql = sql.concat(objPerson_role.getRoleId() + " ,");
        // quit the last ,
        sql = sql.substring(0, sql.length() - 1);
        sql = sql.concat(" )");
        DB.executeQuery(sql);

    }

    public static void update(PersonRoleRepository objPerson_role) {
        String sql = "";
        sql = sql.concat(" update person_role set ");

        sql = sql.concat("person_id=" + objPerson_role.getPersonId() + " ,");
        sql = sql.concat("role_id=" + objPerson_role.getRoleId() + " ,");
        // quit the last ,
        sql = sql.substring(0, sql.length() - 1);
        sql = sql.concat(" where id=" + objPerson_role.getId());
        DB.executeQuery(sql);

    }

    public static List<PersonRoleRepository> getList() {

        final List<PersonRoleRepository> Person_roleList = new ArrayList<PersonRoleRepository>();
        PersonRoleRepository p1 = null;

        ResultSet result = null;
        String sql = "SELECT * FROM person_role ";
        System.out.println(sql);

        try {

            result = DB.executeQuery(sql);

            while (result.next()) {
                p1 = new PersonRoleRepository();

                p1.setId(result.getInt("id"));

                p1.setPersonId(result.getInt("person_id"));

                p1.setRoleId(result.getInt("role_id"));
                Person_roleList.add(p1);

            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        }

        return Person_roleList;
    }

    public static Role getById(int id) {

        Role role = null;
        ResultSet result = null;
        String sql = "SELECT * FROM person_role where (id = " + id + ")";
        System.out.println(sql);

        try {

            result = DB.executeQuery(sql);

            if (result.next()) {
                role = RoleRepository.getById(result.getInt("role_id"));
            } else {
                System.out.println("No Results Found!" + sql);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            System.out.println("role.permissions: " + role.getPermissions().size());
        }
        return role;
    }

}