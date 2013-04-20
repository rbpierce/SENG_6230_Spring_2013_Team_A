package tag;

import javax.servlet.jsp.tagext.TagSupport;

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

    private String _permission = null;
    private String _noPermission = null;

    public void setPermission(String permission) {
       this._permission = permission;
    }
    
    public void setNoPermission(String noPermission) { 
        this._noPermission = noPermission;
    }

    @Override
    public int doStartTag() {
        Person person = (Person) pageContext.getSession().getAttribute("person");
        if (person != null) {
            if (_permission!=null) { 
                if (person.hasPermission(this._permission)) {
                    return EVAL_BODY_INCLUDE;
                } else {
                    return SKIP_BODY;
                }
            } else if (this._noPermission!=null) { 
                if (!person.hasPermission(this._permission)) {
                    return EVAL_BODY_INCLUDE;
                } else {
                    return SKIP_BODY;
                }
            }
            else return EVAL_BODY_INCLUDE;
        } else
            return SKIP_BODY;
    }

    @Override
    public void release() {
        _permission = null;
        _noPermission = null;
        super.release();
    }
    
    private static final long serialVersionUID = 1L;

}
