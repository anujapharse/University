<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="ManageSubject.aspx.cs" Inherits="University.UI.MasterByTushar.ManageSubject" %>

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
            height: 26px;
        }
        .style4
        {
        }
        .style5
        {
            height: 26px;
            width: 129px;
        }
        .style6
        {
            width: 100%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentArea" runat="server">
    <h2>
        Manage Subjects available at the Institute</h2>
    <br />
    <table>
        <strong>Add New Subjects to Institute</strong>
        <br />
        <tr>
            <td class="style1" colspan="2">
                Fields Marks as (*) are mandatory
            </td>
        </tr>
        <tr>
            <td class="style4">
                Subject Name <span class="style2">*</span>
            </td>
            <td class="style10">
                <asp:TextBox ID="txtbx_subname" runat="server" Width="180px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style4">
                Subject Type <span class="style2">* </span>
            </td>
            <td class="style9">
                <asp:DropDownList ID="ddltype" runat="server" Width="180px">
                    <asp:ListItem Value="0">--Select Subject Type--</asp:ListItem>
                    <asp:ListItem Value="General">General</asp:ListItem>
                    <asp:ListItem Value="Lower Maths">Lower Maths</asp:ListItem>
                    <asp:ListItem Value="Lower Maths">Commerce</asp:ListItem>
                    <asp:ListItem Value="Arts">Arts</asp:ListItem>
                    <asp:ListItem Value="Science">Science</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="style5">
                Subject Language
            </td>
            <td class="style3">
                <asp:DropDownList ID="ddllang" runat="server" Width="180px">
                    <asp:ListItem Value="0">--Select Language--</asp:ListItem>
                    <asp:ListItem>English</asp:ListItem>
                    <asp:ListItem>Hindi</asp:ListItem>
                    <asp:ListItem>Marathi</asp:ListItem>
                    <asp:ListItem>Gujrathi</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="style4">
                Subject Description
            </td>
            <td class="style10">
                <asp:TextBox ID="txtbx_subdesc" runat="server" Width="180px" TextMode="MultiLine"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style4">
                &nbsp;
            </td>
            <td class="style10">
                <asp:Button ID="btn_submit" runat="server" Text="Submit" OnClick="btn_submit_Click" />
                <asp:Button ID="btn_canel" runat="server" Text="Cancel" />
            </td>
        </tr>
        <tr>
            <td class="style4">
                &nbsp;</td>
            <td class="style10">
                <asp:Label ID="lblsubid" runat="server" Text="" Visible="false"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="style4" colspan="2">
                <asp:Label ID="lblmsg" runat="server" Text="" Visible="false"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="style4">
                &nbsp;
            </td>
            <td class="style10">
                &nbsp;
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
                        CausesValidation="false" onclick="btnSearch_Click" />
                </td>
            </tr>
        </table>
        <table class="style6">
            <tr>
                <td>
                    <asp:GridView ID="grid_subject" runat="server" AllowSorting="True" Font-Size="12px"
                        Width="100%" AutoGenerateColumns="false" 
                        DataKeyNames="SubjectID,CenterID,SubjectName,SubjectType,SubjectLang,Description,CreatedBy,CreatedDate,CreatedIP,ModifiedBy,ModifiedDate,ModifiedIP,IsBitDeleted" 
                        CellPadding="4" GridLines="None"
                        ForeColor="#333333" onrowdeleting="grid_subject_RowDeleting" 
                        onrowediting="grid_subject_RowEditing">
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        <Columns>
                            <asp:BoundField DataField="SubjectID" HeaderText="ID" />
                            <asp:BoundField DataField="SubjectName" HeaderText="Subject Name" />
                            <asp:BoundField DataField="SubjectType" HeaderText="Subject Type" />
                            <asp:BoundField DataField="SubjectLang" HeaderText="Language" />
                            <asp:TemplateField HeaderText="Edit">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnEdit" runat="server" CommandName="edit" class="mediumbluelink"
                                        CausesValidation="false" ><img src="../Images/edit_icon.jpg"/></asp:LinkButton></ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Delete">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnDelete" runat="server" CommandName="delete" CausesValidation="false"
                                        class="mediumbluelink" OnClientClick="return confirm('Are you sure you want to delete this Designation?');" ><img src="../Images/delete.png"/></asp:LinkButton></ItemTemplate>
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
