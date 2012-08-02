using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Drawing;
using System.Drawing.Drawing2D;

public partial class Account_Profile : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    
    protected void SqlUserEdit_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        MembershipUser currentUser = Membership.GetUser();
        Guid currentUserId = (Guid)currentUser.ProviderUserKey;
        e.Command.Parameters["@UserId"].Value = currentUserId;
    }
    protected void SqlAvatarEdit_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        MembershipUser currentUser = Membership.GetUser();
        Guid currentUserId = (Guid)currentUser.ProviderUserKey;
        e.Command.Parameters["@UserId"].Value = currentUserId;
    }





    //TODO
    //Change the AVATAR image 
    protected void BtnFUProfileAvatar_Click(object sender, EventArgs e)
    {
        if (FUProfileAvatar.HasFile)
        {
            try
            {
                if (FUProfileAvatar.PostedFile.ContentType == "image/jpeg")
                {
                    if (FUProfileAvatar.PostedFile.ContentLength < 420000)
                    {


                        MembershipUser currentUser = Membership.GetUser();
                        Guid currentUserId = (Guid)currentUser.ProviderUserKey;
                        Random rand = new Random();
                        string numRandom = rand.Next(13123, 444128312).ToString();
                        string ranFileNamePath = "~/Images/avatars/" + numRandom + ".jpg";
                        //CHECK THIS   !!!
                        while (File.Exists(ranFileNamePath))
                        {
                            numRandom = rand.Next(13123, 444128312).ToString();
                        }



                        string ProfileName = currentUser.ToString();

                        string ConnectionString = Checks.getConnectionString();




                        string UpdateSqlAvatar = "UPDATE Cus_MoreInfo SET Avatar=@Avatar   WHERE UserId=@UserId";

                        using (SqlConnection myConnection = new SqlConnection(ConnectionString))
                        {

                            myConnection.Open();
                            SqlCommand Avatar = new SqlCommand(UpdateSqlAvatar, myConnection);

                            Avatar.Parameters.AddWithValue("@Avatar", numRandom);
                            Avatar.Parameters.AddWithValue("@UserId", currentUserId);
                            Avatar.ExecuteNonQuery();
                        }


                        string filename = Path.GetFileName(FUProfileAvatar.FileName);
                        FUProfileAvatar.SaveAs(Server.MapPath("~/Images/avatars/") + numRandom + ".jpg");

                        //IMAGE RESIZING
                        Bitmap originalBMP = new Bitmap(FUProfileAvatar.FileContent);

                        // Calculate the new image dimensions
                        decimal origWidth = originalBMP.Width;
                        decimal origHeight = originalBMP.Height;
                        decimal sngRatio = origWidth / origHeight;
                        int newWidth = 130;
                        decimal newHeight_temp = newWidth / sngRatio;
                        int newHeight = Convert.ToInt32(newHeight_temp);

                        // Create a new bitmap which will hold the previous resized bitmap
                        Bitmap newBMP = new Bitmap(originalBMP, newWidth, newHeight);
                        // Create a graphic based on the new bitmap
                        Graphics oGraphics = Graphics.FromImage(newBMP);

                        // Set the properties for the new graphic file
                        oGraphics.SmoothingMode = SmoothingMode.AntiAlias; oGraphics.InterpolationMode = InterpolationMode.HighQualityBicubic;
                        // Draw the new graphic based on the resized bitmap
                        oGraphics.DrawImage(originalBMP, 0, 0, newWidth, newHeight);

                        // Save the new graphic file to the server
                        newBMP.Save(Server.MapPath("~/Images/avatars/130/" + numRandom + ".jpg"));

                        // Once finished with the bitmap objects, we deallocate them.
                        originalBMP.Dispose();
                        newBMP.Dispose();
                        oGraphics.Dispose();                





                        LblAvatarNotify.CssClass = "alert alert-success";
                        LblAvatarNotify.Text = "Avatar Updated";


                    }
                    else
                    {
                        LblAvatarNotify.CssClass = "alert alert-error";
                        LblAvatarNotify.Text = "Image must be less then 400kb";
                    }
                }
                else
                { 
                    LblAvatarNotify.CssClass = "alert alert-error";
                LblAvatarNotify.Text = "Image must be jpeg";
                }
            }
            catch (Exception ex)
            {
                LblAvatarNotify.CssClass = "alert alert-error";
                LblAvatarNotify.Text = "The following error occured: " + ex.Message;
            }
        }



    }
}