<%@ Page Language="C#" AutoEventWireup="true" CodeFile="admUserBan.aspx.cs" Inherits="Adm_admUserBan" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>

    <%-- Description:
        This is local page for administration
            --%>


    <form id="form1" runat="server">
    <div>
    
        <asp:FormView ID="FormView1" runat="server" DataSourceID="SqlDataSource1">
          
          
            <ItemTemplate>
                UserId:
                <asp:Label ID="UserIdLabel" runat="server" Text='<%# Bind("UserId") %>' />
                <br />
                UserName:
                <asp:Label ID="UserNameLabel" runat="server" Text='<%# Bind("UserName") %>' />
                <br />
                ApplicationId:
                <asp:Label ID="ApplicationIdLabel" runat="server" 
                    Text='<%# Bind("ApplicationId") %>' />
                <br />

                Expr1:
                <asp:Label ID="Expr1Label" runat="server" Text='<%# Bind("Expr1") %>' />
                <br />
                IsApproved:
                <asp:CheckBox ID="IsApprovedCheckBox" runat="server" 
                    Checked='<%# Bind("IsApproved") %>' Enabled="false" />
                <br />
                IsLockedOut:
                <asp:CheckBox ID="IsLockedOutCheckBox" runat="server" 
                    Checked='<%# Bind("IsLockedOut") %>' Enabled="false" />
                <br />

            </ItemTemplate>
        </asp:FormView>

        <asp:Button ID="Button1" runat="server" Text="Ban or Un" 
            onclick="Button1_Click" />

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" 
            
            SelectCommand="SELECT vw_aspnet_Users.UserId, vw_aspnet_Users.UserName, vw_aspnet_Users.ApplicationId, aspnet_Membership.UserId AS Expr1, aspnet_Membership.IsApproved, aspnet_Membership.IsLockedOut FROM vw_aspnet_Users INNER JOIN aspnet_Membership ON vw_aspnet_Users.UserId = aspnet_Membership.UserId WHERE (vw_aspnet_Users.UserName = @UserName)">
            <SelectParameters>
                <asp:QueryStringParameter Name="UserName" QueryStringField="user" 
                    Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
    </form>
</body>
</html>
