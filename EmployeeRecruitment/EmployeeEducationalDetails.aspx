<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="EmployeeEducationalDetails.aspx.cs" Inherits="University.UI.EmployeeRecruitment.EmployeeEducationalDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
        .style2
        {
            width: 110px;
        }
        .style3
        {
            width: 225px;
        }
        .style4
        {
            width: 93px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentArea" runat="server">
    <div>
        <h2>
            Add Employee Employee Educational And Qualification Details</h2>
    </div>
    <table class="style1">
        <tr>
            <td class="style2">
                <asp:Label ID="lbl_employeeid" runat="server" Text="Employee ID"></asp:Label>
            </td>
            <td>
                <asp:DropDownList ID="ddl_employeeid" runat="server" Width="180px">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="style2">
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>
    <table class="style1">
        <tr>
            <td>
                <asp:Button ID="btn_Add" runat="server" Text="Add New Row" OnClick="btn_Add_Click" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="grid_employeeeducational" runat="server" ShowFooter="True" AutoGenerateColumns="False"
                    CellPadding="4" ForeColor="#333333" GridLines="None">
                    <Columns>
                        <asp:BoundField DataField="RowNumber" HeaderText="Sr.No" />
                        <asp:TemplateField HeaderText="Degree">
                            <ItemTemplate>
                                <asp:TextBox ID="txtbx_degree" runat="server" Text="<%# Bind ('Col1')%>"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Institute Name">
                            <ItemTemplate>
                                <asp:TextBox ID="txtbx_institutename" runat="server" Text="<%# Bind ('Col2')%>"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Year of Passing">
                            <ItemTemplate>
                                <asp:TextBox ID="txtbx_passingyear" runat="server" Text="<%# Bind ('Col3')%>"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Percentage">
                            <ItemTemplate>
                                <asp:TextBox ID="txtbx_percentage" runat="server" Text="<%# Bind ('Col4')%>"></asp:TextBox>
                            </ItemTemplate>
                            <FooterStyle HorizontalAlign="Right" />
                            <FooterTemplate>
                            </FooterTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <RowStyle BackColor="#EFF3FB" />
                    <EditRowStyle BackColor="#2461BF" />
                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <AlternatingRowStyle BackColor="White" />
                </asp:GridView>
            </td>
        </tr>
    </table>
    <br />
    <br />
    <div>
        <strong>Employee's experience details</strong>
    </div>
    <br />
    <table class="style1">
        <tr>
            <td class="style4">
                Total Experience
            </td>
            <td class="style3">
                <asp:TextBox ID="txtbx_totalexp" runat="server" Width="180px"></asp:TextBox>
            </td>
            <td class="style15">
                &nbsp;
            </td>
            <td class="style16">
                Last Job Profile
            </td>
            <td class="style17">
                <asp:DropDownList ID="ddl_jobprofile" runat="server" Width="180px">
                    <asp:ListItem>--Select a Profile--</asp:ListItem>
                    <asp:ListItem>Fresher</asp:ListItem>
                    <asp:ListItem>Faculty</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="style4">
                Previous Institute
            </td>
            <td class="style3">
                <asp:TextBox ID="txtbx_institute" runat="server" Width="180px"></asp:TextBox>
            </td>
            <td class="style15">
                &nbsp;
            </td>
            <td class="style16">
                Last Salary
            </td>
            <td class="style17">
                <asp:TextBox ID="txtbx_salary" runat="server" Width="180px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style4">
                &nbsp;
            </td>
            <td class="style3">
                &nbsp;
            </td>
            <td class="style15">
                &nbsp;
            </td>
            <td class="style16">
                &nbsp;
            </td>
            <td class="style17">
                <asp:Button ID="btn_submit" runat="server" Text="Submit" 
                    onclick="btn_submit_Click" />&nbsp;&nbsp;
                <asp:Button ID="btn_cancel" runat="server" Text="Cancel" />
            </td>
        </tr>
    </table>
</asp:Content>
