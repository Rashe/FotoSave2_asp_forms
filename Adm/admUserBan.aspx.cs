using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

public partial class Adm_admUserBan : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        string userName = ((Label)FormView1.FindControl("UserNameLabel")).Text;
        MembershipUser user = Membership.GetUser(userName);
        if (user != null)
        {
            user.IsApproved = false;
            Membership.UpdateUser(user);
        }


    }
}