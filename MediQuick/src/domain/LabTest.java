package domain;

import java.util.ArrayList;

import dao.LabRequestDetailRepository;
import dao.LabRequestRepository;
import dao.LabResultDetailRepository;
import dao.LabTestRepository;
import dao.PersonRepository;

public class LabTest extends LabTestRepository{

    public static ArrayList<LabTestRepository> getTests() {
        ArrayList<LabTestRepository> List = (ArrayList<LabTestRepository>) LabTestRepository.getList();
        return List;
    }

    public static void RequestTest(String TestList, int LabID, int ICDCodeID, int PatientID, int requestingNurseID, int DrID, String Status) {
        LabRequestRepository Request = new LabRequestRepository();

        int testCount = 0;
        for (int i = 0; i < TestList.length(); i++)
            if (TestList.charAt(i) == '|')
                testCount++;

        int maximumID = LabRequestRepository.getMaxID();
        Request.setId(maximumID);

        Request.setICD9CodeId(ICDCodeID);
        Request.setLaboratoryId(LabID);

        // today's date
        java.util.Date dt = new java.util.Date();
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String currentTime = sdf.format(dt);
        Request.setOrderPlaced(currentTime);
        Request.setRequestingNurseId(requestingNurseID);
        Request.setOrderingPhysicianId(DrID);
        Request.setPatientId(PatientID);
        Request.setStatus(Status);

        Request.insert();

        // inserting a detail for each of the requested tests
        for (int i = 0; i < testCount; i++) {
            LabRequestDetailRepository ReqDetail = new LabRequestDetailRepository();
            String testName = TestList.substring(0, TestList.indexOf("|"));
            TestList = TestList.substring(TestList.indexOf("|") + 1, TestList.length());

            int testID = LabTestRepository.getLabTestID(testName);
            ReqDetail.setLabTestId(testID);
            ReqDetail.setLabRequestId(Request.getId());

            int detailID = LabRequestDetailRepository.getMaxID();
            ReqDetail.setId(detailID);

            ReqDetail.insert();
        }

    }

    public static  ArrayList<Person> getListOfPatients(int DrID) {
        ArrayList<Person> Patients = LabRequestRepository.getPatientsOfDoctor(DrID);
        return Patients;
    }
    
    public static ArrayList<Person> getListofPatientsByName(int DrID, String PatientFirstName, String PatientLastName)
    {
    	ArrayList<Person> Patients = LabRequestRepository.getPatientsOfDoctorByName(DrID, PatientFirstName, PatientLastName);
    	return Patients;
    }

    public static ArrayList<LabRequest> getListOfTests_DoctorAndPatient(int PatientID, int DrID) {
        ArrayList<LabRequest> Tests = LabRequestRepository.getTests_DoctorAndPatient(PatientID, DrID);
        return Tests;
    }

    public static ArrayList<LabRequest> getListOfTests_Patient(int PatientID) {
        ArrayList<LabRequest> Tests = LabRequestRepository.getTests_Patient(PatientID);
        return Tests;
    }

	public static void SaveResult(int resID, int TestID, String testValue) {
		LabResultDetailRepository LRD = new LabResultDetailRepository();
		LRD.setId(LabResultDetailRepository.getMaxID());
		LRD.setLab_resultId(resID);
		LRD.setLabTestId(TestID);
		LRD.setResult(testValue);
		LRD.insert();
	}

	public static void ModifyResult(int resultID, int TestID, String testValue) {
		LabResultDetailRepository LRD = new LabResultDetailRepository();
		
		LRD.setLab_resultId(resultID);
		LRD.setLabTestId(TestID);
		LRD.setResult(testValue);
		LRD.update();
	}

}
