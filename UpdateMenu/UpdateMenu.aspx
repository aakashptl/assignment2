<%@ Page Language="VB" AutoEventWireup="false" CodeFile="UpdateMenu.aspx.vb" Inherits="WebPages_EntaWebCustom_UpdateMenu" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <asp:Literal id="headTemplate" runat="server"></asp:Literal>
</head>

<body>
    <asp:Literal id="headerTemplate" runat="server"></asp:Literal>
    <div class="page">
        <div class="limit-width">
            <article class="container-fluid">
                <div class="row">

                    <form id="form1" runat="server">

                        <section class="details">
                            <div class="BodyContent">
                                <H2>Update Menus</H2>
                                <b>With Preview</b><br><br>
                                Website: <asp:Label ID="lblWebsite" runat="server"></asp:Label><br>
                                <asp:Label ID="lblHead" runat="server"></asp:Label><br>
                                <asp:Label ID="lblHeader" runat="server"></asp:Label><br>
                                <asp:Label ID="lblFooter" runat="server"></asp:Label><br>
                                <br>
                                <asp:Button ID="btnUpdateContent" runat="server" Text="Update Content" />
                            </div>
                        </section>
                    </form>
                </div>
            </article>
        </div>
    </div>

    


    <asp:Literal id="footerTemplate" runat="server"></asp:Literal>
</body>

</html>