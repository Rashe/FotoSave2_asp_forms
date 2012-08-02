<%@ Page Title="PhotoSave / 404" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="404.aspx.cs" Inherits="_404" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="contataer">
        <div class="cus-404-error">
            <h2>Not Found.. 404 Error</h2>
            <br />
            <br />
            <h2>But You Found Me :)</h2>
            <br />
            <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/smiling-cat.jpg" />
        </div>
    </div>
</asp:Content>
