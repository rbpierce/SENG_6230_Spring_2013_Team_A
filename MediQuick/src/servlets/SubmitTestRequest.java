package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.LabRequestRepository;
import dao.LabTestRepository;
import dao.PatientRepository;
import domain.LabRequest;
import domain.LabRequestDetail;
import domain.LabTest;
import domain.Patient;
import domain.Person;

@WebServlet("/SubmitTestRequest")
public class SubmitTestRequest extends HttpServlet {
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
        String forwardPage = "/viewPatient.jsp?id=" + patientId;

    	Patient patient = PatientRepository.getById(patientId).getPatient();
    	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
    	
        try {
        	if (!person.hasPermission("ORDER_TESTS")) throw new Exception ("Unauthorized Access!");

        	/*
        	 * 	public LabRequest(String status, int id, int laboratory_id, int patient_id, int requesting_nurse_id, 
			Date nurse_request_time, int ordering_physician_id, Date order_placed, 
			Date specimen_collection_time, String specimen_type, Date urine_collection_start, 
			String specimen_number, int urine_interval_in_minutes, Date urine_collection_finish, 
			int urine_volume_in_milliliters, int icd9_code_id) { 
        	 * 
        	 */
        	
        	LabRequest labRequest = new LabRequest(
        			null,
        			LabRequestRepository.getMaxID(),
        			1,
        			patient.getId(),
        			0,
        			null,
        			person.getId(),
        			new java.util.Date(),
        			sdf.parse(request.getParameter("specimen_collection_time")),
        			request.getParameter("specimen_type"),
        			(request.getParameter("urine_collection_start_date").isEmpty() || 
        					request.getParameter("urine_collection_start_time").isEmpty()) ? null : 
        				sdf.parse(request.getParameter("urine_collection_start_date") + " " + 
        					(request.getParameter("urine_collection_start_time"))),
        			request.getParameter("specimen_number"),
        			request.getParameter("urine_interval_in_minutes").isEmpty() ? 0 : 
        				Integer.parseInt(request.getParameter("urine_interval_in_minutes")),
					(request.getParameter("urine_collection_finish_date").isEmpty() || 
        					request.getParameter("urine_collection_finish_time").isEmpty()) ? null : 
        				sdf.parse(request.getParameter("urine_collection_finish_date") + " " + 
        					(request.getParameter("urine_collection_finish_time"))),
					request.getParameter("urine_volume_in_milliliters").isEmpty() ? 0 : 
						Integer.parseInt(request.getParameter("urine_volume_in_milliliters")),
					Integer.parseInt(request.getParameter("icd9_code_id")));
        	labRequest.insert();
        	for (String labTestId : request.getParameterValues("labTest")) { 
        		LabTest test = LabTestRepository.getLabTest(Integer.parseInt(labTestId));
        		LabRequestDetail detail = new LabRequestDetail();
        		detail.setLabTestId(test.getId());
        		detail.setLabRequestId(labRequest.getId());
        		detail.insert();
        	}
        	
        	forwardPage += "&msg=Lab Request Created Successfully";
        	
        } catch (Exception e) {
            e.printStackTrace();
            forwardPage += "&msg=Lab Request entry failed: " + e.getLocalizedMessage();
        }

        request.getRequestDispatcher(forwardPage).forward(request, response);
    }

}
