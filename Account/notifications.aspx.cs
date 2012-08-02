using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Configuration;
using System.Data.SqlClient;

public partial class Account_notifications : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void SqlLVNotif_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        MembershipUser currentUser = Membership.GetUser();
        Guid currentUserId = (Guid)currentUser.ProviderUserKey;
        e.Command.Parameters["@UserName"].Value = currentUser.ToString(); ;
    }





   
    protected void BtnMarkAsRead_Click(object sender, EventArgs e)
    {
        MembershipUser currentUser = Membership.GetUser();
        Guid currentUserId = (Guid)currentUser.ProviderUserKey;
        string isRead = "";
        string isRead2 = "NEW";
        string ConnectionString = Checks.getConnectionString();
        // string selectSqlNotifCheck = "SELECT COUNT(NotifId) FROM Cus_Notif WHERE UserName=@UserName AND isRead=@isRead";

        string updateSqlNoti = "UPDATE Cus_Notif SET isRead=@isRead WHERE UserName=@UserName AND isRead=@isRead2";

        using (SqlConnection myConnection = new SqlConnection(ConnectionString))
        {

            myConnection.Open();
            //     SqlCommand myCommand = new SqlCommand(selectSqlNotifCheck, myConnection);
            //     myCommand.Parameters.AddWithValue("@UserName", currentUser.ToString());
            //    myCommand.Parameters.AddWithValue("@isRead", isRead);
            //     int checkIfNotif = Convert.ToInt32(myCommand.ExecuteScalar());




            SqlCommand Noti = new SqlCommand(updateSqlNoti, myConnection);
            Noti.Parameters.AddWithValue("@UserName", currentUser.ToString());
            Noti.Parameters.AddWithValue("@isRead2", isRead2);
            Noti.Parameters.AddWithValue("@isRead", isRead);
            Noti.ExecuteNonQuery();

        }
        Page.Response.Redirect(Page.Request.Url.ToString(), true);
    }
}