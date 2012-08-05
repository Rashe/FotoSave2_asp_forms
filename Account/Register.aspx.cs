using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Configuration;
using System.Data.SqlClient;

public partial class Account_Register : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        RegisterUser.ContinueDestinationPageUrl = Request.QueryString["ReturnUrl"];
    }

    protected void RegisterUser_CreatedUser(object sender, EventArgs e)
    {
        FormsAuthentication.SetAuthCookie(RegisterUser.UserName, false /* createPersistentCookie */);
        string userNameWiz= RegisterUser.UserName.ToString();
        //new folder create
     //   System.IO.Directory.CreateDirectory(MapPath("~/UserUploads/" + userNameWiz));

        //MoreInfo creating
        MembershipUser newUser = Membership.GetUser(RegisterUser.UserName);
     Guid newUserId = (Guid)newUser.ProviderUserKey;

     string ConnectionString = Checks.getConnectionString();

        string insertSqlMoreInfo = "INSERT INTO Cus_MoreInfo(UserId, HomeTown, FirstName, LastName, About, Avatar) VALUES(@UserId, @HomeTown, @FirstName, @LastName, @About, @Avatar)";


        using (SqlConnection myConnection = new SqlConnection(ConnectionString))
        {
            myConnection.Open();
            SqlCommand myCommand = new SqlCommand(insertSqlMoreInfo, myConnection);
            myCommand.Parameters.AddWithValue("@UserId", newUserId);
            myCommand.Parameters.AddWithValue("@HomeTown", DBNull.Value);
            myCommand.Parameters.AddWithValue("@FirstName", DBNull.Value);
            myCommand.Parameters.AddWithValue("@LastName", DBNull.Value);
            myCommand.Parameters.AddWithValue("@About", DBNull.Value);
            myCommand.Parameters.AddWithValue("@Avatar", DBNull.Value);
           
            myCommand.ExecuteNonQuery();
            
        }






        string continueUrl = RegisterUser.ContinueDestinationPageUrl;
        if (String.IsNullOrEmpty(continueUrl))
        {
            continueUrl = "~/";
        }
        Response.Redirect(continueUrl);
    }

}
