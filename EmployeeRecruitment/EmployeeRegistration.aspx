<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="EmployeeRegistration.aspx.cs" Inherits="University.UI.Management.FacultyRegistration" %>

<%@ Register Src="../UserControls/DatePicker.ascx" TagName="DatePicker" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .style3
        {
            width: 9%;
        }
        .style4
        {
            width: 16px;
        }
        .style6
        {
            width: 94px;
        }
        .style7
        {
            width: 112px;
        }
        .style9
        {
            width: 329px;
        }
        .style10
        {
            width: 196px;
        }
        .style14
        {
            width: 89px;
        }
        .style15
        {
            width: 7px;
        }
        .style16
        {
            width: 119px;
        }
        .style17
        {
            width: 184px;
        }
        .style18
        {
            width: 64px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentArea" runat="server">
    <div>
        <h2>
            Register New Employee</h2>
        <div class="office">
            <br />
            <table>
                <strong>Employee Details for office use only</strong>
                <tr>
                    <td class="style14">
                        Designation
                    </td>
                    <td class="style10">
                        <asp:DropDownList ID="ddl_designation" runat="server" Width="180px">
                            <asp:ListItem>--Select a Designation--</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td class="style15">
                        &nbsp;
                    </td>
                    <td class="style16">
                        Department
                    </td>
                    <td class="style9">
                        <asp:DropDownList ID="ddl_departmentid" runat="server" Width="180px">
                        </asp:DropDownList>
                    </td>
                    <td class="style15">
                        &nbsp;
                    </td>
                    <td class="style16">
                        Date of Joining
                    </td>
                    <td class="style9">
                        <uc1:DatePicker ID="DatePicker1" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td class="style14">
                        Job Type
                    </td>
                    <td class="style10">
                        <asp:DropDownList ID="ddl_jobtype" runat="server" Width="180px">
                            <asp:ListItem Text="--Select a Job Type--" Value="0"></asp:ListItem>
                            <asp:ListItem Text="Permanent" Value="1"></asp:ListItem>
                            <asp:ListItem Text="Contract" Value="2"></asp:ListItem>
                            <asp:ListItem Text="Internship" Value="3"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td class="style15">
                        &nbsp;
                    </td>
                    <td class="style16">
                        Recruitment Type
                    </td>
                    <td class="style9">
                        <asp:DropDownList ID="ddl_recruitmenttype" runat="server" Width="180px">
                            <asp:ListItem Value="--Select Recruitment Type--">--Select Recruitment Type--</asp:ListItem>
                            <asp:ListItem Value="Direct">Direct</asp:ListItem>
                            <asp:ListItem Value="Promotion">Promotion</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
            </table>
        </div>
        <div class="personal">
            <br />
            <table class="style1" align="center">
                <tr>
                    <td colspan="5" style="text-align: left">
                        <strong>Personal Details</strong>
                    </td>
                    <td style="text-align: left" class="style18">
                        &nbsp;
                    </td>
                    <td style="text-align: left" class="style6">
                        &nbsp;
                    </td>
                    <td style="text-align: left">
                        &nbsp;
                    </td>
                    <td style="text-align: left">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td class="style3">
                        First name
                    </td>
                    <td>
                        <asp:TextBox ID="txtbx_firstname" Width="190px" runat="server"></asp:TextBox>
                    </td>
                    <td class="style4">
                        &nbsp;
                    </td>
                    <td class="style7">
                        Middle Name
                    </td>
                    <td>
                        <asp:TextBox ID="txtbx_middlename" Width="190px" runat="server" Style="margin-left: 0px"></asp:TextBox>
                    </td>
                    <td class="style18">
                        &nbsp;
                    </td>
                    <td class="style6">
                        Last Name
                    </td>
                    <td>
                        <asp:TextBox ID="txtbx_lastname" Width="190px" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="style3">
                        Date of birth
                    </td>
                    <td>
                        <asp:TextBox ID="txt_dob" Width="190px" runat="server"></asp:TextBox>
                    </td>
                    <td class="style4">
                        &nbsp;
                    </td>
                    <td class="style7">
                        Gender
                    </td>
                    <td>
                        <asp:CheckBox ID="chkmale" runat="server" Text="Male" />
                        <asp:CheckBox ID="chkfemale" runat="server" Text="Female" />
                    </td>
                    <td class="style18">
                        &nbsp;
                    </td>
                    <td class="style6">
                        Nationality
                    </td>
                    <td>
                        <asp:TextBox ID="txtbx_Nationality" runat="server" Width="190px"></asp:TextBox>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td class="style3">
                        Religion
                    </td>
                    <td>
                        <asp:TextBox ID="txtbx_religion" Width="190px" runat="server"></asp:TextBox>
                    </td>
                    <td class="style4">
                        &nbsp;
                    </td>
                    <td class="style7">
                        Caste
                    </td>
                    <td>
                        <asp:TextBox ID="txtbx_caste" Width="190px" runat="server"></asp:TextBox>
                    </td>
                    <td class="style18">
                        &nbsp;
                    </td>
                    <td class="style6">
                        Contact No
                    </td>
                    <td>
                        <asp:TextBox ID="txtbx_contactno" Width="190px" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td class="style3">
                        Mobile No
                    </td>
                    <td>
                        <asp:TextBox ID="txtbx_Mobile" Width="190px" runat="server"></asp:TextBox>
                    </td>
                    <td class="style4">
                        &nbsp;
                    </td>
                    <td class="style7">
                        Email ID
                    </td>
                    <td>
                        <asp:TextBox ID="txtbx_email" Width="190px" runat="server"></asp:TextBox>
                    </td>
                    <td class="style18">
                        &nbsp;
                    </td>
                    <td class="style6">
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td class="style3">
                        Address
                    </td>
                    <td>
                        <asp:TextBox ID="txtbx_address" runat="server" Width="190px" TextMode="MultiLine"></asp:TextBox>
                    </td>
                    <td class="style4">
                        &nbsp;
                    </td>
                    <td class="style7">
                        Blood Group
                    </td>
                    <td>
                        <asp:DropDownList ID="ddl_bloodgroup" runat="server" Width="180px">
                            <asp:ListItem>--Select a Blood Group--</asp:ListItem>
                            <asp:ListItem>A+</asp:ListItem>
                            <asp:ListItem>B+</asp:ListItem>
                            <asp:ListItem>AB+</asp:ListItem>
                            <asp:ListItem>O+</asp:ListItem>
                            <asp:ListItem>A-</asp:ListItem>
                            <asp:ListItem>B-</asp:ListItem>
                            <asp:ListItem>AB-</asp:ListItem>
                            <asp:ListItem>0-</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td class="style18">
                        &nbsp;
                    </td>
                    <td class="style6">
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
        </div>
        <br />
        <div class="experience">
            <table>
                <tr>
                    <td class="style14">
                        &nbsp;
                    </td>
                    <td class="style10">
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
                            onclick="btn_submit_Click" style="height: 26px" />
                        <asp:Button ID="btn_cancel" runat="server" Text="Cancel" Style="float: right;" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>
