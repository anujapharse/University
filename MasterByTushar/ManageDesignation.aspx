<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="ManageDesignation.aspx.cs" Inherits="University.UI.MasterByTushar.AddDesignation" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .style1
        {
            color: #996600;
            text-align: right;
        }
        .style2
        {
            color: #996600;
        }
        .style3
        {
            color: #CC3300;
        }
        .style4
        {
            width: 100%;
        }
        .style5
        {
            width: 185px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentArea" runat="server">
    <h2>
        Manage Designation for Employee's</h2>
    <div class="office">
        <table>
            <strong>Add Designation for Employees</strong>
            <tr>
                <td class="style1" colspan="2">
                    Fields Marks as (*) are mandatory
                </td>
            </tr>
            <tr>
                <td class="style14">
                    Department Name <span class="style3">*</span>
                </td>
                <td class="style10">
                    <asp:DropDownList ID="ddldept" runat="server">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="style14">
                    Post <span class="style2">*</span>
                </td>
                <td class="style10">
                    <asp:TextBox ID="txtbx_designation" runat="server" Width="180px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style16">
                    Work Profile(Area) <span class="style2">* </span>
                </td>
                <td class="style9">
                    <asp:TextBox ID="txtbx_area" runat="server" Width="180px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style14">
                    Job Description
                </td>
                <td class="style10">
                    <asp:TextBox ID="txtbx_jobdesc" runat="server" Width="180px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style14">
                    &nbsp;
                </td>
                <td class="style10">
                    <asp:Button ID="btn_submit" runat="server" Text="Submit" OnClick="btn_submit_Click" />
                    <asp:Button ID="btn_canel" runat="server" Text="Cancel" />
                </td>
            </tr>
            <tr>
                <td class="style14">
                    &nbsp;
                    <asp:Label ID="lbldid" runat="server" Text="" Visible="false"></asp:Label>
                </td>
                <td class="style10">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td class="style14" colspan="2">
                    <asp:Label ID="lblmsg" runat="server" Text="" Visible="false"></asp:Label>
                </td>
            </tr>
        </table>
        <div>
            <table class="style4">
                <tr>
                    <td class="style5">
                        <asp:TextBox ID="txtsearch" runat="server" Width="180"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Button ID="btnSearch" runat="server" Text="Search" Width="100" CssClass="btn btn-blue"
                            CausesValidation="false" OnClick="btnSearch_Click" />
                    </td>
                </tr>
            </table>
            <table class="style4">
                <tr>
                    <td>
                        <asp:GridView ID="grid_designation" runat="server" AllowSorting="True" Font-Size="12px"
                            Width="100%" AutoGenerateColumns="false" DataKeyNames="DID,DeptID,CenterID,DPost,DArea,DDescription,DCreatedby,DCreatedDate,DCreatedIP,DModifiedBy,DModifiedDate,DModifiedIP,IsBitDeleted"
                            CellPadding="4" GridLines="None" ForeColor="#333333" OnRowDeleting="grid_designation_RowDeleting"
                            OnRowEditing="grid_designation_RowEditing">
                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                            <Columns>
                                <asp:BoundField DataField="DID" HeaderText="ID" />
                                <asp:BoundField DataField="DPost" HeaderText="Post" />
                                <asp:BoundField DataField="DArea" HeaderText="Job Profile" />
                                <asp:BoundField DataField="DDescription" HeaderText="Job Description" />
                                <asp:TemplateField HeaderText="Edit">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnEdit" runat="server" CommandName="edit" class="mediumbluelink"
                                            CausesValidation="false"><img src="../Images/edit_icon.jpg"/></asp:LinkButton></ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Delete">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnDelete" runat="server" OnClientClick="return confirm('Are you sure you want to delete this Designation?');"
                                            CommandName="delete" CausesValidation="false" class="mediumbluelink"><img src="../Images/delete.png"/></asp:LinkButton></ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <EditRowStyle BackColor="#999999" />
                            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                            <SortedAscendingCellStyle BackColor="#E9E7E2" />
                            <SortedAscendingHeaderStyle BackColor="#506C8C" />
                            <SortedDescendingCellStyle BackColor="#FFFDF8" />
                            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                        </asp:GridView>
                    </td>
                </tr>
                <tr id="trPagger" runat="server" class="paggerRowStyle">
                    <td>
                        <webdiyer:AspNetPager ID="grdPagger" runat="server" PageIndexBoxType="DropDownList"
                            CssClass="pages" CurrentPageButtonClass="cpb" FirstPageText="First" LastPageText="Last"
                            OnPageChanged="grdPagger_PageChanged">
                        </webdiyer:AspNetPager>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>
