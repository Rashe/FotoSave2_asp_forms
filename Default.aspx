<%@ Page Title="PhotoSave" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent" EnableViewState="False">
    <div class="contataer">
        <h2>Top Images </h2>
        <hr />
        <%-- Description div that available only for unregistered users--%>
        <div id="cusWelcomeDiv" runat="server" visible="false">
            <div class="row-fluid">
                <div class="span4">
                    <div class="well">
                        <h3>Welcome to PhotoSave</h3>
                        <br />
                        <ul>
                            <li>This website/project made for fun</li>
                            <li>The website is in early <b>ALPHA</b>version</li>
                            <li>The idea is from 500px.com and it's similar</li>
                            <li>500px is much better and I know it, you can't even compare</li>
                        </ul>
                    </div>
                </div>
                <div class="span4">
                    <div class="well">
                        <h4>Usage:</h4>
                        <br />
                        <ul>
                            <li>
                                <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/Account/Register.aspx">Register</asp:HyperLink>
                            </li>
                            <li>Upload Images</li>
                            <li>Like other Images</li>
                            <li>Change your profile settings</li>
                            <li>Follow other uploaders (users)</li>
                        </ul>
                    </div>
                </div>
                <div class="span4">
                    <div class="well">
                        <h4>Made Of:</h4>
                        <br />
                        <ul>
                            <li>Asp.Net 4</li>
                            <li>Sql DataBase</li>
                            <li>Website uses Twitter bootstrap</li>
                            <li>Also Masonry jQuery plugin</li>
                            <li>Ajax Control Toolkit</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <br />
        <%-- TOP Images--%>
        <asp:ListView ID="LVDefaultTopImageShow" runat="server" DataSourceID="SqlLVDefaultTopImageShow" EnableViewState="False">
            <LayoutTemplate>
                <div id="container1" class="clearfix1">
                    <asp:PlaceHolder runat="server" ID="itemPlaceholder"></asp:PlaceHolder>
                </div>
                <br />
                <br />
            </LayoutTemplate>
            <ItemTemplate>
                <div class="box1 photo1 col1113">
                    <asp:HyperLink ID="HyperLink1" NavigateUrl='<%# GlobalFunc.GetImageLink( Eval("ImageName"))%>'
                        runat="server">
                        <asp:Image ID="Image1" ImageUrl='<%# GlobalFunc.GetImageUrl280( Eval("ImageName"))%>'
                            runat="server" />
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
        <asp:SqlDataSource ID="SqlLVDefaultTopImageShow" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
            SelectCommand="SELECT TOP (30) UserId, ImageId, ImageName, NumOfLikes, ProfileName FROM Cus_Upload ORDER BY NumOfLikes DESC, Date DESC">
        </asp:SqlDataSource>
    </div>
</asp:Content>
