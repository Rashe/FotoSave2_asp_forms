<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="User.aspx.cs" Inherits="Account_User" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="contataer">
        <br />
        <br />
        <div class="row">
            <%-- Show Avatar--%>
            <div class="span2">
                <asp:FormView ID="FVUserInfoShow" runat="server" DataKeyNames="UserId" DataSourceID="SqlFVUserInfoShow"
                    RenderOuterTable="False" OnDataBound="FVUserInfoShow_DataBound1">
                    <ItemTemplate>
                        <div class="mer-margin-left">
                            <asp:Image ID="ImageAvatarImageShow" ImageUrl='<%# GlobalFunc.GetImageUrlAvatar( Eval("Avatar"))%>'
                                Width="130px" Height="130px" runat="server" />
                        </div>
                        </div>
                        <%-- More User Info--%>
                        <div class="span2">
                            <asp:Label ID="UserNameLabel" runat="server" Text='<%# Bind("UserName") %>' Font-Bold="True"
                                Font-Size="X-Large" />
                            <asp:Label ID="lblUserOnl" runat="server" Text="(Offline)" Font-Bold="True"></asp:Label>
                            <br />
                            <asp:Label ID="UserIdLabel" runat="server" Text='<%# Eval("UserId") %>' Visible="False" />
                            <br />
                            <asp:Label ID="Label1" runat="server" Text="First Name:"></asp:Label>
                            <asp:Label ID="FirstNameLabel" runat="server" Text='<%# Bind("FirstName") %>' Font-Bold="True" />
                            <br />
                            <asp:Label ID="Label2" runat="server" Text="Last Name:"></asp:Label>
                            <asp:Label ID="LastNameLabel" runat="server" Text='<%# Bind("LastName") %>' Font-Bold="True" />
                            <br />
                            <asp:Label ID="Label3" runat="server" Text="HomeTown:"></asp:Label>
                            <asp:Label ID="HomeTownLabel" runat="server" Text='<%# Bind("HomeTown") %>' Font-Bold="True" />
                            <br />
                        </div>
                        <%-- More User Info NEXT tab--%>
                        <div class="span2 user-margin-for-span2">
                            <asp:Label ID="Label4" runat="server" Text="About:"></asp:Label>
                            <asp:Label ID="AboutLabel" runat="server" Text='<%# Bind("About") %>' Font-Bold="True" />
                            <br />
                            <asp:Label ID="Label5" runat="server" Text="Last Date Logged:"></asp:Label>
                            <asp:Label ID="LastActivityDateLabel" runat="server" Text='<%# Bind("LastActivityDate", "{0:d}") %>'
                                Font-Bold="True" />
                            <br />
                        </div>
                    </ItemTemplate>
                </asp:FormView>
                <br />
                <asp:SqlDataSource ID="SqlFVUserInfoShow" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
                    SelectCommand="SELECT aspnet_Users.UserName, Cus_MoreInfo.UserId, aspnet_Users.UserId AS Expr1, Cus_MoreInfo.HomeTown, Cus_MoreInfo.FirstName, Cus_MoreInfo.LastName, Cus_MoreInfo.About, Cus_MoreInfo.Avatar, aspnet_Users.LastActivityDate FROM aspnet_Users INNER JOIN Cus_MoreInfo ON aspnet_Users.UserId = Cus_MoreInfo.UserId WHERE (aspnet_Users.UserName=@UserName)">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="UserName" QueryStringField="user" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <div class="span6">
                    <%-- Follow btn--%>
                    <asp:Button ID="BtnFollow" runat="server" Text="Follow User" Width="100px" CssClass="btn btn-primary"
                        OnClick="BtnFollow_Click" />
                    <br />
                    <br />
                    <asp:Label ID="Label6" runat="server" Text="Total Likes:"></asp:Label>
                    <asp:Label ID="Label7" runat="server" Text="Soon" ForeColor="#0066FF" Font-Bold="True"></asp:Label>
                </div>
            </div>
            <hr />
            <%-- Images Show--%>
            <asp:ListView ID="LVUserImagesShow" runat="server" DataSourceID="SqlLVUserImagesShow">
                <LayoutTemplate>
                    <div id="container1" class="clearfix1">
                        <asp:PlaceHolder runat="server" ID="itemPlaceholder"></asp:PlaceHolder>
                    </div>
                    <br />
                    <br />
                    <hr />
                    <div class="cus-image-marg">
                        <asp:DataPager PageSize="15" runat="server">
                            <Fields>
                                <asp:NumericPagerField ButtonType="Button" CurrentPageLabelCssClass="btn" NumericButtonCssClass="btn" />
                            </Fields>
                        </asp:DataPager>
                    </div>
                </LayoutTemplate>
                <ItemTemplate>
                    <div class="box1 photo1 col1113">
                        <asp:HyperLink ID="HyperLink1" NavigateUrl='<%# GlobalFunc.GetImageLink( Eval("ImageName"))%>'
                            runat="server">
                            <asp:Image ID="Image1" ImageUrl='<%# GlobalFunc.GetImageUrl280( Eval("ImageName"))%>'
                                runat="server" />
                        </asp:HyperLink>
                    </div>
                </ItemTemplate>
                <EmptyDataTemplate>
                    <br />
                    <br />
                    <div class="cus-image-marg">
                        <h1>Nothing to see yet</h1>
                    </div>
                </EmptyDataTemplate>
            </asp:ListView>
            <script src="../scripts/masonry/jquery-1.7.1.min.js"></script>
            <script src="../scripts/masonry/jquery.masonry.min.js"></script>
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
            <asp:SqlDataSource ID="SqlLVUserImagesShow" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
                SelectCommand="SELECT [UserId], [ImageId], [ProfileName], [ImageName], [Date] FROM [Cus_Upload] WHERE ([ProfileName] = @ProfileName) ORDER BY [Date] DESC">
                <SelectParameters>
                    <asp:QueryStringParameter Name="ProfileName" QueryStringField="user" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
</asp:Content>
