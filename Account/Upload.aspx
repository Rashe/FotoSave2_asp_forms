<%@ Page Title="PhotoSave / Upload Images" Language="C#" MasterPageFile="~/Site.master"
    AutoEventWireup="true" CodeFile="Upload.aspx.cs" Inherits="Account_Upload" %>

<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="logindivmer2">
        <h2>Choose images to upload</h2>
        <hr />
        <br />
        <br />
        <div>
            <h4 class="cus-greeny">You can upload up to 8 Images (jpeg) at once</h4>
            <br />
        </div>
         <%-- Ajax Tool Kit IMAGES UPLOAD--%>
        <ajaxToolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" />
        <ajaxToolkit:AjaxFileUpload ID="AjaxFileUpload1" OnUploadComplete="ajaxUpload1_OnUploadComplete"
            ThrobberID="myThrobber" ContextKeys="fred" AllowedFileTypes="jpg,jpeg" MaximumNumberOfFiles="8"
            runat="server" />
        <br />
        <br />
        <div class="cus-images-prev">
        </div>
    </div>
</asp:Content>
