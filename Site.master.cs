using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing;

public partial class SiteMaster : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {


        //logIn and logOut swipe
       /* if (Page.User.Identity.IsAuthenticated)
        {
            LogInAndOutBtnmer.Text = "LogOut";
           
        }
*/
        

         if (Page.User.Identity.IsAuthenticated == false)
         {
             HLUserName1.NavigateUrl = "~/Account/Login.aspx";
             HLUserName1.Text = "You";

         }
         else
         {

             MembershipUser currentUser = Membership.GetUser();
             HLUserName1.Text = currentUser.ToString();

         }



        if (Page.User.Identity.IsAuthenticated == false)
        {
            HLNottifications.Visible = false;
            HLUpload1.NavigateUrl = "~/Account/Login.aspx";
        }

        if (Page.User.Identity.IsAuthenticated == true)
        {


            MembershipUser currentUser = Membership.GetUser();
        Guid currentUserId = (Guid)currentUser.ProviderUserKey;
            string isRead= "NEW";

            string ConnectionString = ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString;
            string selectSqlNotifCheck = "SELECT COUNT(NotifId) FROM Cus_Notif WHERE UserName=@UserName AND isRead=@isRead";
            using (SqlConnection myConnection = new SqlConnection(ConnectionString))
            {

            myConnection.Open();
            SqlCommand NotifCheck = new SqlCommand(selectSqlNotifCheck, myConnection);
            NotifCheck.Parameters.AddWithValue("@UserName", currentUser.ToString());
                    NotifCheck.Parameters.AddWithValue("@isRead", isRead);
                    int checkIfNotif = Convert.ToInt32(NotifCheck.ExecuteScalar());
                    if (checkIfNotif >= 1)
                    {
                        HLNottifications.ForeColor = Color.Red;
                        HLNottifications.Text = checkIfNotif.ToString()+ " New";

                    }
                    else
                    {
                        HLNottifications.Text = "0";
                       // LBNottifications.ForeColor=;
                    }

            }





        }


    }



   
}
