<%@ Page Title="Profile" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Profile.aspx.cs" Inherits="Account_Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="contataer">
        <h2>Profile Settings</h2>
        <hr />
        <br />
        <br />
        <div class="row-fluid">
            <div class="span3">
                <%-- NAvigation--%>
                <ul class="nav nav-list">
                    <li class="active"><a href="~/Account/Profile.aspx" runat="server">Profile</a></li>
                    <li><a href="~/Account/ChangePassword.aspx" runat="server">Password</a></li>
                    <li><a href="#">Soon</a></li>
                    <li><a href="#">Soon</a></li>
                </ul>
            </div>
            <%-- More User Info--%>
            <div class="span4">
                <asp:FormView ID="FVUserEdit" runat="server" DataKeyNames="UserId" DataSourceID="SqlUserEdit"
                    EmptyDataText="Empty" DefaultMode="Edit" RenderOuterTable="False">
                    <EditItemTemplate>
                        <asp:Label ID="UserIdLabel1" runat="server" Text='<%# Eval("UserId") %>' Visible="False" />
                        <label>FirstName</label>
                        <asp:TextBox ID="FirstNameTextBox" runat="server" Text='<%# Bind("FirstName") %>'
                            placeholder="Write your First Name" />
                        <br />
                        <label>LastName</label>
                        <asp:TextBox ID="LastNameTextBox" runat="server" Text='<%# Bind("LastName") %>' placeholder="Write your Last Name" />
                        <br />
                        <label>HomeTown</label>
                        <asp:TextBox ID="HomeTownTextBox" runat="server" Text='<%# Bind("HomeTown") %>' placeholder="Write your Hometown" />
                        <br />
                        <label>About</label>
                        <asp:TextBox ID="AboutTextBox" runat="server" Text='<%# Bind("About") %>' placeholder="Write about yourself"
                            TextMode="MultiLine" />
                        <br />
                        <br />
                        <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                            Text="Update" />
                        &nbsp;
                    </EditItemTemplate>
                </asp:FormView>
                <asp:SqlDataSource ID="SqlUserEdit" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
                    OnSelecting="SqlUserEdit_Selecting" SelectCommand="SELECT [UserId], [HomeTown], [FirstName], [LastName], [About]  FROM [Cus_MoreInfo] WHERE ([UserId] = @UserId)"
                    UpdateCommand="UPDATE [Cus_MoreInfo] SET [HomeTown] = @HomeTown, [FirstName] = @FirstName, [LastName] = @LastName, [About] = @About WHERE [UserId] = @UserId">
                    <SelectParameters>
                        <asp:Parameter Name="UserId" Type="Object" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="HomeTown" Type="String" />
                        <asp:Parameter Name="FirstName" Type="String" />
                        <asp:Parameter Name="LastName" Type="String" />
                        <asp:Parameter Name="About" Type="String" />
                        <asp:Parameter Name="UserId" Type="Object" />
                    </UpdateParameters>
                </asp:SqlDataSource>
            </div>
            <div class="span5">
                <asp:FormView ID="FVUserAvatarShowandEdit" runat="server" DataKeyNames="UserId" DataSourceID="SqlAvatarEdit"
                    RenderOuterTable="False" EnableViewState="False">
                    <ItemTemplate>
                        <asp:Image ID="ImgAvatarShowAndEdit" ImageUrl='<%# GlobalFunc.GetImageUrlAvatar( Eval("Avatar")) %>'
                            runat="server" Width="130px" Height="130px" />
                        <br />
                    </ItemTemplate>
                </asp:FormView>
                <br />
                <div>
                    <%--avatar upload--%>
                    <asp:FileUpload ID="FUProfileAvatar" runat="server" />
                    <br />
                    <br />
                    <asp:Button ID="BtnFUProfileAvatar" runat="server" Text="Upload" OnClick="BtnFUProfileAvatar_Click"
                        CssClass="btn" Height="50px" Width="200px" />
                </div>
                <br />
                <div>
                    <%--notify lbl--%>
                    <asp:Label ID="LblAvatarNotify" runat="server" Text=""></asp:Label>
                </div>
                <asp:SqlDataSource ID="SqlAvatarEdit" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
                    SelectCommand="SELECT [UserId], [Avatar] FROM [Cus_MoreInfo] WHERE ([UserId] = @UserId)"
                    OnSelecting="SqlAvatarEdit_Selecting">
                    <SelectParameters>
                        <asp:Parameter Name="UserId" Type="Object" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
        </div>
    </div>
</asp:Content>
