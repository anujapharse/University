<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="BatchSchedule.aspx.cs" Inherits="University.UI.MasterByTushar.BatchSchedule" %>

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
        .style5
        {
            width: 181px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentArea" runat="server">
    <h2>
        Manage Batch Schedule for Institute</h2>
    <br />
    <table>
        <strong>Add/ Update Batch Schedule for Institute</strong>
        <br />
        <tr>
            <td class="style1" colspan="2">
                Fields Marks as (*) are mandatory
            </td>
        </tr>
        <tr>
            <td class="style14">
            </td>
            <td class="style10">
                <asp:Label ID="lblid" runat="server" Text="" Visible="false"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="style16">
                Batch Name <span class="style2">*</span>
            </td>
            <td class="style9">
                <asp:DropDownList ID="ddlbatchid" runat="server" Width="180px">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="style16">
                Batch Day<span class="style2">*</span>
            </td>
            <td class="style9">
                <asp:DropDownList ID="ddldays" runat="server" Width="180px">
                    <asp:ListItem Value="--Select Day--">--Select Day--</asp:ListItem>
                    <asp:ListItem Value="Monday">Monday</asp:ListItem>
                    <asp:ListItem Value="Tuesday">Tuesday</asp:ListItem>
                    <asp:ListItem Value="Wednesday">Wednesday</asp:ListItem>
                    <asp:ListItem Value="Thursday">Thursday</asp:ListItem>
                    <asp:ListItem Value="Friday">Friday</asp:ListItem>
                    <asp:ListItem Value="Saturday">Saturday</asp:ListItem>
                    <asp:ListItem Value="Sunday">Sunday</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="style14">
                Start Time <span class="style2">*</span>
            </td>
            <td class="style10">
                <asp:TextBox ID="txtbx_starttime" runat="server" Width="180px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style14">
                End Time <span class="style2">*</span>
            </td>
            <td class="style10">
                <asp:TextBox ID="txtbx_endtime" runat="server" Width="180px"></asp:TextBox>
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
        <table class="style3">
            <tr>
                <td class="style5">
                    <asp:TextBox ID="txtsearch" runat="server" Width="180"></asp:TextBox>
                </td>
                <td>
                    <asp:Button ID="btnSearch" runat="server" CausesValidation="false" CssClass="btn btn-blue"
                        OnClick="btnSearch_Click" Text="Search" Width="100" />
                </td>
            </tr>
        </table>
        <table class="style3">
            <tr>
                <td>
                    <asp:GridView ID="grid_batchschedule" runat="server" AllowPaging="True" AllowSorting="True"
                        Font-Size="12px" Width="100%" AutoGenerateColumns="false" DataKeyNames="BatchScheduleID,CenterID,BatchID,BatchDay,BatchStartTime,BatchEndTime,CreatedBy,CreatedDate,CreatedIP,ModifiedBy,ModifiedDate,ModifiedIP,IsBitDeleted"
                        CellPadding="4" GridLines="None" ForeColor="#333333" 
                        onrowdeleting="grid_batchschedule_RowDeleting" 
                        onrowediting="grid_batchschedule_RowEditing">
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        <EmptyDataTemplate>
                            No results Found.</EmptyDataTemplate>
                        <Columns>
                            <asp:BoundField DataField="BatchScheduleID" HeaderText="ID" ItemStyle-Width="10px"
                                ItemStyle-Wrap="false" />
                            <asp:BoundField DataField="BatchID" HeaderText="Batch ID" ItemStyle-Width="50px"
                                ItemStyle-Wrap="false" />
                            <asp:BoundField DataField="BatchDay" HeaderText="Batch Day" ItemStyle-Width="50px"
                                ItemStyle-Wrap="false" />
                            <asp:BoundField DataField="BatchStartTime" HeaderText="Start Time" ItemStyle-Width="80px"
                                ItemStyle-Wrap="false" />
                            <asp:BoundField DataField="BatchEndTime" HeaderText="End Time" ItemStyle-Width="80px"
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
                        CssClass="pages" CurrentPageButtonClass="cpb" FirstPageText="First" LastPageText="Last" >
                    </webdiyer:AspNetPager>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
