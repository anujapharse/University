<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="ManagingCourseFees.aspx.cs" Inherits="University.UI.MasterByTushar.ManagingCourseFees" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
        .style2
        {
            width: 123px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentArea" runat="server">
    <h2>
        Managing Fees Deatils for Courses</h2>
    <br />
    <div>
        <div class="leftdiv">
            <fieldset>
                <legend>Fees Master</legend>
                <table class="style1">
                    <tr>
                        <td class="style2">
                            <asp:Label ID="lbl_feename" runat="server" Text="Fee Name"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtbx_feename" runat="server" Width="180px"></asp:TextBox>
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
                    <tr>
                        <td class="style2">
                            <asp:Label ID="lbl_feetype" runat="server" Text="Fee Type"></asp:Label>
                        </td>
                        <td>
                            <asp:RadioButton ID="rbtn_main" runat="server" Text="Main" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:RadioButton ID="rbtn_extras" runat="server" Text="Extras" />
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
                    <tr>
                        <td class="style2">
                            <asp:Label ID="lbl_feesdetails" runat="server" Text="Fee Details"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtbx_feedetails" runat="server" Width="180px" TextMode="MultiLine"></asp:TextBox>
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
                    <tr>
                        <td class="style2">
                            &nbsp;
                        </td>
                        <td>
                            <asp:Button ID="btn_Submit" runat="server" Text="Submit" />&nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:Button ID="btn_Reset" runat="server" Text="Reset" />
                        </td>
                    </tr>
                </table>
            </fieldset>
        </div>
        <div class="rightdiv">
            <fieldset style="width: 400px;">
                <legend>Adding Fees for Courses</legend>
                <table class="style1">
                    <tr>
                        <td class="style2">
                            <asp:Label ID="lbl_feeid" runat="server" Text="Fee ID"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddl_feeid" runat="server" Width="180px">
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
                    <tr>
                        <td class="style2">
                            <asp:Label ID="lbl_courseid" runat="server" Text="Course"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddl_courseid" runat="server" Width="180px">
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
                    <tr>
                        <td class="style2">
                            <asp:Label ID="lbl_batchid" runat="server" Text="Batch"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddl_batchid" runat="server" Width="180px">
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
                    <tr>
                        <td class="style2">
                            <asp:Label ID="lbl_fees" runat="server" Text="Fees"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddl_fees" runat="server" Width="180px">
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
                    <tr>
                        <td class="style2">
                            &nbsp;
                        </td>
                        <td>
                            <asp:Button ID="Button1" runat="server" Text="Submit" />&nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:Button ID="Button2" runat="server" Text="Reset" />
                        </td>
                    </tr>
                </table>
            </fieldset>
        </div>
    </div>
    <table class="style3">
        <tr>
            <td>
                <asp:GridView ID="grid_batchschedule" runat="server" AllowPaging="True" AllowSorting="True"
                    Font-Size="12px" Width="100%" AutoGenerateColumns="false" DataKeyNames="BatchScheduleID,CenterID,BatchID,BatchDay,BatchStartTime,BatchEndTime,CreatedBy,CreatedDate,CreatedIP,ModifiedBy,ModifiedDate,ModifiedIP,IsBitDeleted"
                    CellPadding="4" GridLines="None" ForeColor="#333333">
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
    </table>
</asp:Content>
