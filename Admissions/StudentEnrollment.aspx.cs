using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Data.OleDb;
using System.IO;
namespace ASTM.Enrollment
{
    public partial class StudentEnrollment : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ASTMDBConnectionString"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // get scheme details
                getscheme();

                LinkButtonContact.Visible = false;
                LinkButtonPayment.Visible = false;
                LinkButtonPersonal.Visible = false;
                LinkButtonEdu.Visible = false;


                if (Request.QueryString["EnquiryID"] != null)
                {
                    EnquiryNoTextBox.Text = Request.QueryString["EnquiryID"].ToString();
                }
                else
                    EnquiryNoTextBox.Text = "";
            }
        }

        public void getscheme()
        {
            try
            {
                //or CourseID=" +  + " and 
                DataTable dt = new DataTable();
                //            int centerid = Convert.ToInt32(DropDownListCenter.SelectedValue);
                string query = "Select * from Scheme where '" + System.DateTime.Now.ToString("MM-dd-yyyy") + "'  between FromDate and Todate";
                SqlCommand cmd = new SqlCommand(query, con);

                if (con.State == ConnectionState.Closed)
                    con.Open();

                SqlDataReader dr = cmd.ExecuteReader();
                if (dr != null && dr.Read())
                {
                    decimal perc = Convert.ToDecimal(dr["DiscountPerc"]);
                    decimal amt = Convert.ToDecimal(dr["DiscountAmount"]);

                    if (amt > 0)
                        TextBoxFeesDiscount.Text = amt.ToString();
                    else
                    {
                        TextBoxFeesDiscount.Text = perc.ToString();
                        LabelSchemeAmt.Text = "%";
                    }
                }
                dr.Close();
            }
            catch (Exception ex)
            { }

            finally
            {

                con.Close();
            }

        }

        protected void ButtonNew_Click(object sender, EventArgs e)
        {
            Application_Form_multiview.SetActiveView(ViewModify);
            TextBoxRegCode.Text = generatestudentcode();

            LinkButtonContact.Visible = true;
            LinkButtonPayment.Visible = true;
            LinkButtonPersonal.Visible = true;
            LinkButtonEdu.Visible = true;

        }

        public string generatestudentcode()
        {
            string regcode = "";
            string query = "select RegistrationCode from StudentPersonalInformation where ID =(select Max(ID) from StudentPersonalInformation)";
            try
            {
                SqlCommand cmd = new SqlCommand(query, con);

                if (con.State == ConnectionState.Closed)
                    con.Open();

                if (cmd.ExecuteScalar() != null)
                {
                    //regcode = cmd.ExecuteScalar().ToString();
                    //regcode= regcode.Substring(0,regcode.LastIndexOf('/')-1) + Convert.ToInt32(regcode.Substring(regcode.LastIndexOf('/'), (regcode.Length - (regcode.LastIndexOf('/'))) + 1)) +1;
                    regcode = (Convert.ToInt32(cmd.ExecuteScalar()) + 1).ToString();
                }
                else
                    regcode = "1";
//                    regcode = "ASTM/" + DropDownListCenter.SelectedValue + "/" + DateTime.Now.Year + "/1";

                //                regcode = "ASTM/" + DropDownListCenter.Items[0].Text + "/" + DropDownListCourse.SelectedValue + "/" + DateTime.Now.Year + "/1";

            }
            catch (Exception ex)
            { }
            finally
            {
                con.Close();
            }
            return regcode;

        }

        protected void ButtonImportFromExcel_Click(object sender, EventArgs e)
        {
            ReadExcel("c:\\urvi\\Lisha\\Excel.xslx");
        }

        public void ReadExcel(string filePath)
        {
            DataTable table = new DataTable();
            string strConn = string.Format("Provider=Microsoft.ACE.OLEDB.12.0;Data Source={0};Extended Properties=\"Excel 12.0 Xml;HDR=YES;IMEX=1;TypeGuessRows=0;ImportMixedTypes=Text\"", filePath);
            using (OleDbConnection dbConnection = new OleDbConnection(strConn))
            {
                using (OleDbDataAdapter dbAdapter = new OleDbDataAdapter("SELECT * FROM [Sheet1$]", dbConnection)) //rename sheet if required!
                    dbAdapter.Fill(table);
                int rows = table.Rows.Count;
            }


        }

        protected void DropDownListCourse_SelectedIndexChanged(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand("SELECT Fees FROM Course", con); //rename sheet if required!
            decimal fees = Convert.ToDecimal(cmd.ExecuteScalar());
            TextBoxFees.Text = fees.ToString();
        }

        protected void checkboxCourse_SelectedIndexChanged(object sender, EventArgs e)
        {
            // open modules if its modular
        }


        // On click of this button, student image will be uploaded

        protected void SaveButton_Click(object sender, EventArgs e)
        {
            // call SP
            try
            {
                SqlCommand cmdproc = new SqlCommand("InsertStudent", con);
                cmdproc.CommandType = CommandType.StoredProcedure;      

                if (con.State == ConnectionState.Closed)
                    con.Open();
            
                //PERSONAL
                if(TextBoxRegCode.Text != "")
                    cmdproc.Parameters.AddWithValue("@RegistrationCode", TextBoxRegCode.Text);
                else return;
                
                cmdproc.Parameters.AddWithValue("@Title", RadioButtonListTitle.SelectedValue);
                cmdproc.Parameters.AddWithValue("@FirstName", TextBoxFName.Text);
                cmdproc.Parameters.AddWithValue("@LastName", TextBoxLName.Text);
                cmdproc.Parameters.AddWithValue("@DateOfBirth", TextBoxDOB.Text);
                cmdproc.Parameters.AddWithValue("@Gender", CheckBoxListGender.SelectedValue);
                cmdproc.Parameters.AddWithValue("@Phone ", "");
                cmdproc.Parameters.AddWithValue("@Nationality ", DropDownListNationality.SelectedValue);
                cmdproc.Parameters.AddWithValue("@Photo ", LabelFilePath.Text);
                cmdproc.Parameters.AddWithValue("@Caste ", DropDownListCaste.SelectedValue);
                cmdproc.Parameters.AddWithValue("@Religion ", DropDownListReligion.SelectedValue);
                cmdproc.Parameters.AddWithValue("@ApplicableFee ", 0);
                //cmdproc.Parameters.AddWithValue("@AdmissionNumber", 0);

                // CONTACT
                cmdproc.Parameters.AddWithValue("@CurrentAddress", TextBoxCAddr.Text);
                cmdproc.Parameters.AddWithValue("@PermenantAddress ", TextBoxPAddr.Text);
                cmdproc.Parameters.AddWithValue("@CurrentArea", TextBoxCArea.Text);
                cmdproc.Parameters.AddWithValue("@CurrentCity", DropDownListCCity.SelectedValue);
                cmdproc.Parameters.AddWithValue("@CurrentState", DropDownListCState.SelectedValue);
                cmdproc.Parameters.AddWithValue("@CurrentCountry", DropDownListCCountry.SelectedValue);
                cmdproc.Parameters.AddWithValue("@CurrentPinCode", TextBoxCPin.Text);
                cmdproc.Parameters.AddWithValue("@MobileNo", TextBoxCMob.Text);
                cmdproc.Parameters.AddWithValue("@Email", TextBoxEmail.Text);
                cmdproc.Parameters.AddWithValue("@PermenantArea", TextBoxPArea.Text);
                cmdproc.Parameters.AddWithValue("@PermenantCity", DropDownListPCity.SelectedValue);
                cmdproc.Parameters.AddWithValue("@PermenantState", DropDownListPState.SelectedValue);
                cmdproc.Parameters.AddWithValue("@PermenantCountry", DropDownListPCountry.SelectedValue);
                cmdproc.Parameters.AddWithValue("@PermenantPinCode", TextBoxPPin.Text);
                cmdproc.Parameters.AddWithValue("@Landline", TextBoxLandline.Text);

                //EDUCATIONAL
                cmdproc.Parameters.AddWithValue("@Degree", TextBoxDegree1.Text);
                cmdproc.Parameters.AddWithValue("@InstituteName", TextBoxCollege1.Text);
                cmdproc.Parameters.AddWithValue("@UniversityName", TextBoxUni1.Text);
                cmdproc.Parameters.AddWithValue("@Passyear", TextBoxPassyear1.Text);
                cmdproc.Parameters.AddWithValue("@Percentage", TextBoxPerc1.Text);
                cmdproc.Parameters.AddWithValue("@Degree1", TextBoxDegree2.Text);
                cmdproc.Parameters.AddWithValue("@InstituteName1", TextBoxCollege2.Text);
                cmdproc.Parameters.AddWithValue("@UniversityName1", TextBoxUni2.Text);
                cmdproc.Parameters.AddWithValue("@Passyear1", TextBoxPassyear2.Text);
                cmdproc.Parameters.AddWithValue("@Percentage1", TextBoxPerc2.Text);
                cmdproc.Parameters.AddWithValue("@Degree2", TextBoxDegree3.Text);
                cmdproc.Parameters.AddWithValue("@InstituteName2", TextBoxCollege3.Text);
                cmdproc.Parameters.AddWithValue("@UniversityName2", TextBoxUni3.Text);
                cmdproc.Parameters.AddWithValue("@Passyear2", TextBoxPassyear3.Text);
                cmdproc.Parameters.AddWithValue("@Percentage2", TextBoxPerc3.Text);

                // add first payment details

                cmdproc.Parameters.AddWithValue("@Fees", TextBoxFees.Text);
                cmdproc.Parameters.AddWithValue("@ServiceTax", TextBoxserviceTax.Text);
                cmdproc.Parameters.AddWithValue("@Discount", TextBoxFeesDiscount.Text);
                cmdproc.Parameters.AddWithValue("@Netamount", TextBoxNetAmount.Text);
                cmdproc.Parameters.AddWithValue("@NoOfInstallments", GridView2.Rows.Count);
                cmdproc.Parameters.AddWithValue("@Type", 'D');
                cmdproc.Parameters.AddWithValue("@PaymentDate", System.DateTime.Now);
                cmdproc.Parameters.AddWithValue("@DueDate", DBNull.Value);
                cmdproc.Parameters.AddWithValue("@PaymentStatus", 'P');
                cmdproc.Parameters.AddWithValue("@PaymentMode", CheckBoxList_PayMode.SelectedValue);
                cmdproc.Parameters.AddWithValue("@Bank", TextBox_BankName.Text);
                cmdproc.Parameters.AddWithValue("@ChequeDraftNo ", TextBox_Cheque_DDNo.Text);
                cmdproc.Parameters.AddWithValue("@ChecqueDraftDate", TextBox_Dated0.Text);

                cmdproc.Parameters.AddWithValue("@ModificationType", "Insert");
                cmdproc.Parameters.AddWithValue("@ModifiedBy ", Session["UserName"].ToString());
                cmdproc.Parameters.AddWithValue("@ModifiedDate", System.DateTime.Now);
                cmdproc.Parameters.AddWithValue("@Student_ID", TextBoxRegCode.Text);
                cmdproc.Parameters.AddWithValue("@InquiryID", EnquiryNoTextBox.Text);

                cmdproc.ExecuteNonQuery();


                // CHECK HOW TO ADD GRID HERE 
                // add grid payment 

                SqlCommand cmd1;
                for (int i = 0; i <= GridView3.Rows.Count - 1; i++)
                {

                    cmd1 = new SqlCommand();

                    cmd1.Parameters.AddWithValue("@Fees", ((TextBox)GridView2.Rows[i].FindControl("TextboxInstallmentAmount")).Text);
                    cmd1.Parameters.AddWithValue("@ServiceTax", 0);
                    cmd1.Parameters.AddWithValue("@Discount", 0);
                    cmd1.Parameters.AddWithValue("@Netamount", ((TextBox)GridView3.Rows[i].FindControl("TextboxInstallmentAmount")).Text);
                    cmd1.Parameters.AddWithValue("@NoOfInstallments", GridView2.Rows.Count);
                    cmd1.Parameters.AddWithValue("@PaidAmount", 0);
                    cmd1.Parameters.AddWithValue("@Type", 'I');
                    cmd1.Parameters.AddWithValue("@PaymentDate", ((TextBox)GridView3.Rows[i].FindControl("TextboxInstallmentDate")).Text);
                    cmd1.Parameters.AddWithValue("@DueDate", ((TextBox)GridView3.Rows[i].FindControl("TextboxDueDate")).Text);
                    cmd1.Parameters.AddWithValue("@PaymentStatus", 'U');
                    cmd1.Parameters.AddWithValue("@PaymentMode", "");
                    cmd1.Parameters.AddWithValue("@Bank", "");
                    cmd1.Parameters.AddWithValue("@ChequeDraftNo ", "");
                    cmd1.Parameters.AddWithValue("@ChecqueDraftDate", "");
                    cmd1.Parameters.AddWithValue("@ModificationType", "Insert");
                    cmd1.Parameters.AddWithValue("@ModifiedBy ", Session["UserName"].ToString());
                    cmd1.Parameters.AddWithValue("@ModifiedDate", System.DateTime.Now);

                    cmd1.ExecuteNonQuery();

                }

                SqlCommand cmd2;

                for (int i = 0; i <= GridView1.Rows.Count - 1; i++)
                {
                    cmd2 = new SqlCommand();

                    cmd2.Parameters.AddWithValue("@StudentID", TextBoxRegCode.Text);
                    cmd2.Parameters.AddWithValue("@CourseID", DataList1.Items[i].DataItem.ToString());
                    cmd2.Parameters.AddWithValue("@BatchID", DropDownListBatch.SelectedValue);
                    cmd2.Parameters.AddWithValue("@ModificationType", "Insert");
                    cmd2.Parameters.AddWithValue("@ModifiedBy", Session["UserName"].ToString());
                    cmd2.Parameters.AddWithValue("@ModifiedDate", System.DateTime.Now);

                    cmd2.ExecuteNonQuery();
                }


                SqlCommand cmd3;
                for (int i = 0; i <= DataList1.Items.Count - 1; i++)
                {
                    cmd3 = new SqlCommand();

                    cmd3.Parameters.AddWithValue("@StudentID", TextBoxRegCode.Text);
                    cmd3.Parameters.AddWithValue("@DocumentName", TextBoxDocument.Text);
                    cmd3.Parameters.AddWithValue("@DocumentPath", DataList1.Items[i].DataItem.ToString());
                    cmd3.Parameters.AddWithValue("@ModificationType", "Insert");
                    cmd3.Parameters.AddWithValue("@ModifiedBy", Session["UserName"].ToString());
                    cmd3.Parameters.AddWithValue("@ModifiedDate", System.DateTime.Now);

                    cmd3.ExecuteNonQuery();
                }

            }
            catch (Exception ex)
            {

            }
            finally
            {
                con.Close();
            }
        }

        protected void SaveButton0_Click(object sender, EventArgs e)
        {
            DataTable dt = new DataTable(); ;
            if (ViewState["List"] != null)
                dt = (DataTable)ViewState["List"];
            else
            {
                dt.Columns.Add("Path");
            }
            DataRow dr;
            dr = dt.NewRow();
            dr["Path"] = FileUpload1.FileName;
            dt.Rows.Add(dr);

            DataList1.DataSource = dt;
            DataList1.DataBind();

            ViewState["List"] = dt;
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            //// if selected, check  is modular or not... if yes, then open modules... if no then select fees
            //CheckBox chk=((CheckBox)GridView1.SelectedRow.Cells[3].Controls[0]);
            //if (chk.Checked == true)
            //{
            //    SqlCommand cmd = new SqlCommand("Select ModuleName from Modules where CourseID=" + GridView1.SelectedRow.Cells[1].Text);


            //}
        }

        protected void CheckModule_CheckedChanged(object sender, EventArgs e)
        {
            try
            {
                TextBoxFees.Text="0";
                for (int i = 0; i <= GridView1.Rows.Count - 1; i++)
                {

                    CheckBox chkmodular = ((CheckBox)GridView1.Rows[i].Cells[3].Controls[0]);
                    CheckBox chkCourse = ((CheckBox)GridView1.Rows[i].FindControl("CheckModule"));
                    if (chkCourse.Checked == true)
                    {
                        if (chkmodular.Checked == true)
                        {
                            DataTable dt = new DataTable();
                            SqlCommand cmd = new SqlCommand("Select * from Module where CourseID=" + GridView1.Rows[i].Cells[1].Text, con);
                            SqlDataAdapter da = new SqlDataAdapter(cmd);
                            da.Fill(dt);

                            GridViewModules.DataSource = dt;
                            GridViewModules.DataBind();
                        }
                        else
                        {
                            TextBoxFees.Text = (Convert.ToDouble(TextBoxFees.Text) + Convert.ToDouble(GridView1.Rows[i].Cells[4].Text.Trim())).ToString();
                        }
                    }
         

                    if (LabelSchemeAmt.Text == "%")
                    {
                        //CALCULATE NET AMOUNT
                        int fees = Convert.ToInt32(TextBoxFees.Text);
                        double tax = 0.125;
                        double discount = Convert.ToDouble(TextBoxFeesDiscount.Text);
                        int netamount = Convert.ToInt32((fees + (fees * tax)) - (fees * discount));
                        TextBoxNetAmount.Text = netamount.ToString();
                    }
                    else
                    {
                        if (TextBoxFeesDiscount.Text != "" && (Convert.ToInt32(TextBoxFeesDiscount.Text)) > 0)
                        {
                            int fees = Convert.ToInt32(TextBoxFees.Text);
                            double tax = 0.125;
                            double discount = Convert.ToDouble(TextBoxFeesDiscount.Text);
                            int netamount = Convert.ToInt32((fees + (fees * tax)) - discount);
                            TextBoxNetAmount.Text = netamount.ToString();
                        }
                    }

                }
            }
            catch (Exception ex)
            { 
            }
            finally { 
            
            }
        }

        protected void CheckBoxModule_CheckedChanged(object sender, EventArgs e)
        {
            try
            {
               string currentfees=TextBoxFees.Text;
                for (int i = 0; i <= GridViewModules.Rows.Count - 1; i++)
                {

                   // CheckBox chkmodular = ((CheckBox)GridViewModules.Rows[i].Cells[3].Controls[0]);
                    CheckBox chkCourse = ((CheckBox)GridViewModules.Rows[i].FindControl("CheckBoxModule"));
                    if (chkCourse.Checked == true)
                    {
                        TextBoxFees.Text = (Convert.ToDouble(currentfees) + Convert.ToDouble(GridViewModules.Rows[i].Cells[3].Text.Trim())).ToString();
                    }

                    if (LabelSchemeAmt.Text == "%")
                    {
                        //CALCULATE NET AMOUNT
                        int fees = Convert.ToInt32(TextBoxFees.Text);
                        double tax = 0.125;
                        double discount = Convert.ToDouble(TextBoxFeesDiscount.Text);
                        int netamount = Convert.ToInt32((fees + (fees * tax)) - (fees * discount));
                        TextBoxNetAmount.Text = netamount.ToString();
                    }
                    else
                    {
                        if (TextBoxFeesDiscount.Text != "" && (Convert.ToInt32(TextBoxFeesDiscount.Text)) > 0)
                        {
                            int fees = Convert.ToInt32(TextBoxFees.Text);
                            double tax = 0.125;
                            double discount = Convert.ToDouble(TextBoxFeesDiscount.Text);
                            int netamount = Convert.ToInt32((fees + (fees * tax)) - discount);
                            TextBoxNetAmount.Text = netamount.ToString();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
            }
            finally
            {

            }

        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Application_Form_multiview.SetActiveView(ViewContactDetail);

        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            Application_Form_multiview.SetActiveView(ViewEducation);
        }

        protected void LinkButton4_Click(object sender, EventArgs e)
        {
            Application_Form_multiview.SetActiveView(ViewPayment);
        }

        protected void EnquiryLinkButton_Click(object sender, EventArgs e)
        {
            Panel1.Visible = true;
            GridView3.DataBind();
        }

        protected void GridView2_SelectedIndexChanged(object sender, EventArgs e)
        {
            EnquiryNoTextBox.ReadOnly = false;
            EnquiryNoTextBox.Text = GridView2.SelectedRow.Cells[1].Text;
            Panel1.Visible = false;
            string name = GridView2.SelectedRow.Cells[3].Text;

            if (name.Contains(' '))
            {
                TextBoxFName.Text = name.Substring(0, name.IndexOf(' '));
                TextBoxLName.Text = name.Substring(name.IndexOf(' ') - 1, name.Length - name.IndexOf(' '));
            }
            else
                TextBoxFName.Text = name;

            TextBoxCMob.Text = GridView2.SelectedRow.Cells[4].Text;
            TextBoxEmail.Text = GridView2.SelectedRow.Cells[5].Text;

            //DropDownListBatch.Items.FindByValue(GridView2.SelectedRow.Cells[7].Text).Selected = true;
          //  DropDownListc.Items.FindByValue(GridView2.SelectedRow.Cells[6].Text).Selected = true;

        }


        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridView3.DataBind();
        }

        protected void LinkButtonPersonal_Click(object sender, EventArgs e)
        {
            Application_Form_multiview.SetActiveView(ViewModify);
        }

        protected void LinkButtonEdu_Click(object sender, EventArgs e)
        {
            Application_Form_multiview.SetActiveView(ViewEducation);
        }

        protected void LinkButtonPayment_Click(object sender, EventArgs e)
        {
            Application_Form_multiview.SetActiveView(ViewPayment);
        }

        protected void LinkButtonContact_Click(object sender, EventArgs e)
        {
            Application_Form_multiview.SetActiveView(ViewContactDetail);
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            

            string filecontent = "", filename = "", newfile = "";
            if (FileUpload2.HasFile)
            {

                filename = Server.MapPath(FileUpload2.FileName);
                newfile = FileUpload2.PostedFile.FileName;
                //                filecontent = System.IO.File.ReadAllText(filename);
            }

            FileInfo fi = new FileInfo(newfile);
            string ext = fi.Extension;

            // check folder exist or not
            if (!System.IO.Directory.Exists(@"~\images\studentphoto"))
            {
                try
                {

                    string path = Server.MapPath(@"~\Images");
                    System.IO.Directory.CreateDirectory(path + @"\studentphoto");
                    FileUpload2.SaveAs(path + @"\studentphoto\" + TextBoxRegCode.Text  +ext);

                    ImagePhoto.ImageUrl = @"~\Images\studentphoto\" + newfile;
                    ImagePhoto.Visible = true;
                    //System.IO.File.Create(@"~\images\studentphoto\" + filename);
                    //System.IO.File.WriteAllText(@"~\images\studentphoto\" + newfile + ".jpg", filecontent);
                    LabelFilePath.Text = ImagePhoto.ImageUrl;

                }
                catch (Exception ex)
                {
                    LabelFilePath.Text = "Not able to create new directory";
                }
            }
        }

        protected void TextBox_AmountPaid_TextChanged(object sender, EventArgs e)
        {
            if (TextBox_AmountPaid != null)
            {
                int amount = Convert.ToInt32(TextBox_AmountPaid.Text);
                int netamt = Convert.ToInt32(TextBoxNetAmount.Text);
                int duration;
                int maxduration = 0;
                if (netamt - amount > 0)
                {
                    DataTable dt = new DataTable();
                    dt.Columns.Add("IDate");
                    dt.Columns.Add("IAmount");
                    dt.Columns.Add("DueDate");

                    int pending = netamt - amount;
                    for (int i = 0; i <= GridView1.Rows.Count - 1; i++)
                    {
                        // check highest duration 
                        if (((CheckBox)GridView1.Rows[i].FindControl("CheckModule")).Checked == true)
                        {
                            duration = Convert.ToInt32(GridView1.Rows[i].Cells[5].Text);
                            if (duration > maxduration)
                                maxduration = duration;
                        }
                    }

                    int noofinstallments = maxduration - 1;
                    for (int i = 1; i <= noofinstallments; i++)
                    {
                        // add new row
                        DataRow dr = dt.NewRow();
                        dr["IDate"] = System.DateTime.Now.AddMonths(i).ToShortDateString();
                        dr["IAmount"] = pending / noofinstallments;
                        dr["DueDate"] = (System.DateTime.Now.AddMonths(i)).AddDays(10).ToShortDateString();
                        dt.Rows.Add(dr);
                    }

                    GridView3.DataSource = dt;
                    GridView3.DataBind();

                }
            }
        }

        protected void LinkButtonPrint_Click(object sender, EventArgs e)
        {
            
        }


       

    }
}