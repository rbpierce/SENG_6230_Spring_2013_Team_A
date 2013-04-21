package tag;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.Arrays;

import javax.servlet.jsp.tagext.TagSupport;

import domain.Permission;
import domain.Person;

/* If person (logged in user) has the permission passed into the tag, allow enclosed content to be displayed
 *
 *  Example:
 *  <teama:checkRole permission="EDIT_PATIENT">
 *      <a href="/editPatient.jsp">Edit Patient</a>
 *  </teama:checkRole>
 *  <teama:checkRole noPermission="EDIT_PATIENT">
 *      <div>ACCESS DENIED</div>
 *  </teama:checkRole>
 *
 *  if user has the permission, they can see the edit patient link. If not, they can not.
 * Similarly, if user does not have the EDIT_PATIENT permission, they can see the ACCESS DENIED
 * div, otherwise that dis is not displayed.
 */


public class CheckRole extends TagSupport {

    private  ArrayList<String> _permission =  new ArrayList<String>();
    private  ArrayList<String> _noPermission =  new ArrayList<String>();
    private ArrayList<String> _roleList = new ArrayList<String>();

    public void setPermission(String permission) {
       this._permission =  new ArrayList<String>(Arrays.asList(permission.split(",")));
    }
    
    public void setNoPermission(String noPermission) { 
        this._noPermission =  new ArrayList<String>(Arrays.asList(noPermission.split(",")));
    }

    public void setRole(String role) {
    	this._roleList = new ArrayList<String>(Arrays.asList(role.split(",")));
    }
    
    @Override
    public int doStartTag() {
        Person person = (Person) pageContext.getSession().getAttribute("person");
        if (person != null) {
        	boolean satisfiesRole = false;
        	if (this._roleList.isEmpty() || this._roleList.contains(person.getRole().getName())) satisfiesRole = true;
            if (!_permission.isEmpty() && satisfiesRole) { 
            	for (String perm : _permission) { 
            		//only require 1 match
	                if (person.hasPermission(perm) ) {
	                    return EVAL_BODY_INCLUDE;
	                } 
            	}            	
                return SKIP_BODY;
            } else if (!this._noPermission.isEmpty() && satisfiesRole) { 
            	for (String perm : _noPermission) { 
            		//if has even one, skip
	                if (person.hasPermission(perm) ) {
	                    return SKIP_BODY;
	                } 
            	}
                return EVAL_BODY_INCLUDE;
            } 
            else { 
            	if (satisfiesRole) return EVAL_BODY_INCLUDE;
            	else return SKIP_BODY;
            }
        } else
            return SKIP_BODY;
    }

    @Override
    public void release() {
    	this._permission = new ArrayList<String>();
        this._noPermission = new ArrayList<String>();
        this._roleList = new ArrayList<String>();
        super.release();
    }
    
    private static final long serialVersionUID = 1L;

}
