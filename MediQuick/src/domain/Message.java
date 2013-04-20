package domain;

import java.util.*;

public class Message {
	public ArrayList<String> Columns;
	public ArrayList<Message> Messages;
	public String title;
	public int width;
	
	public Message()
	{
		Columns = new ArrayList<String>();
		Messages = new ArrayList<Message>();
	}
}
