package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.LabRequestDetailRepository;
import dao.LabRequestRepository;
import dao.LabResultDetailRepository;
import dao.LabResultRepository;
import dao.LabTestRepository;
import dao.PatientRepository;
import domain.LabRequest;
import domain.LabRequestDetail;
import domain.LabResult;
import domain.LabResultDetail;
import domain.LabTest;
import domain.Patient;
import domain.Person;

@WebServlet("/SubmitTestResult")
public class SubmitTestResult extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
    		throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) 
    		throws ServletException, IOException {

        HttpSession session = request.getSession();
        Person person = (Person) session.getAttribute("person");
        String patientId = request.getParameter("patient_id");
        String labRequestId = request.getParameter("lab_request_id");
        boolean rejected = request.getParameter("reject_test")!=null;
        String forwardPage = "/viewPatient.jsp?id=" + patientId;

    	LabRequest labRequest = LabRequestRepository.getById(Integer.parseInt(labRequestId));
    	
    	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
    	
        try {
        	if (!person.hasPermission("PROCESS_LAB_REQUEST")) throw new Exception ("Unauthorized Access!");

        	LabResult labResult = new LabResult();
        	//labResult.setCompletionStatus(request.getParameter("status"));
        	labResult.setCompletionStatusDetails(request.getParameter("details"));
        	labResult.setCompletionDate(sdf.format(new java.util.Date()));
        	labResult.setLabRequestId(labRequest.getId());
        	labResult.setProcessedByTechnicianId(person.getId());
        	labResult.insert();
        	assert(labResult.getId()>0);
        	if (!rejected) { 
	        	for (LabRequestDetail requestDetail : LabRequestDetailRepository.getAll(labRequest.getId())) {
	        		LabResultDetail resultDetail = new LabResultDetail();
	        		resultDetail.setDetails(request.getParameter("comments_test_" + requestDetail.getId()));
	        		resultDetail.setResult(request.getParameter("results_test_" + requestDetail.getId()));
	        		resultDetail.setLabTestId(requestDetail.getLabTestId());
	        		resultDetail.setLab_resultId(labResult.getId());
	        		LabResultDetailRepository.insertLab_resultDetails(resultDetail);
	        	}
	        	forwardPage += "&msg=Lab Results Updated!";
        	} else { 
	        	forwardPage += "&msg=Lab Request Rejected!";
        	}

        	
        	
        } catch (Exception e) {
            e.printStackTrace();
            forwardPage += "&msg=Lab Results not saved: " + e.getLocalizedMessage();
        }

        request.getRequestDispatcher(forwardPage).forward(request, response);
    }

}
