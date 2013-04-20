package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class MessageRepository {
	private int id;
	private int person_id;
	private String text;
	private String status;
	
	public void setID(int ID)
	{
		id = ID;
	}
	
	public void setPersonID(int PersonID)
	{
		person_id = PersonID;
	}
	
	public void setText(String Text)
	{
		text = Text;
	}
	
	public void setStatus(String Status)
	{
		status = Status;
	}
	
	public int getID()
	{
		return id;
	}
	
	public int getPersonID()
	{
		return person_id;
	}
	
	public String getText()
	{
		return text;
	}
	
	public String getStatus()
	{
		return status;
	}
	
	public static void PutNewMessage(int personID, String Text)
	{
		int maxID = getMaxID();
		String sql = "INSERT INTO general_message VALUES(" + maxID + ", " + personID + ", '" + Text + "', 'NEW')";
		DB.executeUpdate(sql);
	}

	public static int getMaxID() {
		String SQL = "SELECT MAX(id) FROM general_message";
		ResultSet res = DB.executeQuery(SQL);
		try {
			if(res.next()){
				int maxID = res.getInt("MAX(id)");
				return maxID+1;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 1;
	}

	public static ArrayList<MessageRepository> getNewMessages(int personID) {
		ArrayList<MessageRepository> List = new ArrayList<MessageRepository>();
		String sql = "SELECT * FROM general_message WHERE (person_id=" + personID + " AND status='NEW')";
		ResultSet res = DB.executeQuery(sql);
		
		try {
			while(res.next())
			{
				MessageRepository MR = new MessageRepository();
				MR.setID(res.getInt("id"));
				MR.setPersonID(res.getInt("person_id"));
				MR.setText(res.getString("text"));
				MR.setStatus(res.getString("status"));
				
				List.add(MR);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return List;
	}
	
	
	public static ArrayList<MessageRepository> getMessages(int personID) {
		ArrayList<MessageRepository> List = new ArrayList<MessageRepository>();
		String sql = "SELECT * FROM general_message WHERE (person_id=" + personID + ")";
		ResultSet res = DB.executeQuery(sql);
		
		try {
			while(res.next())
			{
				MessageRepository MR = new MessageRepository();
				MR.setID(res.getInt("id"));
				MR.setPersonID(res.getInt("person_id"));
				MR.setText(res.getString("text"));
				MR.setStatus(res.getString("status"));
				
				List.add(MR);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return List;
	}
	
	public static void FlagMessageAsSeen(int MessageID) {
		String sql = "UPDATE general_message set `status`='SEEN' WHERE (id=" + MessageID + ")";
		DB.executeUpdate(sql);
	}

}
