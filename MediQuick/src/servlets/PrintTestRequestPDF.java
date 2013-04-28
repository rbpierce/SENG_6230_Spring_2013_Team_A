package servlets;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.ICD9CodeRepository;
import dao.LabRequestRepository;
import dao.LabResultRepository;
import dao.LabTechnicianRepository;
import dao.PatientRepository;
import dao.PhysicianRepository;
import domain.ICD9Code;
import domain.LabRequest;
import domain.LabResult;
import domain.Patient;
import domain.Person;
import domain.Physician;
import domain.Technician;


import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.ColumnText;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfReader;
import com.itextpdf.text.pdf.PdfStamper;

@WebServlet("/PrintTestRequestPDF")
public class PrintTestRequestPDF extends HttpServlet {
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
        if (!person.hasPermission("VIEW_PROCESSED_LAB_RESULTS")) {
        	response.getOutputStream().print("YOU DO NOT HAVE PERMISSION TO VIEW THIS TEST RESULT!");
        	response.getOutputStream().flush();
        	return;
        }
        //System.out.println("PATH: " + getServletContext().getRealPath("/resources/general.pdf"));
        File template = new File(getServletContext().getRealPath("/resources/general.pdf"));
        String labRequestId = request.getParameter("id");
        
        LabRequest labRequest = LabRequestRepository.getById(Integer.parseInt(labRequestId));
        Person patient = PatientRepository.getById(labRequest.getPatientId());
        Person physician = PhysicianRepository.getById(labRequest.getOrderingPhysicianId());
        //Technician labTech = LabTechnicianRepository.getLabTechnician(labResult.getProcessedByTechnicianId());
        ICD9Code icd9 = ICD9CodeRepository.getICD9Code(labRequest.getICD9CodeId());
        
    	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
    	java.text.SimpleDateFormat sdfHours = new java.text.SimpleDateFormat("yyyy-MM-dd  HH:mm");
    	java.text.SimpleDateFormat sdfHoursUrine = new java.text.SimpleDateFormat("yyyy-MM-dd      HH:mm");
        try {
            PdfReader pdfReader = new PdfReader(template.getAbsolutePath());
            PdfStamper pdfStamper = new PdfStamper(pdfReader,response.getOutputStream());
            PdfContentByte page1 = pdfStamper.getOverContent(1);
      
            ColumnText ct = new ColumnText( page1 );
              
            /*
            //Show helper lines
            for (int i=50; i<=800; i+=50) { 
            	ct.setSimpleColumn(30,i,500,50);
            	String str = "";
            	for (int j=0; j<=3; j++) str += "--------------- " + i;
                ct.setText(new Phrase(str));
                ct.go();
            }
            */
            
            ct.setSimpleColumn(30,760,500,50);
            ct.setText(new Phrase("# " + patient.getId()));
            ct.go();
            
            ct.setSimpleColumn(30,720,500,50);
            ct.setText(new Phrase(patient.getLastName() + ", " + patient.getFirstName()));
            ct.go();
            
            if (patient.getBirthDate()!=null) { 
	            ct.setSimpleColumn(30,670,500,50);
	            ct.setText(new Phrase(sdf.format(patient.getBirthDate())));
	            ct.go();
            }
            
            if (!patient.getGender().equalsIgnoreCase("UNKNOWN")) { 
            	if (patient.getGender().equalsIgnoreCase("MALE"))
            		ct.setSimpleColumn(178,682,500,50);
            	else ct.setSimpleColumn(178,670,500,50);
            	ct.setText(new Phrase("X"));
            	ct.go();
            }
            
            
            ct.setSimpleColumn(30,635,500,50);
            ct.setText(new Phrase("Dr. " + physician.getDisplayName()));
            ct.go();
            
            int specX = 0;
            int specY = 0;
            switch (labRequest.getSpecimen_type()) { 
            case ("Serum"): specY = 617;
            				specX = 63;
            				break;
            case ("Plasma"): specY = 617;
							specX = 96;
			break;
            case ("Urine"): specY = 617;
							specX = 137;
			break;
            case ("CSF"): 	specY = 617;
							specX = 170;
			break;
            case ("Whole Blood"): 	specY = 600;
									specX = 62;
			break;
            case ("Stool"): specY = 600;
							specX = 109;
			break;
            case ("Amniotic"): 	specY = 600;
								specX = 135;
			break;
            case("Other"):	specY = 600;
            				specX = 171;
            				
            }
            ct.setSimpleColumn(specX,specY,500,50);
            ct.setText(new Phrase("X"));
            ct.go();
            
            if (labRequest.getSpecimen_collection_time()!=null) { 
            	ct.setSimpleColumn(30,570,500,50);
                ct.setText(new Phrase(sdfHours.format(labRequest.getSpecimen_collection_time())));
                ct.go();           	
            }
            if (labRequest.getSpecimen_number()!=null) { 
            	ct.setSimpleColumn(30,540,500,50);
                ct.setText(new Phrase("#" + labRequest.getSpecimen_number()));
                ct.go();           	
            }
            if (labRequest.getUrine_collection_start()!=null) { 
            	ct.setSimpleColumn(70,522,500,50);
                ct.setText(new Phrase(sdfHoursUrine.format(labRequest.getUrine_collection_start())));
                ct.go();           	
            }
            if (labRequest.getUrine_collection_finish()!=null) { 
            	ct.setSimpleColumn(70,500,500,50);
                ct.setText(new Phrase(sdfHoursUrine.format(labRequest.getUrine_collection_finish())));
                ct.go();           	
            }
            if (labRequest.getUrine_interval_in_minutes()>0) { 
            	ct.setSimpleColumn(30,465,500,50);
                ct.setText(new Phrase(labRequest.getUrine_interval_in_minutes() + " min"));
                ct.go();           	
            }
            if (labRequest.getUrine_volume_in_milliliters()>0) { 
            	ct.setSimpleColumn(109,465,500,50);
                ct.setText(new Phrase(labRequest.getUrine_volume_in_milliliters() + " mL"));
                ct.go();           	
            }
            if (icd9!=null) { 
            	ct.setSimpleColumn(30,440,500,50);
            	String icdDesc = icd9.getCode() + ": ";
            	icdDesc += icd9.getDescription().length()>=20 ? icd9.getDescription().substring(0,20) + "..." : icd9.getDescription();
                ct.setText(new Phrase(icdDesc));
                ct.go();           	
            }
            ct.setSimpleColumn(30,245,500,50);
            ct.setText(new Phrase(patient.getLastName() + ", " + patient.getFirstName()));
            ct.go();

            pdfStamper.close();
        } catch (Exception e) { 
        	e.printStackTrace();
        }
    }

}
