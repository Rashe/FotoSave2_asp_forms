<%@ Page Title="PhotoSave / New Images" Language="C#" MasterPageFile="~/Site.master"
    AutoEventWireup="true" CodeFile="NewContent.aspx.cs" Inherits="NewContent" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="contataer">
        <h2>New Content</h2>
        <hr />
        <%-- NEW Images--%>
        <asp:ListView ID="LVNewContentShow" runat="server" DataSourceID="SqlLVNewContentShow">
            <LayoutTemplate>
                <div id="container1" class="clearfix1">
                    <asp:PlaceHolder runat="server" ID="itemPlaceholder"></asp:PlaceHolder>
                </div>
                <br />
                <br />
                <hr />
                <div class="cus-image-marg">
                    <asp:DataPager ID="DataPager2" PageSize="25" runat="server">
                        <Fields>
                            <asp:NumericPagerField ButtonType="Button" CurrentPageLabelCssClass="btn btn-info"
                                NumericButtonCssClass="btn" NextPreviousButtonCssClass="btn" />
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
        <asp:SqlDataSource ID="SqlLVNewContentShow" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
            SelectCommand="SELECT [UserId], [ImageName], [Date], [ProfileName], [NumOfLikes] FROM [Cus_Upload] ORDER BY [Date] DESC, [NumOfLikes] DESC">
        </asp:SqlDataSource>
    </div>
</asp:Content>
