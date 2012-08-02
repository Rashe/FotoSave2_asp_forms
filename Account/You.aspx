<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="You.aspx.cs" Inherits="Account_You" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="contataer">
        <h2>Your Images</h2>
        <hr />
        <%-- Images Show--%>
        <asp:ListView ID="LVYouImageDisp" runat="server" DataSourceID="SqlDataFMYouImageDisp"
            ViewStateMode="Disabled" EnableViewState="False">
            <LayoutTemplate>
                <div id="container1" class="clearfix1">
                    <asp:PlaceHolder runat="server" ID="itemPlaceholder"></asp:PlaceHolder>
                </div>
                <br />
                <br />
                <hr />
                <div class="cus-image-marg">
                    <asp:DataPager ID="DataPager1" PageSize="15" runat="server">
                        <Fields>
                            <asp:NumericPagerField ButtonType="Button" CurrentPageLabelCssClass="btn btn-info"
                                NumericButtonCssClass="btn" />
                        </Fields>
                    </asp:DataPager>
                </div>
            </LayoutTemplate>
            <EmptyDataTemplate>
                <div class="cus-404-error">
                    <h3>You haven't uploaded Images yet</h3>
                    <br />
                    <asp:HyperLink ID="HyperLink1" runat="server" Font-Bold="True" Font-Size="X-Large"
                        NavigateUrl="~/Account/Upload.aspx">Upload</asp:HyperLink>
                </div>
            </EmptyDataTemplate>
            <ItemTemplate>
                <div class="box1 photo1 col1113">
                    <asp:HyperLink ID="HyImageLink" NavigateUrl='<%# GlobalFunc.GetImageLink( Eval("ImageName"))%>'
                        runat="server">
                        <asp:Image ID="Image1" ImageUrl='<%# GlobalFunc.GetImageUrl280( Eval("ImageName"))%>'
                            runat="server" />
                    </asp:HyperLink>
                </div>
            </ItemTemplate>
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
    </div>
    <asp:SqlDataSource ID="SqlDataFMYouImageDisp" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
        OnSelecting="SqlDataFMYouImageDisp_Selecting" SelectCommand="SELECT [UserId], [ImageId], [ImageName], [Date], [Folder], [ProfileName] FROM [Cus_Upload] WHERE ([UserId] = @UserId) ORDER BY [Date] DESC">
        <SelectParameters>
            <asp:Parameter Name="UserId" Type="Object" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
