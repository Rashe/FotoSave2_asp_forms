<%@ Page Language="C#" AutoEventWireup="true" CodeFile="users.aspx.cs" Inherits="Adm_meshtamshim" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Users</title>
</head>
<body>

    <%-- Description:
        This is local page for administration
            --%>





    <form id="form1" runat="server">
    <div>
        <h1>Users List</h1>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="Expr1"
            DataSourceID="SqlDataSource1" AllowPaging="True" AllowSorting="True" PageSize="15">
            <Columns>
                <asp:BoundField DataField="UserId" HeaderText="UserId" SortExpression="UserId" />
                <asp:TemplateField HeaderText="UserName" SortExpression="UserName">
                    <ItemTemplate>
                        <asp:HyperLink ID="HyperLink1" Text='<%# Bind("UserName") %>' NavigateUrl='<%# GetUserNameLinkUrl( Eval("UserName")) %>'
                            runat="server"></asp:HyperLink>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="LastActivityDate" HeaderText="LastActivityDate" SortExpression="LastActivityDate" />
                <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                <asp:BoundField DataField="CreateDate" HeaderText="CreateDate" SortExpression="CreateDate" />
                <asp:BoundField DataField="LastLoginDate" HeaderText="LastLoginDate" SortExpression="LastLoginDate" />
                <asp:BoundField DataField="IsApproved" HeaderText="IsApproved" SortExpression="IsApproved" />
                <asp:BoundField DataField="IsLockedOut" HeaderText="IsLockedOut" SortExpression="IsLockedOut" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
            SelectCommand="SELECT aspnet_Users.UserId, aspnet_Users.UserName, aspnet_Users.LastActivityDate, aspnet_Membership.UserId AS Expr1, aspnet_Membership.Email, aspnet_Membership.CreateDate, aspnet_Membership.LastLoginDate, aspnet_Membership.IsLockedOut, aspnet_Membership.IsApproved FROM aspnet_Users INNER JOIN aspnet_Membership ON aspnet_Users.UserId = aspnet_Membership.UserId ORDER BY aspnet_Membership.CreateDate DESC">
        </asp:SqlDataSource>
    </div>
    <br />
    <br />
    <div>
        <h1>Images List</h1>
        <asp:GridView ID="GridView2" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            DataKeyNames="ImageId" DataSourceID="SqlDataSource2">
            <Columns>
                <asp:CommandField ShowEditButton="True" />
                <asp:BoundField DataField="ProfileName" HeaderText="ProfileName" ReadOnly="True"
                    SortExpression="ProfileName" />
                <asp:BoundField DataField="ImageName" HeaderText="ImageName" ReadOnly="True" SortExpression="ImageName" />
                <asp:BoundField DataField="NumOfLikes" HeaderText="NumOfLikes" SortExpression="NumOfLikes" />
                <asp:BoundField DataField="Date" HeaderText="Date" ReadOnly="True" SortExpression="Date" />
                <asp:CommandField ShowDeleteButton="True" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
            DeleteCommand="DELETE FROM [Cus_Upload] WHERE [ImageId] = @ImageId" InsertCommand="INSERT INTO [Cus_Upload] ([ImageName], [Date], [ProfileName], [NumOfLikes], [UserId], [ImageId]) VALUES (@ImageName, @Date, @ProfileName, @NumOfLikes, @UserId, @ImageId)"
            SelectCommand="SELECT TOP(150) [ImageName], [Date], [ProfileName], [NumOfLikes], [UserId], [ImageId] FROM [Cus_Upload] ORDER BY [Date] DESC, [ProfileName] DESC"
            UpdateCommand="UPDATE [Cus_Upload] SET  [NumOfLikes] = @NumOfLikes, [UserId] = @UserId WHERE [ImageId] = @ImageId">
            <DeleteParameters>
                <asp:Parameter Name="ImageId" Type="Object" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="ImageName" Type="String" />
                <asp:Parameter Name="Date" Type="DateTime" />
                <asp:Parameter Name="ProfileName" Type="String" />
                <asp:Parameter Name="NumOfLikes" Type="Int32" />
                <asp:Parameter Name="UserId" Type="Object" />
                <asp:Parameter Name="ImageId" Type="Object" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="ImageName" Type="String" />
                <asp:Parameter Name="Date" Type="DateTime" />
                <asp:Parameter Name="ProfileName" Type="String" />
                <asp:Parameter Name="NumOfLikes" Type="Int32" />
                <asp:Parameter Name="UserId" Type="Object" />
                <asp:Parameter Name="ImageId" Type="Object" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </div>
    <br />
    <br />
    <div>
        <h1>Comments List</h1>
        <asp:GridView ID="GridView3" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" DataKeyNames="ComentId" DataSourceID="SqlDataSource3"
            PageSize="25" Width="1000px">
            <Columns>
                <asp:BoundField DataField="UserName" HeaderText="UserName" SortExpression="UserName" />
                <asp:BoundField DataField="ImageName" HeaderText="ImageName" SortExpression="ImageName" />
                <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" />
                <asp:BoundField DataField="ComentBody" HeaderText="ComentBody" SortExpression="ComentBody" />
                <asp:CommandField ShowDeleteButton="True" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
            DeleteCommand="DELETE FROM [Cus_Coments] WHERE [ComentId] = @ComentId" InsertCommand="INSERT INTO [Cus_Coments] ([ComentId], [UserName], [UserId], [Date], [ComentBody], [ImageName], [ImageId]) VALUES (@ComentId, @UserName, @UserId, @Date, @ComentBody, @ImageName, @ImageId)"
            SelectCommand="SELECT [ComentId], [UserName], [UserId], [Date], [ComentBody], [ImageName], [ImageId] FROM [Cus_Coments] ORDER BY [Date] DESC"
            UpdateCommand="UPDATE [Cus_Coments] SET [UserName] = @UserName, [UserId] = @UserId, [Date] = @Date, [ComentBody] = @ComentBody, [ImageName] = @ImageName, [ImageId] = @ImageId WHERE [ComentId] = @ComentId">
            <DeleteParameters>
                <asp:Parameter Name="ComentId" Type="Object" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="ComentId" Type="Object" />
                <asp:Parameter Name="UserName" Type="String" />
                <asp:Parameter Name="UserId" Type="Object" />
                <asp:Parameter Name="Date" Type="DateTime" />
                <asp:Parameter Name="ComentBody" Type="String" />
                <asp:Parameter Name="ImageName" Type="String" />
                <asp:Parameter Name="ImageId" Type="Object" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="UserName" Type="String" />
                <asp:Parameter Name="UserId" Type="Object" />
                <asp:Parameter Name="Date" Type="DateTime" />
                <asp:Parameter Name="ComentBody" Type="String" />
                <asp:Parameter Name="ImageName" Type="String" />
                <asp:Parameter Name="ImageId" Type="Object" />
                <asp:Parameter Name="ComentId" Type="Object" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </div>
    </form>
</body>
</html>
