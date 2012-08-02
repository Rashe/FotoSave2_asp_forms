<%@ Page Title="PhotoSave / Notifications" Language="C#" MasterPageFile="~/Site.master"
    AutoEventWireup="true" CodeFile="notifications.aspx.cs" Inherits="Account_notifications" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="contataer">
        <h2>Notifications</h2>
        <hr />
        <%-- Read All button--%>
        <asp:Button ID="BtnMarkAsRead" runat="server" Text="Mark all as read" OnClick="BtnMarkAsRead_Click"
            CssClass="btn btn-warning" />
        <br />
        <br />
        <%-- Notification List--%>
        <asp:ListView ID="LVNotif" runat="server" DataSourceID="SqlLVNotif">
            <EmptyDataTemplate>
                <div class="comment-div">
                    No Notifications
                </div>
            </EmptyDataTemplate>
            <LayoutTemplate>
                <asp:PlaceHolder runat="server" ID="itemPlaceholder"></asp:PlaceHolder>
                <br />
                <br />
            </LayoutTemplate>
            <ItemTemplate>
                <div class="row">
                    <div class="span1">
                        <asp:Image ID="Image1" runat="server" AlternateText='<%# Eval ("UserName") %>' ImageUrl='<%# GlobalFunc.GetImageUrlAvatar( Eval("Avatar"))%>'
                            CssClass="coment-avatar-style" />
                    </div>
                    <div class="span8">
                        <div>
                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("Date")%>' Font-Size="Smaller"
                                Font-Italic="True" ForeColor="#666666"></asp:Label>
                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("isRead")%>' ForeColor="Red"
                                Font-Bold="True"></asp:Label>
                        </div>
                        <div>
                            <asp:HyperLink ID="HLProfielName" runat="server" Text='<%# Bind("ProfileName") %>'
                                NavigateUrl='<%# GlobalFunc.GetUserNameLinkUrl( Eval("ProfileName")) %>'></asp:HyperLink>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("NotifBody") %>'></asp:Label>
                            <asp:HyperLink ID="HyperLink1" NavigateUrl='<%# GlobalFunc.GetImageLink( Eval("ImageName"))%>'
                                Text='<%# Bind("ImageName") %>' runat="server"></asp:HyperLink>
                            <br />
                        </div>
                        <br />
                        <br />
                    </div>
                </div>
            </ItemTemplate>
        </asp:ListView>
        <asp:SqlDataSource ID="SqlLVNotif" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
            OnSelecting="SqlLVNotif_Selecting" SelectCommand="SELECT TOP(20) Cus_Notif.NotifId, Cus_Notif.UserId, Cus_Notif.UserName, Cus_Notif.ProfileName, Cus_Notif.NotifBody, Cus_Notif.Date, Cus_Notif.isRead, Cus_MoreInfo.Avatar, Cus_MoreInfo.UserId AS Expr1, Cus_Notif.ImageName FROM Cus_Notif INNER JOIN Cus_MoreInfo ON Cus_Notif.UserId = Cus_MoreInfo.UserId WHERE (Cus_Notif.UserName = @UserName) ORDER BY Cus_Notif.Date DESC, Cus_Notif.isRead">
            <SelectParameters>
                <asp:Parameter Name="UserName" Type="Object" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>
