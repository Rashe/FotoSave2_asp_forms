using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Configuration;
using System.Data.SqlClient;

/// <summary>
/// Checks are ussualy working with DB
/// </summary>
public class Checks
{
    
   

    //Connection string
    public static string getConnectionString()
    {
        return ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString;
    }
	



    public static string getQueryString(object qstr)
    {
        return qstr.ToString() ;
    }


    public static string GetCurrentUserId()
    {
        MembershipUser currentUser = Membership.GetUser();
        Guid currentUserId = (Guid)currentUser.ProviderUserKey;

        return currentUserId.ToString();
    }




    //Check if Image LIKED
    public static int checkIfLikedImage(object qstr)
    {
        string currentUserId = GetCurrentUserId();
        

        string ConnectionString = ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString;
        string SelectSqlCheckIfLike = "SELECT COUNT(LikeId) FROM Cus_ImageLikes WHERE UserId=@UserId AND ImageName=@ImageName";
        int likedOrNot;
        using (SqlConnection myConnection = new SqlConnection(ConnectionString))
        {
            myConnection.Open();
            SqlCommand CheckIfLike = new SqlCommand(SelectSqlCheckIfLike, myConnection);

            CheckIfLike.Parameters.AddWithValue("@UserId", currentUserId);
            CheckIfLike.Parameters.AddWithValue("@ImageName", qstr);
             likedOrNot = Convert.ToInt32(CheckIfLike.ExecuteScalar());
        }
        return likedOrNot;
    }



    //Check if user  is owner of current image
    public static int checkIfUsersImage(object qstr)
    {


        string currentUserId = GetCurrentUserId();
        

        string ConString = getConnectionString();
        string SelectSqlCheckUsersImage = "SELECT COUNT(ImageId) FROM Cus_Upload WHERE UserId=@UserId AND ImageName=@ImageName";
        int UsersOrNot;
        using (SqlConnection myConnection = new SqlConnection(ConString))
        {

            myConnection.Open();
            SqlCommand CheckIfUsersImage = new SqlCommand(SelectSqlCheckUsersImage, myConnection);
            CheckIfUsersImage.Parameters.AddWithValue("@UserId", currentUserId);
            CheckIfUsersImage.Parameters.AddWithValue("@ImageName", qstr);
            UsersOrNot = Convert.ToInt32(CheckIfUsersImage.ExecuteScalar());
        }
        return UsersOrNot;

    }


    //Check is user is already following


    public static int checkIfFollowing(object sesProfileName)
    {
         MembershipUser currentUser = Membership.GetUser();
        Guid currentUserId = (Guid)currentUser.ProviderUserKey;

        int FollowedOrNot;

        string ConString = getConnectionString();

        string SelectSqlCheckIfFollowed = "SELECT COUNT(FollowsId) FROM Cus_Followers2 WHERE FProfileName=@FProfileName AND ProfileName=@ProfileName";

        using (SqlConnection myConnection = new SqlConnection(ConString))
        {

            myConnection.Open();
            
                SqlCommand CheckIfFollowed = new SqlCommand(SelectSqlCheckIfFollowed, myConnection);


                CheckIfFollowed.Parameters.AddWithValue("@ProfileName", currentUser.ToString());
                CheckIfFollowed.Parameters.AddWithValue("@FProfileName", sesProfileName);
                FollowedOrNot = Convert.ToInt32(CheckIfFollowed.ExecuteScalar());
           
        }
            return FollowedOrNot;



    }
   

}