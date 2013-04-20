package servlets;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class FrontController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public FrontController() {
        super();
    }

    private static boolean initFlag = true;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String className = request.getServletPath().substring(1, request.getServletPath().indexOf(".jsp"));

        // initialization
        if (initFlag) {
            initFlag = false;
        }

        try {
            Class ctrlClass = Class.forName("servlets." + className);
            Method m = ctrlClass.getMethod("execute", HttpServletRequest.class, HttpServletResponse.class);
            String forward = (String) m.invoke(ctrlClass.newInstance(), request, response);
            if (forward != null)
                request.getRequestDispatcher(forward).forward(request, response);

        } catch (InvocationTargetException ex) {
            ex.printStackTrace();
            response.setContentType("text/html");
            if (ex.getTargetException() instanceof SQLException)
                response.getOutputStream().println("Error in accessing database!<p>Contact system administrator");
            else
                response.getOutputStream().println("Internal system error!<p>Contact system administrator");
        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/html");
            response.getOutputStream().println("Internal system error!<p>Contact system administrator");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,
            IOException {
        doGet(request, response);
    }
}
