<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="ManageDepartments.aspx.cs" Inherits="University.UI.MasterByTushar.ManageDepartments" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
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
        .style8
        {
            text-align: right;
            color: #CC3300;
            width: 437px;
        }
        .style9
        {
            width: 7px;
        }
        .style10
        {
            width: 8px;
        }
        .style11
        {
            width: 437px;
        }
        .style12
        {
            width: 185px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentArea" runat="server">
    <h2>
        Manage Departments for Institute</h2>
    <br />
    <table>
        <strong>Add New Department to Institute</strong>
        <br />
        <tr>
            <td class="style1" colspan="2">
                Fields Marks as (*) are mandatory
            </td>
            <td class="style8">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td class="style14">
                DeptRoomID <span class="style2">*</span>
            </td>
            <td class="style10">
                <asp:TextBox ID="txtbx_roomid" runat="server" Width="180px"></asp:TextBox>
            </td>
            <td class="style11">
                <asp:RequiredFieldValidator ID="rfvroomid" runat="server" ControlToValidate="txtbx_roomid"
                    ErrorMessage="Please enter Room ID!" ForeColor="Red" ToolTip="Required Input"
                    SetFocusOnError="true" />
            </td>
        </tr>
        <tr>
            <td class="style14">
                Department Name <span class="style2">*</span>
            </td>
            <td class="style10">
                <asp:TextBox ID="txtbx_deptname" runat="server" Width="180px"></asp:TextBox>
            </td>
            <td class="style11">
                <asp:RequiredFieldValidator ID="rfvdeptname" runat="server" ControlToValidate="txtbx_deptname"
                    ErrorMessage="Please enter Department Name!" ForeColor="Red" ToolTip="Required Input"
                    SetFocusOnError="true" />
            </td>
        </tr>
        <tr>
            <td class="style16">
                Description <span class="style2"></span>
            </td>
            <td class="style9">
                <asp:TextBox ID="txtbx_desc" runat="server" TextMode="MultiLine"></asp:TextBox>
            </td>
            <td class="style11">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td class="style14">
                &nbsp;
            </td>
            <td class="style10">
                <asp:Button ID="btn_submit" runat="server" Text="Submit" CausesValidation="true"
                    OnClick="btn_submit_Click" />
                <asp:Button ID="btn_canel" runat="server" Text="Cancel" CausesValidation="false"
                    OnClick="btn_canel_Click" />
            </td>
            <td class="style11">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td class="style14">
                &nbsp;
                <asp:Label ID="lbldeptid" runat="server" Visible="False"></asp:Label>
            </td>
            <td class="style10">
                &nbsp;
            </td>
            <td class="style11">
                &nbsp;
                <asp:Label ID="lblcreator" runat="server" Visible="False"></asp:Label>
                <asp:Label ID="lblcreatedate" runat="server" Visible="False"></asp:Label>
                <asp:Label ID="lblCreateIP" runat="server" Visible="False"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="style14" colspan="2">
                <asp:Label ID="lblmsg" runat="server" Text=""></asp:Label>
            </td>
            <td class="style11">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td class="style14" colspan="2">
                &nbsp;</td>
            <td class="style11">
                &nbsp;</td>
        </tr>
    </table>
    <div>
        <table class="style3">
            <tr>
                <td class="style12">
                    <asp:TextBox ID="txtsearch" runat="server" Width="180"></asp:TextBox>
                </td>
                <td>
                    <asp:Button ID="btnSearch" runat="server" Text="Search" Width="100" CssClass="btn btn-blue"
                        OnClick="btnSearch_Click" CausesValidation="false" />
                </td>
            </tr>
        </table>
        <table cellspacing="0" width="100%">
            <tr>
                <td>
                    <asp:GridView ID="gvdept" runat="server" AllowSorting="True" Font-Size="12px" Width="100%"
                        AutoGenerateColumns="false" DataKeyNames="DeptID,DeptRoomID,DeptName,DeptDesc,CreatedBy,CreatedDate,CreatedIP,ModifiedBy,ModifiedDate,ModifiedIP,IsBitDeleted"
                        CellPadding="4" GridLines="None" ForeColor="#333333" OnRowEditing="gvdept_RowEditing"
                        OnRowDeleting="gvdept_RowDeleting">
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        <EmptyDataTemplate>
                            No results Found.</EmptyDataTemplate>
                        <Columns>
                            <asp:BoundField DataField="DeptID" HeaderText="Dept ID" ItemStyle-Width="20px" ItemStyle-Wrap="false" />
                            <asp:BoundField DataField="DeptRoomID" HeaderText="Dept RoomID" ItemStyle-Width="20px"
                                ItemStyle-Wrap="false" />
                            <asp:BoundField DataField="DeptName" HeaderText="Department Name" ItemStyle-Width="100px"
                                ItemStyle-Wrap="false" />
                            <asp:BoundField DataField="DeptDesc" HeaderText="Description" ItemStyle-Width="150px"
                                ItemStyle-Wrap="false" />
                            <asp:TemplateField HeaderText="Edit" ItemStyle-Width="40px" ItemStyle-Wrap="false">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnEdit" runat="server" CommandName="edit" class="mediumbluelink"
                                        CausesValidation="false"><img src="../Images/edit_icon.jpg"/>
                                    </asp:LinkButton></ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Delete" ItemStyle-Width="40px" ItemStyle-Wrap="false">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnDelete" runat="server" OnClientClick="return confirm('Are you sure you want to delete this BloodBank?');"
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
                    <tr id="trPagger" runat="server" class="paggerRowStyle">
                        <td>
                            <webdiyer:AspNetPager ID="grdPagger" runat="server" PageIndexBoxType="DropDownList"
                                CssClass="pages" CurrentPageButtonClass="cpb" FirstPageText="First" LastPageText="Last"
                                OnPageChanged="grdPagger_PageChanged">
                            </webdiyer:AspNetPager>
                        </td>
                    </tr>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
