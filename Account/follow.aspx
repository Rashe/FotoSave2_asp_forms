<%@ Page Title="PhotoSave / Following" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="follow.aspx.cs" Inherits="Account_follow" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

<div class="contataer">

<h2>Images from followed users</h2>


<hr />

    <h1>Still working on it</h1>

    <asp:ListView ID="LVFollowImagesShow" runat="server" 
        DataSourceID="SqlLVFollowImagesShow">

    <LayoutTemplate>
        <div id="container1" class="clearfix1">
         <asp:PlaceHolder runat="server" ID="itemPlaceholder"></asp:PlaceHolder>
        
        
        </div>
         <br />
        <br />
        <div class="cus-image-marg">

        <asp:DataPager ID="DataPager2" PageSize="25" runat="server">
        <Fields>
        <asp:NumericPagerField ButtonType="Button" CurrentPageLabelCssClass="btn btn-info" NumericButtonCssClass="btn" NextPreviousButtonCssClass="btn" />
        
        </Fields>
        </asp:DataPager>

        </div>



        </LayoutTemplate>


         <ItemTemplate>
         <div class="box1 photo1 col1113">
        
            <asp:HyperLink ID="HyperLink1" NavigateUrl='<%# GlobalFunc.GetImageLink( Eval("ImageName"))%>' runat="server">
             <asp:Image ID="Image1" ImageUrl='<%# GlobalFunc.GetImageUrl280( Eval("ImageName"))%>' runat="server" />
             <br />
                <asp:Label ID="Label3" runat="server" Text="Total Likes:" ForeColor="Black"></asp:Label>
                <asp:Label ID="Label1" runat="server" Text='<%# Bind("NumOfLikes") %>'></asp:Label>
                <br />
                <asp:Label ID="Label4" runat="server" Text="Uploaded by:" ForeColor="Black"></asp:Label>
                <asp:Label ID="Label2" runat="server" Text='<%# Bind("ProfileName") %>'></asp:Label>
        </asp:HyperLink>
        
        </div>
        </ItemTemplate>






    </asp:ListView>







     <script src="scripts/masonry/jquery-1.7.1.min.js"></script>
<script src="scripts/masonry/jquery.masonry.min.js"></script>
<script>
    $(function () {

        var $container = $('#container1');

        $container.imagesLoaded(function () {
            $container.masonry({
                itemSelector: '.box1'
            });
        });

    });
</script>






    <asp:SqlDataSource ID="SqlLVFollowImagesShow" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" 
        onselecting="SqlLVFollowImagesShow_Selecting" 
        
        SelectCommand="SELECT Cus_Followers.FollowId, Cus_Followers.UserId, Cus_Followers.MyUserId AS Expr1, Cus_Followers.ProfileName AS Expr2, Cus_Followers.MyUserName, Cus_Followers.MyProfilelName, Cus_Upload.UserId AS Expr3, Cus_Upload.ImageId, Cus_Upload.ImageName, Cus_Upload.Date, Cus_Upload.ProfileName, Cus_Upload.NumOfLikes FROM Cus_Followers CROSS JOIN Cus_Upload WHERE (Cus_Followers.MyUserId = @MyUserId) ORDER BY Cus_Upload.Date DESC">
        <SelectParameters>
            <asp:Parameter Name="MyUserId" Type="Object" />
        </SelectParameters>
    </asp:SqlDataSource>


</div>

</asp:Content>

