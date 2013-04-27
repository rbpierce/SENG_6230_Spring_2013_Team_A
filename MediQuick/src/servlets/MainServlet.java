package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.PersonRepository;
import domain.*;

@WebServlet("/MainServlet")
public class MainServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public MainServlet() {
        super();
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,
            IOException {
        doGet(request, response);
    }
    

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,
            IOException {
        HttpSession session = request.getSession();
        if (session!=null) session.invalidate();
        session = request.getSession(true);
        String forward = "main.jsp";
        try {

            if (request.getParameter("j_username") != null) {
                // get user
                String UserName = request.getParameter("j_username");
                String Password = request.getParameter("j_password");

                Person person = PersonRepository.getPerson(UserName, Password);
                // redirect if found the user
                if (person != null) {
                    session.setAttribute("person", person);
                } else {// if not found, return to main.jsp with error
                    request.setAttribute("Error", "The UserName and Password combination returned no result; Please try again!");
                    forward =  "index.jsp";
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally { 
            request.getRequestDispatcher(forward).forward(request, response);
        }
    }
}
