package test.dao;

import java.util.ArrayList;

import dao.LabRequestRepository;
import dao.LabResultRepository;
import domain.LabRequest;
import domain.LabResult;
import junit.framework.TestCase;

public class LabRequestResultTest extends TestCase {

	
	public final void testGetTests() {
		ArrayList<LabRequest> requests =  LabRequestRepository.getTestsForPatient(1);
		assertEquals("Expected 16 test requests", 16, requests.size() );
	}

	public final void testGetResult() {
		ArrayList<LabResult> results =LabResultRepository.getAllResultsOfRequest(1);
		assertEquals("Expected 1 result", 1, results.size());
		assertEquals("Expected given details", "Test details for junit testing", 
				results.get(0).getCompletionStatusDetails());
	}

	public final void testGetById() {
		LabRequest request = LabRequestRepository.getById(1);
		assertEquals("Expected given specimen number", "JUNIT TEST NUMBER", request.getSpecimen_number());
		LabResult result = LabResultRepository.getById(1);
		assertEquals("Expected given details", "Test details for junit testing", result.getCompletionStatusDetails());
	}

}
