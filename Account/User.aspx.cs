using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Drawing;
using System.Configuration;
using System.Data.SqlClient;

public partial class Account_User : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {




        //Check that query isn't NULL  and DYNAMIC TITLE
        string qstr = Request.QueryString["user"];
        if (qstr == null)
        {
            Response.Redirect("~/404.aspx");
        }
        else
        {
            Page.Title = "PhotoSave / " + qstr + "'s profile";
        }





        MembershipUser currentUser = Membership.GetUser();
        Guid currentUserId = (Guid)currentUser.ProviderUserKey;


        //Check is user is already following
        string profileName = qstr;
        if (profileName != currentUser.ToString())
        {
            int folowedOrNot = Checks.checkIfFollowing(profileName);
            if (folowedOrNot >= 1)
            {
                BtnFollow.Enabled = false;
                BtnFollow.Text = "Following";
            }
        }
        else
        {

            BtnFollow.Enabled = false;
            BtnFollow.Visible = false;

        }

    }


   

   


   
   



    protected void FVUserInfoShow_DataBound1(object sender, EventArgs e)
     {
        if (FVUserInfoShow.DataItemCount == 0)
        {
            Response.Redirect("~/404.aspx");
        }
        string qstr = Request.QueryString["user"];
        MembershipUserCollection users = Membership.GetAllUsers();
        foreach (MembershipUser user in users)
        {
            if (user.UserName == qstr)
            {
                if (user.IsOnline)
                {

                    Label lblUserOnline = FVUserInfoShow.FindControl("lblUserOnl") as Label;
                    lblUserOnline.ForeColor = Color.Green;
                    lblUserOnline.Text = "(Online)";


                }


            }
            
            



        }
    }




    protected void BtnFollow_Click(object sender, EventArgs e)
    {

        MembershipUser currentUser = Membership.GetUser();
        Guid currentUserId = (Guid)currentUser.ProviderUserKey; ;

        string userId = ((Label)FVUserInfoShow.FindControl("UserIdLabel")).Text;
        string profileName = ((Label)FVUserInfoShow.FindControl("UserNameLabel")).Text;

        string ConnectionString = Checks.getConnectionString();
        //follow insert
        string insertSqlBtnFollow = "INSERT INTO Cus_Followers2(UserId, UserName, ProfileName, FUserId, FUserName, FProfileName) VALUES(@UserId, @UserName, @ProfileName, @FUserId, @FUserName, @FProfileName)";


        //notofication insert
        string insertSqlNotif = "INSERT INTO Cus_Notif(UserId, UserName, ProfileName, NotifBody, IsRead) VALUES(@UserId, @UserName, @ProfileName, @NotifBody, @isRead)";

        using (SqlConnection myConnection = new SqlConnection(ConnectionString))
        {

            myConnection.Open();

            //followers
            SqlCommand BtnFollow = new SqlCommand(insertSqlBtnFollow, myConnection);

            BtnFollow.Parameters.AddWithValue("@UserId", currentUserId);
            BtnFollow.Parameters.AddWithValue("@UserName",currentUser.ToString());
            BtnFollow.Parameters.AddWithValue("@ProfileName",currentUser.ToString());
            BtnFollow.Parameters.AddWithValue("@FUserId", userId);
            BtnFollow.Parameters.AddWithValue("@FUserName",profileName);
            BtnFollow.Parameters.AddWithValue("@FProfileName", profileName);
            BtnFollow.ExecuteNonQuery();



            //notif
            SqlCommand Notif = new SqlCommand(insertSqlNotif, myConnection);
            string notifBody = "started following you";
            string isRead = "NEW";
            Notif.Parameters.AddWithValue("@UserId", currentUserId);
            Notif.Parameters.AddWithValue("@UserName", profileName);
            Notif.Parameters.AddWithValue("@ProfileName", currentUser.ToString());
            Notif.Parameters.AddWithValue("@NotifBody",notifBody);
            Notif.Parameters.AddWithValue("@isRead", isRead);
            Notif.ExecuteNonQuery();

        }


        Page.Response.Redirect(Page.Request.Url.ToString(), true);





    }

}