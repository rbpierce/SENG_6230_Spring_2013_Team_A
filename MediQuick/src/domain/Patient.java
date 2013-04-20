package domain;

import java.util.ArrayList;

import dao.*;

public class Patient extends Person {
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

}
