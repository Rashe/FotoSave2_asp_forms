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

public partial class Account_Upload : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {


       

    }

    //Image Upload with ajax
    protected void ajaxUpload1_OnUploadComplete(object sender, AjaxControlToolkit.AjaxFileUploadEventArgs e)
    {

        
        MembershipUser currentUser = Membership.GetUser();
        Guid currentUserId = (Guid)currentUser.ProviderUserKey;
      //  e.Command.Parameters["@UserId"].Value = currentUserId;


        //generate random image name
        Random rand = new Random();
        string numRandom= rand.Next(13123, 444128312).ToString();
        string ranFileNamePath = "~/UserUploads/" + numRandom + ".jpg";
        //CHECK THIS   !!!
        while (File.Exists(ranFileNamePath))
        {
            numRandom = rand.Next(13123, 444128312).ToString();
        }


        string ProfileName = currentUser.ToString();


       // string ImageName = ProfileName + "/" + numRandom;



        string ConnectionString = Checks.getConnectionString();

        string insertSqlUpload = "INSERT INTO Cus_Upload(UserId, ImageName, ProfileName, Folder, NumOfLikes, NumOfViews) VALUES(@UserId, @ImageName, @ProfileName, @Folder, @NumOfLikes, @NumOfViews)";


            using (SqlConnection myConnection = new SqlConnection(ConnectionString))
            {

                myConnection.Open();
                SqlCommand Upload = new SqlCommand(insertSqlUpload, myConnection);
                Upload.Parameters.AddWithValue("@UserId", currentUserId);
                Upload.Parameters.AddWithValue("@ImageName", numRandom);
                Upload.Parameters.AddWithValue("@ProfileName", currentUser.ToString());
                Upload.Parameters.AddWithValue("@Folder", currentUser.ToString());
                Upload.Parameters.AddWithValue("@NumOfLikes", 0);
                Upload.Parameters.AddWithValue("@NumOfViews", 0);


                Upload.ExecuteNonQuery();

               


            }


            // Generate file path
            string filePath = "~/UserUploads/" + numRandom + ".jpg";

            // Save upload file to the file system
            AjaxFileUpload1.SaveAs(MapPath(filePath));

        //IMAGE RESIZER
            string FileToResize = Server.MapPath(filePath);
            string FileToResize2 = Server.MapPath(filePath);





            Bitmap originalBMP = new Bitmap(FileToResize);
            Bitmap originalBMP2 = new Bitmap(FileToResize2);

            // Calculate the new image dimensions
            decimal origWidth = originalBMP.Width;
            if (origWidth >= 820)
            {
                decimal origHeight = originalBMP.Height;
                decimal sngRatio = origWidth / origHeight;
                int newWidth2 = 280;
                int newWidth = 820;
                decimal newHeight_temp = newWidth / sngRatio;
                decimal newHeight2_temp2 = newWidth2 / sngRatio;
                int newHeight = Convert.ToInt32(newHeight_temp);
                int newHeight2 = Convert.ToInt32(newHeight2_temp2);


                // Create a new bitmap which will hold the previous resized bitmap
                Bitmap newBMP = new Bitmap(originalBMP, newWidth, newHeight);
                Bitmap newBMP2 = new Bitmap(originalBMP2, newWidth2, newHeight2);
                // Create a graphic based on the new bitmap
                Graphics oGraphics = Graphics.FromImage(newBMP);
                Graphics oGraphics2 = Graphics.FromImage(newBMP2);
                // Set the properties for the new graphic file
                oGraphics.SmoothingMode = SmoothingMode.AntiAlias; oGraphics.InterpolationMode = InterpolationMode.HighQualityBicubic;
                // Draw the new graphic based on the resized bitmap
                oGraphics.DrawImage(originalBMP, 0, 0, newWidth, newHeight);
                oGraphics2.SmoothingMode = SmoothingMode.AntiAlias; oGraphics2.InterpolationMode = InterpolationMode.HighQualityBicubic;
                // Draw the new graphic based on the resized bitmap
                oGraphics2.DrawImage(originalBMP2, 0, 0, newWidth2, newHeight2);

                // Save the new graphic file to the server
                newBMP.Save(Server.MapPath("~/UserUploads/820/" + numRandom + ".jpg"));
                newBMP2.Save(Server.MapPath("~/UserUploads/280/" + numRandom + ".jpg"));
                // Once finished with the bitmap objects, we deallocate them.
                originalBMP.Dispose();
                newBMP.Dispose();
                oGraphics.Dispose();

                originalBMP2.Dispose();
                newBMP2.Dispose();
                oGraphics2.Dispose();
            }
            else
            {

                decimal origHeight = originalBMP.Height;
                decimal sngRatio = origWidth / origHeight;
                int newWidth2 = 280;

                decimal newHeight2_temp2 = newWidth2 / sngRatio;
               
                int newHeight2 = Convert.ToInt32(newHeight2_temp2);


                // Create a new bitmap which will hold the previous resized bitmap
                
                Bitmap newBMP2 = new Bitmap(originalBMP2, newWidth2, newHeight2);
                // Create a graphic based on the new bitmap
               
                Graphics oGraphics2 = Graphics.FromImage(newBMP2);
                
               
                oGraphics2.SmoothingMode = SmoothingMode.AntiAlias; oGraphics2.InterpolationMode = InterpolationMode.HighQualityBicubic;
                // Draw the new graphic based on the resized bitmap
                oGraphics2.DrawImage(originalBMP2, 0, 0, newWidth2, newHeight2);

                
                newBMP2.Save(Server.MapPath("~/UserUploads/280/" + numRandom + ".jpg"));
                // Once finished with the bitmap objects, we deallocate them.
                originalBMP.Save(Server.MapPath("~/UserUploads/820/" + numRandom + ".jpg"));

                originalBMP2.Dispose();
                newBMP2.Dispose();
                oGraphics2.Dispose();


            }

    }


}