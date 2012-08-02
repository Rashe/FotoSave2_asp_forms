using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

public partial class Account_follow : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }


    public string GetImageUrl(object img)
    {

        //  MembershipUser currentUser = Membership.GetUser();
        //  string userName = currentUser.ToString();

        string img_File = "";
        if (img != null)
            img_File = img.ToString();
        if (img_File == "")
            return "~/Images/image-not-found.gif";
        return "~/UserUploads/280/" + img_File + ".jpg";


    }

    public string GetImageLink(object thelink)
    {
        string ImageName = "";
        if (thelink != null)
        {
            ImageName = thelink.ToString();
        }
        return "~/Account/Image.aspx?img=" + ImageName;
    }


    protected void SqlLVFollowImagesShow_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        MembershipUser currentUser = Membership.GetUser();
        Guid currentUserId = (Guid)currentUser.ProviderUserKey;
        e.Command.Parameters["@MyUserId"].Value = currentUserId;
    }
}