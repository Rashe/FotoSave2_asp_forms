<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Image.aspx.cs" Inherits="Account_Image" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div class="contataer">
        <h2>
            User Images</h2>
        <hr />
        <div class="row">
            <%-- Image Show--%>
            <div class="span9">
                <asp:FormView ID="FVImageFromLinkImage" runat="server" DataKeyNames="ImageId" DataSourceID="SqlImageFromLinkImage"
                    RenderOuterTable="False" OnDataBound="FVImageFromLinkImage_DataBound">
                    <EmptyDataTemplate>
                        <h2>
                            Are you tring to damage my website?</h2>
                    </EmptyDataTemplate>
                    <ItemTemplate>
                        <div>
                        </div>
                        <div class="cus-image-marg">
                            <asp:Image ID="ImageShow" ImageUrl='<%# GlobalFunc.GetImageUrl820( Eval("ImageName"))%>'
                                runat="server" CssClass="cus-image-show-marg" />
                        </div>
                        <br />
                        </div>
                        <%-- Profile Name--%>
                        <div class="span3 image-span3-info-show">
                            <div>
                                <asp:HyperLink ID="HLProfileNameLink" runat="server" Text='<%# Bind("ProfileName") %>'
                                    NavigateUrl='<%# GlobalFunc.GetUserNameLinkUrl( Eval("ProfileName")) %>' Font-Bold="True"
                                    Font-Size="X-Large">f</asp:HyperLink>
                                <asp:Label ID="LblUserId" runat="server" Text='<%# Bind("UserId") %>' Visible="False"></asp:Label>
                                <asp:Label ID="lblProfileName" runat="server" Text='<%# Bind("ProfileName") %>' Visible="false"></asp:Label>
                            </div>
                            <br />
                    </ItemTemplate>
                </asp:FormView>
                <asp:SqlDataSource ID="SqlImageFromLinkImage" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
                    SelectCommand="SELECT [UserId], [ImageId], [ImageName], [ProfileName] FROM [Cus_Upload] WHERE ([ImageName] = @ImageName)">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="ImageName" QueryStringField="img" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <%-- Avatar show and INFO--%>
                <asp:FormView ID="FVAvatarUserOfImage" runat="server" DataKeyNames="UserId" DataSourceID="SqlFVAvatarUserOfImage"
                    RenderOuterTable="False">
                    <ItemTemplate>
                        <div class="cus-info-div-avatar">
                            <asp:Image ID="ImageAvatarImageShow" ImageUrl='<%# GlobalFunc.GetImageUrlAvatar( Eval("Avatar"))%>'
                                runat="server" Width="130px" Height="130px" />
                            <br />
                        </div>
                        <div class="cus-info-div-avatar">
                            <asp:Label ID="Label2" runat="server" Text="Name "></asp:Label>
                            <br />
                            <asp:Label ID="FirstNameLabel" runat="server" Text='<%# Bind("FirstName") %>' Font-Bold="True" />
                            <asp:Label ID="LastNameLabel" runat="server" Text='<%# Bind("LastName") %>' Font-Bold="True" />
                            <br />
                            <br />
                            <asp:Label ID="Label3" runat="server" Text="HomeTown:"></asp:Label>
                            <br />
                            <asp:Label ID="HomeTownLabel" runat="server" Text='<%# Bind("HomeTown") %>' Font-Bold="true" />
                        </div>
                        <br />
                    </ItemTemplate>
                </asp:FormView>
                <div class="clear">
                </div>
                <hr />
                <asp:SqlDataSource ID="SqlFVAvatarUserOfImage" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
                    SelectCommand="SELECT Cus_MoreInfo.Avatar, Cus_MoreInfo.UserId, Cus_MoreInfo.HomeTown, Cus_MoreInfo.FirstName, Cus_MoreInfo.LastName, Cus_MoreInfo.About, Cus_Upload.UserId AS Expr1, Cus_Upload.ImageName FROM Cus_MoreInfo INNER JOIN Cus_Upload ON Cus_MoreInfo.UserId = Cus_Upload.UserId WHERE ([ImageName] = @ImageName)">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="ImageName" QueryStringField="img" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <%-- Follow btn--%>
                <asp:Button ID="BtnFollow" runat="server" Text="Follow User" CssClass="btn btn-primary"
                    OnClick="BtnFollow_Click" Width="100px" />
                <br />
                <br />
                <%-- LIKES And Info--%>
                <asp:FormView ID="FVImageLikesAndInfo" runat="server" DataKeyNames="ImageId" DataSourceID="SqlImageLikesNadInfo"
                    RenderOuterTable="False">
                    <ItemTemplate>
                        <asp:Label ID="Label7" runat="server" Text="Views:"></asp:Label>
                        <asp:Label ID="Label11" runat="server" Text='<%# Bind("NumOfViews") %>' Font-Bold="True"></asp:Label>
                        <br />
                        <asp:Label ID="Label4" runat="server" Text="Total Likes:"></asp:Label>
                        <asp:Label ID="NumOfLikesLabel" runat="server" Text='<%# Bind("NumOfLikes") %>' Font-Bold="True" />
                        <br />
                        <asp:Label ID="Label5" runat="server" Text="Date Created:"></asp:Label>
                        <asp:Label ID="DateLabel" runat="server" Text='<%# Bind("Date", "{0:d}") %>' Font-Bold="True" />
                        <br />
                        <asp:Label ID="Label6" runat="server" Text="Description:"></asp:Label>
                        <asp:Label ID="DescriptionLabel" runat="server" Text='<%# Bind("Description") %>'></asp:Label>
                        <br />
                        <asp:Label ID="lblImageIdForUndef" runat="server" Text='<%# Bind("ImageId") %>' Visible="False"></asp:Label>
                    </ItemTemplate>
                </asp:FormView>
                <asp:SqlDataSource ID="SqlImageLikesNadInfo" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
                    SelectCommand="SELECT [NumOfViews], [NumOfLikes], [Date], [Description], [ImageName], [ImageId], [UserId] FROM [Cus_Upload] WHERE ([ImageName] = @ImageName)">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="ImageName" QueryStringField="img" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <br />
                <br />
                <div>
                    <%--Like button--%>
                    <asp:Button ID="BtnLike" runat="server" Text="Like" CssClass="btn btn-success" Width="180px"
                        Height="35px" OnClick="BtnLike_Click" Font-Bold="True" Font-Size="Medium" />
                </div>
                <br />
                <div>
                    <asp:Button ID="BtnImageDeleteAction" runat="server" Text="Delete this Image" CssClass="btn btn-danger"
                        Visible="False" OnClick="BtnImageDeleteAction_Click" />
                </div>
                <br />
                <br />
                <div>
                    <%-- More Images--%>
                    <asp:ListView ID="LVMoreImagesToShow" GroupItemCount="2" runat="server" DataSourceID="SqlLVMoreImagesToShow">
                        <LayoutTemplate>
                            <ul class="unstyled">
                                <asp:PlaceHolder ID="groupPlaceholder" runat="server" />
                            </ul>
                        </LayoutTemplate>
                        <GroupTemplate>
                            <li>
                                <asp:PlaceHolder ID="itemPlaceholder" runat="server" />
                            </li>
                        </GroupTemplate>
                        <ItemTemplate>
                            <asp:HyperLink ID="HyperLink1" NavigateUrl='<%# GlobalFunc.GetImageLink( Eval("ImageName"))%>'
                                runat="server">
                                <asp:Image ID="Image2" ImageUrl='<%# GlobalFunc.GetImageUrl280( Eval("ImageName"))%>'
                                    runat="server" CssClass="cus-more-image-show" />
                            </asp:HyperLink>
                        </ItemTemplate>
                    </asp:ListView>
                    <asp:SqlDataSource ID="SqlLVMoreImagesToShow" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
                        SelectCommand="SELECT TOP(6) [UserId], [ImageId], [ImageName], [Date], [ProfileName] FROM [Cus_Upload] WHERE ([ProfileName] = @ProfileName) ORDER BY [Date] DESC">
                        <SelectParameters>
                            <asp:SessionParameter Name="ProfileName" SessionField="ForMotherRussia" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>
            </div>
        </div>
        <hr />
        <br />
        <div>
            <%--User Comments--%>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server" EnableViewState="false">
                <ContentTemplate>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Enter your comment please"
                        Display="Dynamic" ControlToValidate="TxtUserComments" ValidationGroup="a" ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="Enter your comment please"
                        Display="Dynamic" ControlToValidate="TxtUserComments" ValidationGroup="a" ForeColor="Red"></asp:CustomValidator>
                    <br />
                    <asp:TextBox ID="TxtUserComments" runat="server" TextMode="MultiLine" Width="870px"
                        Height="50px" placeholder="Enter Comment" ValidationGroup="a"></asp:TextBox>
                    <br />
                    <asp:Button ID="BtnUserComments" runat="server" CssClass="btn" Text="Comment" OnClick="BtnUserComments_Click"
                        ValidationGroup="a" />
                    <br />
                    <br />
                    <br />
                    <h3>
                        Users Comments</h2>
                        <asp:ListView ID="LVImageUserComments" runat="server" DataSourceID="SqlLVImageUserComments">
                            <EmptyDataTemplate>
                                <div class="comment-div">
                                    No comments
                                </div>
                            </EmptyDataTemplate>
                            <LayoutTemplate>
                                <asp:PlaceHolder runat="server" ID="itemPlaceholder"></asp:PlaceHolder>
                            </LayoutTemplate>
                            <ItemTemplate>
                                <div class="row">
                                    <hr class="cus-hr-comment" />
                                    <div class="span1">
                                        <asp:Image ID="Image1" runat="server" AlternateText='<%# Eval ("UserName") %>' ImageUrl='<%# GlobalFunc.GetImageUrlAvatar( Eval("Avatar"))%>'
                                            CssClass="coment-avatar-style" />
                                    </div>
                                    <div class="span8">
                                        <div>
                                            <asp:Label ID="Label1" runat="server" Text="Comment from:" Font-Size="Smaller" Font-Italic="True"
                                                ForeColor="#666666"></asp:Label>
                                            <asp:HyperLink ID="HLuserNmaeComentLink" runat="server" Text='<%# Bind("UserName") %>'
                                                NavigateUrl='<%# GlobalFunc.GetUserNameLinkUrl( Eval("UserName")) %>'>HyperLink</asp:HyperLink>
                                            <asp:Label ID="Label8" runat="server" Text="at:" Font-Italic="True" Font-Size="Smaller"
                                                ForeColor="#666666"></asp:Label>
                                            <asp:Label ID="Label9" runat="server" Text='<%# Eval ("Date") %>' Font-Size="Smaller"
                                                Font-Italic="True" ForeColor="#666666" />
                                        </div>
                                        <div>
                                            <asp:Label ID="Label10" runat="server" Text='<%# Eval("ComentBody") %>' />
                                        </div>
                                    </div>
                                    <br />
                                    <br />
                                </div>
                            </ItemTemplate>
                        </asp:ListView>
                        <asp:SqlDataSource ID="SqlLVImageUserComments" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
                            SelectCommand="SELECT Cus_Coments.ComentId, Cus_Coments.UserId, Cus_Coments.UserName, Cus_Coments.Date, Cus_Coments.ComentBody, Cus_Coments.ImageName, Cus_Coments.ImageId, Cus_MoreInfo.UserId AS Expr1, Cus_MoreInfo.Avatar FROM Cus_Coments INNER JOIN Cus_MoreInfo ON Cus_Coments.UserId = Cus_MoreInfo.UserId WHERE (Cus_Coments.ImageName = @ImageName) ORDER BY Cus_Coments.Date DESC">
                            <SelectParameters>
                                <asp:QueryStringParameter Name="ImageName" QueryStringField="img" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>
