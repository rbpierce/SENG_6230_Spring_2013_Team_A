package dao;

//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.util.Iterator;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

import domain.*;

public class PersonRepository {
    private int Id;
    private String _memberType;
    private String _firstName;
    private String _middleName;
    private String _lastName;
    private String _maidenName;
    private String _suffix;
    private String _gender;
    private String maritalStatus;
    private Date _birthDate;
    private boolean _isTest;
    private boolean isActive;
    private String _username;
    private String _passwordPlaintext;
    private boolean isPasswordResetRequired;
    private Role _role;

    public PersonRepository() { 
    	Id = 0;
    	_memberType = null;
    	_firstName = "";
    	_lastName = "";
    	_middleName = "";
    	_maidenName = "";
    	_suffix = "";
    	_gender = "";
    	maritalStatus = "UNREPORTED";
    	_birthDate = null;
    	isActive = true;
    }

    public int getId() {
        return Id;
    }

    public void setId(int id) {
        this.Id = id;
    }

    public String getMemberType() {
        return _memberType;
    }

    public void setMemberType(String member_type) {
        this._memberType = member_type;
    }

    public String getFirstName() {
        return _firstName;
    }

    public void setFirstName(String firstName) {
        this._firstName = firstName;
    }

    public String getMiddleName() {
        return _middleName;
    }

    public void setMiddleName(String middleName) {
        this._middleName = middleName;
    }

    public String getLastName() {
        return _lastName;
    }

    public void setLastName(String lastName) {
        this._lastName = lastName;
    }

    public String getMaidenName() {
        return _maidenName;
    }

    public void setMaidenName(String maidenName) {
        this._maidenName = maidenName;
    }

    public String getSuffix() {
        return _suffix;
    }

    public void setSuffix(String suffix) {
        this._suffix = suffix;
    }

    public String getGender() {
        return _gender;
    }

    public void setGender(String gender) {
        this._gender = gender;
    }

    public String getMaritalStatus() {
        return maritalStatus;
    }

    public void setMaritalStatus(String maritalStatus) {
        this.maritalStatus = maritalStatus;
    }

    public Date getBirthDate() {
        return _birthDate;
    }

    public void setBirthDate(Date birthDate) {
        this._birthDate = birthDate;
    }

    public boolean getIsTest() {
        return _isTest;
    }

    public void setIsTest(boolean isTest) {
        this._isTest = isTest;
    }

    public boolean getIsActive() {
        return isActive;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }

    public String getUsername() {
        return _username;
    }

    public void setUsername(String username) {
        this._username = username;
    }

    public String getPasswordPlaintext() {
        return _passwordPlaintext;
    }

    public void setPasswordPlaintext(String passwordPlaintext) {
        this._passwordPlaintext = passwordPlaintext;
    }

    public boolean getIsPasswordResetRequired() {
        return isPasswordResetRequired;
    }

    public void setIsPasswordResetRequired(boolean isPasswordResetRequired) {
        this.isPasswordResetRequired = isPasswordResetRequired;
    }
    

    public Role getRole() {
        return _role;
    }

    public void setRole(Role _role) {
        this._role = _role;
    }

    
    public Message getMessages(int personID)
    {
    	Person person = Person.getById(personID);
    	
    	PersonRepository p = null;
        String MemType = person.getMemberType().toUpperCase();
        
        if(MemType.equals("PHYSICIAN"))	
        	p = new Physician();
        else if(MemType.equals("PATIENT"))
        	p = new Patient();
        else if(MemType.equals("NURSE"))
        	p = new Nurse();
        
        if(p==null)
        	return null;
        else
        	return p.getMessages(personID);
    }

    public void deletePerson(PersonRepository objPerson) {
        String sql = "delete * FROM Person where (`id` = " + objPerson.getId() + ")";
        DB.executeQuery(sql);

    }

    public void deletePerson(int id) {
        String sql = "delete * FROM Person where (`id` = " + id + ")";
        DB.executeQuery(sql);

    }

    public void insertPerson(PersonRepository objPerson) {
        String sql = "";
    	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
        sql = sql
                .concat(" insert into Person (`id`, `member_type`,`first_name`,`middle_name`,`last_name`,`maiden_name`,`suffix`,`gender`,`marital_status`,`birth_date`,`is_test`,`is_active`,`username`,`password_plaintext`,`is_password_reset_required`)");
        sql = sql.concat(" values (");
        sql = sql.concat((objPerson.getId()<=0 ? PersonRepository.getMaxID()+1 : objPerson.getId()) + ", \"");
        sql = sql.concat(objPerson.getMemberType() + "\" ,\"");
        sql = sql.concat(objPerson.getFirstName() + "\" ,\"");
        sql = sql.concat(objPerson.getMiddleName() + "\" ,\"");
        sql = sql.concat(objPerson.getLastName() + "\" ,\"");
        sql = sql.concat(objPerson.getMaidenName() + "\" ,\"");
        sql = sql.concat(objPerson.getSuffix() + "\" ,\"");
        sql = sql.concat(objPerson.getGender() + "\" ,\"");
        sql = sql.concat(objPerson.getMaritalStatus() + "\" ,\"");
        sql = sql.concat(sdf.format(objPerson.getBirthDate()) + "\" , ");
        sql = sql.concat(String.valueOf(objPerson.getIsTest())) + " ,";
        sql = sql.concat(String.valueOf(objPerson.getIsActive())) + " ,\"";
        sql = sql.concat(objPerson.getUsername() + "\" ,\"");
        sql = sql.concat(objPerson.getPasswordPlaintext() + "\" ,");
        sql = sql.concat(String.valueOf(objPerson.getIsPasswordResetRequired())) + " )";
System.out.println(sql);
        DB.executeUpdate(sql);

    }

