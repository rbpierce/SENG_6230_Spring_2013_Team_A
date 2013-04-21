package domain;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import java.sql.PreparedStatement;

import dao.*;

public class Patient extends PatientRepository {
	public Message getMessages(int PersonID)
	{
		ArrayList<MessageRepository> Messages = MessageRepository.getNewMessages(PersonID);
		Message m = new Message();
    	m.Columns.add("Message");
    	m.width = 900;
    	
    	if(Messages.size() == 0)
    		return null;
    	else if(Messages.size() == 1)
    		m.title = "You have 1 new message";
    	else if (Messages.size() > 1)
        	m.title = "You have " + Messages.size() + " new messages";
        
    	
    	for(MessageRepository MR: Messages)
    	{
    		Message m1 = new Message();
    		m1.Columns.add(MR.getText());
    		MessageRepository.FlagMessageAsSeen(MR.getID());
            m.Messages.add(m1);
    	}
    	
    	return m;
	}

	
	public static ArrayList<Person> search(Physician physicianHasOrderedTests, String firstName, String lastName) {
		String sql = "SELECT p.id FROM person p ";
		if (physicianHasOrderedTests!=null) sql += " LEFT JOIN lab_request r ON p.ordering_physician_id=" + physicianHasOrderedTests.getId() + ")";
		sql += " WHERE p.first_name LIKE CONCAT(?,'%') AND p.last_name LIKE CONCAT(?,'%') AND p.is_active=1 AND p.member_type='PATIENT' ";
		if (physicianHasOrderedTests!=null) sql += " AND r.id IS NOT NULL ";
		sql += " ORDER BY p.last_name, p.first_name";
	    ArrayList<Person> matchingPatients = new ArrayList<Person>();
	    try {
			PreparedStatement ps = DB.getConn().prepareStatement(sql);
			ps.setString(1,  firstName);
			ps.setString(2, lastName);
			
		    ResultSet res = ps.executeQuery();
	    	while (res.next()) {
	            Person p = Person.getById(res.getInt("id"));
	            matchingPatients.add(p);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return matchingPatients;
	}	
	
}
