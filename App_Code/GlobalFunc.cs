using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for GlobalFunc
/// </summary>
public class GlobalFunc : System.Web.UI.Page
{
    public GlobalFunc()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    //Making Image Avatar
    public static string GetImageUrlAvatar(object img)
    {
        string img_File = "";
        if (img != null)
            img_File = img.ToString();
        if (img_File == "")
            return "~/Images/default.jpg";
        return "~/Images/avatars/130/" + img_File + ".jpg";
    }

    //Making Image showable
     public static string GetImageUrl820(object img)
    {
        string img_File = "";
        if (img != null)
            img_File = img.ToString();
        if (img_File == "")
            return "~/Images/image-not-found.gif";
        return "~/UserUploads/820/" + img_File + ".jpg";

    }


    //Making Images as link
    public static string GetImageLink(object thelink)
    {
        string ImageName = "";
        if (thelink != null)
        {
            ImageName = thelink.ToString();
        }
        return "~/Account/Image.aspx?img=" + ImageName;

    }

    public static string GetImageUrl280(object img)
    {
        string img_File = "";
        if (img != null)
            img_File = img.ToString();
        if (img_File == "")
            return "~/Images/image-not-found.gif";
        return "~/UserUploads/280/" + img_File + ".jpg";

    }

    //User Link URL
    public static string GetUserNameLinkUrl(object theName)
    {
        string UserName = "";
        if (theName != null)
        {
            UserName = theName.ToString();
        }
        return "~/Account/User.aspx?user=" + UserName;
    }

}