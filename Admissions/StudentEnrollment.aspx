<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Default.Master" CodeBehind="StudentEnrollment.aspx.cs" Inherits="ASTM.Enrollment.StudentEnrollment" %>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
   


    <h3 align="center">
        Student Enrollment Form</h3>
        <br />
    <table style="width:100%;">
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:LinkButton ID="LinkButtonPersonal" runat="server" CssClass="comments" 
                    Width="180px" OnClick="LinkButtonPersonal_Click">Add Personal Details &gt;&gt;</asp:LinkButton>
            </td>
            <td>
                <asp:LinkButton ID="LinkButtonEdu" runat="server" CssClass="comments" 
                    Width="180px" OnClick="LinkButtonEdu_Click">Add Education Details &gt;&gt;</asp:LinkButton>
            </td>
            <td>
                <asp:LinkButton ID="LinkButtonPayment" runat="server" CssClass="comments" 
                    Width="180px" OnClick="LinkButtonPayment_Click">Add Payment Details &gt;&gt;</asp:LinkButton>
            </td>
            <td>
                <asp:LinkButton ID="LinkButtonContact" runat="server" CssClass="comments" 
                    Width="180px" OnClick="LinkButtonContact_Click">Add Contact Details &gt;&gt;</asp:LinkButton>
            </td>
        </tr>
    </table>
    <br />
        <asp:multiview ID="Application_Form_multiview" runat="server" 
        ActiveViewIndex="0">
        <asp:View ID="view_Gridview" runat="server">
            <asp:Button ID="ButtonNew" runat="server" CommandArgument="ViewModify" 
                CommandName="SwitchViewByID" CssClass="comments" onclick="ButtonNew_Click" 
                Text="New" />
            <br />
            <br />
            <asp:GridView ID="GridView_application_form" runat="server" 
                AutoGenerateColumns="False" DataSourceID="SqlDataSource1">
                    <Columns>
                        <asp:BoundField DataField="FirstName" HeaderText="Name" SortExpression="FirstName" />
                        <asp:BoundField DataField="RegistrationCode" HeaderText="RegistrationCode" 
                            SortExpression="RegistrationCode" />
                        <asp:BoundField DataField="Gender" HeaderText="Gender" 
                            SortExpression="Gender" />
                        <asp:BoundField DataField="Fees" HeaderText="Fees" SortExpression="Fees" /> 
                    </Columns>
                        <EmptyDataTemplate>
                                <div>
                                    No Records found.
                                </div>
                            </EmptyDataTemplate>
                            <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                            <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
                            <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
                            <sortedascendingcellstyle backcolor="#F7F7F7" />
                            <sortedascendingheaderstyle backcolor="#4B4B4B" />
                            <sorteddescendingcellstyle backcolor="#E5E5E5" />
                            <sorteddescendingheaderstyle backcolor="#242121" />
                    
            </asp:GridView>
             <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ASTMDBConnectionString %>" 
                SelectCommand="SELECT [FirstName], [RegistrationCode], [Gender], [Fees] FROM [StudentPersonalInformation]">
            </asp:SqlDataSource>
             <br />
            <asp:SqlDataSource ID="SqlDataSource6" runat="server"></asp:SqlDataSource>
             &nbsp
            <asp:Button ID="ButtonImportFromExcel" runat="server" Text="Import from Excel" 
                CssClass="comments" Width="200px" OnClick="ButtonImportFromExcel_Click" />
         </asp:View>
         <asp:View ID="ViewModify" runat="server">
        <table align="center">
        <tr><td colspan="4" align="left"> &nbsp;&nbsp;&nbsp;</td></tr>
            <tr>
                <td align="left" colspan="4">&nbsp;</td>
            </tr>
            <tr>
                <td align="left" colspan="4" style="width: 15%">Enquiry No:
                    <asp:TextBox ID="EnquiryNoTextBox" runat="server" 
                        ></asp:TextBox>
                    <asp:RequiredFieldValidator ID="EnquiryRequiredFieldValidator" runat="server" 
                        ControlToValidate="EnquiryNoTextBox" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                    &nbsp;
                    <asp:LinkButton ID="EnquiryLinkButton" runat="server" CausesValidation="false" 
                        OnClick="EnquiryLinkButton_Click">Select Enquiry</asp:LinkButton>
                    <br />
                    <asp:Panel ID="Panel1" runat="server" Visible="False">
                        <table style="width:100%;">
                            <tr>
                                <td class="auto-style1">&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="auto-style1">Center</td>
                                <td>
                                    <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" 
                                        OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                                        <asp:ListItem Value="1">ASTM-Bandra</asp:ListItem>
                                        <asp:ListItem Value="2">ASTM-Dadar</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="auto-style1" colspan="2">
                                    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" 
                                        DataKeyNames="StudentEnquiryID" DataSourceID="SqlDataSource4" 
                                        OnSelectedIndexChanged="GridView2_SelectedIndexChanged" AllowPaging="True" 
                                        AllowSorting="True">
                                        <Columns>
                                            <asp:CommandField ShowSelectButton="True" />
                                            <asp:BoundField DataField="StudentEnquiryID" HeaderText="ID" 
                                                InsertVisible="False" ReadOnly="True" SortExpression="StudentEnquiryID" />
                                            <asp:BoundField DataField="EnquiryDate" HeaderText="EnquiryDate" 
                                                SortExpression="EnquiryDate" />
                                            <asp:BoundField DataField="StudentName" HeaderText="StudentName" 
                                                SortExpression="StudentName" />
                                            <asp:BoundField DataField="MobileNo" HeaderText="MobileNo" 
                                                SortExpression="MobileNo" />
                                            <asp:BoundField DataField="EmailID" HeaderText="EmailID" 
                                                SortExpression="EmailID" />
                                            <asp:BoundField DataField="Courses" HeaderText="Courses" 
                                                SortExpression="Courses" />
                                            <asp:BoundField DataField="PreferredBatch" HeaderText="PreferredBatch" 
                                                SortExpression="PreferredBatch" />
                                            <asp:BoundField DataField="CounsellerName" HeaderText="CounsellerName" 
                                                SortExpression="CounsellerName" />
                                        </Columns>
                                    </asp:GridView>
                                    <asp:SqlDataSource ID="SqlDataSource4" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:ASTMDBConnectionString %>" 
                                        SelectCommand="SELECT * FROM [StudentEnquiry] WHERE ([CenterID] = @CenterID)">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="DropDownList1" Name="CenterID" 
                                                PropertyName="SelectedValue" Type="Int32" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </td>
                                <td>&nbsp;</td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td align="left">Student Registration Code
                    
                </td>
                <td  colspan="3">
                    <asp:TextBox ID="TextBoxRegCode" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="left" >Center:
                </td>
                <td colspan="3"><asp:DropDownList ID="DropDownListCenter" 
                        runat="server" DataSourceID="SqlDataSource2" DataTextField="TrainingCenterName" 
                        DataValueField="ID" Width="230px">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:ASTMDBConnectionString %>" 
                        SelectCommand="SELECT [TrainingCenterName], [ID] FROM [TrainingCenter]">
                    </asp:SqlDataSource></td>
            </tr>
            <tr>
                <td align="left" >Batch:
                </td>
                <td colspan="3">
                                        <asp:DropDownList ID="DropDownListBatch" runat="server" 
                        DataSourceID="SqlDataSource3" DataTextField="BatchName" DataValueField="ID" 
                        Width="230px">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:ASTMDBConnectionString %>" 
                        SelectCommand="SELECT [ID], [BatchName], [CenterID] FROM [Batch] WHERE ([CenterID] = @CenterID)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DropDownListCenter" Name="CenterID" 
                                PropertyName="SelectedValue" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>


                </td>
            </tr>
        <tr><td colspan="4" align="center"> <strong>PERSONAL DETAILS :</strong></td></tr>
        <tr>
        <td colspan="4">Title : 
            <asp:RadioButtonList ID="RadioButtonListTitle" runat="server" 
                RepeatDirection="Horizontal" RepeatLayout="Flow">
                <asp:ListItem>Mr</asp:ListItem>
                <asp:ListItem>Ms</asp:ListItem>
                <asp:ListItem>Mrs</asp:ListItem>
            </asp:RadioButtonList>
            </td>
  
        </tr>
        <tr><td>First Name :</td>
        <td><asp:TextBox ID="TextBoxFName" runat="server" Width="230px"></asp:TextBox></td>
        <td>Last Name :</td>
        <td><asp:TextBox ID="TextBoxLName" runat="server" Width="230px"></asp:TextBox></td>
        </tr>
        <tr>
        <td>Date Of Birth :</td>
        <td><asp:TextBox ID="TextBoxDOB" runat="server" Width="230px"></asp:TextBox></td>
        <td>Gender :</td>
        <td>
             <asp:RadioButtonList ID="CheckBoxListGender" runat="server" 
                 RepeatDirection="Horizontal" RepeatLayout="Flow">
                 <asp:ListItem  Text="Male" Value="Male"> </asp:ListItem>
                 <asp:ListItem Text="Female" Value="Female"></asp:ListItem>
             </asp:RadioButtonList>

        </tr>
        <tr>
        <td>Nationality :
        </td>
        <td><asp:DropDownList ID="DropDownListNationality" runat="server" Width="160px">
            <asp:ListItem>Indian</asp:ListItem>
            </asp:DropDownList>
        </td>
        <td>Caste :
        </td>
        <td><asp:DropDownList ID="DropDownListCaste" runat="server" Width="160px">
            <asp:ListItem>Open</asp:ListItem>
            <asp:ListItem>SC</asp:ListItem>
            <asp:ListItem>ST</asp:ListItem>
            </asp:DropDownList>
        </td>
        </tr>
            <tr>
        <td>Religion :
        </td>
        <td><asp:DropDownList ID="DropDownListReligion" runat="server" Width="160px">
            <asp:ListItem>Hindu</asp:ListItem>
            <asp:ListItem>Muslim</asp:ListItem>
            <asp:ListItem>Sikh</asp:ListItem>
            </asp:DropDownList>
        </td>
        <td>Handicapped :
        </td>
        <td>             <asp:CheckBoxList ID="CheckBoxListHandicaped" runat="server" 
                RepeatDirection="Horizontal">
                 <asp:ListItem  Text="Yes" Value="Y"> </asp:ListItem>
                 <asp:ListItem Text="No" Value="N"></asp:ListItem>
             </asp:CheckBoxList>

        </td>
        </tr>
              <tr>
                <td>Photo</td>
                <td>
                    <asp:FileUpload ID="FileUpload2" runat="server" />
                </td>
                <td>
                    <asp:Button ID="ButtonUpload" runat="server" OnClick="Button1_Click" 
                        Text="Upload Image" CssClass="comments" Height="38px" Width="120px" />
                </td>
                <td rowspan="7" valign="top">
                    <asp:Image ID="ImagePhoto" runat="server" Height="130px" Width="130px" 
                        GenerateEmptyAlternateText="True" />
                </td>
            </tr>
              <tr>
                  <td class="auto-style3"></td>
                  <td class="auto-style2">(*only image files jpg/gif/png)</td>
                  <td class="auto-style3">
                      <asp:Label ID="LabelFilePath" runat="server"></asp:Label>
                  </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
              <tr>
                <td colspan="4" align="center"><strong>REQUIRED DOCUMENTS</strong></td>
            </tr>
            <tr>
                <td>Document Name:</td>
                <td>
                    <asp:TextBox ID="TextBoxDocument" runat="server" Width="230px"></asp:TextBox>
                </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>Upload</td>
                <td>
                    <asp:FileUpload ID="FileUpload1" runat="server" />
                </td>
                <td>
                    <asp:Button ID="SaveButton0" runat="server" CssClass="comments" 
                        OnClick="SaveButton0_Click" Text="Add Document" Width="120px" />
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>
                    &nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>
                    <asp:DataList ID="DataList1" runat="server">
                        <ItemTemplate>
                            <asp:Label ID="LabelPath" runat="server" Text='<%# Bind("Path") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:DataList>
                </td>
                <td>&nbsp;</td>
                <td></td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>
                    &nbsp;</td>
                <td>
                    <asp:LinkButton ID="LinkButton2" runat="server" CssClass="comments" 
                        OnClick="LinkButton2_Click" Width="200px">Add Contact Details &gt;&gt;</asp:LinkButton>
                </td>
            </tr>
        </table>


     

    </asp:View>


            <asp:View ID="ViewContactDetail" runat="server">

                   <table align="center">
        <tr><td colspan="4" align="center"> CONTACT DETAILS :</td></tr>
        <tr>
        <td>Current Address :</td>
         <td>         
        <asp:TextBox ID="TextBoxCAddr" runat="server" TextMode="MultiLine" Width="160px" 
                Height="60px"></asp:TextBox></td>
           <td>Permanent Address :</td>
          <td>         
        <asp:TextBox ID="TextBoxPAddr" runat="server" TextMode="MultiLine" Width="160px" 
                Height="60px"></asp:TextBox></td>
        </tr>
        <tr>
        <td>Area :</td>
         <td>         
             <asp:TextBox ID="TextBoxCArea" runat="server" Width="160px"></asp:TextBox></td>
           <td>Area :</td>
          <td><asp:TextBox ID="TextBoxPArea" runat="server" Width="160px"></asp:TextBox></td>
        </tr>
        <tr>
        <td>City :</td>
         <td>         
        <asp:DropDownList ID="DropDownListCCity" runat="server" Width="160px">
            <asp:ListItem>Mumbai</asp:ListItem>
            </asp:DropDownList></td>
           <td>City :</td>
          <td>         
        <asp:DropDownList ID="DropDownListPCity" runat="server" Width="160px">
            <asp:ListItem>Mumbai</asp:ListItem>
            
            </asp:DropDownList></td>
        </tr>
         <tr>
        <td>State :</td>
         <td>         
             <asp:DropDownList ID="DropDownListCState" runat="server" Width="160px">
                 <asp:ListItem>Maharashtra</asp:ListItem>
            </asp:DropDownList></td>
           <td>State :</td>
          <td><asp:DropDownList ID="DropDownListPState" runat="server" Width="160px">
                               <asp:ListItem>Maharashtra</asp:ListItem>

            </asp:DropDownList></td>
        </tr>
         <tr>
        <td>Country :</td>
         <td>         
        <asp:DropDownList ID="DropDownListCCountry" runat="server" Width="160px">
                             <asp:ListItem>India</asp:ListItem>

            </asp:DropDownList></td>
           <td>Country :</td>
          <td>         
        <asp:DropDownList ID="DropDownListPCountry" runat="server" Width="160px">
                             <asp:ListItem>India</asp:ListItem>

            </asp:DropDownList></td>
        </tr>
         <tr>
        <td>Pincode :</td>
         <td>         
             <asp:TextBox ID="TextBoxCPin" runat="server"></asp:TextBox></td>
           <td>Pincode :</td>
          <td><asp:TextBox ID="TextBoxPPin" runat="server"></asp:TextBox></td>
        </tr>
        <tr>
        <td>Mobile No. :</td>
         <td>         
        <asp:TextBox ID="TextBoxCMob" runat="server"></asp:TextBox></td>
           <td>Landline No :</td>
          <td><asp:TextBox ID="TextBoxLandline" runat="server"></asp:TextBox></td>
        </tr>
        <tr>
        <td>Email Address :</td>
         <td>         
             <asp:TextBox ID="TextBoxEmail" runat="server"></asp:TextBox></td>
           <td></td>
          <td></td>
        </tr>
          
            <tr>
                <td valign="top">&nbsp;</td>
                <td>
                    &nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
          
                       <tr>
                           <td valign="top">&nbsp;</td>
                           <td>&nbsp;</td>
                           <td>
                               <asp:LinkButton ID="LinkButton3" runat="server" CssClass="comments" 
                                   OnClick="LinkButton3_Click" Width="200px">Add Education Details &gt;&gt;</asp:LinkButton>
                           </td>
                           <td>&nbsp;</td>
                       </tr>
          
            <tr>
                <td align="center" colspan="4">&nbsp;</td>
            </tr>
            
                            
        </table>
            </asp:View>

            <asp:View ID="ViewPayment" runat="server">


                <table align="center">
                    <tr>
                            <td align="center"><strong>COURSE DETAILS</strong></td>
                        </tr>
                        <tr>
                            <td>Course<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                                    DataKeyNames="ID" DataSourceID="SqlDataSource5" 
                                    OnSelectedIndexChanged="GridView1_SelectedIndexChanged" Width="100%">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                                    <asp:CheckBox ID="CheckModule" runat="server" AutoPostBack="true" 
                                                    OnCheckedChanged="CheckModule_CheckedChanged" />
                                        
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" 
                                        ReadOnly="True" SortExpression="ID" />
                                    <asp:BoundField DataField="CourseName" HeaderText="CourseName" 
                                        SortExpression="CourseName" />
                                    <asp:CheckBoxField DataField="Modular" HeaderText="Modular" 
                                        SortExpression="Modular" />
                                    <asp:BoundField DataField="FullTimeFees" HeaderText="Fees" 
                                        SortExpression="FullTimeFees" />
                                    <asp:BoundField DataField="Duration" HeaderText="Duration" 
                                        SortExpression="Duration" />
                                    <asp:BoundField DataField="PartTimeFees" HeaderText="PartTimeFees" 
                                        SortExpression="PartTimeFees" Visible="False" />
                                </Columns>
                                <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                                <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
                                <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
                                <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
                                <SortedAscendingCellStyle BackColor="#F7F7F7" />
                                <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
                                <SortedDescendingCellStyle BackColor="#E5E5E5" />
                                <SortedDescendingHeaderStyle BackColor="#242121" />
                                </asp:GridView>
                                <asp:SqlDataSource ID="SqlDataSource5" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:ASTMDBConnectionString %>" 
                                    
                                    SelectCommand="SELECT [CourseName], [ID], [Modular], [FullTimeFees], [PartTimeFees], [Duration] FROM [Course]">
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:GridView ID="GridViewModules" runat="server" AutoGenerateColumns="False">
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:CheckBox ID="CheckBoxModule" runat="server" AutoPostBack="true" 
                                                    OnCheckedChanged="CheckBoxModule_CheckedChanged" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="ModuleID" HeaderText="ID" />
                                        <asp:BoundField DataField="ModuleName" HeaderText="Module Name" />
                                        <asp:BoundField DataField="Fees" HeaderText="Fees" />
                                    </Columns>
                                    <EmptyDataTemplate>
                                        <div>
                                            No Records found.
                                        </div>
                                    </EmptyDataTemplate>
                                    <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                                    <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
                                    <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
                                    <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
                                    <SortedAscendingCellStyle BackColor="#F7F7F7" />
                                    <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
                                    <SortedDescendingCellStyle BackColor="#E5E5E5" />
                                    <SortedDescendingHeaderStyle BackColor="#242121" />
                                </asp:GridView>
                            </td>
                        </tr>
   



                    <tr>
                        <td align="center"><strong>PAYMENT DETAILS</strong></td>
                    </tr>
                    <tr>
                        <td>
                            <table align="center" style="width: 30%;">
                                <tr align="left">
                                    <td>Fees</td>
                                    <td>
                                        <asp:TextBox ID="TextBoxFees" runat="server" Text="0"></asp:TextBox>
                                    </td>
                                    <td nowrap="nowrap">&nbsp;</td>
                                    
                                </tr>
                                <tr align="left">
                                    <td class="auto-style1">Service Tax</td>
                                    <td class="auto-style1">
                                        <asp:TextBox ID="TextBoxserviceTax" runat="server" Text="12.5"></asp:TextBox>
                                    </td>
                                    <td class="auto-style1" nowrap="nowrap"></td>
                                    
                                </tr>
                                <tr align="left">
                                    <td>Discount (If any)</td>
                                    <td>
                                        <asp:TextBox ID="TextBoxFeesDiscount" runat="server"></asp:TextBox>
                                        <asp:Label ID="LabelSchemeAmt" runat="server"></asp:Label>
                                    </td>
                                    <td nowrap="nowrap">&nbsp;</td>
                                    
                                </tr>
                                <tr align="left">
                                    <td>Net Amount</td>
                                    <td>
                                        <asp:TextBox ID="TextBoxNetAmount" runat="server" Text="0"></asp:TextBox>
                                    </td>
                                    <td nowrap="nowrap">&nbsp;</td>
                                    
                                </tr>
                                <tr align="left">
                                    <td>
                                        <asp:Label ID="Label_AmountPaid" runat="server" Text="Amount Paid:"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TextBox_AmountPaid" runat="server" 
                                            OnTextChanged="TextBox_AmountPaid_TextChanged" AutoPostBack="True"></asp:TextBox>
                                    </td>
                                    <td nowrap="nowrap">&nbsp;</td>
                                    
                                </tr>
                                <tr align="left">
                                    <td nowrap="nowrap">
                                        <asp:Label ID="Label_ModeOfPayment0" runat="server" Text="Mode Of Payment:"></asp:Label>
                                    </td>
                                    <td nowrap="nowrap">
                                        <asp:RadioButtonList ID="CheckBoxList_PayMode" runat="server" RepeatDirection="Horizontal">
                                            <asp:ListItem Value="Cash" Text="Cash">

                                 </asp:ListItem>
                                            <asp:ListItem Value="Cheque" Text="Cheque/DD">

                                 </asp:ListItem>
                                            <asp:ListItem Value="Online" Text="Onine Transfer">

                                 </asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                    <td nowrap="nowrap">&nbsp;</td>
                                </tr>
                                <tr align="left">
                                    <td nowrap="nowrap">
                                        <asp:Label ID="Label_Cheque_DDNo" runat="server" Text="Cheque/DD No:"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TextBox_Cheque_DDNo" runat="server"></asp:TextBox>
                                    </td>
                                    <td>&nbsp;</td>
                                    
                                </tr>
                                <tr align="left">
                                    <td nowrap="nowrap">
                                        <asp:Label ID="Label_Dated" runat="server" Text="Dated:"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TextBox_Dated0" runat="server" Width="160px"></asp:TextBox>
                                    </td>
                                    <td>&nbsp;</td>
                                    
                                </tr>
                                <tr align="left">
                                    <td>
                                        <asp:Label ID="Label_BankName" runat="server" Text="Bank Name"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TextBox_BankName" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr align="left">
                                    <td>&nbsp;</td>
                                    <td><strong>EMI Details</strong></td>
                                </tr>
                                <tr align="left">
                                    <td colspan="2">
                                        <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False">
                                            <HeaderStyle />
                                            <Columns>
                                                <asp:TemplateField>
                                                    <HeaderTemplate>
                                                        Installment Date
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="TextboxInstallmentDate0" runat="server" 
                                                            Text='<%# Bind("IDate") %>'></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <HeaderTemplate>
                                                        Installment Amount
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="TextboxInstallmentAmount0" runat="server" 
                                                            Text='<%# Bind("IAmount") %>'></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <HeaderTemplate>
                                                        Due Date
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="TextboxDueDate0" runat="server" Text='<%# Bind("DueDate") %>'></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </td>
                                </tr>
                                <tr align="left">
                                    <td colspan="2">&nbsp;</td>
                                </tr>
                                <tr align="left">
                                    <td>&nbsp;</td>
                                    <td>
                                        <asp:Button ID="SaveButton" runat="server" CssClass="comments" 
                                            OnClick="SaveButton_Click" Text="Save" />
                                        <asp:Button ID="BackButton" runat="server" CssClass="comments" Text="Back" />
                                    </td>
                                </tr>
                                <tr align="left">
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                </tr>
                                <tr align="left">
                                    <td colspan="2">&nbsp;</td>
                                </tr>
                                <tr align="left">
                                    <td>&nbsp;</td>
                                    <td align="center">
                                        <asp:LinkButton ID="LinkButtonPrint" runat="server" Font-Size="Large" 
                                            OnClick="LinkButtonPrint_Click">Print Receipt</asp:LinkButton>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>


            </asp:View>
            <asp:View ID="ViewEducation" runat="server">
                <table>
                    <tr>
                <td align="center" colspan="4"><strong>EDUCATION DETAILS</strong></td>
            </tr>
                    <tr>
                        <td colspan="4">
                            <table align="center">
                                <tr>
                                    <td>Degree</td>
                                    <td>
                                        <asp:TextBox ID="TextBoxDegree1" runat="server"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TextBoxDegree2" runat="server"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TextBoxDegree3" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Institute Name</td>
                                    <td>
                                        <asp:TextBox ID="TextBoxCollege1" runat="server"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TextBoxCollege2" runat="server"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TextBoxCollege3" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>University</td>
                                    <td>
                                        <asp:TextBox ID="TextBoxUni1" runat="server"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TextBoxUni2" runat="server"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TextBoxUni3" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Passing Year</td>
                                    <td>
                                        <asp:TextBox ID="TextBoxPassyear1" runat="server"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TextBoxPassyear2" runat="server"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TextBoxPassyear3" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>% Obtained</td>
                                    <td>
                                        <asp:TextBox ID="TextBoxPerc1" runat="server"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TextBoxPerc2" runat="server"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TextBoxPerc3" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                </tr>
                                <tr>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>
                                        <asp:LinkButton ID="LinkButton4" runat="server" CssClass="comments" 
                                            OnClick="LinkButton4_Click" Width="200px">Add Payment Details &gt;&gt;</asp:LinkButton>
                                    </td>
                                    <td>&nbsp;</td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    </table>
            </asp:View>
    </asp:multiview>
    

</asp:Content>
<asp:Content ID="Content1" runat="server" contentplaceholderid="head">
    </asp:Content>