    public static int getMaxID() {
        String sql = "SELECT MAX(id) FROM person";
        ResultSet res = DB.executeQuery(sql);
        int maxID = 0;
        try {
            if (res.next())
                maxID = res.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return maxID;
    }


	public static void updatePerson(PersonRepository objPerson) {
        String sql = "";
        sql = sql.concat(" update Person set ");

        sql = sql.concat("`member_type`=\"" + nt(objPerson.getMemberType()) + "\" ,");
        sql = sql.concat("`first_name`=\"" + nt(objPerson.getFirstName()) + "\" ,");
        sql = sql.concat("`middle_name`=\"" + nt(objPerson.getMiddleName()) + "\" ,");
        sql = sql.concat("`last_name`=\"" + nt(objPerson.getLastName()) + "\" ,");
        sql = sql.concat("`maiden_name`=\"" + nt(objPerson.getMaidenName()) + "\" ,");
        sql = sql.concat("`suffix`=\"" + nt(objPerson.getSuffix()) + "\" ,");
        sql = sql.concat("`gender`=\"" + objPerson.getGender() + "\" ,");
        sql = sql.concat("`marital_status`=\"" + nt(objPerson.getMaritalStatus()) + "\" ,");
        sql = sql.concat("`birth_date`=\"" + objPerson.getBirthDate() + "\" , ");
        sql = sql.concat("`is_test`=\"" + (objPerson.getIsTest()?1:0) + "\" ,");
        sql = sql.concat("`is_active`=\"" + (objPerson.getIsActive()?1:0) + "\" ,");
        sql = sql.concat("`username`=\"" + nt(objPerson.getUsername()) + "\" ,");
        sql = sql.concat("`password_plaintext`=\"" + nt(objPerson.getPasswordPlaintext()) + "\" ,");
        sql = sql.concat("`is_password_reset_required`=\"" + (objPerson.getIsPasswordResetRequired()?1:0) + "\" ");
        sql = sql.concat(" where `id`=" + objPerson.getId());
        System.out.println(sql);
        DB.executeUpdate(sql);

    }
	
	private static String nt(String str) { 
		if (str==null) return "";
		else return str;
	}

    public static ResultSet getList() {
        ResultSet result = null;
        String sql = "SELECT * FROM Person ";
        try {
            result = DB.executeQuery(sql);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        }
        return result;
    }

    public static String getPersonName(int id) {
        PersonRepository temp = PersonRepository.getById(id);
        return temp.getFirstName() + " " + temp.getLastName();
    }
    
    public String getDisplayName() { 
    	return getFirstName() + " " + getLastName();
    }

    public static Person getById(int id) {

    	Person p1 = null;
        ResultSet result = null;
        String sql = "SELECT * FROM person where (id = " + id + ")";

        try {

            result = DB.executeQuery(sql);

            if (result.next()) {
                p1 = new Person();
                p1.setId(result.getInt("id"));
                p1.setMemberType(result.getString("member_type"));
                p1.setFirstName(result.getString("first_name"));
                p1.setMiddleName(result.getString("middle_name"));
                p1.setLastName(result.getString("last_name"));
                p1.setMaidenName(result.getString("maiden_name"));
                p1.setSuffix(result.getString("suffix"));
                p1.setGender(result.getString("gender"));
                p1.setMaritalStatus(result.getString("marital_status"));
                p1.setBirthDate(result.getDate("birth_date"));
                p1.setIsTest(result.getBoolean("is_test"));
                p1.setIsActive(result.getBoolean("is_active"));
                p1.setUsername(result.getString("username"));
                p1.setPasswordPlaintext(result.getString("password_plaintext"));
                p1.setIsPasswordResetRequired(result.getBoolean("is_password_reset_required"));

            } else {
                System.out.println("No  found!");
                return null;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
        }

        return p1;
    }

    public static Person getPerson(String UserName, String Password) {

        Person person1 = null;
        ResultSet result = null;
        String sql = "SELECT * FROM Person where (username = '" + UserName + "' AND password_plaintext='" + Password
                + "')";
        System.out.println(sql);

        try {

            result = DB.executeQuery(sql);

            if (result.next()) {
                person1 = new Person();
                person1.setId(result.getInt("id"));
                person1.setMemberType(result.getString("member_type"));
                person1.setFirstName(result.getString("first_name"));
                person1.setMiddleName(result.getString("middle_name"));
                person1.setLastName(result.getString("last_name"));
                person1.setMaidenName(result.getString("maiden_name"));
                person1.setSuffix(result.getString("suffix"));
                person1.setGender(result.getString("gender"));
                person1.setMaritalStatus(result.getString("marital_status"));
                person1.setBirthDate(result.getDate("birth_date"));
                person1.setIsTest(result.getBoolean("is_test"));
                person1.setIsActive(result.getBoolean("is_active"));
                person1.setUsername(result.getString("username"));
                person1.setPasswordPlaintext(result.getString("password_plaintext"));
                person1.setIsPasswordResetRequired(result.getBoolean("is_password_reset_required"));

                result = DB.executeQuery("SELECT * FROM person_role WHERE person_id=" + person1.getId());
                System.out.println("SELECT * FROM person_role WHERE person_id=" + person1.getId());
                if (result.next()) person1.setRole(PersonRoleRepository.getById(result.getInt("id")));
                
            } else {
                System.out.println("No person found!");
                return null;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
        }

        return person1;
    }

	public static boolean isDoctor(int personID) {
		Person P = Person.getById(personID);
		String memType = P.getMemberType().toLowerCase();
		if(memType.equals("P"))
			return true;
		return false;
	}
    
    

}