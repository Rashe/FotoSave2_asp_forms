using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Configuration;
using System.Data.SqlClient;

public partial class Account_Image : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //add text to cement field
        //   TxtUserComments.Attributes.Add("onfocus", "this.value=''");


        // FVImageLikesAndInfo.DataBind();


        MembershipUser currentUser = Membership.GetUser();
        Guid currentUserId = (Guid)currentUser.ProviderUserKey;


        //title 
        Page.Title = "PhotoSave";

        //QueryString
        string qstr = Request.QueryString["img"];
        if (qstr == null)
        {
            Response.Redirect("~/404.aspx");
        }


        //Check if Image LIKED
        int likedOrNot = Checks.checkIfLikedImage(qstr);
        if (likedOrNot >= 1) //YES
        {
            BtnLike.Enabled = false;
            BtnLike.Text = "Liked";

        }

        //Check if user  is owner of current image
        int UsersOrNot = Checks.checkIfUsersImage(qstr);
        if (UsersOrNot == 1)
        {
            BtnImageDeleteAction.Visible = true;
            BtnImageDeleteAction.Enabled = true;
            BtnLike.Enabled = false;
            BtnLike.Visible = false;

        }




        string ConnectionString = Checks.getConnectionString();
        //ShowMore Images
        string SelectSqlMoreImagesToShowProg = "SELECT ProfileName FROM Cus_Upload WHERE ImageName=@ImageName";

        //Insert Views NUM
        string UpdateSqlImageViews = "UPDATE Cus_Upload SET NumOfViews= NumOfViews+1   WHERE ImageName=@ImageName";

        using (SqlConnection myConnection = new SqlConnection(ConnectionString))
        {
            myConnection.Open();
            SqlCommand MoreImagesToShowProg = new SqlCommand(SelectSqlMoreImagesToShowProg, myConnection);
            SqlCommand ImageViews = new SqlCommand(UpdateSqlImageViews, myConnection);

            MoreImagesToShowProg.Parameters.AddWithValue("@ImageName", qstr);
            string ProfileName = MoreImagesToShowProg.ExecuteScalar().ToString();
            // int lookForId = Convert.ToInt32(myCommand3.ExecuteScalar());
            Session["forMotherRussia"] = ProfileName;
            //    string SelectSqlMoreImagesToShowProgQuest2= "SELECT "

            ImageViews.Parameters.AddWithValue("@ImageName", qstr);
            ImageViews.ExecuteNonQuery();
        }




        //Check is user is already following
        string profileName = Session["forMotherRussia"].ToString();
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







    //Button to like the IMAGE
    protected void BtnLike_Click(object sender, EventArgs e)
    {
        MembershipUser currentUser = Membership.GetUser();
        Guid currentUserId = (Guid)currentUser.ProviderUserKey; ;


        //Get Image ID
        string strImageId = ((Label)FVImageLikesAndInfo.FindControl("lblImageIdForUndef")).Text;

        string qstr = Request.QueryString["img"];


        string ConnectionString = Checks.getConnectionString();
        string insertSqlBtnLikes = "INSERT INTO Cus_ImageLikes(UserId, ImageId, ImageName) VALUES(@UserId, @ImageId, @ImageName)";
        string UpdateSqlBtnkLike = "UPDATE Cus_Upload SET NumOfLikes= NumOfLikes+1   WHERE ImageId=@ImageId";

        //notofication insert
        string insertSqlNotif = "INSERT INTO Cus_Notif(UserId, UserName, ProfileName, NotifBody, IsRead, ImageName) VALUES(@UserId, @UserName, @ProfileName, @NotifBody, @isRead, @ImageName)";

        using (SqlConnection myConnection = new SqlConnection(ConnectionString))
        {

            myConnection.Open();
            SqlCommand BtnLikes = new SqlCommand(insertSqlBtnLikes, myConnection);

            BtnLikes.Parameters.AddWithValue("@UserId", currentUserId);
            BtnLikes.Parameters.AddWithValue("@ImageId", strImageId);
            BtnLikes.Parameters.AddWithValue("@ImageName", qstr);
            BtnLikes.ExecuteNonQuery();
            SqlCommand BtnkLike = new SqlCommand(UpdateSqlBtnkLike, myConnection);
            BtnkLike.Parameters.AddWithValue("@ImageId", strImageId);
            BtnkLike.ExecuteNonQuery();


            //notif
            SqlCommand Notif = new SqlCommand(insertSqlNotif, myConnection);
            string notifBody = "liked your photo";
            string isRead = "NEW";
            string profileName = Session["forMotherRussia"].ToString();
            Notif.Parameters.AddWithValue("@UserId", currentUserId);
            Notif.Parameters.AddWithValue("@UserName", profileName);
            Notif.Parameters.AddWithValue("@ProfileName", currentUser.ToString());
            Notif.Parameters.AddWithValue("@NotifBody", notifBody);
            Notif.Parameters.AddWithValue("@isRead", isRead);
            Notif.Parameters.AddWithValue("@ImageName", qstr);
            Notif.ExecuteNonQuery();


        }

        //reload page
        Page.Response.Redirect(Page.Request.Url.ToString(), true);

    }

    //If no IMAGE go to Another page
    protected void FVImageFromLinkImage_DataBound(object sender, EventArgs e)
    {
        if (FVImageFromLinkImage.DataItemCount == 0)
        {
            Response.Redirect("~/404.aspx");
        }


    }






    //Button Comments Add
    protected void BtnUserComments_Click(object sender, EventArgs e)
    {
        //Validation on server side
        if (!Page.IsValid)
            return;

        MembershipUser currentUser = Membership.GetUser();
        Guid currentUserId = (Guid)currentUser.ProviderUserKey;

        //Get Image ID
        string strImageId = ((Label)FVImageLikesAndInfo.FindControl("lblImageIdForUndef")).Text;
        //QueryString
        string qstr = Request.QueryString["img"];

        string ConnectionString = Checks.getConnectionString();
        string insertSqlBtnComment = "INSERT INTO Cus_Coments(UserId, UserName, ComentBody, ImageName, ImageId) VALUES(@UserId, @UserName, @ComentBody, @ImageName, @ImageId)";

        //notofication insert
        string insertSqlNotif = "INSERT INTO Cus_Notif(UserId, UserName, ProfileName, NotifBody, IsRead, ImageName) VALUES(@UserId, @UserName, @ProfileName, @NotifBody, @isRead, @ImageName)";


        using (SqlConnection myConnection = new SqlConnection(ConnectionString))
        {

            myConnection.Open();
            SqlCommand BtnComment = new SqlCommand(insertSqlBtnComment, myConnection);

            BtnComment.Parameters.AddWithValue("@UserId", currentUserId);
            BtnComment.Parameters.AddWithValue("@UserName", currentUser.ToString());
            BtnComment.Parameters.AddWithValue("@ComentBody", TxtUserComments.Text.Trim());
            BtnComment.Parameters.AddWithValue("@ImageName", qstr);

            BtnComment.Parameters.AddWithValue("@ImageId", strImageId);

            BtnComment.ExecuteNonQuery();


            if ((Session["forMotherRussia"].ToString()) != currentUser.ToString())
            {
                //notif
                SqlCommand Notif = new SqlCommand(insertSqlNotif, myConnection);
                string notifBody = "commented on you photo";
                string isRead = "NEW";
                string profileName = Session["forMotherRussia"].ToString();
                Notif.Parameters.AddWithValue("@UserId", currentUserId);
                Notif.Parameters.AddWithValue("@UserName", profileName);
                Notif.Parameters.AddWithValue("@ProfileName", currentUser.ToString());
                Notif.Parameters.AddWithValue("@NotifBody", notifBody);
                Notif.Parameters.AddWithValue("@isRead", isRead);
                Notif.Parameters.AddWithValue("@ImageName", qstr);
                Notif.ExecuteNonQuery();
            }

        }
        TxtUserComments.Text = null;


    }


    protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if (TxtUserComments.Text == "Enter Comment")
        { args.IsValid = false; }
    }

    protected void BtnImageDeleteAction_Click(object sender, EventArgs e)
    {


        //Get Image ID
        string strImageId = ((Label)FVImageLikesAndInfo.FindControl("lblImageIdForUndef")).Text;
        //  string qstr = Request.QueryString["img"];

        string ConnectionString = Checks.getConnectionString();
        string deleteImageActionSQL = "DELETE FROM Cus_Upload WHERE ImageId=@ImageId";

        using (SqlConnection myConnection = new SqlConnection(ConnectionString))
        {

            myConnection.Open();
            SqlCommand ImageAction = new SqlCommand(deleteImageActionSQL, myConnection);

            ImageAction.Parameters.AddWithValue("@ImageId", strImageId);

            //  myCommand.Parameters.AddWithValue("@ImageName", qstr);



            ImageAction.ExecuteNonQuery();


        }

        Response.Redirect("~/Account/you.aspx");
    }


    //Follow the user
    protected void BtnFollow_Click(object sender, EventArgs e)
    {
        MembershipUser currentUser = Membership.GetUser();
        Guid currentUserId = (Guid)currentUser.ProviderUserKey; ;

        //get user Id
        string userId = ((Label)FVImageFromLinkImage.FindControl("LblUserId")).Text;
        string profileName = ((Label)FVImageFromLinkImage.FindControl("lblProfileName")).Text;

        string ConnectionString = Checks.getConnectionString();
        string insertSqlBtnFollow = "INSERT INTO Cus_Followers2(UserId, UserName, ProfileName, FUserId, FUserName, FProfileName) VALUES(@UserId, @UserName, @ProfileName, @FUserId, @FUserName, @FProfileName)";

        //notofication insert
        string insertSqlNotif = "INSERT INTO Cus_Notif(UserId, UserName, ProfileName, NotifBody, IsRead) VALUES(@UserId, @UserName, @ProfileName, @NotifBody, @isRead)";


        using (SqlConnection myConnection = new SqlConnection(ConnectionString))
        {

            myConnection.Open();
            SqlCommand BtnFollow = new SqlCommand(insertSqlBtnFollow, myConnection);

            BtnFollow.Parameters.AddWithValue("@UserId", currentUserId);
            BtnFollow.Parameters.AddWithValue("@UserName", currentUser.ToString());
            BtnFollow.Parameters.AddWithValue("@ProfileName", currentUser.ToString());
            BtnFollow.Parameters.AddWithValue("@FUserId", userId);
            BtnFollow.Parameters.AddWithValue("@FUserName", profileName);
            BtnFollow.Parameters.AddWithValue("@FProfileName", profileName);
            BtnFollow.ExecuteNonQuery();


            //notif
            SqlCommand Notif = new SqlCommand(insertSqlNotif, myConnection);
            string notifBody = "started following you";
            string isRead = "NEW";
            Notif.Parameters.AddWithValue("@UserId", currentUserId);
            Notif.Parameters.AddWithValue("@UserName", profileName);
            Notif.Parameters.AddWithValue("@ProfileName", currentUser.ToString());
            Notif.Parameters.AddWithValue("@NotifBody", notifBody);
            Notif.Parameters.AddWithValue("@isRead", isRead);
            Notif.ExecuteNonQuery();



        }


        Page.Response.Redirect(Page.Request.Url.ToString(), true);


    }
}