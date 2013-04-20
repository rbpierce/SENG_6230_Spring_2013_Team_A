package domain;

import java.util.ArrayList;

import dao.*;

public class LabResult extends LabResultRepository {
	public static ArrayList<LabResultDetail> getDetails(int ResultID)
	{
		ArrayList<LabResultDetail> result = LabResultRepository.getDetails(ResultID);
		return result;
	}

}
