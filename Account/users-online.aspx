<%@ Page Title="PhotoSave / Users Online" Language="C#" MasterPageFile="~/Site.master"
    AutoEventWireup="true" CodeFile="users-online.aspx.cs" Inherits="Account_users_online" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="contataer">
        <h2>Users Online</h2>
        <hr />
        <br />
        <asp:ListView ID="LVUsersOnlineShow" runat="server" DataSourceID="SqlDataLVUsersOnlineShow"
            GroupItemCount="8">
            <LayoutTemplate>
                <div>
                    <asp:PlaceHolder ID="groupPlaceholder" runat="server" />
                </div>
            </LayoutTemplate>
            <GroupTemplate>
                <div>
                    <asp:PlaceHolder ID="itemPlaceholder" runat="server" />
                </div>
                <div class="clear"></div>
                <br />
                <br />
            </GroupTemplate>
            <ItemTemplate>
                <div class="cus-info-div-avatar2">
                    <div>
                        <asp:HyperLink ID="HLProfileNamelink" runat="server" Text='<%# Eval("UserName") %>'
                            NavigateUrl='<%# GlobalFunc.GetUserNameLinkUrl( Eval("UserName")) %>' Font-Bold="True"
                            Font-Size="X-Large">f</asp:HyperLink>
                    </div>
                    <div>
                        <asp:Image ID="ImageAvatarShow1" runat="server" ImageUrl='<%# GlobalFunc.GetImageUrlAvatar( Eval("Avatar"))%>'
                            Width="130px" Height="130px" />
                    </div>
                </div>
            </ItemTemplate>
            <EmptyDataTemplate>
            </EmptyDataTemplate>
        </asp:ListView>
        <asp:SqlDataSource ID="SqlDataLVUsersOnlineShow" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
            SelectCommand="SELECT aspnet_Users.UserId, Cus_MoreInfo.UserId AS Expr1, aspnet_Users.UserName, aspnet_Users.LastActivityDate, Cus_MoreInfo.Avatar FROM aspnet_Users INNER JOIN Cus_MoreInfo ON aspnet_Users.UserId = Cus_MoreInfo.UserId WHERE aspnet_Users.LastActivityDate &gt; DATEADD(minute, -(20), GETDATE())">
        </asp:SqlDataSource>
    </div>
</asp:Content>
