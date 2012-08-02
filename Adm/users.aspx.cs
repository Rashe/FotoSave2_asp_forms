using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Adm_meshtamshim : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }


    public string GetUserNameLinkUrl(object theName)
    {
        string UserName = "";
        if (theName != null)
        {
            UserName = theName.ToString();
        }
        return "~/Adm/admUserBan.aspx?user=" + UserName;
    }


}