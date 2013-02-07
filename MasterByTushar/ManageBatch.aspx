<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="ManageBatch.aspx.cs" Inherits="University.UI.MasterByTushar.ManageBatch" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<%@ Register Src="../UserControls/DatePicker.ascx" TagName="DatePicker" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .style1
        {
            text-align: right;
            color: #CC3300;
        }
        .style2
        {
            color: #CC3300;
        }
        .style3
        {
            width: 100%;
        }
        .style4
        {
            text-align: right;
            width: 282px;
        }
        .style5
        {
            width: 425px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentArea" runat="server">
    <h2>
        Manage Batch for Institute</h2>
    <br />
    <table>
        <strong>Add/ Update Batch for Institute</strong>
        <br />
        <tr>
            <td class="style1" colspan="2">
                Fields Marks as (*) are mandatory
            </td>
        </tr>
        <tr>
            <td class="style14">
                &nbsp;
            </td>
            <td class="style10">
                <asp:Label ID="lblid" runat="server" Text="" Visible="false"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="style16">
                Batch Name <span class="style2"></span>
            </td>
            <td class="style9">
                <asp:TextBox ID="txtbx_batchname" runat="server" Width="180px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style14">
                Class Name <span class="style2">*</span>
            </td>
            <td class="style10">
                <asp:DropDownList ID="ddlclass" runat="server" Width="180px">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="style14">
                Course Name <span class="style2">*</span>
            </td>
            <td class="style10">
                <asp:DropDownList ID="ddlcourseid" runat="server" Width="180px">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="style14">
                Start Date
            </td>
            <td class="style10">
                <uc1:DatePicker ID="DatePicker1" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="style16">
                Description <span class="style2"></span>
            </td>
            <td class="style9">
                <asp:TextBox ID="txtbx_desc" runat="server" TextMode="MultiLine"></asp:TextBox>
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
            <td class="style14" colspan="2">
                <asp:Label ID="lblmsg" runat="server" Text=""></asp:Label>
            </td>
        </tr>
    </table>
    <div>
        <br />
        <br />
        <table class="style4">
            <tr>
                <td class="style5">
                    <asp:TextBox ID="txtsearch" runat="server" Width="180"></asp:TextBox>
                </td>
                <td>
                    <asp:Button ID="btnSearch" runat="server" Text="Search" Width="100" CssClass="btn btn-blue"
                        CausesValidation="false" onclick="btnSearch_Click" />
                </td>
            </tr>
        </table>
        <table class="style3">
            <tr>
                <td>
                    <asp:GridView ID="grid_batch" runat="server" AllowPaging="True" AllowSorting="True"
                        Font-Size="12px" Width="100%" AutoGenerateColumns="false" DataKeyNames="BatchID,CenterID,CourseID,BatchName,ClassID,StartDate,BDesc,CreatedBy,CreatedDate,CreatedIP,ModifiedBy,ModifiedDate,ModifiedIP,IsBitDeleted"
                        CellPadding="4" GridLines="None" ForeColor="#333333" 
                        onrowdeleting="grid_batch_RowDeleting" onrowediting="grid_batch_RowEditing">
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        <EmptyDataTemplate>
                            No results Found.</EmptyDataTemplate>
                        <Columns>
                            <asp:BoundField DataField="BatchID" HeaderText="Batch ID" ItemStyle-Width="10px"
                                ItemStyle-Wrap="false" />
                            <asp:BoundField DataField="BatchName" HeaderText="Batch Name" ItemStyle-Width="50px"
                                ItemStyle-Wrap="false" />
                            <asp:BoundField DataField="StartDate" HeaderText="Start Date" ItemStyle-Width="50px"
                                ItemStyle-Wrap="false" />
                            <asp:TemplateField HeaderText="Edit" ItemStyle-Width="40px" ItemStyle-Wrap="false">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnEdit" runat="server" CommandName="edit" class="mediumbluelink"
                                        CausesValidation="false"><img src="../Images/edit_icon.jpg"/>
                                    </asp:LinkButton></ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Delete" ItemStyle-Width="40px" ItemStyle-Wrap="false">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnDelete" runat="server" OnClientClick="return confirm('Are you sure you want to delete this record?');"
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
</asp:Content>
